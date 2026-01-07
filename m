Return-Path: <netdev+bounces-247747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F48CFE06F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 320C03112711
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8590339843;
	Wed,  7 Jan 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KyvmZM7n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E05337BB0;
	Wed,  7 Jan 2026 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792287; cv=none; b=es4ldVf1g349Ikd3Pj0Nr3/y9O7+rkAAbmS58VsHnitboW45ypgY5ojXDFI2C43QMdS+9KR/MKScCnn+E5MzjbiZld4Xw2OvS6+PlpUomS7qt3QrbNRhaaipjWG7ZzaemiHw9O6A+j+1d+iAyfHsSsDzjwyh6uw+Mx780G9k9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792287; c=relaxed/simple;
	bh=voY8d62Ogh3SK5ugW/ejVnzKnPXsFPkJw9Zr+r2l1aQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skEWJUGENNec6s7necNwiqOnlVExOSPTpWFfC+IAIsCbLshYSWFhUJPhM2cNEwQKBmXRInCK7O36RUHok56A0CISaMBOp+vVfQ5C5/BeXz1JTJy9GiJbFOlX+beouHrKNfEzGiJK3HJi5ZwtJGeYuwfm7TRNd6AqSUVbt0C5Yo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KyvmZM7n; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NSoYv774435;
	Wed, 7 Jan 2026 05:24:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	IhKyjbPOXk5Tez10oKwaTsa028Q9ccDPob4SwX6qBY=; b=KyvmZM7nw2HR0Ef5w
	bTNltoJdLK6t/QaYPY0OMf2yU9Mqj42E//K/qlVD7XY9eCTzFQSwNpOUXqx8xyAi
	Daob/kOehWm+DIuCjGv2pIPJbqg3PvsU89/tlozi8/VRYc2cOdwMsQQHQLkslk/p
	d6x5Fzpw10EeCy3Dj71mHGrYC038nMKtY/4r5n4bpAiYorkwaLxb7YiyZ4xymRSc
	49jAeHlfurS6xI0IRW+CXNdQlObsld8btRlsm+Dmi70o2Bwhqn3fO1SqmjXFSzFK
	sjnNQiz3+LEJwOubjmyECSRNiQGLHZEdZJzFq8jj890XVkFfvzx++4m4h29LEZJG
	jam5A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc3n1bth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:24:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:24:35 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BB7123F70B2;
	Wed,  7 Jan 2026 05:24:32 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 06/10] octeontx2-pf: switch: Register for notifier chains.
Date: Wed, 7 Jan 2026 18:54:04 +0530
Message-ID: <20260107132408.3904352-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107132408.3904352-1-rkannoth@marvell.com>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 13Wt03UlaM_39IQp_5suUCTmY-HavRJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX2//uPxaji5S6
 m2fsGcryuCUM1BIr/k1sObMAilwylpEVn7R8T9+q2OZwVuLAC2uRAK5t4Z+6fbZkti2kuOCCnsM
 7p7bbZMFmQA90LoH1s+NQUITPHiDH1TYtlph27+JOjqF6MNrJ2NaigGADfzAEXZhG1oLEl1JIG7
 xN5b/G7EVE+o1G2NSNt7EItKvrSYGpiDUeq2WTSTo9CUOX2WAbhdDRnPjg5aRd6ZuDR3598FWSv
 VjORRBcgQK45YMLYskgoQDAH9XRBwOooFXZqwyKRjNBpBSkF8IfOz4vDNcbWSXuMzNXrFU0tZ1O
 Y8liJEgwPXIGTefPH266dBJnWez0fbUAVmCfMZotlVcjEII46oL/ngzLTx1/o04IhTd5r9luvl3
 K05MsbLq56ooIGQGmcz4vemH3FalcoLV6w3wkgv4zw3ZN7YWU6ipPVsDMhgcQGUZeG0lSRG1nDs
 qdi6nGxL2mkdaqnTp9A==
X-Authority-Analysis: v=2.4 cv=EOILElZC c=1 sm=1 tr=0 ts=695e5e94 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=8MKmJXxhQqrjLFTQZSMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 13Wt03UlaM_39IQp_5suUCTmY-HavRJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Switchdev flow table needs information on 5tuple information
to mangle/to find egress ports etc. PF driver registers for fdb/fib/netdev
notifier chains to listen to events. These events are parsed and sent
to switchdev HW through mbox events.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |   7 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 622 +++++++++++++++++-
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  22 +-
 3 files changed, 647 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 9200198be71f..0edbc56ae693 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -15,6 +15,7 @@
 #include "cn10k.h"
 #include "otx2_reg.h"
 #include "rep.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_rep"
 #define DRV_STRING	"Marvell RVU Representor Driver"
