Return-Path: <netdev+bounces-275691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FX+KRn302k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C13A6085
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E196B301C59F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A3392C47;
	Mon,  6 Apr 2026 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T7fvYgN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0138F942
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498740; cv=none; b=bwg1VFbIY6Y/G6YFJ3vqyhApLbixdwxX9oCrcnEo65Xz8YcbDRKkBItAYRxGcUiT16UZSxietfY9RvrjvY9yzmeC8JyuyEL9dSj6/N80uevpczlPJ/mdh43bgzvvcrtRF0Qz9TvM0LFOa6dtESD42ACtxXJ0Z0w223oyGNTsNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498740; c=relaxed/simple;
	bh=0LEd7nXeylgWzhUOs7JXcP9wEOEbd7K2NKI/FMqXn7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKRfV0+eCZk14ugiU3sgH4EydEHjb5RGbw/XF1npbTHXpjleETlK2rcXry4zpET9hqvcybDIuc03iNEejeks2UibHPd3wR/gMdO/TyTVymm3I6yj3LdF+Goh3KOmU6AdYnL24GXJKtRJ7IvFzqlOUzmkTv7Oi8xPURcvb1NChDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T7fvYgN1; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-12732e6a123so1353283c88.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498739; x=1776103539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jpYXGzc0tS+4vu/OqFZfeuXHOs7clzcFPcajiMG5gE=;
        b=Ze0JJmFbEE24q2+DF4GjO2l7qqLeMmE/vihAyzyXVucvnaZF7UAKeCe5WH9c1eK7V9
         6s4yiUZvKdH3/H+JdLPyJ65K1vePFtAnxFypKbWB/4Beuqxxdd0focqF9rDHMJSk7QHN
         OP6BJmMEc27b2wSTHP77tqF0YVFf3nFD1m3zGeDk2Qv3DrCHlubMRsbfGBDOQamo60Af
         nol/VK5cfVyOWgfFBBq6J1w7fbLO+nMNT/UcHFYMP9DCng3/1nlfP5Cy2UHjjnkisU5L
         WOG9pKb0wbgITdKSSSYbL822mGhBTytismu44mZwsZ19h/TFCtjtDSR5scriVq1elDC/
         tfxg==
X-Gm-Message-State: AOJu0YzRdtQL/stPCW5QUbvd+Pmieu1baIKuHtNuEyCaETUMDsVIQ7AT
	GgmVsA1LXbONMPRTAbUJ7oGPrefBbgU9LUPPq5NkmBpOKWI8nJwBm7lpEzhrSjSChruQI2ezDNw
	teN+9rOwBNneSmrX+5czDI5KqKKToI5jb+B1FOxPMVNCIiGXGLXf2oZ/VrTQM5h4S6ypa1ZaQgM
	/6DLlanNn55J6SmJK6dTDLneF8+AkfGlk/hM62aZKwFEiZK+9ZZfzjujldEgjlFxjNJN+o9R8dm
	497fMk0AuJjj8Cpjg==
X-Gm-Gg: AeBDievq5Koqrl+T+WMyeiK0n0XkRp+ZTQci4DdqYL/8WihoOMqM0EHmJZJ9f6ZhS2E
	13AML7PW1mB1GTITQYVaO30mEmCp9fqDzQ7bqrYOfAmVuBNwVntKOWJIxa5VCCjAZfd/CtbKgIG
	XxWDL/tOv5H5eB3MyDQzcJH59reYP++WQ62mTfB42y6pVfYEPjeZdi5NNwImz5VwpbwEeZtQ7wl
	vpLAfSmhPpmqqE7ZGrf0lOXYj3w/t+QP3PouiE8sMNVJgaxLqm91KLl0S53OmZ3mICTjJLTUYOP
	ass65XV6raOcuTDZjwlzc6L5YQFON3ACF8KcIiJTD8359WEq/7WhlrChzjNAv/vgOCeD3QkMN1z
	ZftWoN7LgQ57JpVvDDjEbhyK/g1gx6G88w7M9x/WA13LDxmc0SWx1hPgqNU8pUeIcQVI03yAyMt
	CartK7E+JByKkAIc9ysikhDfbrPqSDounq+ocUeEdKa6t0sfXgGf4u6zxA9bCVreE=
X-Received: by 2002:a05:7300:6d07:b0:2c5:347:e63b with SMTP id 5a478bee46e88-2cbfbf79c2emr7182879eec.25.1775498738564;
        Mon, 06 Apr 2026 11:05:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2cb61750eb8sm884512eec.29.2026.04.06.11.05.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0b0aae381so43639575ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498737; x=1776103537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jpYXGzc0tS+4vu/OqFZfeuXHOs7clzcFPcajiMG5gE=;
        b=T7fvYgN1FwT7EB7yMJWWpu7q9dxxUgGQ1dyA30NmZYyAg6ew7uqYrXbgEB/F9ch/P5
         nEDvEMZzRp9BILTqrvw43ROYCBiAjkOJ2E6/mFqEkEu3q84Gl4pZ7uaKYDGj3iyeQLvf
         KDIJvt1oUy7DT1zjSFnu8rTD8gLa3tkxTus2c=
X-Received: by 2002:a17:903:191:b0:2b2:5637:1487 with SMTP id d9443c01a7336-2b28178f0b7mr139701395ad.34.1775498736807;
        Mon, 06 Apr 2026 11:05:36 -0700 (PDT)
X-Received: by 2002:a17:903:191:b0:2b2:5637:1487 with SMTP id d9443c01a7336-2b28178f0b7mr139701125ad.34.1775498736393;
        Mon, 06 Apr 2026 11:05:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:35 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v12 08/10] bng_en: implement ndo_get_stats64
Date: Mon,  6 Apr 2026 23:34:18 +0530
Message-ID: <20260406180420.279470-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275691-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AD4C13A6085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 6f41dff3fbcb..4148a9ec6d23 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2898,6 +2898,46 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_get_port_stats64(struct bnge_net *bn,
+				  struct rtnl_link_stats64 *stats)
+{
+	unsigned int start;
+	u64 *tx, *rx;
+
+	rx = bn->port_stats.sw_stats;
+	tx = bn->port_stats.sw_stats + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+
+	do {
+		start = u64_stats_fetch_begin(&bn->port_stats.syncp);
+
+		stats->rx_crc_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_fcs_err_frames);
+		stats->rx_frame_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_align_err_frames);
+		stats->rx_length_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_undrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_ovrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_runt_frames);
+		stats->rx_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_false_carrier_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_jbr_frames);
+		stats->collisions =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_total_collisions);
+		stats->tx_fifo_errors =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_fifo_underruns);
+		stats->tx_errors = BNGE_GET_TX_PORT_STATS64(tx, tx_err);
+	} while (u64_stats_fetch_retry(&bn->port_stats.syncp, start));
+}
+
+static void bnge_get_stats64(struct net_device *dev,
+			     struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS)
+		bnge_get_port_stats64(bn, stats);
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2931,6 +2971,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
-- 
2.47.3


