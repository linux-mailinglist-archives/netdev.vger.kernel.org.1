Return-Path: <netdev+bounces-44548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA127D88B0
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9087F1C20F9E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092453B79A;
	Thu, 26 Oct 2023 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnUTYHnl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCA3B793
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 19:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D4FC43395;
	Thu, 26 Oct 2023 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698346870;
	bh=RxPwgiZlXvKIqQUXZOhCUZy0/PdYzWot7r+pZkkYB38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnUTYHnlJp+uBEFKogGRxcl5wCPbRLnp8DogJrN4MyzKDWPi72nZG4i0LNpg8WMBo
	 VIeyBjnG/8ROmFKi1MPE8RgsPGmfopxIiuXE7uBvXVPxQ7jrWn+e0jiEy/0yK2YX3X
	 wAFjhsowhhh30fPyqyluCFge0p6iN00U6ANPzCo3F3fE9dKC1GCmN1G17N9jDu06pv
	 yWhLWoCvqWS6XoD7TvuzSQsGiF9u2iiHNHj5a8lfx0L1ylywD4JYLUghX17iR4VLM1
	 S9zSe9imfAOk6gU49YBThbTfVVjpLki7s2bVYnd+nmXTda0D0qmQWZA8wKnNLvQqYZ
	 Ij6+0R5lDHZMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	arnd@arndb.de,
	ap420073@gmail.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com
Subject: [PATCH net-next 4/4] net: fill in MODULE_DESCRIPTION()s under drivers/net/
Date: Thu, 26 Oct 2023 12:01:01 -0700
Message-ID: <20231026190101.1413939-5-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026190101.1413939-1-kuba@kernel.org>
References: <20231026190101.1413939-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: arnd@arndb.de
CC: ap420073@gmail.com
CC: willemdebruijn.kernel@gmail.com
CC: jasowang@redhat.com
---
 drivers/net/amt.c        | 1 +
 drivers/net/dummy.c      | 1 +
 drivers/net/eql.c        | 1 +
 drivers/net/ifb.c        | 1 +
 drivers/net/macvtap.c    | 1 +
 drivers/net/sungem_phy.c | 1 +
 drivers/net/tap.c        | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 2d20be6ffb7e..53415e83821c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3449,5 +3449,6 @@ static void __exit amt_fini(void)
 module_exit(amt_fini);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for Automatic Multicast Tunneling (AMT)");
 MODULE_AUTHOR("Taehee Yoo <ap420073@gmail.com>");
 MODULE_ALIAS_RTNL_LINK("amt");
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index c4b1b0aa438a..768454aa36d6 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -202,4 +202,5 @@ static void __exit dummy_cleanup_module(void)
 module_init(dummy_init_module);
 module_exit(dummy_cleanup_module);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Dummy netdevice driver which discards all packets sent to it");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
diff --git a/drivers/net/eql.c b/drivers/net/eql.c
index ca3e4700a813..3c2efda916f1 100644
--- a/drivers/net/eql.c
+++ b/drivers/net/eql.c
@@ -607,4 +607,5 @@ static void __exit eql_cleanup_module(void)
 
 module_init(eql_init_module);
 module_exit(eql_cleanup_module);
+MODULE_DESCRIPTION("Equalizer Load-balancer for serial network interfaces");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 78253ad57b2e..2c1b5def4a0b 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -454,5 +454,6 @@ static void __exit ifb_cleanup_module(void)
 module_init(ifb_init_module);
 module_exit(ifb_cleanup_module);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intermediate Functional Block (ifb) netdevice driver for sharing of resources and ingress packet queuing");
 MODULE_AUTHOR("Jamal Hadi Salim");
 MODULE_ALIAS_RTNL_LINK("ifb");
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index bddcc127812e..29a5929d48e5 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -250,5 +250,6 @@ static void __exit macvtap_exit(void)
 module_exit(macvtap_exit);
 
 MODULE_ALIAS_RTNL_LINK("macvtap");
+MODULE_DESCRIPTION("MAC-VLAN based tap driver");
 MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index 36803d932dff..d591e33268e5 100644
--- a/drivers/net/sungem_phy.c
+++ b/drivers/net/sungem_phy.c
@@ -1194,4 +1194,5 @@ int sungem_phy_probe(struct mii_phy *phy, int mii_id)
 }
 
 EXPORT_SYMBOL(sungem_phy_probe);
+MODULE_DESCRIPTION("PHY drivers for the sungem Ethernet MAC driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5c01cc7b9949..9f0495e8df4d 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1399,6 +1399,7 @@ void tap_destroy_cdev(dev_t major, struct cdev *tap_cdev)
 }
 EXPORT_SYMBOL_GPL(tap_destroy_cdev);
 
+MODULE_DESCRIPTION("Common library for drivers implementing the TAP interface");
 MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
 MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
 MODULE_LICENSE("GPL");
-- 
2.41.0


