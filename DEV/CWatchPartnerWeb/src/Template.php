<?php
class Template
{
    protected $_file;
    protected $_data = array();
    private $headerFile = PROJECT_SRC . '/templates/header.tpl';
    private $footerFile = PROJECT_SRC . '/templates/footer.tpl';

    public function __construct($file = null)
    {
        $this->_file = $file;
    }

    public function set($key, $value)
    {
        $this->_data[$key] = $value;
        return $this;
    }

    public function render()
    {
        extract($this->_data);
        ob_start();
        require $this->headerFile;
        require $this->_file;
        require $this->footerFile;
        return ob_get_clean();
    }
}