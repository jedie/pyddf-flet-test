from flet.version import version as flet_version
import flet as ft
import sys

import platform
import os
import datetime
import asyncio


# from flet_geolocator import Geolocator, GeolocatorSettings, GeolocatorPositionAccuracy


def main(page: ft.Page):
    page.scroll = ft.ScrollMode.ALWAYS

    markdown_text = ft.Markdown(
        'loading...',
        selectable=True,
        extension_set=ft.MarkdownExtensionSet.GITHUB_WEB,
        on_tap_link=lambda e: page.launch_url(e.data),
    )
    page.add(markdown_text)

    def add_line(line):
        markdown_text.value += f'{line}\n'
        markdown_text.update()
        page.scroll_to(offset=-1, duration=1000)

    markdown_text.value = ''  # Remove "loading..." text
    add_line(f'\n# {__file__}')
    add_line(f'\n## {flet_version=}')
    add_line(f"\n## Python version\n\n * {platform.python_version()}")
    add_line(f"\n## Platform\n\n * {platform.platform()}")
    add_line(f"\n## Working directory\n\n * {os.getcwd()}")
    add_line(f"\n## Executable\n\n * {sys.executable}")
    add_line("\n## sys.path\n\n")
    add_line('\n'.join(f' * {p}' for p in sys.path))

    def handle_position_change(e):
        print(f"New position: {e.latitude} {e.longitude}")
        add_line(f"\n\nNew position: {e.latitude} {e.longitude}")

    def handle_position_error(e):
        print(f"Error: {e.data}")
        add_line(f"\n\nError: {e.data}")

    gl = ft.Geolocator(
        location_settings=ft.GeolocatorSettings(
            accuracy=ft.GeolocatorPositionAccuracy.LOW
        ),
        on_position_change=handle_position_change,
        on_error=handle_position_error,
    )
    page.overlay.append(gl)

    async def update_timer():
        while True:
            add_line(f'\n{datetime.datetime.now().isoformat()} | {os.getloadavg()=}\n')
            await asyncio.sleep(1)
    page.run_task(update_timer)


ft.app(main)