@@ -399,6 +400,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+	struct net_device *netdev = priv->netdev;
 	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
@@ -414,6 +416,11 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
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
index 2d14a0590c5d..ce565fe7035c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -4,14 +4,632 @@
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
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
 #include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+
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
+{
+	return sw_nb_cmd2str[cmd];
+}
+EXPORT_SYMBOL(sw_nb_get_cmd2str);
+
+static bool sw_nb_is_cavium_dev(struct net_device *netdev)
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
+	return 0;
+}
+
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
+		rcu_read_lock();
+		br = netdev_master_upper_dev_get_rcu(netdev);
+		if (!br) {
+			rcu_read_unlock();
+			return false;
+		}
+
+		netdev_walk_all_lower_dev(br, sw_nb_check_slaves, &priv);
+		rcu_read_unlock();
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
+sw_nb_fib_event_dump(struct net_device *dev, unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	int i;
+
+	netdev_info(dev,
+		    "%s:%d FIB event=%lu dst=%#x dstlen=%u type=%u\n",
+		    __func__, __LINE__,
+		    event, fen_info->dst, fen_info->dst_len,
+		    fen_info->type);
+
+	fi = fen_info->fi;
+	if (!fi)
+		return;
+
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++)
+		netdev_info(dev, "%s:%d dev=%s saddr=%#x gw=%#x\n",
+			    __func__, __LINE__,
+			    fib_nh->fib_nh_dev->name,
+			    fib_nh->nh_saddr, fib_nh->fib_nh_gw4);
+}
+
+#define SWITCH_NB_FIB_EVENT_DUMP(...) \
+	sw_nb_fib_event_dump(__VA_ARGS__)
+
+static int sw_nb_fib_event_to_otx2_event(int event)
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
+	return -1;
+}
+
+static int sw_nb_fib_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct net_device *dev, *pf_dev = NULL;
+	struct fib_notifier_info *info = ptr;
+	struct fib_entry *entries, *iter;
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *lower;
+	struct list_head *lh;
+	struct neighbour *neigh;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	struct otx2_nic *pf;
+	__be32 *haddr;
+	int hcnt = 0;
+	int cnt, i;
+
+	if (info->family != AF_INET)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+	case FIB_EVENT_ENTRY_ADD:
+	case FIB_EVENT_ENTRY_DEL:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	/* Process only UNICAST routes add or del */
+	if (fen_info->type != RTN_UNICAST)
+		return NOTIFY_DONE;
+
+	fi = fen_info->fi;
+
+	if (!fi)
+		return NOTIFY_DONE;
+
+	if (fi->fib_nh_is_v6)
+		return NOTIFY_DONE;
+
+	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	haddr = kcalloc(fi->fib_nhs, sizeof(__be32), GFP_ATOMIC);
+	if (!haddr) {
+		kfree(entries);
+		return NOTIFY_DONE;
+	}
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
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event);
+		iter->dst = fen_info->dst;
+		iter->dst_len = fen_info->dst_len;
+		iter->gw = be32_to_cpu(fib_nh->fib_nh_gw4);
+
+		netdev_dbg(dev,
+			   "%s:%d FIB route Rule cmd=%lld dst=%#x dst_len=%d gw=%#x\n",
+			   __func__, __LINE__,
+			   iter->cmd, iter->dst, iter->dst_len, iter->gw);
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
+			haddr[hcnt++] = fib_nh->nh_saddr;
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
+	if (!cnt) {
+		kfree(entries);
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
 
-int sw_nb_unregister(void)
+	if (!hcnt) {
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
+
+	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	iter = entries;
+
+	for (i = 0; i < hcnt; i++, iter++) {
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event);
+		iter->dst = be32_to_cpu(haddr[i]);
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
+		netdev_dbg(dev,
+			   "%s:%d FIB host  Rule cmd=%lld dst=%#x dst_len=%d gw=%#x %s\n",
+			   __func__, __LINE__,
+			   iter->cmd, iter->dst, iter->dst_len, iter->gw, dev->name);
+	}
+
+	kfree(haddr);
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
+	struct net_device *lower, *pf_dev;
+	struct neighbour *n = ptr;
+	struct fib_entry *entry;
+	struct list_head *iter;
+	struct otx2_nic *pf;
+
+	switch (event) {
+	case NETEVENT_NEIGH_UPDATE:
+		if (n->tbl->family != AF_INET)
+			break;
+
+		if (n->tbl != &arp_tbl)
+			break;
+
+		if (!sw_nb_is_valid_dev(n->dev))
+			break;
+
+		entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			break;
+
+		entry->cmd = OTX2_NEIGH_UPDATE;
+		entry->dst = be32_to_cpu(*(__be32 *)n->primary_key);
+		entry->dst_len = n->tbl->key_len * 8;
+		entry->mac_valid = 1;
+		entry->nud_state = n->nud_state;
+		ether_addr_copy(entry->mac, n->ha);
+
+		pf_dev = n->dev;
+		if (netif_is_bridge_master(n->dev))  {
+			entry->bridge = 1;
+			netdev_for_each_lower_dev(n->dev, lower, iter) {
+				pf_dev = lower;
+				break;
+			}
+		} else if (is_vlan_dev(n->dev)) {
+			entry->vlan_valid = 1;
+			pf_dev = vlan_dev_real_dev(n->dev);
+			entry->vlan_tag = vlan_dev_vlan_id(n->dev);
+		}
+
+		pf = netdev_priv(pf_dev);
+		entry->port_id = pf->pcifunc;
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netevent = {
+	.notifier_call = sw_nb_net_event,
+
+};
+
+static int sw_nb_inetaddr_event_to_otx2_event(int event)
 {
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
+	return -1;
+}
+
+static int sw_nb_inetaddr_event(struct notifier_block *nb,
+				unsigned long event, void *ptr)
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
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	idev = __in_dev_get_rtnl(dev);
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event);
+	entry->dst = be32_to_cpu(ifa->ifa_address);
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
+	netdev_dbg(dev,
+		   "%s:%d pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
+		   __func__, __LINE__,  entry->dst, entry->mac, dev->name);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_inetaddr = {
+	.notifier_call = sw_nb_inetaddr_event,
+};
+
+static int sw_nb_netdev_event(struct notifier_block *unused,
+			      unsigned long event, void *ptr)
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
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
+	ifa = rtnl_dereference(idev->ifa_list);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event);
+	entry->dst = be32_to_cpu(ifa->ifa_address);
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
+	netdev_dbg(dev,
+		   "%s:%d pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
+		   __func__, __LINE__,  entry->dst, entry->mac, dev->name);
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
+	err = unregister_inetaddr_notifier(&sw_nb_inetaddr);
+	if (err)
+		netdev_err(netdev, "Failed to unregister addr event\n");
+
+	err = unregister_netdevice_notifier(&sw_nb_netdev);
+	if (err)
+		netdev_err(netdev, "Failed to unregister netdev notifier\n");
+
+	sw_fl_deinit();
+	sw_fib_deinit();
+	sw_fdb_deinit();
+
 	return 0;
 }
