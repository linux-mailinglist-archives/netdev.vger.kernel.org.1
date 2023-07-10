Return-Path: <netdev+bounces-16368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6E74CEAD
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387CA280F6E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B08C8EE;
	Mon, 10 Jul 2023 07:39:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B99C8CC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:39:12 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316AE77;
	Mon, 10 Jul 2023 00:38:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so612120b3a.0;
        Mon, 10 Jul 2023 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974736; x=1691566736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvWjzWyFKI2pPo1p6eQdrq9RKByhHwpQNo4P07gJwcY=;
        b=jVQjD4lw3c7pfmKN6CHCW+s8gwwWrPswqaPE1kUojRGMFWS7Mv2Kq0eBrDgFfkSoaz
         sDaOP8iVtzYJDIm6TM+v3Lz3aaCobDNPsmrWonQZPp4W2F3Pv6NHPgji9Z/2zVXiSqug
         JFJB/yTeMMU4gPaKTh75E8otIAm+0ccO38Dj753kyJK4Pn/yg75YAhtdr3B137PzIwhJ
         aSJv3mKBM0wqQUhlosgqTEVlWVkBY8lHobz47LZTUxjq80oudrMS4jYKEjzfo/w0N7Ma
         1Fds8r5YQdvyJvT9eOtQl7WteBfivpVM+R5y4cIg6gNrSt/crMRkdbXfnvTU2MV6gotF
         mw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974736; x=1691566736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvWjzWyFKI2pPo1p6eQdrq9RKByhHwpQNo4P07gJwcY=;
        b=ePT2w/EdfdNZB9LvvY7HvBhNEBN1YczWdSt0e0dPl8EYUutdD+gTLjt2BRKV0XRP0V
         /v17vH97qds9ZsxFMwDH39Ly5qmzDC6CcIBGLdA0xxdX9cKCsnUIegp6Uh8RqFJMYKss
         qzvzQoqmyUmHqaJO6rP5OsyXt+uHquaPCA9D1n4Qa658hqiZKXziLMuAe4N9BATUcePY
         wlP4X9A59y1QGhzYsaN+lUTnGs94M2bgTm6D0xBosynT/1vBY7f6ST/yPKpe3KUc5YW1
         P8aJCulgTRQORhmCMsKdB3XvcjXJOVht+uxhheE7JRs5tKU9auNw98PVIDMXFmW8PW0i
         wt4w==
X-Gm-Message-State: ABy/qLaZEaHrXlmDiCkw8hydUskcGsW80cKGX/SGjIsds3yfmgIuwqg9
	B8g4YKpx1rugdWgvZPLmSBYMm+rLLC3EGpHs
X-Google-Smtp-Source: APBJJlEuaaOWrQYx5CzCg2H6QF2pidZTjjA5+vccsiHPwjAcsk5iWIlAMpUOnjL1fJkOLkdJRr08Dg==
X-Received: by 2002:a05:6a00:3387:b0:675:8627:a291 with SMTP id cm7-20020a056a00338700b006758627a291mr12242941pfb.3.1688974735917;
        Mon, 10 Jul 2023 00:38:55 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r20-20020a62e414000000b0063f2a5a59d1sm6514483pfh.190.2023.07.10.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:38:55 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew@lunn.ch,
	aliceryhl@google.com,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH v2 4/5] samples: rust: add dummy network driver
Date: Mon, 10 Jul 2023 16:37:02 +0900
Message-Id: <20230710073703.147351-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710073703.147351-1-fujita.tomonori@gmail.com>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a simpler version of drivers/net/dummy.c.

This demonstrates the usage of abstractions for network device drivers.

Allows allocator_api feature for Box::try_new();

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 samples/rust/Kconfig           | 13 ++++++
 samples/rust/Makefile          |  1 +
 samples/rust/rust_net_dummy.rs | 75 ++++++++++++++++++++++++++++++++++
 scripts/Makefile.build         |  2 +-
 4 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 samples/rust/rust_net_dummy.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..02bda7bdf722 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -30,6 +30,19 @@ config SAMPLE_RUST_PRINT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_NET_DUMMY
+	tristate "Dummy network driver"
+	depends on NET
+	help
+	  This is the simpler version of drivers/net/dummy.c.
+	  No intention to replace it. This provides educational information
+	  for Rust abstractions for network device drivers.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_net_dummy.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..440dee2971ba 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_NET_DUMMY)		+= rust_net_dummy.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_net_dummy.rs b/samples/rust/rust_net_dummy.rs
new file mode 100644
index 000000000000..78f8f3321fd2
--- /dev/null
+++ b/samples/rust/rust_net_dummy.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+//! Rust dummy netdev.
+
+//use kernel::types::ForeignOwnable;
+use kernel::{
+    c_str,
+    net::dev::{
+        flags, priv_flags, Device, DeviceOperations, EtherOperations, EthtoolTsInfo, Registration,
+        SkBuff, TxCode,
+    },
+    prelude::*,
+};
+
+module! {
+    type: DummyNetdev,
+    name: "rust_net_dummy",
+    author: "Rust for Linux Contributors",
+    description: "Rust dummy netdev",
+    license: "GPL v2",
+}
+
+#[vtable]
+impl DeviceOperations for Box<DriverData> {
+    fn init(dev: Device<Box<DriverData>>) -> Result {
+        // how to access to the driver private data.
+        let _ = dev.drv_priv_data();
+        Ok(())
+    }
+
+    fn start_xmit(_dev: Device<Box<DriverData>>, mut skb: SkBuff) -> TxCode {
+        skb.tx_timestamp();
+        skb.consume();
+        TxCode::Ok
+    }
+}
+
+/// For device driver specific information.
+struct DriverData {}
+
+struct DummyNetdev {
+    _r: Registration<Box<DriverData>>,
+}
+
+#[vtable]
+impl EtherOperations for Box<DriverData> {
+    fn get_ts_info(dev: Device<Box<DriverData>>, mut info: EthtoolTsInfo) -> Result {
+        EthtoolTsInfo::ethtool_op_get_ts_info(&dev, &mut info)
+    }
+}
+
+impl kernel::Module for DummyNetdev {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        let data = Box::try_new(DriverData {})?;
+        let mut r = Registration::<Box<DriverData>>::try_new_ether(1, 1, data)?;
+        r.set_ether_operations::<Box<DriverData>>()?;
+
+        let netdev = r.dev_get();
+        netdev.set_name(c_str!("dummy%d"))?;
+
+        netdev.set_flags(netdev.get_flags() | flags::IFF_NOARP & !flags::IFF_MULTICAST);
+        netdev.set_priv_flags(
+            netdev.get_priv_flags() | priv_flags::IFF_LIVE_ADDR_CHANGE | priv_flags::IFF_NO_QUEUE,
+        );
+        netdev.set_random_eth_hw_addr();
+        netdev.set_min_mtu(0);
+        netdev.set_max_mtu(0);
+
+        r.register()?;
+
+        // TODO: Replaces pr_info with the wrapper of netdev_info().
+        pr_info!("Hello Rust dummy netdev!");
+        Ok(DummyNetdev { _r: r })
+    }
+}
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 78175231c969..1404967e908e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit
+rust_allowed_features := allocator_api,new_uninit
 
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
-- 
2.34.1


