Return-Path: <netdev+bounces-252942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLecHsLNc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:36:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D522E7A330
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72BAD3010DDB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5B02C0281;
	Fri, 23 Jan 2026 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQacgNma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F52D7D3A
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196948; cv=none; b=Wd1M1+GcBICk57gx+l8IUTvQH8JA9vSTo4Zg5BD5dUt6+e4WsmWSR25W4xVHS5OSWLNiN2tn/gRI/SrdLGNjeLkWf1/fu3pq0wBUfsJA1XKXQtsvr68NNeVRb0ycnb/p8Cz4rLRMNjHcCOKawcQhdsOqSCznSL7jVyqZcVW5Pzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196948; c=relaxed/simple;
	bh=+426l+HxRyq3a7RSISVqDALXB+wvYRf//cVq+Ymj6vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeHDtuG5ftXveXKymi6k0cS4RdtRrpJYmNQSKqnC7HgGgKvVHCQBMpfAPqipE5MAdAXjzb9qjY+e7QYBwQrvxs+13HXDpoecAziFXLEtCFRxV3mDeG22TXLn5j908qemY12RO8V9LNXwmPACTviWt/S5z71EO8VQP4CUVo/ZKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQacgNma; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7cfd8ca8191so914281a34.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196944; x=1769801744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2PNNrzYfwF6RJOlif8UuJP8LkFjNKReEQi+5VZis0Q=;
        b=de6nj3zWv29OqiCJjL2kdk2yxn5lIrUwBLQ1a9gOQo1Wfl7pDQoJkwZI3Nd4FAeVY1
         b8bbK3ZrGrVMpe+dGVhYg0V1mrUM8CLB/XSp8w+k23VsQOQbhpD4gTKBwzi53ycJo7Bx
         nFsbDDgUvjQZAPAE5ohm2J8l41l0xMp6APeOSMDGLwNA7jdSRMSB8+JjYJneE8QNa+bH
         x/8qNcsDkIKNwUD9LRIznQLz5y8fC/hmqyMg+P7wgQu+/tkvUElblmvKLTbFvhvso/vc
         sf/ymmCt4Mh5CUuRILIgOLb68XGMgxmYQHowR7wH8SvXIrweze5zEyZBACjpfKXTMMt5
         D8tw==
X-Gm-Message-State: AOJu0YzBIxgVCXv83M3AGH9z5SegVbfJANOgGPyJE7Vb55Ppug3jvBNM
	4nrg+ofJ2NOAtTtmCXk82sYbMHDNygTLK0eobyvLJkAzHcvU+17xCxq7L3HdZCzPVDwgaszgYif
	EQyBIzqv7MCEyHpWGWwBh+vJniknjfTRgY1DjO79md7G5xdN+TmNPS1cTyo8HO8P6YJhxnc17qE
	eQ9z3Pxou+BPepPe7VXof8YGMrhB8xL1ZZX1p2B2xTHCiV//XhWnbqtXLXLr7ZZXi84vVCGmdeB
	E+I6FvpuU/3JrZ33g==
X-Gm-Gg: AZuq6aJYRv/CCgSixCLaJ8yWSoParSLE/MTn3HAgWlF3Zd5reol1c5oo2PoKJk33zlD
	5/7hrIE7+yXS0cJgnO7TEZgnVGZP6Gb2TfC2sPI/jdszfjT3nxY/mY4GOipY8s/WS1MUjEs2hJP
	EF8KWLL193PJC2MSV3OXZZ5OyyJDl2126z4xfOTIAs7X/1VrVTGDGv6Pj0m/27s2jxYlNUApQA/
	VHLXX3EL7PcDgo0hJUWeazcB8YpMtrN5hbs/7qLKMyHmvblJiAAQQ/dpVGVpyRgoH25QH3dn/iy
	6R/no93p6EuNY4UNr+5co+Vln9LaI7uDrPd1A9ZK47xf3t+JgSVjtwZaeJ6MJ00mWkkFrNPzWf+
	XBAJFdS9I/cR8MGIl2ac/2aJTRNqjy//GfxBy5Vp44csAMIK5q3M+QyTFWoCzeGPRZ38/2frLQN
	UzBduMTLZg4faEBtX+d0LODwIwUNurKw4Jy93TBSQS+6BiiSz6tQaNfA==
