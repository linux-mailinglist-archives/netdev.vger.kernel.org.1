Return-Path: <netdev+bounces-252936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J9MFKPNc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:36:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E32757A30A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB703045A80
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AFA224AE8;
	Fri, 23 Jan 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AML2SMEQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72A1F75A6
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196925; cv=none; b=oKNw8US40KrLQOPgm4UQdpoQO4aJK3WUqdbEP8S1yC7A+o1EXuXv0RjXhzbl3rTBePRxEq1ukMmYsPmMRFuh1KP8PnCEo/ULj+Ggw0xSe6UJGpEwTIqI4139obZNDkFlgz5sEbo0OVXJXnmO4Do/0JpUH6LFnfYuo6FLjin8IHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196925; c=relaxed/simple;
	bh=G42HEdK63RMSkNcCPQGCk4X08ncSFrRURRT8K21yxRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDNc8l7Dy2goXH9JjgET2x1Ut3U7vT7ZHVLtRAgP90lMyfcDGeN4VvVONmv7IIvRjuOfezETPWFmlQyEJZ4zKa+ULQOgXtMbV/b6dPr/TnyXVSVs6mSXYqdD0/l+LWMCdX8SUNgH2PRdGWZ50lfbMEI4d4GhChO7tIc9Uvi7HAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AML2SMEQ; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2b704f08e73so1339420eec.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196923; x=1769801723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=KZzHIvzkCMuY58AGMsPfouNh4EDuKZxC/sZJy4Ux1s1F4kKmGblkZpiU8SOhpxY8sk
         5cIxBxY/ysOcQ4HHDPcRF6sOVEB2KgR+z8nbT1WsmKb9tQpYxPgIytuXGhBRrwDx+/4P
         +Dc9mXInffKIdeeqCcWXdOIO00U8IWytG8oUwBx/Xbg5AkOhmBSwvTFMpo+ZPLof06d5
         az05zOYcRyKBxUfWBvVMOWOKLYwA+Ku3ifwKj4/IjdVZhIFOkJTTaimYaqeNXqSfjs4d
         r1FGHXkrYE74MboNycSFJplqmhfmDHFF+3DReOmCHctATGb/HWYN9pbzC7xI/1p4F6Mv
         7nHQ==
X-Gm-Message-State: AOJu0YznCuPXFk8HuNxWHHRymYt2ZHIa5Nn8nwyWsNtUsmCeDEd6Gze5
	/zCjZNx0n41Z+8pY3xBZ/38oQaTDbMKBeIFZmR4CcFggv3AGV9OT9kPVkIQLKa7RNq5FLEcTecN
	NRQDkaT0sp4mbx8jqBUpqRd4KuDUy0XxZmwT0gtmS4cuaeYshrYTz9ND6GwC/RPaBMNvwmIGXIm
	5FqdhTzEMsMKb/wFU+GAUKpUdWuAOfq4LJ7I6W4y7f4yjJxbl7BPIk6Dv0ZqEruJHY44++DQKGE
	uRwOIwiXBql9oN5YA==
X-Gm-Gg: AZuq6aLPqzurlnqF1nJyQ6WW88zrb62pcUwzvpeOUqoZKmBh5L/6H8s0e973mPRcbR5
	CSfTo+M1FLY/bbgurES/XQWUAtL5CSTKHhbz/mcFZHs8FgJ4ifjHEF5K3q2XQvjlkWg2X/99dPu
	K+1b2jZhdr0UCRRRHEgeuj1JyhN3v1nFcoCzvcKhQDCQxM4iOH0CrTizXXBSnAb0lDNcvWDjMZq
	ZZ6wPwMUJMnSq12SJCt8O/pUIzFo6GbKHQZxMPeEAXStTt5Cz5MnNcxFsYCCSmHwiGrLV2jHd0e
	uFaw39TlzE8zbCWbROXNTgnQw/CEVx7e4pOVSsCUuJEVbtb6ewGzz/o4pvvF5i2LsGzUpnQo7sq
	gmcbL6i0HnaHuqw2D3pWup8Yncb3WNYUtqZEfHQ1D7zEpjf8ponqCozsrlmP/5w8OJobMDi86Dc
	IC4nWZhXX4K02SLyLdtZk0/SmhPtrRa2/4dqVLhWpmSRL2AIm5H1k=
