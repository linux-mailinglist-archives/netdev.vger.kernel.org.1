Return-Path: <netdev+bounces-302906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XhhZHMYvQ2oKUAoAu9opvQ
	(envelope-from <netdev+bounces-302906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:53:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C26DFEA3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:53:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=RjGnqNfX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302906-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302906-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBA7130C6569
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E6D3DA5D8;
	Tue, 30 Jun 2026 02:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3473C4B94;
	Tue, 30 Jun 2026 02:48:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787685; cv=none; b=gHoBN4xG9nJpoTlxUnZ8ZtPe6CaRY6WhePnAkTx72eCtp/e0FMsy4HQPX+r7+FLyEwiKm4ZZGg0ENJNcXZt3asfIpuPQ2n32m0XBDeaFC7jrPzkTBz4PmB4o8uKljEHi0CIhvlKhl+y+foBRPkY2U0HH9JnYNDLmLRnRJoWnY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787685; c=relaxed/simple;
	bh=J/TRXZoiBh1T7165UvlsuvtEr1+p9CLS7f4wGjwZSHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdKa2G+d3pecz+I7S/YUxzVlaIX6u7n4uEYM+dqK+SzeWAMJmknic4Q2DheetNHbwW4X7IWYDl5S6NaldprgDiiaqDKbFwdqkTKmhxxPV6G72PPfa92KH96gQzlpqrw+oSIGpaGEmZiPFNkQEOrTuaU5tmM3eS73C3iNxtCxmps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RjGnqNfX; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1JZng3491675;
	Mon, 29 Jun 2026 19:47:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	3lWwzpd0TA6RxX/2ViOTu9GYx0h40r7E52ijv3+K3I=; b=RjGnqNfXwhDRj3vZe
	D7fKSRU1uSWalcsKNnonAIce+qi/N8bsFhrBNG3XkOgsMoU05/hMvduvOfhd/HMR
	7CIwiFR5sjJYtPQ0XSd0d0/cHX1nM+mdmVznoD0OlBHpBtBkNTX0I8+Ru9DrXV+P
	ZIcfVTA7oVS/JG7rasnvPwOP9DWTgGydIVY4pZZDZqMCKl0Np71rR9vv1eObAfaU
	zNvH+ChijzMY/hBmjinmE5bF4/vaUCdy6iBIglT2SejqdpkDXhWkoMJ8U1bCaPmM
	f1ap1l7FfLw12uLpqdpFaacfrGsb5whLv++8MkTjCIjaHN9fmPJD4zrQbqc0QnBB
	bg63w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f2e1h7ypj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 19:47:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 19:47:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 19:47:45 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C08873F7041;
	Mon, 29 Jun 2026 19:47:41 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next 6/9] octeontx2-pf: register switch notifiers for eswitch offload
Date: Tue, 30 Jun 2026 08:17:12 +0530
Message-ID: <20260630024715.4124281-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630024715.4124281-1-rkannoth@marvell.com>
References: <20260630024715.4124281-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DJFH1Y3TR7RxE6Bhp1_J57_TaIpf6LSk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX+UAc3sL1PliA
 u/SSqkSK8lVGljHLjzc5DvwgX0vJT+BNg7XvA3DDWIpndtl4N2MW3r4ljoGokQv3pl39cOmbbEe
 +4SAO9Bja96gylZMZ9ZaNk6yew3Fs7k=
X-Authority-Analysis: v=2.4 cv=e802j6p/ c=1 sm=1 tr=0 ts=6a432e56 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=kubnibgvJZR3beTJyoEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: DJFH1Y3TR7RxE6Bhp1_J57_TaIpf6LSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX5kbx2ajcoyKq
 /9rLu8il5zuO9BBy0JCiP414OZgku9UwXbUl/WsXGLkHYE+4W2NTLbAoEh8CQUHKFx+scz2SAzJ
 B8xhS7Cm/KKQ2hUCSGQYYxiuwjwSIRDvtbcKeypOboOX8NlsNJ4Ta82O+XZdm9UakvvD6DYqLAP
 BhfVzDG056c67EgEEt+9ILcLtJRG3yzYYzNlw4eO9B/u7wqOoVUsS5ycaaD4k1qJvzZ6+5W1uh7
 N5nJOwJqQo6TYNhPB0dw5p+Tg95sSO2v48rP/lJg4jAus8BwaJsPAMilFJKuIhrmSEzTbD1RdFL
 gPGjyh+pbDH6eu4ruqjWYGXeZ75PQiHlpb63Kt4veLnFgAaj2uD5uEnhJgBCVouuM5HcpwLhzpj
 Le0kirAEHXso30sx0vhfWCFqebzT9sZfD2Yap/VaPJEKMUsPVrNJHKyKchw04pcvuGMfxxzOutj
 EtzuGSsOvTWoN1AOb5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302906-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,priv.data:url];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E21C26DFEA3

