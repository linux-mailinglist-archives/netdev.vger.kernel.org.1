Return-Path: <netdev+bounces-270673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI1/JAqLwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:48:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE92FB8E1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1DDA30584DA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650CE3C456B;
	Mon, 23 Mar 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="tiBDfMKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E631327F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291158; cv=none; b=OLkblx3sYMynsWeHV/CB7ix19J/iUJ+eF8XxW1HpLbWZpbQWM0ylIXxYAhV2j3ZGhwo5ybP1lfxDQNUBtr08aRfGJK9CutC6XVpaTFZe98NZqffQidKuQFlz/9iOmLb8XRIyTSq5UIYvRuJz7YNbIPEhCGlHXFbB7u63TAdUlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291158; c=relaxed/simple;
	bh=HtDcextZUR/YPcgIMnOZtvtxd0jwbtm6Ak5Sth33ogo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3rT5T/O0Lb55GB5EsguB/4xnC+URd3dRrwrCot6rspIEQ2t+Yj68wZz2tnyk3wbUJSAuj703T6TXDCJDFKPvdYlRQQOwtAtW/+e4lTWHGqEhXG8NPilS8pNXVlDBVtvfW2N2vHw/pTnFlysUcVpjrHiYO5oqYjvspgvVF6KgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=tiBDfMKm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82418b0178cso280140b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291153; x=1774895953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgC2gqkZaDT8s1RV7I0kqk405vgv8rZzFFbIUkMM2/c=;
        b=tiBDfMKmyfrYt9k3v5e8JPzhNyUVaDpWtN2BupizXi/FKg5LS+DrU8u0nGMtwqDHdB
         umnYhgpJOt04JlXfw3uAeoNieMfzUtNf9lWUow6Hi4uljRPOxdMr0vyE+0ujYL6KfNKq
         D9gjI/bz1otOSEoyT1OD5T8BCkyDoy5B94upPo/NZC7DqJzttVSuhKGujryKUbdpq4kl
         0K2PxG4mH4LIgqmZNYZztPqhPZsv2KepeoXwuvXKSdQyKATsmP/8RijeBZuardZZ4klf
         YrYtedjsyzVpC4HrS8f8c8/Eh6DZfq0Tvjv+mV4wj2K5Wlceu3zu30TGT7bMkyyp7vA+
         8zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291153; x=1774895953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgC2gqkZaDT8s1RV7I0kqk405vgv8rZzFFbIUkMM2/c=;
        b=mhK0i1orRcVwV0copnSlghPLD2OxKRT3cPV4Onhp1Ohof5pdpWvkXrPYIUXZL5o/9+
         frg2CyupkfPn2DcZSllROlaxfESENXInIrZbo8Q+T271+ZBS2nkqD8vhvX9DfzgZq2+j
         ISFzZilsZlHOgTHMZMnIK1pnfq5rGN6nNZKnvIEv5toV0bSgLokSGPd+rNBXc5rz7q9I
         CHQKXYlQ20zEuEnwvXYmymk1hQjEVeSwj0TLMey/hr9BUweVoBPrqJAAVe6SAXkAy1nw
         69v1z+AZ74HaoPXquY6aBjF/rVf143uA4JDmC6WXvQQnSH6W1sQj8tUhTG2DwhGOKCWo
         R5ww==
X-Gm-Message-State: AOJu0YzWTEiBettMfCfRdhT/AG1hPdQiIqZzFkzPNuZph79FmbBn41su
	JMcb8Hdl5aMKbgG6g6Mn4tCNv8pHSKws1KLdioNhV2oilWMLx/zA+ocLmEUdy2EMy7fEojH/Ji6
	uOCkX4tQ=