+EXPORT_SYMBOL(sw_nb_unregister);
 
-int sw_nb_register(void)
+int sw_nb_register(struct net_device *netdev)
 {
+	int err;
+
+	sw_fdb_init();
+	sw_fib_init();
+	sw_fl_init();
+
+	err = register_switchdev_notifier(&sw_nb_fdb);
+	if (err) {
+		netdev_err(netdev, "Failed to register switchdev nb\n");
+		return err;
+	}
+
+	err = register_fib_notifier(&init_net, &sw_nb_fib, NULL, NULL);
+	if (err) {
+		netdev_err(netdev, "Failed to register fb notifier block");
+		goto err1;
+	}
+
+	err = register_netevent_notifier(&sw_nb_netevent);
+	if (err) {
+		netdev_err(netdev, "Failed to register netevent\n");
+		goto err2;
+	}
+
+	err = register_inetaddr_notifier(&sw_nb_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to register addr event\n");
+		goto err3;
+	}
+
+	err = register_netdevice_notifier(&sw_nb_netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to register netdevice nb\n");
+		goto err4;
+	}
+
 	return 0;
+
+err4:
+	unregister_inetaddr_notifier(&sw_nb_inetaddr);
+
+err3:
+	unregister_netevent_notifier(&sw_nb_netevent);
+
+err2:
+	unregister_fib_notifier(&init_net, &sw_nb_fib);
+
+err1:
+	unregister_switchdev_notifier(&sw_nb_fdb);
+	return err;
 }
+EXPORT_SYMBOL(sw_nb_register);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
index 503a0e18cfd7..a6fbd19a473b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -7,7 +7,25 @@
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
 
+int sw_nb_register(struct net_device *netdev);
+int sw_nb_unregister(struct net_device *netdev);
+bool sw_nb_is_valid_dev(struct net_device *netdev);
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
+
+const char *sw_nb_get_cmd2str(int cmd);
 #endif // SW_NB_H__
-- 
2.43.0


