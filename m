Return-Path: <netdev+bounces-260332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NWwIPQpnWmfNAQAu9opvQ
	(envelope-from <netdev+bounces-260332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:32:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C3181A89
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCA7E303B1A6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EFC2BF3F4;
	Tue, 24 Feb 2026 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs/RvXXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F429D273
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771907539; cv=none; b=qfXVnwDOF/4vo+JuQEQcgoE32+LTZb/E1lji6PWihqfTFHhO3rz/8/B1AY6q9VwdcZpq3N+xrPy24mKUx8npRv7GFST9zDpEAMMslzapn3h6oHqJjEnrDx7/albz/lDpaZ0RmWvkqOcTTLu/iBmpNiFrHDz5RNvu7mJKaGXTGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771907539; c=relaxed/simple;
	bh=N7MWqqsHu380Gb5Rc2gHv1QWehPH/HCcbhJPVIYlH10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIzuEV0/9v0nPobv4b/2VjGjcI8e6aRwBaMtbvqhlOJBXW1xwJfqguH0HGmnUN8FGcuNueqOEFZTBS+lP9klCBq+li32cnhPfGKkaNdmPdJM6yD2rHseN5+h/Ka0/PogwYtuIxUWK5lkkWhNipor5gn3FZ/QVa0gnBuj+URFQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs/RvXXG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c20dc9577so9435678a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 20:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771907535; x=1772512335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuF+2ZeNg9MZpifVmvjXA4TLhrwpvQWcio7F8T9WLuI=;
        b=Bs/RvXXGz9U82DjHrLFLC15NX/WSXX0MnohT3EfibFpWWrHFP33WcEdZy1q8CAFiX/
         RpzMweMIyxHVag81blg0rAWaA9DNsnHqkxBPKI7P/1WblNEtr1nQj/ykF49digucILxD
         eWKYSjidUO/KLx8FtNGjodipQAWBkLwK4aDjXudCxgmoJ6NAQHzJxXticcOixFtS3g4C
         D+ZGz5HdCOMI6DOV2XCbHuEA6GhqxCqAfcnC31lWo4clwSxF9vpB1cr5dgSyxJuVe/x6
         j9n343T9RI/oMm02UPE/OqzNV6lNtklWQ+xd9+Y2YaRIRYzsG6H6MG9v96nKUV9AtfV/
         0SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771907535; x=1772512335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuF+2ZeNg9MZpifVmvjXA4TLhrwpvQWcio7F8T9WLuI=;
        b=VB5KfK/IYQDMw43ueaDuQzE5sxqkTTuff8lWMCvOUB9IoNQ/ENTblfkSjyqONdyUx6
         SCBuwApd053vOhl5O0qTWZhR5MVpsLJ/EP8b6uuq3bJxYFrU2mwYr863C68BrGNaXDvk
         z5aAanmkwGFRxq+HQ6ubB1HxsU67PX2T6y8zjbbKhrvR1+7SFKGzqRLE+ptbGOHeJdsz
         eWMqHFUTGtUSr9kmuFR0PD+C8fTART2d9XWapd2laGHaBlyTXlA7N60IyrV/EfLbUcMB
         apdN9jj+z+Od9TqLbPI3BQDaMMaU1RbVJtEOfjhe9UM7MoEKCeTKk2zs5ZPjz1aRhFS/
         zktg==
X-Forwarded-Encrypted: i=1; AJvYcCUA0b0zTKPcIUXfuNdJGzPWz6Py1Ivp6u2/wYVWpw+oFwj1ICW2yagoaNegObD3CJBwdlKCXN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEqIJ6kY/0qOXhx4YeLdqiZs7Es6zG4WV3YTDHjf4xB//v47Y
	GvklLhqMx2xfb06EsHp2t2ZKTAsKV8Q9R6qDLz3ZUtqoEpTR7XpNBKoi
X-Gm-Gg: AZuq6aLLbxEirAMr7jHtZYXkYoEK3QCVNECjTUCdgkS79LTlZzrFNatInR+ET7YxU3I
	REcuk0lxI1zd4ivSi+3mYEajQZboFvO6JuSq2FgqDI2POoTFacPt3pWeRI9qFkpwyQXLHPo2bN8
	Ne//6orWQZflR645MAy5dkETT+NBPcG4KhDKvGTHW1hvKFCH8BA1WGGXOHMTI+kZ2xBZcCbEBiV
	kfgCD+gVG6TvnYzzBgk6mWzAPTDOX1blpJTzw2PgIEXbPxpgcgKKtP9X6M/zjIN7lfOB+Aj3BsK
	vQrQu86Qlf5ZBuay1AVPhIEzrr0eVx46Afrt+U7AeQbHWzfQLigjLfU2l21G35mxnDg5+g7iwNL
	AUUovEWcCSPZrvuAuzFw7KZy86agI4YqjljXCE5UIvTFoUE8mCHgWjxnWJj6H70r1r3huLWlZgE
	5tf6Ezko56nIMlraV+2pTjFc6ZkuqIuWwGpBuepJIdftYZQ3vkBYd6CRXWdFXkPFprjkiFY238t
	9795F9H86rKYgbtDJisgnkOdbpeLQMOkvFfg83Tp1NjV8OXk8RSiUW0z1r1yDi7Jv973IAkBT+W
	kp0uTW52
X-Received: by 2002:a17:907:fdcb:b0:b8f:a03c:ac22 with SMTP id a640c23a62f3a-b9081b77ae4mr722929966b.42.1771907535344;
        Mon, 23 Feb 2026 20:32:15 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.i2f7e30109524dc12-tp.internal (206.242.32.34.bc.googleusercontent.com. [34.32.242.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9088c8fc30sm371284466b.63.2026.02.23.20.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 20:32:14 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH net-next v2 3/3] net: phy: add Rust reference driver for ET1011C
Date: Tue, 24 Feb 2026 04:32:11 +0000
Message-ID: <20260224043211.1747-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224043211.1747-1-iprintercanon@gmail.com>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
 <20260224043211.1747-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B2C3181A89
X-Rspamd-Action: no action

Add a Rust implementation of the LSI ET1011C PHY driver, equivalent
to the existing C driver in drivers/net/phy/et1011c.c. The driver
implements config_aneg and read_status callbacks using the Rust PHY
abstraction.

The Rust driver uses the new speed() getter to detect speed changes,
only reconfiguring the TX FIFO depth and GMII interface when the
negotiated speed actually changes. This matches the C driver behavior.

The Rust driver can be selected via the ET1011C_RUST_PHY Kconfig
option, following the same pattern as AX88796B_RUST_PHY.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/net/phy/Kconfig         |  9 ++++
 drivers/net/phy/Makefile        |  6 ++-
 drivers/net/phy/et1011c_rust.rs | 75 +++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/et1011c_rust.rs

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7b73332a13d9..5271898a38f7 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -254,6 +254,15 @@ config LSI_ET1011C_PHY
 	help
 	  Supports the LSI ET1011C PHY.
 
+config ET1011C_RUST_PHY
+	bool "Rust reference driver for LSI ET1011C PHY"
+	depends on RUST_PHYLIB_ABSTRACTIONS && LSI_ET1011C_PHY
+	help
+	  Uses the Rust reference driver for LSI ET1011C PHY
+	  (et1011c_rust.ko). The features and behavior are
+	  equivalent to the C driver. Selecting this option builds
+	  the Rust version instead of the C version.
+
 config MARVELL_PHY
 	tristate "Marvell Alaska PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 3a34917adea7..491469457a67 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -62,7 +62,11 @@ obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
-obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
+ifdef CONFIG_ET1011C_RUST_PHY
+  obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c_rust.o
+else
+  obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
+endif
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
diff --git a/drivers/net/phy/et1011c_rust.rs b/drivers/net/phy/et1011c_rust.rs
new file mode 100644
index 000000000000..7b8ae3bf492c
--- /dev/null
+++ b/drivers/net/phy/et1011c_rust.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2026 Artem Lytkin <iprintercanon@gmail.com>
+
+//! Rust LSI ET1011C PHY driver
+//!
+//! C version of this driver: [`drivers/net/phy/et1011c.c`](./et1011c.c)
+
+use kernel::{
+    net::phy::{self, reg::C22, DeviceId, Driver},
+    prelude::*,
+    uapi,
+};
+
+kernel::module_phy_driver! {
+    drivers: [PhyET1011C],
+    device_table: [
+        DeviceId::new_with_driver::<PhyET1011C>()
+    ],
+    name: "rust_et1011c_phy",
+    authors: ["Artem Lytkin <iprintercanon@gmail.com>"],
+    description: "Rust LSI ET1011C PHY driver",
+    license: "GPL",
+}
+
+const ET1011C_STATUS_REG: C22 = C22::vendor_specific::<0x1A>();
+const ET1011C_CONFIG_REG: C22 = C22::vendor_specific::<0x16>();
+
+const ET1011C_SPEED_MASK: u16 = 0x0300;
+const ET1011C_GIGABIT_SPEED: u16 = 0x0200;
+const ET1011C_TX_FIFO_MASK: u16 = 0x3000;
+const ET1011C_TX_FIFO_DEPTH_16: u16 = 0x1000;
+const ET1011C_GMII_INTERFACE: u16 = 0x0002;
+const ET1011C_SYS_CLK_EN: u16 = 0x0010;
+
+const BMCR_FULLDPLX: u16 = uapi::BMCR_FULLDPLX as u16;
+const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;
+const BMCR_SPEED1000: u16 = uapi::BMCR_SPEED1000 as u16;
+const BMCR_ANENABLE: u16 = uapi::BMCR_ANENABLE as u16;
+const BMCR_RESET: u16 = uapi::BMCR_RESET as u16;
+
+struct PhyET1011C;
+
+#[vtable]
+impl Driver for PhyET1011C {
+    const NAME: &'static CStr = c"ET1011C";
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x0282f014);
+
+    fn config_aneg(dev: &mut phy::Device) -> Result {
+        let ctl = dev.read(C22::BMCR)?;
+        let ctl = ctl & !(BMCR_FULLDPLX | BMCR_SPEED100 | BMCR_SPEED1000 | BMCR_ANENABLE);
+        dev.write(C22::BMCR, ctl | BMCR_RESET)?;
+        dev.genphy_config_aneg()
+    }
+
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        let old_speed = dev.speed();
+        dev.genphy_read_status::<C22>()?;
+
+        if old_speed != dev.speed() {
+            let val = dev.read(ET1011C_STATUS_REG)?;
+            if (val & ET1011C_SPEED_MASK) == ET1011C_GIGABIT_SPEED {
+                let cfg = dev.read(ET1011C_CONFIG_REG)?;
+                let cfg = cfg & !ET1011C_TX_FIFO_MASK;
+                dev.write(
+                    ET1011C_CONFIG_REG,
+                    cfg | ET1011C_GMII_INTERFACE
+                        | ET1011C_SYS_CLK_EN
+                        | ET1011C_TX_FIFO_DEPTH_16,
+                )?;
+            }
+        }
+
+        Ok(0)
+    }
+}
-- 
2.43.0


