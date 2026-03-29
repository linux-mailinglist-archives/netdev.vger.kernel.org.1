Return-Path: <netdev+bounces-273034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNhJOiu1yWlO1gUAu9opvQ
	(envelope-from <netdev+bounces-273034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D37354679
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B24B3009567
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4BA366DB5;
	Sun, 29 Mar 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ASUQ4NvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C376026
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774826784; cv=none; b=CVQ3b+uP41mUcE2AEE9vB69ynqAXTh7R+K2cX0ZI9khrERyt5xoMI/QGZz0vot9x0jvEo6kUQVEFj+gw7LUTY7ANLkrALsjf/sSaYVCtDJb9jSlo2sJrtKhL1SjKhxapz17Mz5eXoAaB2Pzba7FUsjKId8Y+Z2+UNYxdnvcJ7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774826784; c=relaxed/simple;
	bh=G0/tYhvX3czc5pELyj0sYz+2gm+FdjVv+mJ5GdliiKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MABF1u01dH7V9rAwmbJqw6pefIV/n5lMcAntovq69ZtOeUe6y24lzC/Q8D/R+7yXzGH4yMcPQKfvT/Th3SC0GQOi71h/Q/FSk2bp6lG8cdsf1x1tRvENYQ5F2ZEheqzF+UKdTEdbTWj8/E6T3BkxtjaNKkHFi3+fpAJY96IdT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ASUQ4NvW; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-650182d19e0so693604d50.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774826782; x=1775431582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwQY6Q1xUKoKQ2ogGjN0YyuUC7VxDZ8Wo21nhnvPQI4=;
        b=n0B2z0gVoy8/haEAkIVKS8De4ENSfkB+JciKsHk+j7eHa55fQ5PmDE24YBeLlTQ40S
         fLyWHwhY4MqLG9E5NaRHl/F5IaoC3H8q0HliKEqrxNp1LEHUwJOmI/OBMWjzx8Hqhnm2
         QASW81snEYSda+ISRkJAYY3kMTMKAAmY+r7Bxmf9sog7oFuZqwjxeGjU5HrXk+EnVgIu
         Al1JDjnbmA3M9G6s9Wm/hDQca5RGKaaCx/ZTLUVDQFEG8WJuu6CokwN649TcTbpEXbcr
         sDctVv00hvYzjzN7aZ08wBWNnfQBjFZ8EvR4/CXO2xFwL4Hh5rMZDWMcY95E/80NzyEP
         D7uw==
X-Gm-Message-State: AOJu0YxduHV29ToS142FgezBtVPT7J82z+NwwejmI+fkF/v6eUMhiYss
	qHJaH7ZWzueWJHCqcJwJwX87utJkdhK6M8xLwpX2DvSD5gUhn0tK6LiFjmLv1FdSusIAK0So/fx
	JyRSDQp9yiYQFTojubzEiT/dqPx8gbAvdY4ZXsrEMSk0biyY2TPAWXqdcZ9XgogNY7WEixd4VsY
	yhwVOILzH2TinNCGgcrFo3kJx8pXF6GvupMtOXz3KNqOisO9jWrT4jE5fgkNvuqvWeLYB3scCu1
	qIVSOOUlU0=
X-Gm-Gg: ATEYQzzhsTSCfAWhtAZ22yMDIJDs2n1At2eG30PTfe0Ua7ZoKrlQCkKHAArwS/yxooj
	eIsSRo3kJPEo/HIz4iSFK8FmRXTc9x4ft4F7jtSybEKPsOtfwCJGx9XucDhmM6iNzuNdatjWtxB
	XcooZ5cPxGf6thUyeUPUerwIQ7h1OOWxe/ZJCsQzPYZPFcgbu1bK3hhRyjbcbb2gLNpwXcA52di
	6yzyOiI0aEBHjGDhshBqQhlX2uCFXaF+WUVvFI52FMYT/7jrKTYpy9wVzDovg+wVHj5Tl5/EhB6
	wpwLNCffZTpCnFu1/UL9e1yKGITV0iwtDr0p79YC+yzK3f/5TRaoBLY6OCC5fvkKQRdny2vjGKf
	elF3A4fcXopq5aEgemdw8IBOqp099b0TZicM76ZmS61xacpM5ueSlUiyMOxJXQTma1j0BiCtMIs
	wsbjGOfWjiHuOqU8ScLPB+U1bkj3cD3ydw6pYuUU59P/6pTFpq+9N+VYdo
X-Received: by 2002:a05:690c:389:b0:79a:d067:1b45 with SMTP id 00721157ae682-79bddd1523amr109217157b3.22.1774826782082;
        Sun, 29 Mar 2026 16:26:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79cb9f7d954sm4651247b3.16.2026.03.29.16.26.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2026 16:26:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50939597b85so99598871cf.2
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774826781; x=1775431581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwQY6Q1xUKoKQ2ogGjN0YyuUC7VxDZ8Wo21nhnvPQI4=;
        b=ASUQ4NvWZjgyelpesU1IH4rRWy5YPrpitxgix5z9naQccAyPbGRX+X8jMtqLuNRH76
         GK1qEidSn5uSKcjgU9DOtD4ihR8g4+NNGcmIjr2oBtaUZj4lMsFYY5r3DKcA+/8+aJlA
         fAYxid3GUrry2U15G5JQMjku2xT1lIA27FyFU=
X-Received: by 2002:a05:622a:112:b0:50b:6b21:2a73 with SMTP id d75a77b69052e-50ba380a51bmr145762771cf.1.1774826781172;
        Sun, 29 Mar 2026 16:26:21 -0700 (PDT)
X-Received: by 2002:a05:622a:112:b0:50b:6b21:2a73 with SMTP id d75a77b69052e-50ba380a51bmr145762501cf.1.1774826780621;
        Sun, 29 Mar 2026 16:26:20 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb7729698sm41601531cf.29.2026.03.29.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 16:26:19 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 1/3] bnxt_en: Refactor some basic ring setup and adjustment logic
