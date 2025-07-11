Исходный код
=====================
.. uml:: ../../projectTemplate/diagrams/project_structure.puml

src/main.py
^^^^^^^^^^^
.. automodule:: src.main
   :members:
   :undoc-members:
   :show-inheritance:

📁 src/utils/
-------------

src/utils/logger.py
^^^^^^^^^^^^^^^^^^^
.. automodule:: src.utils.logger
   :members:
   :undoc-members:
   :show-inheritance:

📁 configs/
-----------

configs/config.py
^^^^^^^^^^^^^^^^^
.. automodule:: configs.config
   :members:
   :undoc-members:
   :show-inheritance:

configs/path_manager.py
^^^^^^^^^^^^^^^^^^^^^^^
.. automodule:: configs.path_manager
   :members:
   :undoc-members:
   :show-inheritance:

📁 tools/
---------

tools/diagram_auto_update.py
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. automodule:: tools.diagram_auto_update
   :members:
   :undoc-members:
   :show-inheritance:

tools/print_structure.py
^^^^^^^^^^^^^^^^^^^^^^^^
.. automodule:: tools.print_structure
   :members:
   :undoc-members:
   :show-inheritance:

📁 tests/
---------


🛠 Конфигурационные файлы
==========================

Dockerfile
----------
.. literalinclude:: ../Dockerfile
   :language: docker
   :caption: Dockerfile

docker-compose.yaml
-------------------
.. literalinclude:: ../docker-compose.yaml
   :language: yaml
   :caption: docker-compose.yaml

Makefile
--------
.. literalinclude:: ../Makefile
   :language: make
   :caption: Makefile

requirements.txt
----------------
.. literalinclude:: ../requirements.txt
   :language: text
   :caption: requirements.txt
