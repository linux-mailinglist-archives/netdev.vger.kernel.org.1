Return-Path: <netdev+bounces-38957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF317BD433
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A0E2813CB
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F4DFC06;
	Mon,  9 Oct 2023 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AsyGse47"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ADC8C1A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:23:11 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B228B9
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 00:23:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e742a787so2416057f8f.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696836186; x=1697440986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+wjv6ohQ/J1gbmZuOpM8GZ58jf+gpRKYWWWE53GrKA=;
        b=AsyGse47WG70dGP7/3KAN2UlOzGb0JUOjsvrqS7arnuIIGOK3Hn5Vj7XbAWf+dPlmV
         /xz5y5fa8CCypr3se/UVj7P6l9o+bCKvwgGciBqALPC8AYM8Z/Jxpy7f+hApiWkC8V2G
         vAAKXGwYjQOjm6W/WncBewEDEwcSZ0sLTIXeJs73kO7dG32KNUMNK5kSmArTxMtCCyNQ
         IoPvAWAKD+RFNEVueyAVsg/+ELmBRelHpBZpUAUao+QAmK1IT6+/BkVijY00Jced854i
         EG7ChQQNi1XiGtK/ZMHHscwvkahmoMxI3tb09ry0RxrEZXhADHMpDticRhQy5YlCV51f
         sTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696836186; x=1697440986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+wjv6ohQ/J1gbmZuOpM8GZ58jf+gpRKYWWWE53GrKA=;
        b=cILXiFZWUmhe/QNhXY3PV/g6nikbVeFLWsRRQun4pf5XeeQWbID+ozzHkidoD0lOOk
         atcYCTJVBlJj9XEMRqIQF21JL59uwl4P5TUn22EFGcBkUrg8MdusoZdE+c4WsUavvAmq
         7EfWA5fA3GUOd9WDoZi0XgB7pZyd3zjXqHFAgLn3W5sCeCd0K5FAnxeD4VUtJI0/5FFl
         JGq3tzVaR+LHYXugCG96i6lrjWYxvnjJDtSz40meoCr/Ct/+qlnO4+fXWM6PyRsGAK3z
         H9d4Cv7//5OF3sN19x9YkWOMjrGrFjZiVmezrFP1nDEfZ0RehHwAJx/09kChqWxbwFHV
         SPJQ==
X-Gm-Message-State: AOJu0YyO45rjn+GPZMcBfrrFetMfF8Rk+D/jiXMgs97YND8tvSYYYqwY
	jMgYH4cD48X619OiXUAw50rpkrIOzE71xa9Ld3A=
X-Google-Smtp-Source: AGHT+IEUygX5opuJW2F+JCB3/zU7jnizPS3p5041jzj7UKSO4c3lv2UFBqyCiKcd9fI7rDAD1Nd2fg==
X-Received: by 2002:adf:f78a:0:b0:316:fc03:3c66 with SMTP id q10-20020adff78a000000b00316fc033c66mr9648125wrp.3.1696836186224;
        Mon, 09 Oct 2023 00:23:06 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k21-20020adfb355000000b003296b913bbesm8163520wrd.12.2023.10.09.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 00:23:05 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:23:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <ZSOqWMqm/JQOieAd@nanopsycho>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009013912.4048593-4-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 09, 2023 at 03:39:12AM CEST, fujita.tomonori@gmail.com wrote:
>This is the Rust implementation of drivers/net/phy/ax88796b.c. The
>features are equivalent. You can choose C or Rust versionon kernel
>configuration.
>
>Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>---
> drivers/net/phy/Kconfig          |   7 ++
> drivers/net/phy/Makefile         |   6 +-
> drivers/net/phy/ax88796b_rust.rs | 129 +++++++++++++++++++++++++++++++
> rust/uapi/uapi_helper.h          |   2 +
> 4 files changed, 143 insertions(+), 1 deletion(-)
> create mode 100644 drivers/net/phy/ax88796b_rust.rs
>
>diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>index 421d2b62918f..0317be180ac2 100644
>--- a/drivers/net/phy/Kconfig
>+++ b/drivers/net/phy/Kconfig
>@@ -107,6 +107,13 @@ config AX88796B_PHY
> 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
> 	  AX88796B package.
> 
>+config AX88796B_RUST_PHY
>+	bool "Rust version driver for Asix PHYs"
>+	depends on RUST_PHYLIB_BINDINGS && AX88796B_PHY
>+	help
>+	  Uses the Rust version driver for Asix PHYs (ax88796b_rust.ko)
>+	  instead of the C version.
>+
> config BROADCOM_PHY
> 	tristate "Broadcom 54XX PHYs"
> 	select BCM_NET_PHYLIB
>diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
>index c945ed9bd14b..58d7dfb095ab 100644
>--- a/drivers/net/phy/Makefile
>+++ b/drivers/net/phy/Makefile
>@@ -41,7 +41,11 @@ aquantia-objs			+= aquantia_hwmon.o
> endif
> obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
> obj-$(CONFIG_AT803X_PHY)	+= at803x.o
>-obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
>+ifdef CONFIG_AX88796B_RUST_PHY
>+  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
>+else
>+  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
>+endif
> obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
> obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
> obj-$(CONFIG_BCM7XXX_PHY)	+= bcm7xxx.o
>diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
>new file mode 100644
>index 000000000000..017f817f6f8d
>--- /dev/null
>+++ b/drivers/net/phy/ax88796b_rust.rs
>@@ -0,0 +1,129 @@
>+// SPDX-License-Identifier: GPL-2.0
>+// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
>+
>+//! Rust Asix PHYs driver
>+//!
>+//! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)

