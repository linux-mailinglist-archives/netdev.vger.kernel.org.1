Return-Path: <netdev+bounces-254421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLT1J5Fcemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:59:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF3A7FFD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E728A305A95A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14437416E;
	Wed, 28 Jan 2026 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ImeN/lPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD269218592
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626659; cv=none; b=tXdYhogWNo4aBjFWJlSnNNaCVL+h5APLwPFhDUOAzQTIvTKh5BqfcAb5/PwZ7gl9iEn9slHLQr3xi/LOzP+xa1pmegxNyrXgFenDmocwW6kgAB6GmFEUiI6XZiHJ4Ed9mhZDM5WA8BwOaGHMtKvzRgNk0hK/a4rCtTLuFPcZjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626659; c=relaxed/simple;
	bh=29y+CNcWM8TwE06oqpHJlzRbyBQvcZaMwlBZzRstafU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObUv8mEu3xMZnaoODO9jPCo4XG1DSTegrX6obEcfgBV6O0LGpNdN+0Lv2o7+qOPXveO/6b2LAFa93ISmY485Nq0qSa9YWqJBCFzZatMLgEU+vgNeng1gyeHhffFmXJ+O4ZCp4ZjqBICDm8zbrmYhG77QeQ1NW+XnuwCJohbF4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ImeN/lPv; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3540266d356so69435a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626657; x=1770231457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhM3X2blAiALo965kAx4B4GNugyVAWmZh0kAO/OGVo4=;
        b=L5x0PwPLT2bXO9AmgcWxAyPZAOBnIbtlFYTBkcXJ6PXG+Jn4aJaaPO3EnGsYK3afln
         jNzwGRRFHNeWEgq7418NRFrWfBDHBvYcCK5dwUXzO6vSDDm//qbGASn5t9ob/iqV/zd2
         8uAhHyz9LZj+d7n10utYtg0UBqpgrhpquPIcOl+mmcoUOQVuG8dcuXKC7o45Uo10K7AE
         wmdXOcd6SGmeR0oAPlGJA6zMev29bc2o5duvKCVGvtITDkSVRrYH7/A3cTr5CqVyXavW
         5EVN7JeN3RLj9+VyFBlT+extNr5w31pV1NJRGyIYP+77jIdchAcoRkJl13R/FdGQQNHN
         VKmw==
X-Gm-Message-State: AOJu0YxrlOnYjV6ldOzOHEUEQeMpZghj/SQ2IYJ4rsPdwr4wiFRvn6lE
	7e8AxPvPkWCXv5SsnOr4FIwD09fhYrYutP/qejzgbAGDEsh7OyQ2Ay3O9NLwoFKxxiaDfiu/vWq
	0euQCd9M39hoAcK5mLIeFYYAVktk3AM+R+2KEO/PvlV89+ZUOX3npqF3MsWYZgH4DDQDWGEeaQc
	Wkxfuri7LBxkClQXEEA33aniELJtGK2S/u3WHLJFC8mp+jEiDmiU28V07XuiITe6r+uAp+kwd5x
	LFXAg40eDrugIMCeg==
X-Gm-Gg: AZuq6aLkQt3wOrxIPDqvheVzcHDwP0tHdwxmdD63BThkjYgEFpOeSxolTnfcQZenI2Y
	iS1q0AACLM9OiGzI8kCUxs9SInKJG9IGyCFMt2q3bn1zhqqoHwmlxjF4q+MhaTV0RSSPxpq6trN
	E2rDGLCTeGLsSpfuIixTZq1iaDBZ88yqbgEfarie4oR1Yz9k6VmQlbP8Gh2lXNXeO9SwcM2WiFF
	UHDRw92dVwjIQY6OEzx72yT+5P6NIIZHzV99Q6o4nU0kOOXkEyUF6bEMFjN9fUJc9sAJV8w1Ysu
	d4BKIQ/e3SehEmpEGXR2WSMpLHpEbx0WU/N9Qzx0YhpOh+Pg7wdp9fTieE0GawiAell3SuaqbVq
	ta4Y1/AMLKQk5+5gBVn09SX65vq2tb6a/Je3hN65Y016NNF0Lhu5s7bBzDu0Ap5G3wuvONMZXni
	2YNmt6/l5UTi8bMkWEBwftBcu6eu3P3n8BZQUEL7300GzWM+iC
X-Received: by 2002:a17:90b:384f:b0:34a:a65e:e6ad with SMTP id 98e67ed59e1d1-353fecccf5amr5548989a91.1.1769626656932;
        Wed, 28 Jan 2026 10:57:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-353f62d73e8sm942511a91.7.2026.01.28.10.57.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:57:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c629a3276e9so232679a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769626655; x=1770231455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhM3X2blAiALo965kAx4B4GNugyVAWmZh0kAO/OGVo4=;
        b=ImeN/lPvR7jXkfKsXK5j5r8keu/3S0cHkgXu/U9X/hF0mX/xriS6Aq16OxiaesdOuz
         7q/hvC83HjXXxbbdR5Eqv+9t6So75H0UWiQxlnmejF7yxFkUYU4LIT7OJiZ9wps1SQk4
         ZkeZleD9NkuRsOtm6o2vGk1isUF6tbgzmboZ4=
X-Received: by 2002:a05:6a00:181f:b0:81f:eb35:69ef with SMTP id d2e1a72fcca58-823692b20ddmr5247548b3a.40.1769626655148;
        Wed, 28 Jan 2026 10:57:35 -0800 (PST)
X-Received: by 2002:a05:6a00:181f:b0:81f:eb35:69ef with SMTP id d2e1a72fcca58-823692b20ddmr5247527b3a.40.1769626654582;
        Wed, 28 Jan 2026 10:57:34 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22466sm3263536b3a.50.2026.01.28.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:57:34 -0800 (PST)
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
Subject: [v7, net-next 6/8] bng_en: Add support to handle AGG events
Date: Thu, 29 Jan 2026 00:26:21 +0530
Message-ID: <20260128185623.26559-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
References: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254421-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13CF3A7FFD
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
index 0e28352f41f2..7ca273f2e54f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -139,6 +139,20 @@ struct rx_cmp_ext {
 	__le32 rx_cmp_timestamp;
 };
 
+#define RX_AGG_CMP_TYPE			GENMASK(5, 0)
+#define RX_AGG_CMP_LEN			GENMASK(31, 16)
+#define RX_AGG_CMP_LEN_SHIFT		16
+#define RX_AGG_CMP_V			BIT(0)
+#define RX_AGG_CMP_AGG_ID		GENMASK(25, 16)
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
index fba7f6a73b85..a8e036d666df 100644
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
index 2b22db47ec2b..69cc0442b456 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -515,4 +515,9 @@ u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
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
index 312b5cbea2a5..8992076f19b8 100644
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
@@ -225,15 +411,16 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
 
@@ -262,11 +449,15 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
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
@@ -274,11 +465,23 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
@@ -290,10 +493,19 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
@@ -473,6 +685,11 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
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


