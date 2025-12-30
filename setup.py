from setuptools import find_packages, setup

package_name = 'workpkg'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='shun',
    maintainer_email='s24c1122vn@s.chibakoudai.jp',
    description='mitei',
    license='GPL-3.0-only',
    extras_require={
        'test': [
            'pytest',
        ],
    },
    entry_points={
        'console_scripts': [
            'task1 = workpkg.task1:main',
            'task2 = workpkg.task2:main',
        ],
    },
)
