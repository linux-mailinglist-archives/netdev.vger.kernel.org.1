Return-Path: <netdev+bounces-43701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A817D446A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037A9B20ED3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33063BF;
	Tue, 24 Oct 2023 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zhoi1eWi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE7523D;
	Tue, 24 Oct 2023 01:01:52 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69214D7D;
	Mon, 23 Oct 2023 18:01:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so938570b3a.1;
        Mon, 23 Oct 2023 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698109309; x=1698714109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxzmY8d6ZYjaLo7KwtGaocFvYRqIgzllSYwrvdHB8LE=;
        b=Zhoi1eWiJ3E0ZgrTMsESD38VO79MTXjsRTehDI4rRt9F8yFYZmaCwKv4aa8k2CHPhr
         COu4SL23DX4kJ7zWMndnXj8w73YS3/8HUOsHynB+3oYgMZjN1KdAC4GW5vVEkabgxvVj
         /7NQ345PmgnKPvj8gVsNB6vThwaaSNhbNEFNg/MvUUV7GWMJuQl46yXfJcTIIEfZ/gTd
         P2ygC5GNRm/jUa065nxQWQ5sHF8WOYaYsQEi2zMdXwDVKitAqX7Dc6rZqCGZ/mBUgpHF
         ovCpwldi60At8Xjezj6j6yH01l8Afz4aMgKuGBgyY1sf0d9fJRbmL+4qMLAFNbqd+nMY
         fh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698109309; x=1698714109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxzmY8d6ZYjaLo7KwtGaocFvYRqIgzllSYwrvdHB8LE=;
        b=hijOSzKfmJAPcWU4mA9gnBUwW2bEK6wJ7og6u0Ri5ImfAfLpB7tKo4+xkfq+AepjJu
         pS2XVjoFkvIeQ92H/UVYdUQYqoYUWgLeKXYHe++LILzxP0BHsYe69J1QHDYcLgU9Mx0T
         poDhT5JWWZwvXNGC5GqRE7T6uTStel+BvMMudwzqEI3Xvkw9oa3+ajph9Zu5lGErYWiI
         vLsswKUGoyWbS2gvvYixMl6U2CEhGONI2Ekieo2xEviRk2m878XlCqHiGpyYabA+mUzy
         Nu3aKe/U/+o2v6Eog7ET26P126s2RrieR0L1qmR8Zrjs+ao1BbBQh/hJ2WNHIIM8o7fA
         BZvg==
X-Gm-Message-State: AOJu0Yz8RQsqdUrovebkDU5nKXbmcS/3T0o9y73xYjHp9ayk3+A3Whn5
	CfXDE4iv49WKUG5XR98lrECeWv7RK5n88UZk
X-Google-Smtp-Source: AGHT+IEA3pwufWDM6nncM8xiHgkl76NRdlbaPUgwymwdfHd7Lvw8LYGa8aQ+ipVR85Hb5NaC4+5Xyw==
X-Received: by 2002:a05:6a21:33a4:b0:163:c167:964a with SMTP id yy36-20020a056a2133a400b00163c167964amr14151621pzb.1.1698109309628;
        Mon, 23 Oct 2023 18:01:49 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k6-20020aa78206000000b006be077531aesm6707888pfi.220.2023.10.23.18.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 18:01:49 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	greg@kroah.com
Subject: [PATCH net-next v6 5/5] net: phy: add Rust Asix PHY driver
Date: Tue, 24 Oct 2023 09:58:42 +0900
Message-Id: <20231024005842.1059620-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the Rust implementation of drivers/net/phy/ax88796b.c. The
features are equivalent. You can choose C or Rust versionon kernel
configuration.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 MAINTAINERS                      |   8 ++
 drivers/net/phy/Kconfig          |   8 ++
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 129 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 5 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 568b99d34533..410b72d3ae37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3058,6 +3058,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/asix,ax88796c.yaml
 F:	drivers/net/ethernet/asix/ax88796c_*
 
