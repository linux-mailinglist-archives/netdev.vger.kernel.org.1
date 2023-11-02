Return-Path: <netdev+bounces-45767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED37DF720
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB95B20DD1
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB21D52D;
	Thu,  2 Nov 2023 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs/ici9u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877D1D529
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:55:27 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8066512E
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 08:55:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so1830531a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698940524; x=1699545324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88K3Ni4jGbF8Y9NKqC6Q989G9BjpKvZlekcVE2lXRy8=;
        b=fs/ici9uXf5IXBBochcxXqTpfajfBYQ1Ewu+QRwUmKb+BSN+1ywnI5i/YfP+smg16b
         bEHmcYT77a1whbMZQqgyuaSqFp6srJtbqJajoXDp2CUuW6PsUdBFIzCCBWFv7zzxvYIk
         Zww5XyBAnqOseOB45KbaHRQrhCxjp2dspygpeCU0SWQjGFF/ZGvYWrKcCrkrhV3Q54XT
         hTXzOK3dpjU1CpdE+IcldW0TlDTBqd2TXTgPwK1zPi8vwe5SmPLkyyoR0RvDhhRL5IA3
         AASOtB8DsAlZ462VlgMXcJzyE+9ZYNlcCpKNuu563GPfmcwetMtwVTfSYlig3TqZOCwT
         FgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698940524; x=1699545324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88K3Ni4jGbF8Y9NKqC6Q989G9BjpKvZlekcVE2lXRy8=;
        b=Qe1NaIJRq8QELdGiHTg4zro2iR3dBa3tzTmK1s4Sdnnk93yngztDKXwfoDiZOO5kaS
         +Cv/rjWwI37BRTvQ0nE88S6u562YymyeYMcdZbEXTBkN/1tY7Sz3L6nSGmz6MJiUhpV+
         FsjVrtWhdrqHQVnCBIlCGw2atZJA57a3phPIrB1OK9L9FRfs6WtB4FLT/G70r/ibDQig
         8YiKfgQPW2VdEX2PODshnZarO+udEN0P621hKhXhJ0F5sWEgH+gI8yY4afbscDVW+ZuM
         L7fivUdEiTfIo+6fhiaU7B2TzyLwzu+2uep7yOEGGsW/dUHtQSQ2hniDGZK5Tly+Aq+6
         508Q==
X-Gm-Message-State: AOJu0YzMQEZPoiSL0unlBSMFeAmV25T5xrKAfOLlcgjNbiY5O8P5QIOT
	8pIvo2gzL8UGZfQ/MDmwoMw=
X-Google-Smtp-Source: AGHT+IGjdq0/pSiKWwe5Hz4WbRuHS+Efi9mr/R6qAqoRY9rsohQ/SsPA5ppuK7VkTSCnawXIemPutA==
X-Received: by 2002:a50:aa96:0:b0:543:7115:eb15 with SMTP id q22-20020a50aa96000000b005437115eb15mr6593053edc.20.1698940523599;
        Thu, 02 Nov 2023 08:55:23 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id lx8-20020a170906af0800b00993664a9987sm1286075ejb.103.2023.11.02.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:55:23 -0700 (PDT)
Date: Thu, 2 Nov 2023 17:55:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
	alsi@bang-olufsen.dk, andrew@lunn.ch, vivien.didelot@gmail.com,
	f.fainelli@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org, krzk+dt@kernel.org,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20231102155521.2yo5qpugdhkjy22x@skbuf>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf>
 <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com>

On Thu, Nov 02, 2023 at 03:59:48PM +0100, Linus Walleij wrote:
> I don't know if this is an answer to your question, but look at what I did in
> 
> drivers/usb/fotg210/Makefile:
> 
> # This setup links the different object files into one single
> # module so we don't have to EXPORT() a lot of internal symbols
> # or create unnecessary submodules.
> fotg210-objs-y                          += fotg210-core.o
> fotg210-objs-$(CONFIG_USB_FOTG210_HCD)  += fotg210-hcd.o
> fotg210-objs-$(CONFIG_USB_FOTG210_UDC)  += fotg210-udc.o
> fotg210-objs                            := $(fotg210-objs-y)
> obj-$(CONFIG_USB_FOTG210)               += fotg210.o
> 
> Everything starting with CONFIG_* is a Kconfig option obviously.
> 
> The final module is just one file named fotg210.ko no matter whether
> HCD (host controller), UDC (device controller) or both parts were
> compiled into it. Often you just need one of them, sometimes you may
> need both.
> 
> It's a pretty clean example of how you do this "one module from
> several optional parts" using Kbuild.

To be clear, something like this is what you mean, right?

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 060165a85fb7..857a039fb0f1 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -15,39 +15,37 @@ menuconfig NET_DSA_REALTEK
 
 if NET_DSA_REALTEK
 
+config NET_DSA_REALTEK_INTERFACE
+	tristate
+	help
+	  Common interface driver for accessing Realtek switches, either
+	  through MDIO or SMI.
+
 config NET_DSA_REALTEK_MDIO
-	tristate "Realtek MDIO interface driver"
-	depends on OF
-	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
-	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
-	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
+	tristate "Realtek MDIO interface support"
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
 
 config NET_DSA_REALTEK_SMI
-	tristate "Realtek SMI interface driver"
-	depends on OF
-	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
-	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
-	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
+	bool "Realtek SMI interface support"
 	help
 	  Select to enable support for registering switches connected
 	  through SMI.
 
 config NET_DSA_REALTEK_RTL8365MB
 	tristate "Realtek RTL8365MB switch subdriver"
