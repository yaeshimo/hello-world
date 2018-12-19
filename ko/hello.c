#include <linux/module.h>
#include <linux/kernel.h> // kernel info
#include <linux/init.h> // __init __exit macros

MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("name <addr@mail>");
MODULE_DESCRIPTION("hello kernel module");

static int __init hello_init(void)
{
  printk(KERN_INFO "hello: hello kernel!!\n");
  printk(KERN_ALERT "hello: test ALERT init\n");
  return 0; // if !0 can't load the module
}

static void __exit hello_seeyou(void)
{
  printk(KERN_INFO "hello: See you next time!!\n");
  printk(KERN_ALERT "hello: test ALERT exit!\n");
}

module_init(hello_init);
module_exit(hello_seeyou);