+ASIX PHY DRIVER [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:	Trevor Gross <tmgross@umich.edu>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/ax88796b_rust.rs
+
 ASPEED CRYPTO DRIVER
 M:	Neal Liu <neal_liu@aspeedtech.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 0faebdb184ca..11b18370a05b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -115,6 +115,14 @@ config AX88796B_PHY
 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
 	  AX88796B package.
 
+config AX88796B_RUST_PHY
+	bool "Rust reference driver for Asix PHYs"
+	depends on RUST_PHYLIB_ABSTRACTIONS && AX88796B_PHY
+	help
+	  Uses the Rust reference driver for Asix PHYs (ax88796b_rust.ko).
+	  The features are equivalent. It supports the Asix Electronics PHY
+	  found in the X-Surf 100 AX88796B package.
+
 config BROADCOM_PHY
 	tristate "Broadcom 54XX PHYs"
 	select BCM_NET_PHYLIB
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..58d7dfb095ab 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -41,7 +41,11 @@ aquantia-objs			+= aquantia_hwmon.o
 endif
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
-obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
+ifdef CONFIG_AX88796B_RUST_PHY
+  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
+else
+  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
+endif
 obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
 obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
 obj-$(CONFIG_BCM7XXX_PHY)	+= bcm7xxx.o
diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
new file mode 100644
index 000000000000..017f817f6f8d
--- /dev/null
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Rust Asix PHYs driver
+//!
+//! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
+use kernel::c_str;
+use kernel::net::phy::{self, DeviceId, Driver};
+use kernel::prelude::*;
+use kernel::uapi;
+
+kernel::module_phy_driver! {
+    drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
+    device_table: [
+        DeviceId::new_with_driver::<PhyAX88772A>(),
+        DeviceId::new_with_driver::<PhyAX88772C>(),
+        DeviceId::new_with_driver::<PhyAX88796B>()
+    ],
+    name: "rust_asix_phy",
+    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
+    description: "Rust Asix PHYs driver",
+    license: "GPL",
+}
+
+// Performs a software PHY reset using the standard
+// BMCR_RESET bit and poll for the reset bit to be cleared.
+// Toggle BMCR_RESET bit off to accommodate broken AX8796B PHY implementation
+// such as used on the Individual Computers' X-Surf 100 Zorro card.
+fn asix_soft_reset(dev: &mut phy::Device) -> Result {
+    dev.write(uapi::MII_BMCR as u16, 0)?;
+    dev.genphy_soft_reset()
+}
+
+struct PhyAX88772A;
+
+#[vtable]
+impl phy::Driver for PhyAX88772A {
+    const FLAGS: u32 = phy::flags::IS_INTERNAL;
+    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
+
+    // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
+    // after autoneg is done and the link status is reported as active, the MII_LPA
+    // register is 0. This issue is not reproducible on AX88772C.
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        dev.genphy_update_link()?;
+        if !dev.get_link() {
+            return Ok(0);
+        }
+        // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to resolve
+        // linkmode so use MII_BMCR as default values.
+        let ret = dev.read(uapi::MII_BMCR as u16)?;
+
+        if ret as u32 & uapi::BMCR_SPEED100 != 0 {
+            dev.set_speed(uapi::SPEED_100);
+        } else {
+            dev.set_speed(uapi::SPEED_10);
+        }
+
+        let duplex = if ret as u32 & uapi::BMCR_FULLDPLX != 0 {
+            phy::DuplexMode::Full
+        } else {
+            phy::DuplexMode::Half
+        };
+        dev.set_duplex(duplex);
+
+        dev.genphy_read_lpa()?;
+
+        if dev.is_autoneg_enabled() && dev.is_autoneg_completed() {
+            dev.resolve_aneg_linkmode();
+        }
+
+        Ok(0)
+    }
+
+    fn suspend(dev: &mut phy::Device) -> Result {
+        dev.genphy_suspend()
+    }
+
+    fn resume(dev: &mut phy::Device) -> Result {
+        dev.genphy_resume()
+    }
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        asix_soft_reset(dev)
+    }
+
+    fn link_change_notify(dev: &mut phy::Device) {
+        // Reset PHY, otherwise MII_LPA will provide outdated information.
+        // This issue is reproducible only with some link partner PHYs.
+        if dev.state() == phy::DeviceState::NoLink {
+            let _ = dev.init_hw();
+            let _ = dev.start_aneg();
+        }
+    }
+}
+
+struct PhyAX88772C;
+
+#[vtable]
+impl Driver for PhyAX88772C {
+    const FLAGS: u32 = phy::flags::IS_INTERNAL;
+    const NAME: &'static CStr = c_str!("Asix Electronics AX88772C");
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1881);
+
+    fn suspend(dev: &mut phy::Device) -> Result {
+        dev.genphy_suspend()
+    }
+
+    fn resume(dev: &mut phy::Device) -> Result {
+        dev.genphy_resume()
+    }
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        asix_soft_reset(dev)
+    }
+}
+
+struct PhyAX88796B;
+
+#[vtable]
+impl Driver for PhyAX88796B {
+    const NAME: &'static CStr = c_str!("Asix Electronics AX88796B");
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_model_mask(0x003b1841);
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        asix_soft_reset(dev)
+    }
+}
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 301f5207f023..08f5e9334c9e 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -7,3 +7,5 @@
  */
 
 #include <uapi/asm-generic/ioctl.h>
+#include <uapi/linux/mii.h>
+#include <uapi/linux/ethtool.h>
-- 
2.34.1


