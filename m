Return-Path: <netdev+bounces-240518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91796C75CFD
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2530A30914
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6E34CFD4;
	Thu, 20 Nov 2025 17:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AE3242A0;
	Thu, 20 Nov 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661062; cv=none; b=nXDMDqEKN5JeAAdo1EytrDqyOelv1iLOT1EbU9OKEfyIGCnH4x3SjDVK8QsSHVYyym9AVExecUS0XRI8ksNv9HWNMWVFpsEJ0loQ7w97u4xGRFWBuuOZXf/63++JPYUF1nzfhxsZxX2WP2DojfuIiPpEBWX+P0SERhKSWiXwdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661062; c=relaxed/simple;
	bh=uEWtOV3QUkQ4YJljyOKiXRV0Jl2FuYMkLE4HEFdc120=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p//G4abLd93ecF7X55bbtZbHOGGcHsL2uYsippkgiyi/wvYzpI0chyUSBnhGkdhUGodAwFs9xzi6BnbgnnxLHF531oB9QBtyDj1pZzPPNcTxZfel12JbwevKtHfZ1mMObNXPpQn0FwqT+zqtPL0ksH93LKCRIOEaWWP+0ssMZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5Tw6063zHnGh7;
	Fri, 21 Nov 2025 01:50:12 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 023B81402EC;
	Fri, 21 Nov 2025 01:50:48 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:50:47 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Xiao Liang <shaw.leon@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Julian
 Vetter <julian@outer-limits.org>, Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	<linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 08/12] ipvlan: const-specifier for functions that use iaddr
Date: Thu, 20 Nov 2025 20:49:45 +0300
Message-ID: <20251120174949.3827500-9-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Fix functions that accept "void *iaddr" as param to have
const-specifier.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      | 6 +++---
 drivers/net/ipvlan/ipvlan_core.c | 2 +-
 drivers/net/ipvlan/ipvlan_main.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index c087697340dc..fe2f7895598e 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -200,11 +200,11 @@ void ipvlan_multicast_enqueue(struct ipvl_port *port,
 int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev);
 void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr);
 int ipvlan_add_addr(struct ipvl_dev *ipvlan,
-		    void *iaddr, bool is_v6, const u8 *hwaddr);
-void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6);
+		    const void *iaddr, bool is_v6, const u8 *hwaddr);
+void ipvlan_del_addr(struct ipvl_dev *ipvlan, const void *iaddr, bool is_v6);
 struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 				   const void *iaddr, bool is_v6);
-bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6);
+bool ipvlan_addr_busy(struct ipvl_port *port, const void *iaddr, bool is_v6);
 void ipvlan_ht_addr_del(struct ipvl_addr *addr);
 struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 				     int addr_type, bool use_dest);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 8141ab480620..ce6202667159 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -121,7 +121,7 @@ struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 	return ret;
 }
 
-bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6)
+bool ipvlan_addr_busy(struct ipvl_port *port, const void *iaddr, bool is_v6)
 {
 	struct ipvl_dev *ipvlan;
 	bool ret = false;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 74da68babba1..7be0722e688f 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -1058,7 +1058,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 }
 
 /* the caller must held the addrs lock */
-int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
+int ipvlan_add_addr(struct ipvl_dev *ipvlan, const void *iaddr, bool is_v6,
 		    const u8 *hwaddr)
 {
 	struct ipvl_addr *addr;
@@ -1092,7 +1092,7 @@ int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
 	return 0;
 }
 
-void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
+void ipvlan_del_addr(struct ipvl_dev *ipvlan, const void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
-- 
2.25.1