Date: Sun, 29 Mar 2026 16:25:26 -0700
Message-ID: <20260329232528.870637-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260329232528.870637-1-michael.chan@broadcom.com>
References: <20260329232528.870637-1-michael.chan@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273034-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 53D37354679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor out the basic code that trims the default rings, sets up and
adjusts XDP TX rings and CP rings.  There is no change in behavior.
This is to prepare for the next bug fix patch.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 53 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  5 +-
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0751c0e4581a..fa44c86af67b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12992,6 +12992,21 @@ static int bnxt_tx_nr_rings_per_tc(struct bnxt *bp)
 	return bp->num_tc ? bp->tx_nr_rings / bp->num_tc : bp->tx_nr_rings;
 }
 
+static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
+{
+	bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
+}
+
+static void bnxt_adj_tx_rings(struct bnxt *bp)
+{
+	/* Make adjustments if reserved TX rings are less than requested */
+	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	if (bp->tx_nr_rings_xdp)
+		bnxt_set_xdp_tx_rings(bp);
+}
+
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -13009,13 +13024,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (rc)
 		return rc;
 
-	/* Make adjustments if reserved TX rings are less than requested */
-	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
-	if (bp->tx_nr_rings_xdp) {
-		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
-		bp->tx_nr_rings += bp->tx_nr_rings_xdp;
-	}
+	bnxt_adj_tx_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -15436,11 +15445,19 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+void bnxt_set_cp_rings(struct bnxt *bp, bool sh)
+{
+	int tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+
+	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
+			       tx_cp + bp->rx_nr_rings;
+}
+
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	bool sh = false;
-	int rc, tx_cp;
+	int rc;
 
 	if (tc > bp->max_tc) {
 		netdev_err(dev, "Too many traffic classes requested: %d. Max supported is %d.\n",
@@ -15473,9 +15490,7 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 		bp->num_tc = 0;
 	}
 	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
-			       tx_cp + bp->rx_nr_rings;
+	bnxt_set_cp_rings(bp, sh);
 
 	if (netif_running(bp->dev))
 		return bnxt_open_nic(bp, true, false);
@@ -16525,6 +16540,15 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
 }
 
+static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
+{
+	if (sh)
+		bnxt_trim_dflt_sh_rings(bp);
+	else
+		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
+	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+}
+
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 {
 	int dflt_rings, max_rx_rings, max_tx_rings, rc;
@@ -16550,11 +16574,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		return rc;
 	bp->rx_nr_rings = min_t(int, dflt_rings, max_rx_rings);
 	bp->tx_nr_rings_per_tc = min_t(int, dflt_rings, max_tx_rings);
-	if (sh)
-		bnxt_trim_dflt_sh_rings(bp);
-	else
-		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
-	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+
+	bnxt_adj_dflt_rings(bp, sh);
 
 	avail_msix = bnxt_get_max_func_irqs(bp) - bp->cp_nr_rings;
 	if (avail_msix >= BNXT_MIN_ROCE_CP_RINGS) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a97d651130df..4bc7f7aeaab3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2985,6 +2985,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		     int tx_xdp);
 int bnxt_fw_init_one(struct bnxt *bp);
 bool bnxt_hwrm_reset_permitted(struct bnxt *bp);
+void bnxt_set_cp_rings(struct bnxt *bp, bool sh);
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc);
 struct bnxt_ntuple_filter *bnxt_lookup_ntp_filter_from_idx(struct bnxt *bp,
 				struct bnxt_ntuple_filter *fltr, u32 idx);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 28d0ece2e7b1..0407aa1b3190 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -945,7 +945,6 @@ static int bnxt_set_channels(struct net_device *dev,
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
-	int tx_cp;
 
 	if (channel->other_count)
 		return -EINVAL;
@@ -1013,9 +1012,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	if (tcs > 1)
 		bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs + tx_xdp;
 
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
-			       tx_cp + bp->rx_nr_rings;
+	bnxt_set_cp_rings(bp, sh);
 
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 85cbeb35681c..bebe37e139c9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -384,7 +384,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 {
 	struct net_device *dev = bp->dev;
-	int tx_xdp = 0, tx_cp, rc, tc;
+	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
 
 	netdev_assert_locked(dev);
@@ -431,8 +431,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = max_t(int, tx_cp, bp->rx_nr_rings);
+	bnxt_set_cp_rings(bp, true);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 
-- 
2.51.0


