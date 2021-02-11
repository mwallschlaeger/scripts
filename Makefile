INSTALL_PATH:=/usr/local/bin/

install:
	cp script_docker_remove_old_containers script_docker_remove_none_images $(INSTALL_PATH)
	chmod 755 $(INSTALL_PATH)script_docker_remove_old_containers $(INSTALL_PATH)script_docker_remove_none_images
