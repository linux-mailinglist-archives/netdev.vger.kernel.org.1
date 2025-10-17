Return-Path: <netdev+bounces-230274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B36BE61F1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6474919C2FF7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C392459D9;
	Fri, 17 Oct 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dsNo1SoO"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93832253EE;
	Fri, 17 Oct 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669004; cv=none; b=cRvxm4LMs81P+H/ZwK+HDoSjm8jxY3jf8EtluJNVjwmTBNMLT4gaea97kaiuYwqEpCLRsHmOpmXULX8d2C/5Hv0ed10wjzvl3dHoC+fVpHX8hNqv4aYVfcgxwpMWqxj7qgI8hEncBRed3YLUiVBCmBIzXgNpNNo6DVJrScXqinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669004; c=relaxed/simple;
	bh=N0SPoREcfjToVSvpDpuB20UkPpIAnS92ECS0wYXYfYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ld1B/1tU3g7lYePj7YtqgFT5wqn+NUhD30zvVr94PijwFZrfHDdJYLzYaS6sPO/pRXnWb8DrPd8NrBzT5NH6e6xp9+cW0DhQVCn8+sIuvhZHtUyMF3fEllx3WucQFUBJliJ6TbPFEbwyOZWmbjw6J7jWRhHwReCWeZlfkoforh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dsNo1SoO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/k
	Q7yMmRbRhx6uqfPluLv3tH08pPgFdiUcBwhpyhBNM=; b=dsNo1SoOBz2KaiOs7T
	RVHmDw0UIN+VRYqWFE5b7vPv+wKZazpvMzfWaxdNM9CW0eteBLerlhh4Ssvjbe73
	Wlxacl5yd+45wrCVmarIzWlmpm9B0Iy/s4JqUc/1grU7kARaqMY5Ogs1il3GSVdf
	qS5mKudZhzsPxA+lOwqDIjjLU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHc4sVrfFonJv9Ag--.1829S2;
	Fri, 17 Oct 2025 10:42:31 +0800 (CST)
From: yicongsrfy@163.com
To: michal.pecio@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver@neukum.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver for config selection
Date: Fri, 17 Oct 2025 10:42:29 +0800
Message-Id: <20251017024229.1959295-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251013110753.0f640774.michal.pecio@gmail.com>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHc4sVrfFonJv9Ag--.1829S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWkAFyrGr1kXF4DuFy5XFb_yoWrtw1DpF
	WUKa1YyrWUXFWfGr4fXrW8XFyY9ws2krW2kr1fJ3W3ur95ur97tF48K345uFy8CrW8GF12
	vw4UKF43uws8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uca9-UUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbixwHp22jxpfnf7gAAsA

On Mon, 13 Oct 2025 11:07:53 +0200, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> On Sat, 11 Oct 2025 15:53:13 +0800, yicongsrfy@163.com wrote:
> > From: Yi Cong <yicong@kylinos.cn>
> >
> > A similar reason was raised in commit ec51fbd1b8a2 ("r8152: add USB
> > device driver for config selection"):
> > Linux prioritizes probing non-vendor-specific configurations.
> >
> > Referring to the implementation of this patch, cfgselect is also
> > used for ax88179 to override the default configuration selection.
> >
> > Signed-off-by: Yi Cong <yicong@kylinos.cn>
> >
> > ---
> > v2: fix warning from checkpatch.
> > v5: 1. use KBUILD_MODNAME to obtain the module name.
> >     2. add error handling when usb_register fail.
> >     3. use .choose_configuration instead of .probe.
> >     4. reorder deregister logic.
> > ---
> >  drivers/net/usb/ax88179_178a.c | 68 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 65 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> > index b034ef8a73ea..b6432d414a38 100644
> > --- a/drivers/net/usb/ax88179_178a.c
> > +++ b/drivers/net/usb/ax88179_178a.c
> > @@ -1713,6 +1713,14 @@ static int ax88179_stop(struct usbnet *dev)
> >  	return 0;
> >  }
> >
> > +static int ax88179_probe(struct usb_interface *intf, const struct usb_device_id *i)
> > +{
> > +	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> > +		return -ENODEV;
> > +
> > +	return usbnet_probe(intf, i);
> > +}
>
> This isn't part of the cfgselector driver being added by this commit
> nor is it documented in the changelog, so why is it here?

> It doesn't seem to be necessary, because USB_DEVICE_AND_INTERFACE_INFO
> matches used by this driver ensure that probe() will only be called on
> interfaces of the correct class 0xff.

I've retested this logic, and indeed, there's no need to add this extra check.
It's already planned to remove this modification in the next patch version.

> > +
> >  static const struct driver_info ax88179_info = {
> >  	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
> >  	.bind = ax88179_bind,
> > @@ -1941,9 +1949,9 @@ static const struct usb_device_id products[] = {
> >  MODULE_DEVICE_TABLE(usb, products);
> >
> >  static struct usb_driver ax88179_178a_driver = {
> > -	.name =		"ax88179_178a",
> > +	.name =		KBUILD_MODNAME,
> >  	.id_table =	products,
> > -	.probe =	usbnet_probe,
> > +	.probe =	ax88179_probe,
> >  	.suspend =	ax88179_suspend,
> >  	.resume =	ax88179_resume,
> >  	.reset_resume =	ax88179_resume,
> > @@ -1952,7 +1960,61 @@ static struct usb_driver ax88179_178a_driver = {
> >  	.disable_hub_initiated_lpm = 1,
> >  };
> >
> > -module_usb_driver(ax88179_178a_driver);
> > +static int ax88179_cfgselector_choose_configuration(struct usb_device *udev)
> > +{
> > +	struct usb_host_config *c;
> > +	int i, num_configs;
> > +
> > +	/* The vendor mode is not always config #1, so to find it out. */
> > +	c = udev->config;
> > +	num_configs = udev->descriptor.bNumConfigurations;
> > +	for (i = 0; i < num_configs; (i++, c++)) {
> > +		struct usb_interface_descriptor	*desc = NULL;
> > +
> > +		if (!c->desc.bNumInterfaces)
> > +			continue;
> > +		desc = &c->intf_cache[0]->altsetting->desc;
> > +		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
> > +			break;
> > +	}
> > +
> > +	if (i == num_configs)
> > +		return -ENODEV;
> > +
> > +	return c->desc.bConfigurationValue;
> > +}
>
> I wonder how many copies of this code would justify making it some
> sort of library in usbnet or usbcore?

Yes, there are many similar code instances in the USB subsystem.
However, I'm primarily focused on the networking subsystem,
so my abstraction work here might not be thorough enough.
Hopefully, an experienced USB developer may can optimize this issue.


> > +static struct usb_device_driver ax88179_cfgselector_driver = {
> > +	.name =	KBUILD_MODNAME "-cfgselector",
> > +	.choose_configuration =	ax88179_cfgselector_choose_configuration,
> > +	.id_table = products,
> > +	.generic_subclass = 1,
> > +	.supports_autosuspend = 1,
> > +};
> > +
> > +static int __init ax88179_driver_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = usb_register_device_driver(&ax88179_cfgselector_driver, THIS_MODULE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = usb_register(&ax88179_178a_driver);
> > +	if (ret)
> > +		usb_deregister_device_driver(&ax88179_cfgselector_driver);
>
> Any problems if the order of registration is reversed, to ensure that
> the interface driver always exists if the device driver exists?

After swapping the registration order, testing confirms there are no problems.

> > +
> > +	return 0;
>
> return ret perhaps?

Will be fixed in the next version.