X-Gm-Gg: ATEYQzwqRUhiQnHPZQjR163Gpdc+aFszgT7BCRaKGjfrYCrGmrPBz0qPJhlSsowP00T
	ea3PfYT010Lm0RKBWx3FizDtTqn1cc9vet3+tNl0lyZxr7ygJEEkFYMe8d4DM2Ve+r//Mr0LK0G
	695sfyiGzENHlOIFH+1Jusnh9XlJF2bztN25Upv3f4Z3+y/b4GkwvrbE8l9LpE15BO4rUXObxHh
	wyK8iXeQYr1gobd9fx0Cx9RLCrfCEFCEQ7bWzzuAd0mHo1gDcjZJqtQ4YPb7xTuIZRE2R2k3AHY
	LJzQi9Yq9BZd0WjkHY63KWGvkR163thWnRLG4KNrhcL6SHeo1VqRa+wwIdFOgikXWYj48UbnoRD
	RKjslvPr0VDgtAC1ZtF+Mj0pYkbwkSjJa4ldMo/5HITOWxjc7TlZlDEHa46qgepAQRPDxkwLskt
	XQCrPtJX550HKDaA==
X-Received: by 2002:a05:6a00:91a6:b0:82a:e3de:27c2 with SMTP id d2e1a72fcca58-82ae3de2ff0mr8957916b3a.41.1774291153012;
        Mon, 23 Mar 2026 11:39:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aaabdesm10375094b3a.5.2026.03.23.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:12 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>,
	bpf@vger.kernel.org
Subject: [net-next v5 07/12] net: bnxt: Add boilerplate GSO code
Date: Mon, 23 Mar 2026 11:38:32 -0700
Message-ID: <20260323183844.3146982-8-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270673-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid,broadcom.com:email,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0BFE92FB8E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bnxt_gso.c and bnxt_gso.h with a stub bnxt_sw_udp_gso_xmit()
function, SW USO constants (BNXT_SW_USO_MAX_SEGS,
BNXT_SW_USO_MAX_DESCS), and the is_sw_gso field in bnxt_sw_tx_bd
with BNXT_SW_GSO_MID/LAST markers.

The full SW USO implementation will be added in a future commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 30 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 31 +++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index ba6c239d52fa..debef78c8b6d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BNXT) += bnxt_en.o
 
-bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o
+bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o bnxt_gso.o
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 751dbc055fdd..18b08789b3a4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -891,6 +891,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_ts_pkt;
 	u8			is_push;
 	u8			action;
+	u8			is_sw_gso;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
@@ -898,6 +899,9 @@ struct bnxt_sw_tx_bd {
 	};
 };
 
+#define BNXT_SW_GSO_MID		1
+#define BNXT_SW_GSO_LAST	2
+
 struct bnxt_sw_rx_bd {
 	void			*data;
 	u8			*data_ptr;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
new file mode 100644
index 000000000000..b296769ee4fe
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Broadcom NetXtreme-C/E network driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/netdev_queues.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/udp.h>
+#include <net/tso.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_gso.h"
+
+netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
+				 struct bnxt_tx_ring_info *txr,
+				 struct netdev_queue *txq,
+				 struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+	dev_core_stats_tx_dropped_inc(bp->dev);
+	return NETDEV_TX_OK;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
new file mode 100644
index 000000000000..f01e8102dcd7
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Broadcom NetXtreme-C/E network driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef BNXT_GSO_H
+#define BNXT_GSO_H
+
+/* Maximum segments the stack may send in a single SW USO skb.
+ * This caps gso_max_segs for NICs without HW USO support.
+ */
+#define BNXT_SW_USO_MAX_SEGS	64
+
+/* Worst-case TX descriptors consumed by one SW USO packet:
+ * Each segment: 1 long BD + 1 ext BD + payload BDs.
+ * Total payload BDs across all segs <= num_segs + nr_frags (each frag
+ * boundary crossing adds at most 1 extra BD).
+ * So: 3 * max_segs + MAX_SKB_FRAGS + 1 = 3 * 64 + 17 + 1 = 210.
+ */
+#define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
+
+netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
+				 struct bnxt_tx_ring_info *txr,
+				 struct netdev_queue *txq,
+				 struct sk_buff *skb);
+
+#endif
-- 
2.52.0