X-Received: by 2002:a05:6830:661b:b0:7c7:e3b:488a with SMTP id 46e09a7af769-7d15a634711mr1970874a34.30.1769196944541;
        Fri, 23 Jan 2026 11:35:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d15b3a10dbsm526366a34.3.2026.01.23.11.35.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:35:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so4759773b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769196943; x=1769801743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2PNNrzYfwF6RJOlif8UuJP8LkFjNKReEQi+5VZis0Q=;
        b=WQacgNmadqk7Q45/fKxDfaSfOsURMR5eq/MLEqKwKbfSOht/Cd9xaeCFGu6u2tjHti
         CwbKW1E3SOojr+Qiz39m9wQOU6NXa/EHAw5R8S6veW5vVPyXaIFY5YySHzkExGp/9SHC
         b6FpG238P7M2HRL98Ej2QyfV4W/J7t27y9zoc=
X-Received: by 2002:a05:6a00:3d51:b0:823:1252:9428 with SMTP id d2e1a72fcca58-82317d937femr3300350b3a.9.1769196942804;
        Fri, 23 Jan 2026 11:35:42 -0800 (PST)
X-Received: by 2002:a05:6a00:3d51:b0:823:1252:9428 with SMTP id d2e1a72fcca58-82317d937femr3300319b3a.9.1769196942157;
        Fri, 23 Jan 2026 11:35:42 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e519sm2843206b3a.49.2026.01.23.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:35:41 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v6, net-next 6/8] bng_en: Add support to handle AGG events
Date: Sat, 24 Jan 2026 01:05:02 +0530
Message-ID: <20260123193504.285573-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123193504.285573-1-bhargava.marreddy@broadcom.com>
References: <20260123193504.285573-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252942-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D522E7A330
X-Rspamd-Action: no action

Add AGG event handling in the RX path to receive packet data
on AGG rings. This enables Jumbo and HDS functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  14 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  17 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   5 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 223 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |   1 +
 5 files changed, 250 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
index 0e28352f41f2..d2c2acf44e82 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -139,6 +139,20 @@ struct rx_cmp_ext {
 	__le32 rx_cmp_timestamp;
 };
 
+#define RX_AGG_CMP_TYPE			GENMASK(5, 0)
+#define RX_AGG_CMP_LEN			GENMASK(31, 16)
+#define RX_AGG_CMP_LEN_SHIFT		16
+#define RX_AGG_CMP_V			BIT(0)
+#define RX_AGG_CMP_AGG_ID		GENMASK(31, 16)
+#define RX_AGG_CMP_AGG_ID_SHIFT		16
+
+struct rx_agg_cmp {
+	__le32 rx_agg_cmp_len_flags_type;
+	u32 rx_agg_cmp_opaque;
+	__le32 rx_agg_cmp_v;
+	__le32 rx_agg_cmp_unused;
+};
+
 #define RX_CMP_L2_ERRORS						\
 	cpu_to_le32(RX_CMPL_ERRORS_BUFFER_ERROR_MASK | RX_CMPL_ERRORS_CRC_ERROR)
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 2c8f8949d500..5b0e326c5056 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -10,6 +10,9 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <net/netdev_lock.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
@@ -979,9 +982,9 @@ static netmem_ref __bnge_alloc_rx_netmem(struct bnge_net *bn,
 	return netmem;
 }
 