Wait. So you just add rust driver as a duplicate of existing c driver?
What's the point exactly to have 2 drivers for the same thing?



>+use kernel::c_str;
>+use kernel::net::phy::{self, DeviceId, Driver};
>+use kernel::prelude::*;
>+use kernel::uapi;
>+
>+kernel::module_phy_driver! {
>+    drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
>+    device_table: [
>+        DeviceId::new_with_driver::<PhyAX88772A>(),
>+        DeviceId::new_with_driver::<PhyAX88772C>(),
>+        DeviceId::new_with_driver::<PhyAX88796B>()
>+    ],
>+    name: "rust_asix_phy",
>+    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
>+    description: "Rust Asix PHYs driver",
>+    license: "GPL",
>+}
>+
>+// Performs a software PHY reset using the standard
>+// BMCR_RESET bit and poll for the reset bit to be cleared.
>+// Toggle BMCR_RESET bit off to accommodate broken AX8796B PHY implementation
>+// such as used on the Individual Computers' X-Surf 100 Zorro card.
>+fn asix_soft_reset(dev: &mut phy::Device) -> Result {
>+    dev.write(uapi::MII_BMCR as u16, 0)?;
>+    dev.genphy_soft_reset()
>+}
>+
>+struct PhyAX88772A;
>+
>+#[vtable]
>+impl phy::Driver for PhyAX88772A {
>+    const FLAGS: u32 = phy::flags::IS_INTERNAL;
>+    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
>+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
>+
>+    // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
>+    // after autoneg is done and the link status is reported as active, the MII_LPA
>+    // register is 0. This issue is not reproducible on AX88772C.
>+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
>+        dev.genphy_update_link()?;
>+        if !dev.get_link() {
>+            return Ok(0);
>+        }
>+        // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to resolve
>+        // linkmode so use MII_BMCR as default values.
>+        let ret = dev.read(uapi::MII_BMCR as u16)?;
>+
>+        if ret as u32 & uapi::BMCR_SPEED100 != 0 {
>+            dev.set_speed(uapi::SPEED_100);
>+        } else {
>+            dev.set_speed(uapi::SPEED_10);
>+        }
>+
>+        let duplex = if ret as u32 & uapi::BMCR_FULLDPLX != 0 {
>+            phy::DuplexMode::Full
>+        } else {
>+            phy::DuplexMode::Half
>+        };
>+        dev.set_duplex(duplex);
>+
>+        dev.genphy_read_lpa()?;
>+
>+        if dev.is_autoneg_enabled() && dev.is_autoneg_completed() {
>+            dev.resolve_aneg_linkmode();
>+        }
>+
>+        Ok(0)
>+    }
>+
>+    fn suspend(dev: &mut phy::Device) -> Result {
>+        dev.genphy_suspend()
>+    }
>+
>+    fn resume(dev: &mut phy::Device) -> Result {
>+        dev.genphy_resume()
>+    }
>+
>+    fn soft_reset(dev: &mut phy::Device) -> Result {
>+        asix_soft_reset(dev)
>+    }
>+
>+    fn link_change_notify(dev: &mut phy::Device) {
>+        // Reset PHY, otherwise MII_LPA will provide outdated information.
>+        // This issue is reproducible only with some link partner PHYs.
>+        if dev.state() == phy::DeviceState::NoLink {
>+            let _ = dev.init_hw();
>+            let _ = dev.start_aneg();
>+        }
>+    }
>+}
>+
>+struct PhyAX88772C;
>+
>+#[vtable]
>+impl Driver for PhyAX88772C {
>+    const FLAGS: u32 = phy::flags::IS_INTERNAL;
>+    const NAME: &'static CStr = c_str!("Asix Electronics AX88772C");
>+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1881);
>+
>+    fn suspend(dev: &mut phy::Device) -> Result {
>+        dev.genphy_suspend()
>+    }
>+
>+    fn resume(dev: &mut phy::Device) -> Result {
>+        dev.genphy_resume()
>+    }
>+
>+    fn soft_reset(dev: &mut phy::Device) -> Result {
>+        asix_soft_reset(dev)
>+    }
>+}
>+
>+struct PhyAX88796B;
>+
>+#[vtable]
>+impl Driver for PhyAX88796B {
>+    const NAME: &'static CStr = c_str!("Asix Electronics AX88796B");
>+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_model_mask(0x003b1841);
>+
>+    fn soft_reset(dev: &mut phy::Device) -> Result {
>+        asix_soft_reset(dev)
>+    }
>+}
>diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
>index 301f5207f023..08f5e9334c9e 100644
>--- a/rust/uapi/uapi_helper.h
>+++ b/rust/uapi/uapi_helper.h
>@@ -7,3 +7,5 @@
>  */
> 
> #include <uapi/asm-generic/ioctl.h>
>+#include <uapi/linux/mii.h>
>+#include <uapi/linux/ethtool.h>

What is exactly the reason to change anything in uapi for phy driver?
Should be just kernel api implementation, no?



>-- 
>2.34.1
>
>