X-Received: by 2002:a05:693c:2d83:b0:2a6:a306:efdb with SMTP id 5a478bee46e88-2b7396af2d1mr1720619eec.3.1769196922710;
        Fri, 23 Jan 2026 11:35:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b73a616cf1sm326188eec.6.2026.01.23.11.35.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:35:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7fc82eff4adso2126656b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769196921; x=1769801721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=AML2SMEQiPnbbZz01QQX91jWy+BJISpKoQzm1CevWZ3AHQLiC3eDex/yvTtc3bAWED
         txOB8IEjjRlfkpPm4kWUUzOSpJK/ZzuFFOAyG99DxsGWPQbW8oggK8OOEx+Sklx0lF+R
         edx6Rc0DCqMz/yh1qGmBkc7ILkRWJe2VSFcnQ=
X-Received: by 2002:a05:6a00:894:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-82317a492f7mr3396663b3a.10.1769196920699;
        Fri, 23 Jan 2026 11:35:20 -0800 (PST)
X-Received: by 2002:a05:6a00:894:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-82317a492f7mr3396644b3a.10.1769196920158;
        Fri, 23 Jan 2026 11:35:20 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e519sm2843206b3a.49.2026.01.23.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:35:19 -0800 (PST)
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
Subject: [v6, net-next 1/8] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Sat, 24 Jan 2026 01:04:57 +0530
Message-ID: <20260123193504.285573-2-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252936-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E32757A30A
X-Rspamd-Action: no action

Add rx-copybreak support in bnge_set_ring_params()

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 19 +++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  5 +++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 832eeb960bd2..8bd019ea55a2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/netdev_queues.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 
@@ -2295,7 +2296,6 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	rx_space = rx_size + ALIGN(NET_SKB_PAD, 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bn->rx_copy_thresh = BNGE_RX_COPY_THRESH;
 	ring_size = bn->rx_ring_size;
 	bn->rx_agg_ring_size = 0;
 	bn->rx_agg_nr_pages = 0;
@@ -2334,7 +2334,10 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 		bn->rx_agg_ring_size = agg_ring_size;
 		bn->rx_agg_ring_mask = (bn->rx_agg_nr_pages * RX_DESC_CNT) - 1;
 
-		rx_size = SKB_DATA_ALIGN(BNGE_RX_COPY_THRESH + NET_IP_ALIGN);
+		rx_size = max3(BNGE_DEFAULT_RX_COPYBREAK,
+			       bn->rx_copybreak,
+			       bn->netdev->cfg_pending->hds_thresh);
+		rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
 		rx_space = rx_size + NET_SKB_PAD +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	}
@@ -2367,6 +2370,17 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	bn->cp_ring_mask = bn->cp_bit - 1;
 }
 
+static void bnge_init_ring_params(struct bnge_net *bn)
+{
+	u32 rx_size;
+
+	bn->rx_copybreak = BNGE_DEFAULT_RX_COPYBREAK;
+	/* Try to fit 4 chunks into a 4k page */
+	rx_size = SZ_1K -
+		NET_SKB_PAD - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -2456,6 +2470,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bn->rx_dir = DMA_FROM_DEVICE;
 
 	bnge_set_tpa_flags(bd);
+	bnge_init_ring_params(bn);
 	bnge_set_ring_params(bd);
 
 	bnge_init_l2_fltr_tbl(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index fb3b961536ba..557cca472db6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -135,7 +135,8 @@ struct bnge_ring_grp_info {
 	u16	nq_fw_ring_id;
 };
 
-#define BNGE_RX_COPY_THRESH     256
+#define BNGE_DEFAULT_RX_COPYBREAK	256
+#define BNGE_MAX_RX_COPYBREAK		1024
 
 #define BNGE_HW_FEATURE_VLAN_ALL_RX	\
 		(NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)
@@ -186,7 +187,7 @@ struct bnge_net {
 	u32			rx_buf_size;
 	u32			rx_buf_use_size; /* usable size */
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	u16			rx_nr_pages;
-- 
2.47.3


