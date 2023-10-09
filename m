Return-Path: <netdev+bounces-38934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D937BD1D3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1EF1C20B21
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274571115;
	Mon,  9 Oct 2023 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKSjPZxq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1F15A6;
	Mon,  9 Oct 2023 01:41:31 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA5AC;
	Sun,  8 Oct 2023 18:41:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690f8e63777so1126265b3a.0;
        Sun, 08 Oct 2023 18:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696815690; x=1697420490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0TLw8/zn4GsF1M9EshsBJkY1OE36SMUTQ3moVOgfX4=;
        b=SKSjPZxqfhKMsTF2JBgcKmQCbHeOrEDhEtzw67HtnikP0Jfa8VxWFUU8xAaxE7As/E
         NHVVOhtN5b98A5HPx0Y09w6mSQ2l3uw3GsFUhZ0T/h080wqi5qjA49PaQgFqnxweqDCF
         FhSAn/lQDf7Ye0WS0khfpmb+wYfxb9FfH8vQtGOONxByn4PY6W7KlzjG81l1djyFD+Pj
         xWmV+2nPgJ8qLGhYBRG1y9ZwVnDIsU31zBk5LDmdLoY3cBQFMwAzEqhgNCEYOaSefNL+
         o5kShKvP+VYOQ4EOJB29doO7xxnDp3qmx9HFDcdXUVLgd1K/tQRtAzchVGrqPuuiLfKL
         VazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696815690; x=1697420490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0TLw8/zn4GsF1M9EshsBJkY1OE36SMUTQ3moVOgfX4=;
        b=Rraq0JFjgtEPj4iEzlGgEnIcHRinPlKxkh+Wlk6t8nMMK0uTeeuGWUGRpMOTYZ6IvP
         1QLqIVbwAanplL+SQ/yDpmKVUCPLCa/1gjmOcFP2frTlXD4hmxDa4DmJb7eM461YnwQ5
         jdrL+6J7t/YgjBGAwjhy3kiMmc5p9QkWZFA3D4Aq1QN/OJJGDcTF4okeQRiZwNdyv9t3
         SQrWj+WvC07HL80hofCIPfGSxPzXy34Lxv/XjnhLptJBGfgajasXgzml5iUGsbSAuUZb
         eSd2v3RRVHZmRSUi3x4h/JWR6K4f3Mv6vyi2R8rEHKhpihsxCo3n60ZGGPsczMt6ZGb8
         XBLA==
X-Gm-Message-State: AOJu0Yznu5GOzrYk6X0jaTZQcPQVVG08fgmYQyE5YCYmJdEUcOv3Zz/3
	gXzGgrppxqi11pcM0CbxlNG7hPmfODQ95CGe
X-Google-Smtp-Source: AGHT+IG04l1u4IHcYWAFhrWghVd+DpWw0uvzLTlcRG9LQHZfe0LQuxBmLtn2VNatXLhdvVjAiGKMHg==
X-Received: by 2002:a05:6a00:2e92:b0:692:b3d4:e6c3 with SMTP id fd18-20020a056a002e9200b00692b3d4e6c3mr15548963pfb.0.1696815689798;
        Sun, 08 Oct 2023 18:41:29 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b0068fb8e18971sm5132917pfh.130.2023.10.08.18.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:41:29 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com,
	tmgross@umich.edu
Subject: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Date: Mon,  9 Oct 2023 10:39:12 +0900
Message-Id: <20231009013912.4048593-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the Rust implementation of drivers/net/phy/ax88796b.c. The
features are equivalent. You can choose C or Rust versionon kernel
configuration.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/phy/Kconfig          |   7 ++
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 129 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 4 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 421d2b62918f..0317be180ac2 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -107,6 +107,13 @@ config AX88796B_PHY
 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
 	  AX88796B package.
 
+config AX88796B_RUST_PHY
+	bool "Rust version driver for Asix PHYs"
+	depends on RUST_PHYLIB_BINDINGS && AX88796B_PHY
+	help
+	  Uses the Rust version driver for Asix PHYs (ax88796b_rust.ko)
+	  instead of the C version.
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


