Return-Path: <netdev+bounces-44857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9387DA239
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A02282585
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1893FB20;
	Fri, 27 Oct 2023 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufLVu52B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B93FB11
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325ECC433C8;
	Fri, 27 Oct 2023 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698441196;
	bh=hgy/z4VYdhPL222FlA5dQfapeD9qqQwWjFbn5Oxwf4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufLVu52BbJltHGA7uG/dwjnEiSRV/bEj7ChrARDDNwaePk+R0lgbqlpzWfaLi5YIO
	 FRBy3iysaA5blaiE8uOg3qtolJ/OEP+ZB92wE2h7MtwsP7LpOYstuNgJkcz0w1d1rl
	 L8pj6MsVghAk3yRwZaP+VrV3dKPKh81/MLKzfqigZA0vVGaJHPR92WsSy7rZ452bUY
	 7N+vBsExYzxuiIL5x+Se2p4RP4lY0F8MfwcWzvxBvCQ7KvqbfvfqQ6k+58uXkNCeHw
	 Ngal8xDZfa+IJtO0Z2ufF/sA3hZ5aWdRUY5WGdyJDQH9lRsBLAW1yYuKtvuVkfPWSH
	 ET2LdVLecFwbw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ulf.hansson@linaro.org,
	rostedt@goodmis.org,
	sj@kernel.org,
	schspa@gmail.com,
	vladbu@nvidia.com,
	idosch@nvidia.com
Subject: [PATCH net-next v2 3/4] net: fill in MODULE_DESCRIPTION()s under net/802*
Date: Fri, 27 Oct 2023 14:13:10 -0700
Message-ID: <20231027211311.1821605-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027211311.1821605-1-kuba@kernel.org>
References: <20231027211311.1821605-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ulf.hansson@linaro.org
CC: rostedt@goodmis.org
CC: sj@kernel.org
CC: schspa@gmail.com
CC: vladbu@nvidia.com
CC: idosch@nvidia.com
---
 net/802/fddi.c   | 1 +
 net/802/garp.c   | 1 +
 net/802/mrp.c    | 1 +
 net/802/p8022.c  | 1 +
 net/802/psnap.c  | 1 +
 net/802/stp.c    | 1 +
 net/8021q/vlan.c | 1 +
 7 files changed, 7 insertions(+)

diff --git a/net/802/fddi.c b/net/802/fddi.c
index 7533ce26ba5f..888379ae35ec 100644
--- a/net/802/fddi.c
+++ b/net/802/fddi.c
@@ -175,4 +175,5 @@ struct net_device *alloc_fddidev(int sizeof_priv)
 }
 EXPORT_SYMBOL(alloc_fddidev);
 
+MODULE_DESCRIPTION("Core routines for FDDI network devices");
 MODULE_LICENSE("GPL");
diff --git a/net/802/garp.c b/net/802/garp.c
index ab24b21fbb49..6a743d004301 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -21,6 +21,7 @@
 static unsigned int garp_join_time __read_mostly = 200;
 module_param(garp_join_time, uint, 0644);
 MODULE_PARM_DESC(garp_join_time, "Join time in ms (default 200ms)");
+MODULE_DESCRIPTION("IEEE 802.1D Generic Attribute Registration Protocol (GARP)");
 MODULE_LICENSE("GPL");
 
 static const struct garp_state_trans {
diff --git a/net/802/mrp.c b/net/802/mrp.c
index eafc21ecc287..3154d7409493 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -26,6 +26,7 @@ static unsigned int mrp_periodic_time __read_mostly = 1000;
 module_param(mrp_periodic_time, uint, 0644);
 MODULE_PARM_DESC(mrp_periodic_time, "Periodic time in ms (default 1s)");
 
+MODULE_DESCRIPTION("IEEE 802.1Q Multiple Registration Protocol (MRP)");
 MODULE_LICENSE("GPL");
 
 static const u8
diff --git a/net/802/p8022.c b/net/802/p8022.c
index 79c23173116c..78c25168d7c9 100644
--- a/net/802/p8022.c
+++ b/net/802/p8022.c
@@ -60,4 +60,5 @@ void unregister_8022_client(struct datalink_proto *proto)
 EXPORT_SYMBOL(register_8022_client);
 EXPORT_SYMBOL(unregister_8022_client);
 
+MODULE_DESCRIPTION("Support for 802.2 demultiplexing off Ethernet");
 MODULE_LICENSE("GPL");
diff --git a/net/802/psnap.c b/net/802/psnap.c
index 1406bfdbda13..fca9d454905f 100644
--- a/net/802/psnap.c
+++ b/net/802/psnap.c
@@ -160,4 +160,5 @@ void unregister_snap_client(struct datalink_proto *proto)
 	kfree(proto);
 }
 
+MODULE_DESCRIPTION("SNAP data link layer. Derived from 802.2");
 MODULE_LICENSE("GPL");
diff --git a/net/802/stp.c b/net/802/stp.c
index d550d9f88f60..03c9f75e92c9 100644
--- a/net/802/stp.c
+++ b/net/802/stp.c
@@ -98,4 +98,5 @@ void stp_proto_unregister(const struct stp_proto *proto)
 }
 EXPORT_SYMBOL_GPL(stp_proto_unregister);
 
+MODULE_DESCRIPTION("SAP demux for IEEE 802.1D Spanning Tree Protocol (STP)");
 MODULE_LICENSE("GPL");
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e40aa3e3641c..e45187b88220 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -738,5 +738,6 @@ static void __exit vlan_cleanup_module(void)
 module_init(vlan_proto_init);
 module_exit(vlan_cleanup_module);
 
+MODULE_DESCRIPTION("802.1Q/802.1ad VLAN Protocol");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
-- 
2.41.0