-static u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
-				struct bnge_rx_ring_info *rxr,
-				gfp_t gfp)
+u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+			 struct bnge_rx_ring_info *rxr,
+			 gfp_t gfp)
 {
 	unsigned int offset;
 	struct page *page;
@@ -1048,7 +1051,7 @@ static int bnge_alloc_one_rx_ring_bufs(struct bnge_net *bn,
 	return 0;
 }
 
-static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
+u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
 {
 	u16 next, max = rxr->rx_agg_bmap_size;
 
@@ -1058,9 +1061,9 @@ static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static int bnge_alloc_rx_netmem(struct bnge_net *bn,
-				struct bnge_rx_ring_info *rxr,
-				u16 prod, gfp_t gfp)
+int bnge_alloc_rx_netmem(struct bnge_net *bn,
+			 struct bnge_rx_ring_info *rxr,
+			 u16 prod, gfp_t gfp)
 {
 	struct bnge_sw_rx_agg_bd *rx_agg_buf;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index d7cef5c5ba68..ee036ce63655 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -514,4 +514,9 @@ u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
+u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx);
+u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+			 struct bnge_rx_ring_info *rxr, gfp_t gfp);
+int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+			 u16 prod, gfp_t gfp);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 33f39a57f12d..363f835438f4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/tcp.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 #include <linux/if_vlan.h>
@@ -43,6 +44,191 @@ irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static struct rx_agg_cmp *bnge_get_agg(struct bnge_net *bn,
+				       struct bnge_cp_ring_info *cpr,
+				       u16 cp_cons, u16 curr)
+{
+	struct rx_agg_cmp *agg;
+
+	cp_cons = RING_CMP(bn, ADV_RAW_CMP(cp_cons, curr));
+	agg = (struct rx_agg_cmp *)
+		&cpr->desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
+	return agg;
+}
+
+static void bnge_reuse_rx_agg_bufs(struct bnge_cp_ring_info *cpr, u16 idx,
+				   u16 start, u32 agg_bufs)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct bnge_net *bn = bnapi->bn;
+	struct bnge_rx_ring_info *rxr;
+	u16 prod, sw_prod;
+	u32 i;
+
+	rxr = bnapi->rx_ring;
+	sw_prod = rxr->rx_sw_agg_prod;
+	prod = rxr->rx_agg_prod;
+
+	for (i = 0; i < agg_bufs; i++) {
+		struct bnge_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
+		struct rx_agg_cmp *agg;
+		struct rx_bd *prod_bd;
+		netmem_ref netmem;
+		u16 cons;
+
+		agg = bnge_get_agg(bn, cpr, idx, start + i);
+		cons = agg->rx_agg_cmp_opaque;
+		__clear_bit(cons, rxr->rx_agg_bmap);
+
+		if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
+			sw_prod = bnge_find_next_agg_idx(rxr, sw_prod);
+
+		__set_bit(sw_prod, rxr->rx_agg_bmap);
+		prod_rx_buf = &rxr->rx_agg_buf_ring[sw_prod];
+		cons_rx_buf = &rxr->rx_agg_buf_ring[cons];
+
+		/* It is possible for sw_prod to be equal to cons, so
+		 * set cons_rx_buf->netmem to 0 first.
+		 */
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+		prod_rx_buf->netmem = netmem;
+		prod_rx_buf->offset = cons_rx_buf->offset;
+
+		prod_rx_buf->mapping = cons_rx_buf->mapping;
+
+		prod_bd = &rxr->rx_agg_desc_ring[RX_AGG_RING(bn, prod)]
+					[RX_IDX(prod)];
+
+		prod_bd->rx_bd_haddr = cpu_to_le64(cons_rx_buf->mapping);
+		prod_bd->rx_bd_opaque = sw_prod;
+
+		prod = NEXT_RX_AGG(prod);
+		sw_prod = RING_RX_AGG(bn, NEXT_RX_AGG(sw_prod));
+	}
+	rxr->rx_agg_prod = prod;
+	rxr->rx_sw_agg_prod = sw_prod;
+}
+
+static int bnge_agg_bufs_valid(struct bnge_net *bn,
+			       struct bnge_cp_ring_info *cpr,
+			       u8 agg_bufs, u32 *raw_cons)
+{
+	struct rx_agg_cmp *agg;
+	u16 last;
+
+	*raw_cons = ADV_RAW_CMP(*raw_cons, agg_bufs);
+	last = RING_CMP(bn, *raw_cons);
+	agg = (struct rx_agg_cmp *)
+		&cpr->desc_ring[CP_RING(last)][CP_IDX(last)];
+	return RX_AGG_CMP_VALID(bn, agg, *raw_cons);
+}
+
+static int bnge_discard_rx(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
+			   u32 *raw_cons, void *cmp)
+{
+	u32 tmp_raw_cons = *raw_cons;
+	struct rx_cmp *rxcmp = cmp;
+	u8 cmp_type, agg_bufs = 0;
+
+	cmp_type = RX_CMP_TYPE(rxcmp);
+
+	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
+		agg_bufs = (le32_to_cpu(rxcmp->rx_cmp_misc_v1) &
+			    RX_CMP_AGG_BUFS) >>
+			   RX_CMP_AGG_BUFS_SHIFT;
+	}
+
+	if (agg_bufs) {
+		if (!bnge_agg_bufs_valid(bn, cpr, agg_bufs, &tmp_raw_cons))
+			return -EBUSY;
+	}
+	*raw_cons = tmp_raw_cons;
+	return 0;
+}
+
+static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
+				 struct bnge_cp_ring_info *cpr,
+				 u16 idx, u32 agg_bufs,
+				 struct sk_buff *skb)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct skb_shared_info *shinfo;
+	struct bnge_rx_ring_info *rxr;
+	u32 i, total_frag_len = 0;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
+	shinfo = skb_shinfo(skb);
+
+	for (i = 0; i < agg_bufs; i++) {
+		struct bnge_sw_rx_agg_bd *cons_rx_buf;
+		struct rx_agg_cmp *agg;
+		u16 cons, frag_len;
+		netmem_ref netmem;
+
+		agg = bnge_get_agg(bn, cpr, idx, i);
+		cons = agg->rx_agg_cmp_opaque;
+		frag_len = (le32_to_cpu(agg->rx_agg_cmp_len_flags_type) &
+			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
+
+		cons_rx_buf = &rxr->rx_agg_buf_ring[cons];
+		skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
+				       cons_rx_buf->offset,
+				       frag_len, BNGE_RX_PAGE_SIZE);
+		__clear_bit(cons, rxr->rx_agg_bmap);
+
+		/* It is possible for bnge_alloc_rx_netmem() to allocate
+		 * a sw_prod index that equals the cons index, so we
+		 * need to clear the cons entry now.
+		 */
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+
+		if (bnge_alloc_rx_netmem(bn, rxr, prod, GFP_ATOMIC) != 0) {
+			skb->len -= frag_len;
+			skb->data_len -= frag_len;
+			skb->truesize -= BNGE_RX_PAGE_SIZE;
+
+			--shinfo->nr_frags;
+			cons_rx_buf->netmem = netmem;
+
+			/* Update prod since possibly some netmems have been
+			 * allocated already.
+			 */
+			rxr->rx_agg_prod = prod;
+			bnge_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i);
+			return 0;
+		}
+
+		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+						  BNGE_RX_PAGE_SIZE);
+
+		total_frag_len += frag_len;
+		prod = NEXT_RX_AGG(prod);
+	}
+	rxr->rx_agg_prod = prod;
+	return total_frag_len;
+}
+
+static struct sk_buff *bnge_rx_agg_netmems_skb(struct bnge_net *bn,
+					       struct bnge_cp_ring_info *cpr,
+					       struct sk_buff *skb, u16 idx,
+					       u32 agg_bufs)
+{
+	u32 total_frag_len;
+
+	total_frag_len = __bnge_rx_agg_netmems(bn, cpr, idx, agg_bufs, skb);
+	if (!total_frag_len) {
+		skb_mark_for_recycle(skb);
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+
+	return skb;
+}
+
 static void bnge_sched_reset_rxr(struct bnge_net *bn,
 				 struct bnge_rx_ring_info *rxr)
 {
@@ -221,15 +407,16 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	struct bnge_napi *bnapi = cpr->bnapi;
 	struct net_device *dev = bn->netdev;
 	struct bnge_rx_ring_info *rxr;
+	u32 tmp_raw_cons, flags, misc;
 	struct bnge_sw_rx_bd *rx_buf;
 	struct rx_cmp_ext *rxcmp1;
 	u16 cons, prod, cp_cons;
-	u32 tmp_raw_cons, flags;
 	u8 *data_ptr, cmp_type;
 	struct rx_cmp *rxcmp;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
 	unsigned int len;
+	u8 agg_bufs;
 	void *data;
 	int rc = 0;
 
@@ -258,11 +445,15 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 	cons = rxcmp->rx_cmp_opaque;
 	if (unlikely(cons != rxr->rx_next_cons)) {
+		int rc1 = bnge_discard_rx(bn, cpr, &tmp_raw_cons, rxcmp);
+
 		/* 0xffff is forced error, don't print it */
 		if (rxr->rx_next_cons != 0xffff)
 			netdev_warn(bn->netdev, "RX cons %x != expected cons %x\n",
 				    cons, rxr->rx_next_cons);
 		bnge_sched_reset_rxr(bn, rxr);
+		if (rc1)
+			return rc1;
 		goto next_rx_no_prod_no_len;
 	}
 	rx_buf = &rxr->rx_buf_ring[cons];
@@ -270,11 +461,23 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	data_ptr = rx_buf->data_ptr;
 	prefetch(data_ptr);
 
+	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
+	agg_bufs = (misc & RX_CMP_AGG_BUFS) >> RX_CMP_AGG_BUFS_SHIFT;
+
+	if (agg_bufs) {
+		if (!bnge_agg_bufs_valid(bn, cpr, agg_bufs, &tmp_raw_cons))
+			return -EBUSY;
+
+		cp_cons = NEXT_CMP(bn, cp_cons);
+		*event |= BNGE_AGG_EVENT;
+	}
 	*event |= BNGE_RX_EVENT;
 
 	rx_buf->data = NULL;
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
 		bnge_reuse_rx_data(rxr, cons, data);
+		if (agg_bufs)
+			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
 		rc = -EIO;
 		goto next_rx_no_len;
 	}
@@ -286,10 +489,19 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	if (len <= bn->rx_copybreak) {
 		skb = bnge_copy_skb(bnapi, data_ptr, len, dma_addr);
 		bnge_reuse_rx_data(rxr, cons, data);
-		if (!skb)
-			goto oom_next_rx;
 	} else {
 		skb = bnge_rx_skb(bn, rxr, cons, data, data_ptr, dma_addr, len);
+	}
+
+	if (!skb) {
+		if (agg_bufs)
+			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
+		goto oom_next_rx;
+	}
+
+	if (agg_bufs) {
+		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, cp_cons,
+					      agg_bufs);
 		if (!skb)
 			goto oom_next_rx;
 	}
@@ -469,6 +681,11 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 		bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
 		bnapi->events &= ~BNGE_RX_EVENT;
 	}
+
+	if (bnapi->events & BNGE_AGG_EVENT) {
+		bnge_db_write(bn->bd, &rxr->rx_agg_db, rxr->rx_agg_prod);
+		bnapi->events &= ~BNGE_AGG_EVENT;
+	}
 }
 
 static void
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index 32be5eb46870..2a17ff639100 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -107,6 +107,7 @@ static inline void bnge_db_write_relaxed(struct bnge_net *bn,
 #define ADV_RAW_CMP(idx, n)	((idx) + (n))
 #define NEXT_RAW_CMP(idx)	ADV_RAW_CMP(idx, 1)
 #define RING_CMP(bn, idx)	((idx) & (bn)->cp_ring_mask)
+#define NEXT_CMP(bn, idx)	RING_CMP(bn, ADV_RAW_CMP(idx, 1))
 
 #define RX_CMP_ITYPES(rxcmp)					\
 	(le32_to_cpu((rxcmp)->rx_cmp_len_flags_type) & RX_CMP_FLAGS_ITYPES_MASK)
-- 
2.47.3