The representor enables switch mode via devlink; register and unregister
the switch notifier blocks when that mode is turned on or off so the PF
can observe FIB routes, neighbour updates, IPv4/IPv6 address changes,
netdev state, and switchdev FDB notifications.
Add sw_nb_v4.c and sw_nb_v6.c for IPv4 and IPv6-specific handling, build
sw_nb_v6.o only when CONFIG_IPV6 is set, and extend sw_nb.c with device
filtering for Cavium ports behind bridges and VLANs.
Initialize and tear down the existing sw_fdb, sw_fib, and sw_fl helpers
together with notifier registration.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/Makefile   |   7 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |   9 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 410 +++++++++++++++++-
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  28 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   | 323 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v4.h   |  21 +
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   | 237 ++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v6.h   |  21 +
 8 files changed, 1050 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index da87e952c187..0e12659876e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -13,7 +13,12 @@ rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
 	       switch/sw_fdb.o switch/sw_fl.o
 
 ifdef CONFIG_OCTEONTX_SWITCH
-rvu_nicpf-y += switch/sw_nb.o switch/sw_fib.o
+rvu_nicpf-y += switch/sw_nb.o switch/sw_fib.o \
+	       switch/sw_nb_v4.o
+
+ifdef CONFIG_IPV6
+rvu_nicpf-y += switch/sw_nb_v6.o
+endif
 endif
 
 rvu_nicvf-y := otx2_vf.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 257a2ae6a53e..e4c01ac87477 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -15,6 +15,7 @@
 #include "cn10k.h"
 #include "otx2_reg.h"
 #include "rep.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_rep"
 #define DRV_STRING	"Marvell RVU Representor Driver"
@@ -399,6 +400,9 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	struct net_device *netdev = priv->netdev;
+#endif
 	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
@@ -414,6 +418,11 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	ena ? sw_nb_register(netdev) : sw_nb_unregister(netdev);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 2d14a0590c5d..5d69961f516b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -4,14 +4,420 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
 #include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+#include "sw_nb_v4.h"
+#include "sw_nb_v6.h"
+
+/* PF netdev for netdev_* logging when notifier info has no device */
+static struct net_device *sw_nb_pf_netdev;
 
-int sw_nb_unregister(void)
+static const char *sw_nb_cmd2str[OTX2_CMD_MAX] = {
+	[OTX2_DEV_UP]  = "OTX2_DEV_UP",
+	[OTX2_DEV_DOWN] = "OTX2_DEV_DOWN",
+	[OTX2_DEV_CHANGE] = "OTX2_DEV_CHANGE",
+	[OTX2_NEIGH_UPDATE] = "OTX2_NEIGH_UPDATE",
+	[OTX2_FIB_ENTRY_REPLACE] = "OTX2_FIB_ENTRY_REPLACE",
+	[OTX2_FIB_ENTRY_ADD] = "OTX2_FIB_ENTRY_ADD",
+	[OTX2_FIB_ENTRY_DEL] = "OTX2_FIB_ENTRY_DEL",
+	[OTX2_FIB_ENTRY_APPEND] = "OTX2_FIB_ENTRY_APPEND",
+};
+
+const char *sw_nb_get_cmd2str(int cmd)
 {
+	return sw_nb_cmd2str[cmd];
+}
+EXPORT_SYMBOL(sw_nb_get_cmd2str);
+
+bool sw_nb_is_cavium_dev(struct net_device *netdev)
+{
+	struct pci_dev *pdev;
+	struct device *dev;
+
+	dev = netdev->dev.parent;
+	if (!dev)
+		return false;
+
+	pdev = container_of(dev, struct pci_dev, dev);
+	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)
+		return false;
+
+	return true;
+}
+
+static int sw_nb_check_slaves(struct net_device *dev,
+			      struct netdev_nested_priv *priv)
+{
+	int *cnt;
+
+	if (!priv->flags)
+		return 0;
+
+	priv->flags &= sw_nb_is_cavium_dev(dev);
+	if (priv->flags) {
+		cnt = priv->data;
+		(*cnt)++;
+	}
+
 	return 0;
 }
 
