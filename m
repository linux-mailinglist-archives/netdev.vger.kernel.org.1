Return-Path: <netdev+bounces-252940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP/gDNPNc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:36:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68817A33E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF23330347AA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B142BEC4A;
	Fri, 23 Jan 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IexQp+lN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEB2C027C
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196942; cv=none; b=O9Biha52TVthGwA8rcoQSFE7L1KYVFiKpKN4zpX/UDedxoBNK33gBONmkAOKyAgkBVzLu+6VGdnuBQLlQFua48MsuahKcDdmc62F1/99gUgyMGyloRJHwjThYFI0K9hxRWXFWsjssiXtEHgexSwsusqsj/4mjJd9pWm97erqRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196942; c=relaxed/simple;
	bh=+Zc6l/SwHKnLCayJhbpyWDPUKoNOWSCBVYgFGpSy/3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xz2Uj9RZfyglza9REr/Puqu5hVLqZiK63s0GdTU6srw7HqYx8GzocjM3jEUEIeNNgxnWa1WHOqpYnu8LKjl+1UJwjla64H2FwyXreLISyk48gnt6dQRS9CeAQPFi8wAc1+7DZKGyHmXKm9gG4hZ8HoMbRFrLywmTxN/TZc9y9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IexQp+lN; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5663724e4daso1763740e0c.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196940; x=1769801740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdLE4jDYZgc7is6bLs44R3LFutP/tV6g4ht/06BO8G0=;
        b=ISgJUj8rIEUd7778UmCEDFi5ntIrvhRo+jbL8fw3jF8ceqMeaMcSiZfmMDoYc1eCR2
         eyDe+jl6wgyqfqVb1QFCSQpGJsE0Tt86hXLIMu8PoDAoT8ugwS5VZCxF9xmovCfeTAiJ
         9Hoj+WfbG92dLdR3b0pDw+6W99H2FNdaQ/eMDzE5oEvI4l2/pl2LxmbnmXr0Y53NH7hO
         MgDIpippYKtOw8QbYmBWO4hK5thVqv5Xpu9pc9lVQD8XkZOC+IyeEMG19NwZA367BCpe
         cnrQXLR/h9hKvARSm38JR2EWliXSL80WfHzsFF+CkJqrtNqZrmGyl6wgDB7TTnu/r5fl
         3Cgw==
X-Gm-Message-State: AOJu0Yy7S5NFuNh0Z1mingzYuckSftGo5DQdHQB3ixEV0DTZAkWNUHg6
	kz9eE8d+FNPOwEg6NPpge6nbW6CBEQsrYylb98Iy68ChrCUOJKdCZphVAV+cIQAdXjUDD8mDRxv
	JogWgmUKXRYkGn3Q5I5w4W4Tga6847lUma9vOmENfZP6614j+m6OSl/zNI6dlB49mGNILQ6OlGN
	yIcwuax4jaG8rzZc/oNaQ5ivOhtw0bURL9UkRpma2GU6Ud4iZuod1krvDMLIPHuGY6YasaAGyYp
	dcMyiFfofbwQs1L+g==
X-Gm-Gg: AZuq6aKJTsLuOnBan9Ie1Sno0TBWrGm9KFGISdZdCjPr0R4Tqa8xAY1VE/fC8xSvKAY
	hLS/nOFHzZVQKvbuCD+nKC1Zz2UDtyK8zxRMoWTi6wLJ/lYj42Cvpb6E+0h35DHyZjSF1Nc5xTf
	0xtBnTKt42V/PNHUm9JMGD6ocMn+B9DCPudVvh+OctNS3r2D6QA1/iM37KmTfEoyPmuPW20jaJY
	ZI47Fa54m7aozSt2hGec7O7SdJz5tXoVGB0EMdYcpOOEYNEHsz9dbvJip1zl02ibz5nGCEcplNq
	wbge2WLAIXGUiidMEMxnzQlTPoxRiiq3+kTAa6tMHUmWRub3y4W89rCrTm2DY5s3sRHM59ttNVd
	YCj3WZ5QCx6cpBXsgqndrUBsg9iw52AmxQzo/WoaVqxyK5xA0OoW4r9I4O+sDyigNWqPA/BYSn9
	jqL2FwbI0U9tRLSMW5+zjh4s0E+03Pt5+LUvlWyQcxOEPRPxn3tEDSbA==
X-Received: by 2002:a05:6102:c90:b0:5f5:266a:d8b8 with SMTP id ada2fe7eead31-5f54bd3e67fmr1352884137.45.1769196939670;
        Fri, 23 Jan 2026 11:35:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5f54d40f57csm396589137.2.2026.01.23.11.35.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:35:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f8c209cfbso1500715b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769196938; x=1769801738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdLE4jDYZgc7is6bLs44R3LFutP/tV6g4ht/06BO8G0=;
        b=IexQp+lNoV91nZVTxcz4f9zNT8mFrX7xn9tJ+/Hrob3wUY4F7TjOtH+N4yCft4MBye
         fYUTFK1hOCtJAwBHTVCjxgZfcus3RYzkEBAu3N61puzzZdQ26Fa6Sv5I4c7KAJALYxEv
         gE7ay9daifYFHk0NTuPWFrxd1zcly5TIMbMQc=
X-Received: by 2002:a05:6a00:1790:b0:81e:b2ba:5b3a with SMTP id d2e1a72fcca58-82317c13039mr3557634b3a.8.1769196938359;
        Fri, 23 Jan 2026 11:35:38 -0800 (PST)
X-Received: by 2002:a05:6a00:1790:b0:81e:b2ba:5b3a with SMTP id d2e1a72fcca58-82317c13039mr3557611b3a.8.1769196937837;
        Fri, 23 Jan 2026 11:35:37 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e519sm2843206b3a.49.2026.01.23.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:35:37 -0800 (PST)
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
	Rahul Gupta <rahul-rg.gupta@broadcom.com>
Subject: [v6, net-next 5/8] bng_en: Add ndo_features_check support
Date: Sat, 24 Jan 2026 01:05:01 +0530
Message-ID: <20260123193504.285573-6-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252940-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A68817A33E
X-Rspamd-Action: no action

Implement ndo_features_check to validate hardware constraints per-packet:
- Disable SG if nr_frags exceeds hardware limit.
- Disable GSO if packet/fragment length exceeds supported maximum.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 24 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 2c1df5d48b5e..2c8f8949d500 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2420,6 +2420,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_features_check	= bnge_features_check,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index efd08c93008a..33f39a57f12d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -962,3 +962,27 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
+
+netdev_features_t bnge_features_check(struct sk_buff *skb,
+				      struct net_device *dev,
+				      netdev_features_t features)
+{
+	u32 len;
+
+	features = vlan_features_check(skb, features);
+#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
+	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS)
+		features &= ~NETIF_F_SG;
+#endif
+
+	if (skb_is_gso(skb))
+		len = bnge_get_gso_hdr_len(skb) + skb_shinfo(skb)->gso_size;
+	else
+		len = skb->len;
+
+	len >>= 9;
+	if (unlikely(len >= ARRAY_SIZE(bnge_lhint_arr)))
+		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index 81a24d8f9689..32be5eb46870 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -119,4 +119,7 @@ irqreturn_t bnge_msix(int irq, void *dev_instance);
 netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
 int bnge_napi_poll(struct napi_struct *napi, int budget);
+netdev_features_t bnge_features_check(struct sk_buff *skb,
+				      struct net_device *dev,
+				      netdev_features_t features);
 #endif /* _BNGE_TXRX_H_ */
-- 
2.47.3