-	imply NET_DSA_REALTEK_SMI
-	imply NET_DSA_REALTEK_MDIO
+	select NET_DSA_REALTEK_INTERFACE
 	select NET_DSA_TAG_RTL8_4
+	depends on OF
 	help
 	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
 
 config NET_DSA_REALTEK_RTL8366RB
 	tristate "Realtek RTL8366RB switch subdriver"
-	imply NET_DSA_REALTEK_SMI
-	imply NET_DSA_REALTEK_MDIO
+	select NET_DSA_REALTEK_INTERFACE
 	select NET_DSA_TAG_RTL4_A
+	depends on OF
 	help
 	  Select to enable support for Realtek RTL8366RB.
 
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 0aab57252a7c..35b7734c0ad0 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
+
+obj-$(CONFIG_NET_DSA_REALTEK_INTERFACE) := realtek-interface.o
+
+realtek-interface-objs			:= realtek-interface-common.o
+ifdef CONFIG_NET_DSA_REALTEK_MDIO
+realtek-interface-objs			+= realtek-mdio.o
+endif
+ifdef CONFIG_NET_DSA_REALTEK_SMI
+realtek-interface-objs			+= realtek-smi.o
+endif
+
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/realtek-interface-common.c b/drivers/net/dsa/realtek/realtek-interface-common.c
new file mode 100644
index 000000000000..bb7c77cdb9e2
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-interface-common.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/module.h>
+
+#include "realtek-mdio.h"
+#include "realtek-smi.h"
+
+static int __init realtek_interface_init(void)
+{
+	int err;
+
+	err = realtek_mdio_init();
+	if (err)
+		return err;
+
+	err = realtek_smi_init();
+	if (err) {
+		realtek_smi_exit();
+		return err;
+	}
+
+	return 0;
+}
+module_init(realtek_interface_init);
+
+static void __exit realtek_interface_exit(void)
+{
+	realtek_smi_exit();
+	realtek_mdio_exit();
+}
+module_exit(realtek_interface_exit);
+
+MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_DESCRIPTION("Driver for interfacing with Realtek switches via MDIO or SMI");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..6997dec14de2 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* Realtek MDIO interface driver
+/* Realtek MDIO interface support
  *
  * ASICs we intend to support with this driver:
  *
@@ -19,12 +19,12 @@
  * Copyright (C) 2009-2010 Gabor Juhos <juhosg@openwrt.org>
  */
 
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-mdio.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -283,8 +283,12 @@ static struct mdio_driver realtek_mdio_driver = {
 	.shutdown = realtek_mdio_shutdown,
 };
 
-mdio_module_driver(realtek_mdio_driver);
+int realtek_mdio_init(void)
+{
+	return mdio_driver_register(&realtek_mdio_driver);
+}
 
-MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
-MODULE_LICENSE("GPL");
+void realtek_mdio_exit(void)
+{
+	mdio_driver_unregister(&realtek_mdio_driver);
+}
diff --git a/drivers/net/dsa/realtek/realtek-mdio.h b/drivers/net/dsa/realtek/realtek-mdio.h
new file mode 100644
index 000000000000..941b4ef9d531
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-mdio.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_MDIO_H
+#define _REALTEK_MDIO_H
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO)
+
+int realtek_mdio_init(void);
+void realtek_mdio_exit(void);
+
+#else
+
+static inline int realtek_mdio_init(void)
+{
+	return 0;
+}
+
+static inline void realtek_mdio_exit(void)
+{
+}
+
+#endif
+
+#endif
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 755546ed8db6..4c282bfc884d 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* Realtek Simple Management Interface (SMI) driver
+/* Realtek Simple Management Interface (SMI) interface
  * It can be discussed how "simple" this interface is.
  *
  * The SMI protocol piggy-backs the MDIO MDC and MDIO signals levels
@@ -26,7 +26,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
@@ -40,6 +39,7 @@
 #include <linux/if_bridge.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
@@ -560,8 +560,13 @@ static struct platform_driver realtek_smi_driver = {
 	.remove_new = realtek_smi_remove,
 	.shutdown = realtek_smi_shutdown,
 };
-module_platform_driver(realtek_smi_driver);
 
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
-MODULE_LICENSE("GPL");
+int realtek_smi_init(void)
+{
+	return platform_driver_register(&realtek_smi_driver);
+}
+
+void realtek_smi_exit(void)
+{
+	platform_driver_unregister(&realtek_smi_driver);
+}
diff --git a/drivers/net/dsa/realtek/realtek-smi.h b/drivers/net/dsa/realtek/realtek-smi.h
new file mode 100644
index 000000000000..9a4838321f94
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-smi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_SMI_H
+#define _REALTEK_SMI_H
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI)
+
+int realtek_smi_init(void);
+void realtek_smi_exit(void);
+
+#else
+
+static inline int realtek_smi_init(void)
+{
+	return 0;
+}
+
+static inline void realtek_smi_exit(void)
+{
+}
+
+#endif
+
+#endif
-- 
2.34.1


It looks pretty reasonable to me. More stuff could go into
realtek-interface-common.c, that could be called directly from
realtek-smi.c and realtek-mdio.c without exporting anything.

I've eliminated the possibility for the SMI and MDIO options to be
anything other than y or n, because only a single interface module
(the common one) exists, and the y/n/m quality of that is
implied/selected by the drivers which depend on it. I hope I wasn't too
trigger-happy with this.

