Return-Path: <netdev+bounces-254416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKwgET9cemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:58:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0052A7FB2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248B63054D09
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999936F417;
	Wed, 28 Jan 2026 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BMYoha+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E2372B48
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626633; cv=none; b=SaPGwFy1iwDBM7bF5Zf3YFzBDamUsgylfRg0aYRBCJ4Srrfvjhkp+jU2Twq2KPTANZRWjU2Y33ak0yYM9W6UHM3vGasiejc0Y5X3Xqm7VhXUobxwROPhPnHiYtMzTuNpKUlxgFvh525RnbTKej5YhXv9sQZfVttAy/P9icCbqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626633; c=relaxed/simple;
	bh=G42HEdK63RMSkNcCPQGCk4X08ncSFrRURRT8K21yxRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFalURXSh4DkIUrc+cw2do+yVfDV8+jZ6oWCeLPeOEA1d3YKbUepITrw9teZS2yV111NFr6l+CwFO842OuTpqB9MJgh2bg4YOkRmjjjOJz+HVCHsP0QJR65/8iDPJJk6RpieLywKWQS23kvz/VqpEPyZ0Hfm1zcmerxPDXxhEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BMYoha+L; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so144895b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626631; x=1770231431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=QHX0KCUfNfoLg6roBUAhGprnaWNSND1jbVDXkAmkYJiUaWNQuwLEkV8miBVfrzBPXC
         c/GIqlQleIqg34CFnNJjJi8MZbkApZ7MQwIGdFGaOuq+LKUGrSCvqng5oJ1H2ZKLxfDs
         ArH2M/uD7ZokIC6eHKgOaGXRRHlzu3k2nkHOsw8seGmnDdDJolPlbCWP9smEh2SaDbHJ
         quVB+9sZ1AN3/L3qupYQdCS+TVMZv1+8m0EQNi1QfmN0qOPDc89Vl+pxRiwKzn2+FMcN
         pO6QH8ccpgAHmunKQwNz8gBewWkzHUQ9qq1wMWDo1UU1UfqaGHNBEt2nmIfhdfskPMGq
         3E6g==
X-Gm-Message-State: AOJu0YwK6kixBgfe2CwfiimGU5tI9hCd/hlDLC9cW7ALzwWCkMEGiij8
	qGvVWDa5ec5elJZLc5qW4S6/r3eBnIC/uWdxqopJjfCpSQlfHnjLwwP27FsPvMXZU/a9R85xxxv
	yOHi7sAujzyXadKGj3PF5GTtUxrNVrbpDdkx1ik2+Z36w8R27AACLZDriEsO5MBIPfddlpTVVLy
	FvBY2SIA+dErj25NttnbJqCNTMM2Tn7O1LMPkh8G5UU6qha7iVwZVfe+edzfw7WVp/O8BXC9ZYC
	YUFxooOLRSVL7V7qA==
X-Gm-Gg: AZuq6aI6rkEQQ+RbawP0R0wiBJ+EcIdIstUGjEy2tdEkHsMsNPiZJ2gZn9H/z8JE8Ik
	QOGZ+3S/Gu0kxEPkGP3Y4XIzYRiJta/0R83bzYuHVE0XJjm/pxk2zHD+I2wbyHRfIsAxEPmzAxS
	AMFZv2UTTrMBH2/fbu3GpT24GjStvgaaKoqCq06UAltc3rgC2IYYKYkIlgZbBj9ubY2tMJWizUG
	g6J0LuJrNIwXdFAmhy2sxLjrlEjo1wILB2Nr/6ZESJWGeGnsT9V8nTcwdOIIMfYygKO/1LhCYbB
	NhjDF5DdRFumPAFQdjTbGgM+N+qzIGxhayv0rG/8H6Yc+Gl2KVPVMJTdYQkkA6guq0CqJGhKnaJ
	zIj8cicDNNoxbb6hwV9cBlqFKx65dbCowzow206zwVeFAaFTCjp6tELeJhTAh1P717XBYY2d2sj
	hGco/gDW/ULMScztbPTqWsGifbBACHg/JYGWMK415oRHowD0npYpM=
X-Received: by 2002:a05:6a00:240d:b0:823:244f:1fac with SMTP id d2e1a72fcca58-8236916783emr6029542b3a.6.1769626631403;
        Wed, 28 Jan 2026 10:57:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82379b46b08sm346540b3a.4.2026.01.28.10.57.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:57:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f39ad0d82so308487b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769626630; x=1770231430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=BMYoha+LlWjggbGcsF/94siq0ARa6jD6QtVBhd8UughdZK/gP71/ueVa25oabqok/K
         s3SU/tieuPjgUEWJVKTgjw2QkJZfhXaW0X9jpWICGCv9ccDr+ExHRHI/wy1DGWDZoW4m
         Z5Izw/VP47TjFUKyrhrPZxOgzCbO52Lkdkgaw=
X-Received: by 2002:a05:6a00:ad86:b0:81f:9a5c:5b95 with SMTP id d2e1a72fcca58-82369301f3emr6799942b3a.68.1769626629505;
        Wed, 28 Jan 2026 10:57:09 -0800 (PST)
X-Received: by 2002:a05:6a00:ad86:b0:81f:9a5c:5b95 with SMTP id d2e1a72fcca58-82369301f3emr6799921b3a.68.1769626629130;
        Wed, 28 Jan 2026 10:57:09 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22466sm3263536b3a.50.2026.01.28.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:57:08 -0800 (PST)
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
Subject: [v7, net-next 1/8] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Thu, 29 Jan 2026 00:26:16 +0530
Message-ID: <20260128185623.26559-2-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254416-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A0052A7FB2
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