-int sw_nb_register(void)
+bool sw_nb_is_valid_dev(struct net_device *netdev)
+{
+	struct netdev_nested_priv priv;
+	struct net_device *br;
+	int cnt = 0;
+
+	priv.flags = true;
+	priv.data = &cnt;
+
+	if (netif_is_bridge_master(netdev) || is_vlan_dev(netdev)) {
+		netdev_walk_all_lower_dev(netdev, sw_nb_check_slaves, &priv);
+		return priv.flags && !!*(int *)priv.data;
+	}
+
+	if (netif_is_bridge_port(netdev)) {
+		br = netdev_master_upper_dev_get_rcu(netdev);
+		if (!br)
+			return false;
+
+		netdev_walk_all_lower_dev(br, sw_nb_check_slaves, &priv);
+		return priv.flags && !!*(int *)priv.data;
+	}
+
+	return sw_nb_is_cavium_dev(netdev);
+}
+
+static int sw_nb_fdb_event(struct notifier_block *unused,
+			   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		if (fdb_info->is_local)
+			break;
+		break;
+
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (fdb_info->is_local)
+			break;
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_fdb = {
+	.notifier_call = sw_nb_fdb_event,
+};
+
+static void __maybe_unused
+sw_nb_fib_event_dump(unsigned long event, void *ptr)
 {
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct net_device *log_dev;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	int i;
+
+	fi = fen_info->fi;
+	log_dev = (fi && fi->fib_nhs) ? fi->fib_nh->fib_nh_dev : sw_nb_pf_netdev;
+	if (log_dev)
+		netdev_info(log_dev, "%s: FIB event=%lu dst=%#x dstlen=%u type=%u\n",
+			    __func__, event, fen_info->dst, fen_info->dst_len,
+			    fen_info->type);
+
+	if (!fi)
+		return;
+
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
+		if (!fib_nh->fib_nh_dev)
+			continue;
+		netdev_info(fib_nh->fib_nh_dev,
+			    "%s: dev=%s saddr=%#x gw=%#x\n",
+			    __func__, fib_nh->fib_nh_dev->name,
+			    fib_nh->nh_saddr, fib_nh->fib_nh_gw4);
+	}
+}
+
+#define SWITCH_NB_FIB_EVENT_DUMP(...) \
+	sw_nb_fib_event_dump(__VA_ARGS__)
+
+int sw_nb_fib_event_to_otx2_event(int event, struct net_device *netdev)
+{
+	switch (event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+		return OTX2_FIB_ENTRY_REPLACE;
+	case FIB_EVENT_ENTRY_ADD:
+		return OTX2_FIB_ENTRY_ADD;
+	case FIB_EVENT_ENTRY_DEL:
+		return OTX2_FIB_ENTRY_DEL;
+	default:
+		break;
+	}
+
+	netdev_err(netdev, "Wrong FIB event %d\n", event);
+	return -1;
+}
+
+static int sw_nb_fib_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct fib_notifier_info *info = ptr;
+
+	switch (event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+	case FIB_EVENT_ENTRY_ADD:
+	case FIB_EVENT_ENTRY_DEL:
+		break;
+	default:
+		if (sw_nb_pf_netdev)
+			netdev_dbg(sw_nb_pf_netdev,
+				   "%s: Won't process FIB event %lu\n",
+				   __func__, event);
+		return NOTIFY_DONE;
+	}
+
+	switch (info->family) {
+	case AF_INET:
+		return sw_nb_v4_fib_event(nb, event, ptr);
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		return sw_nb_v6_fib_event(nb, event, ptr);
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_fib = {
+	.notifier_call = sw_nb_fib_event,
+};
+
+static int sw_nb_net_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct neighbour *n = ptr;
+
+	if (!sw_nb_is_valid_dev(n->dev))
+		return NOTIFY_DONE;
+
+	if (event != NETEVENT_NEIGH_UPDATE)
+		return NOTIFY_DONE;
+
+	switch (n->tbl->family) {
+	case AF_INET:
+		return sw_nb_net_v4_neigh_update(nb, event, ptr);
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		return sw_nb_net_v6_neigh_update(nb, event, ptr);
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netevent = {
+	.notifier_call = sw_nb_net_event,
+
+};
+
+int sw_nb_inetaddr_event_to_otx2_event(int event, struct net_device *netdev)
+{
+	switch (event) {
+	case NETDEV_CHANGE:
+		return OTX2_DEV_CHANGE;
+	case NETDEV_UP:
+		return OTX2_DEV_UP;
+	case NETDEV_DOWN:
+		return OTX2_DEV_DOWN;
+	default:
+		break;
+	}
+	netdev_dbg(netdev, "%s: Wrong interaddr event %d\n",
+		   __func__, event);
+	return -1;
+}
+
+static struct notifier_block sw_nb_v4_inetaddr = {
+	.notifier_call = sw_nb_v4_inetaddr_event,
+};
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct notifier_block sw_nb_v6_inetaddr = {
+	.notifier_call = sw_nb_v6_inetaddr_event,
+};
+#endif
+
+static int sw_nb_netdev_event(struct notifier_block *unused,
+			      unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct in_device *idev;
+	struct inet6_dev *i6dev;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	idev = __in_dev_get_rtnl(dev);
+	if (idev)
+		sw_nb_v4_netdev_event(unused, event, ptr);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	i6dev = __in6_dev_get(dev);
+	if (i6dev)
+		sw_nb_v6_netdev_event(unused, event, ptr);
+#endif
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netdev = {
+	.notifier_call = sw_nb_netdev_event,
+};
+
+int sw_nb_unregister(struct net_device *netdev)
+{
+	int err;
+
+	err = unregister_switchdev_notifier(&sw_nb_fdb);
+
+	if (err)
+		netdev_err(netdev, "Failed to unregister switchdev nb\n");
+
+	err = unregister_fib_notifier(&init_net, &sw_nb_fib);
+	if (err)
+		netdev_err(netdev, "Failed to unregister fib nb\n");
+
+	err = unregister_netevent_notifier(&sw_nb_netevent);
+	if (err)
+		netdev_err(netdev, "Failed to unregister netevent\n");
+
+	err = unregister_inetaddr_notifier(&sw_nb_v4_inetaddr);
+	if (err)
+		netdev_err(netdev, "Failed to unregister addr event\n");
+
+#if IS_ENABLED(CONFIG_IPV6)
+	err = unregister_inet6addr_notifier(&sw_nb_v6_inetaddr);
+	if (err)
+		netdev_err(netdev, "Failed to unregister addr event\n");
+#endif
+
+	err = unregister_netdevice_notifier(&sw_nb_netdev);
+	if (err)
+		netdev_err(netdev, "Failed to unregister netdev notifier\n");
+
+	sw_fl_deinit();
+	sw_fib_deinit();
+	sw_fdb_deinit();
+
+	sw_nb_pf_netdev = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL(sw_nb_unregister);
+
+int sw_nb_register(struct net_device *netdev)
+{
+	int err;
+
+	sw_nb_pf_netdev = netdev;
+
+	sw_fdb_init();
+	sw_fib_init();
+	sw_fl_init();
+
+	err = register_switchdev_notifier(&sw_nb_fdb);
+	if (err) {
+		netdev_err(netdev, "Failed to register switchdev nb\n");
+		sw_nb_pf_netdev = NULL;
+		return err;
+	}
+
+	err = register_fib_notifier(&init_net, &sw_nb_fib, NULL, NULL);
+	if (err) {
+		netdev_err(netdev, "Failed to register fb notifier block\n");
+		goto err1;
+	}
+
+	err = register_netevent_notifier(&sw_nb_netevent);
+	if (err) {
+		netdev_err(netdev, "Failed to register netevent\n");
+		goto err2;
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	err = register_inet6addr_notifier(&sw_nb_v6_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to register addr event\n");
+		goto err3;
+	}
+#endif
+
+	err = register_inetaddr_notifier(&sw_nb_v4_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to register addr event\n");
+		goto err4;
+	}
+
+	err = register_netdevice_notifier(&sw_nb_netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to register netdevice nb\n");
+		goto err5;
+	}
+
 	return 0;
+
+err5:
+	unregister_inetaddr_notifier(&sw_nb_v4_inetaddr);
+
+err4:
+#if IS_ENABLED(CONFIG_IPV6)
+	unregister_inet6addr_notifier(&sw_nb_v6_inetaddr);
+
+err3:
+#endif
+	unregister_netevent_notifier(&sw_nb_netevent);
+
+err2:
+	unregister_fib_notifier(&init_net, &sw_nb_fib);
+
+err1:
+	unregister_switchdev_notifier(&sw_nb_fdb);
+	sw_nb_pf_netdev = NULL;
+	return err;
 }
+EXPORT_SYMBOL(sw_nb_register);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
index 5f744cc3ecbb..b0ce10ed25d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -7,7 +7,29 @@
 #ifndef SW_NB_H_
 #define SW_NB_H_
 
-int sw_nb_register(void);
-int sw_nb_unregister(void);
+enum {
+	OTX2_DEV_UP = 1,
+	OTX2_DEV_DOWN,
+	OTX2_DEV_CHANGE,
+	OTX2_NEIGH_UPDATE,
+	OTX2_FIB_ENTRY_REPLACE,
+	OTX2_FIB_ENTRY_ADD,
+	OTX2_FIB_ENTRY_DEL,
+	OTX2_FIB_ENTRY_APPEND,
+	OTX2_CMD_MAX,
+};
 
-#endif // SW_NB_H_
+int sw_nb_register(struct net_device *netdev);
+int sw_nb_unregister(struct net_device *netdev);
+bool sw_nb_is_valid_dev(struct net_device *netdev);
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
+
+bool sw_nb_is_cavium_dev(struct net_device *netdev);
+int sw_nb_fib_event_to_otx2_event(int event, struct net_device *netdev);
+int sw_nb_inetaddr_event_to_otx2_event(int event, struct net_device *netdev);
+
+const char *sw_nb_get_cmd2str(int cmd);
+#endif // SW_NB_H__
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
new file mode 100644
index 000000000000..14db824ddc06
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+#include <linux/inetdevice.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+#include "sw_nb.h"
+#include "sw_nb_v4.h"
+
+int sw_nb_v4_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *pf_dev;
+	struct in_ifaddr *ifa;
+	struct fib_entry *entry;
+	struct in_device *idev;
+	struct otx2_nic *pf;
+	struct list_head *iter;
+	struct net_device *lower;
+
+	idev = __in_dev_get_rtnl(dev);
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
+	ifa = rtnl_dereference(idev->ifa_list);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	entry->dst = (__force u32)htonl((__force u32)ifa->ifa_address);
+	entry->dst_len = 32;
+	entry->mac_valid = 1;
+	entry->host = 1;
+
+	pf_dev = dev;
+	if (netif_is_bridge_master(dev))  {
+		entry->bridge = 1;
+		netdev_for_each_lower_dev(dev, lower, iter) {
+			pf_dev = lower;
+			break;
+		}
+	} else if (is_vlan_dev(dev)) {
+		entry->vlan_valid = 1;
+		pf_dev = vlan_dev_real_dev(dev);
+		entry->vlan_tag = vlan_dev_vlan_id(dev);
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+
+	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
+		   __func__, entry->dst, entry->mac, dev->name);
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr)
+{
+	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct net_device *dev = ifa->ifa_dev->dev;
+	struct net_device *lower, *pf_dev;
+	struct netdev_hw_addr *dev_addr;
+	struct fib_entry *entry;
+	struct in_device *idev;
+	struct list_head *iter;
+	struct otx2_nic *pf;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	idev = __in_dev_get_rtnl(dev);
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	entry->dst = (__force u32)htonl((__force u32)ifa->ifa_address);
+	entry->dst_len = 32;
+	entry->mac_valid = 1;
+	entry->host = 1;
+
+	pf_dev = dev;
+	if (netif_is_bridge_master(dev))  {
+		entry->bridge = 1;
+		netdev_for_each_lower_dev(dev, lower, iter) {
+			pf_dev = lower;
+			break;
+		}
+	} else if (is_vlan_dev(dev)) {
+		entry->vlan_valid = 1;
+		pf_dev = vlan_dev_real_dev(dev);
+		entry->vlan_tag = vlan_dev_vlan_id(dev);
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+
+	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
+		   __func__, entry->dst, entry->mac, dev->name);
+
+	kfree(entry);
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v4_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct fib_entry *entries, *iter;
+	struct net_device *dev, *pf_dev = NULL;
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *lower;
+	struct list_head *lh;
+	struct neighbour *neigh;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	struct otx2_nic *pf;
+	u32 *haddr;
+	int hcnt = 0;
+	int cnt, i;
+
+	/* Process only UNICAST routes add or del */
+	if (fen_info->type != RTN_UNICAST)
+		return NOTIFY_DONE;
+
+	fi = fen_info->fi;
+	if (!fi)
+		return NOTIFY_DONE;
+
+	if (fi->fib_nh_is_v6) {
+		struct net_device *log_dev = (fi->fib_nhs > 0) ?
+			fi->fib_nh->fib_nh_dev : NULL;
+
+		if (log_dev)
+			netdev_dbg(log_dev, "%s: Received v6 notification\n",
+				   __func__);
+		return NOTIFY_DONE;
+	}
+
+	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	haddr = kcalloc(fi->fib_nhs, sizeof(u32), GFP_ATOMIC);
+
+	iter = entries;
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
+		dev = fib_nh->fib_nh_dev;
+
+		if (!dev)
+			continue;
+
+		if (dev->type != ARPHRD_ETHER)
+			continue;
+
+		if (!sw_nb_is_valid_dev(dev))
+			continue;
+
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event, dev);
+		iter->dst = fen_info->dst;
+		iter->dst_len = fen_info->dst_len;
+		iter->gw = (__force u32)htonl((__force u32)fib_nh->fib_nh_gw4);
+
+		netdev_dbg(dev, "%s: FIB route Rule cmd=%lld dst=%#x dst_len=%d gw=%#x\n",
+			   __func__, iter->cmd, iter->dst, iter->dst_len, iter->gw);
+
+		pf_dev = dev;
+		if (netif_is_bridge_master(dev))  {
+			iter->bridge = 1;
+			netdev_for_each_lower_dev(dev, lower, lh) {
+				pf_dev = lower;
+				break;
+			}
+		} else if (is_vlan_dev(dev)) {
+			iter->vlan_valid = 1;
+			pf_dev = vlan_dev_real_dev(dev);
+			iter->vlan_tag = vlan_dev_vlan_id(dev);
+		}
+
+		pf = netdev_priv(pf_dev);
+		iter->port_id = pf->pcifunc;
+
+		if (!fib_nh->fib_nh_gw4) {
+			if (iter->dst || iter->dst_len)
+				iter++;
+
+			continue;
+		}
+		iter->gw_valid = 1;
+
+		if (fib_nh->nh_saddr)
+			haddr[hcnt++] = (__force u32)fib_nh->nh_saddr;
+
+		rcu_read_lock();
+		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);
+		if (!neigh) {
+			rcu_read_unlock();
+			iter++;
+			continue;
+		}
+
+		if (is_valid_ether_addr(neigh->ha)) {
+			iter->mac_valid = 1;
+			ether_addr_copy(iter->mac, neigh->ha);
+		}
+
+		iter++;
+		rcu_read_unlock();
+	}
+
+	cnt = iter - entries;
+	if (!cnt)
+		return NOTIFY_DONE;
+
+	netdev_dbg(pf_dev, "pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
+	kfree(entries);
+
+	if (!hcnt)
+		return NOTIFY_DONE;
+
+	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	iter = entries;
+
+	for (i = 0; i < hcnt; i++, iter++) {
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event, pf_dev);
+		iter->dst = (__force u32)htonl(haddr[i]);
+		iter->dst_len = 32;
+		iter->mac_valid = 1;
+		iter->host = 1;
+		iter->port_id = pf->pcifunc;
+
+		for_each_dev_addr(pf_dev, dev_addr) {
+			ether_addr_copy(iter->mac, dev_addr->addr);
+			break;
+		}
+
+		netdev_dbg(pf_dev, "%s: FIB host  Rule cmd=%lld dst=%#x dst_len=%d gw=%#x %s\n",
+			   __func__, iter->cmd, iter->dst, iter->dst_len, iter->gw, pf_dev->name);
+	}
+	kfree(entries);
+	kfree(haddr);
+	return NOTIFY_DONE;
+}
+
+int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr)
+{
+	struct net_device *lower, *pf_dev;
+	struct neighbour *n = ptr;
+	struct fib_entry *entry;
+	struct list_head *iter;
+	struct otx2_nic *pf;
+
+	if (n->tbl != &arp_tbl)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	entry->cmd = OTX2_NEIGH_UPDATE;
+	entry->dst = (__force u32)htonl(*(u32 *)n->primary_key);
+	entry->dst_len = n->tbl->key_len * 8;
+	entry->mac_valid = 1;
+	entry->nud_state = n->nud_state;
+	ether_addr_copy(entry->mac, n->ha);
+
+	pf_dev = n->dev;
+	if (netif_is_bridge_master(n->dev))  {
+		entry->bridge = 1;
+		netdev_for_each_lower_dev(n->dev, lower, iter) {
+			pf_dev = lower;
+			goto err;
+		}
+	} else if (is_vlan_dev(n->dev)) {
+		entry->vlan_valid = 1;
+		pf_dev = vlan_dev_real_dev(n->dev);
+		entry->vlan_tag = vlan_dev_vlan_id(n->dev);
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	kfree(entry);
+	return NOTIFY_DONE;
+err:
+	kfree(entry);
+	return NOTIFY_DONE;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
new file mode 100644
index 000000000000..c6dbf4b93a9a
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_NB_V4_H_
+#define SW_NB_V4_H_
+
+int sw_nb_v4_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr);
+
+int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr);
+
+int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr);
+
+int sw_nb_v4_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr);
+#endif // SW_NB_V4_H__
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
new file mode 100644
index 000000000000..e43c28d4f15c
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <net/ip6_fib.h>
+#include <net/nexthop.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+#include "sw_nb.h"
+#include "sw_nb_v6.h"
+
+#if IS_ENABLED(CONFIG_IPV6)
+
+int sw_nb_v6_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_hw_addr *dev_addr;
+	struct inet6_ifaddr *ifp;
+	struct fib_entry *entry;
+	struct inet6_dev *i6dev;
+	struct otx2_nic *pf;
+
+	i6dev = __in6_dev_get(dev);
+	ifp = list_first_entry_or_null(&i6dev->addr_list,
+				       struct inet6_ifaddr,  if_list);
+	if (!ifp)
+		return NOTIFY_DONE;
+
+	if (ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL)
+		return NOTIFY_DONE;
+
+	pf = netdev_priv(dev);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	memcpy(entry->dst6, &ifp->addr, sizeof(entry->dst6));
+	entry->dst6_plen = ifp->prefix_len;
+	entry->host = 1;
+	entry->ipv6 = 1;
+	entry->port_id = pf->pcifunc;
+
+	for_each_dev_addr(dev, dev_addr) {
+		entry->mac_valid = 1;
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+
+	netdev_dbg(dev, "netdev event %pM plen=%u mac=%pM\n",
+		   &ifp->addr, ifp->prefix_len, entry->mac);
+	kfree(entry);
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v6_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr)
+{
+	struct fib6_entry_notifier_info *f6_eni;
+	struct fib_notifier_info *info = ptr;
+	struct net_device *fib_dev;
+	struct fib_entry *entry;
+	struct fib6_info *f6i;
+	struct neighbour *neigh;
+	struct fib6_nh *nh6;
+	struct otx2_nic *pf;
+	struct rt6key *key;
+
+	f6_eni = container_of(info, struct fib6_entry_notifier_info, info);
+	f6i = f6_eni->rt;
+
+	fib_dev = fib6_info_nh_dev(f6i);
+
+	if (!fib_dev)
+		return NOTIFY_DONE;
+
+	if (fib_dev->type != ARPHRD_ETHER)
+		return NOTIFY_DONE;
+
+	if (!sw_nb_is_cavium_dev(fib_dev))
+		return NOTIFY_DONE;
+
+	if (f6i->fib6_type != RTN_UNICAST)
+		return NOTIFY_DONE;
+
+	key = &f6i->fib6_dst;
+	if (ipv6_addr_type(&key->addr) & IPV6_ADDR_LINKLOCAL)
+		return NOTIFY_DONE;
+
+	netdev_dbg(fib_dev, "fib6dst rt6key.addr=%pI6c len=%u\n", &key->addr,
+		   key->plen);
+
+	netdev_dbg(fib_dev, "fib6flags=%#x proto=%u type=%u\n",
+		   f6i->fib6_flags, f6i->fib6_protocol, f6i->fib6_type);
+
+	nh6 = f6i->nh ? nexthop_fib6_nh(f6i->nh) : f6i->fib6_nh;
+	netdev_dbg(nh6->fib_nh_dev ? nh6->fib_nh_dev : fib_dev,
+		   "nh family=%u dev=%s  gw=%pI6c gwfamily=%u\n",
+		   nh6->fib_nh_family,
+		   nh6->fib_nh_dev ? nh6->fib_nh_dev->name : "No dev",
+		   &nh6->fib_nh_gw6, nh6->fib_nh_gw_family);
+
+	pf = netdev_priv(fib_dev);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	entry->cmd = sw_nb_fib_event_to_otx2_event(event, fib_dev);
+	entry->ipv6 = 1;
+	entry->port_id = pf->pcifunc;
+	memcpy(entry->dst6, &key->addr, sizeof(entry->dst6));
+	entry->dst6_plen = key->plen;
+
+	memcpy(entry->gw6, &nh6->fib_nh_gw6, sizeof(nh6->fib_nh_gw6));
+	entry->gw_valid = !!(ipv6_addr_type(&nh6->fib_nh_gw6) & IPV6_ADDR_UNICAST);
+
+	rcu_read_lock();
+	neigh = ip_neigh_gw6(fib_dev, &nh6->fib_nh_gw6);
+	if (!neigh) {
+		rcu_read_unlock();
+		return NOTIFY_DONE;
+	}
+
+	if (is_valid_ether_addr(neigh->ha)) {
+		entry->mac_valid = 1;
+		ether_addr_copy(entry->mac, neigh->ha);
+		netdev_dbg(fib_dev, "fib found MAC=%pM\n", entry->mac);
+	}
+
+	rcu_read_unlock();
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+
+int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr)
+{
+	struct neighbour *n = ptr;
+	struct fib_entry *entry;
+	struct net_device *pf_dev;
+	struct otx2_nic *pf;
+
+	if (n->tbl != &nd_tbl)
+		return NOTIFY_DONE;
+
+	if (ipv6_addr_type((struct in6_addr *)n->primary_key) & IPV6_ADDR_LINKLOCAL)
+		return NOTIFY_DONE;
+
+	pf_dev = n->dev;
+	pf = netdev_priv(pf_dev);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	entry->cmd = OTX2_NEIGH_UPDATE;
+
+	entry->dst6_plen = n->tbl->key_len * 8;
+	memcpy(entry->dst6, (struct in6_addr *)n->primary_key,
+	       sizeof(entry->dst6));
+	entry->ipv6 = 1;
+	entry->nud_state = n->nud_state;
+	ether_addr_copy(entry->mac, n->ha);
+	entry->mac_valid = 1;
+	entry->port_id = pf->pcifunc;
+
+	netdev_dbg(n->dev, "v6 neigh update %pI6 mac=%pM plen=%u\n",
+		   n->primary_key, n->ha, n->tbl->key_len * 8);
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr)
+{
+	struct inet6_ifaddr *ifa6 = (struct inet6_ifaddr *)ptr;
+	struct net_device *dev = ifa6->idev->dev;
+	struct netdev_hw_addr *dev_addr;
+	struct fib_entry *entry;
+	struct otx2_nic *pf;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	if (dev->type != ARPHRD_ETHER)
+		return NOTIFY_DONE;
+
+	if (!sw_nb_is_cavium_dev(dev))
+		return NOTIFY_DONE;
+
+	if (ipv6_addr_type(&ifa6->addr) & IPV6_ADDR_LINKLOCAL)
+		return NOTIFY_DONE;
+
+	pf = netdev_priv(dev);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	memcpy(entry->dst6, &ifa6->addr, sizeof(entry->dst6));
+	entry->dst6_plen = ifa6->prefix_len;
+	entry->mac_valid = 1;
+	entry->host = 1;
+	entry->ipv6 = 1;
+	entry->port_id = pf->pcifunc;
+
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		entry->mac_valid = 1;
+		break;
+	}
+
+	netdev_dbg(dev, "inetaddr addr=%pI6c len=%u %pM\n",
+		   &ifa6->addr, ifa6->prefix_len, entry->mac);
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
new file mode 100644
index 000000000000..f73efc98c311
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_NB_V6_H_
+#define SW_NB_V6_H_
+
+int sw_nb_v6_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr);
+
+int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr);
+
+int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr);
+
+int sw_nb_v6_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr);
+#endif // SW_NB_V6_H__
-- 
2.43.0


