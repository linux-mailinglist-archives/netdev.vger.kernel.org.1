Return-Path: <netdev+bounces-284101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGAfEYcz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:02:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2574C5127
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A41B2302F73C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216243FF8A7;
	Mon,  4 May 2026 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J6N3l/NE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D403FFAAE
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939162; cv=none; b=Vo5BrCH96BQOzVyaTNY2LoPC9kdZK2qonznlVgPw31OyjR5C9KeMVVJpXwBiTgTB98TT1Tg1yLDVCtCFO+zwshx1YlRguTozhjvAzIzsqDqqdBMKfDxYbowjt7spwG8KQk99yHkwXRYKrn51tP71bMVO/cX+kohoq0gpxDe2gLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939162; c=relaxed/simple;
	bh=Bf7ebQpL29GciLFzenFAKkb9H2c/jtdvJ0IpbX6ZT1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7Rv8vshIYYiPp/66/41hM39fAkcEn5hQ2J0/gjIZ7BLe55NS3RyaHEU9HS0hNuoS4JgedW7A6y4Kwhreyel2PwlpJTxNblGklX2cXRD2YeDbaZ02t7iGM420pNoKPWI6qFAArIjtPrAsgQX0C/rAJXXQizXx8ij8gw7VJlzTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J6N3l/NE; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-65c6a2158d3so182725d50.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939159; x=1778543959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkCm2ITKN7piLyO9VSnv0mQgUDHe1kUJDW/DbH+Vxuc=;
        b=spS4/w99fcSpuIpFLDR1FnyZKBnm7KGEUyC+PWAHpJexuir5oKVHCasDW56SrlCq7w
         Wk82mUKDZH8lGcv7lLDYgq58asUvaJtyKRBS8EfaU2/YFqWOgQKUkYzLm1rr4HE0TE0q
         827XfJjOMw65YalRrUckbDkFOQ+l3nU5vjf0sMuKtZbiO06q0T2EDUrnqTyAzU4WMIT2
         iXSudej5N+Z7Wef4LJHAr/xmPoKhASDdUjM3H9btvJ5Ur8nnDmMDFnuCMJ41QDOxw8Dv
         Le+OMpEyCPEMrShYMOz2RuspYSBKgts2rTE6DowMDad4QJSaRODqEh2prTEYhA6GOWsC
         mq1A==
X-Gm-Message-State: AOJu0YybnKODygxCEvfPVuooHF6ngKkgBgs8bjlvfdCQxNnnt6pq5Y85
	AUJTMCrBItfhTp/Y9Q6BJlYxecI3jRkUy4kMze9GPwuEOPDZFiikjHiYqt+DSePuKWAJy3IyRJt
	yEfXKZieWM+cpSsqkxaI8sWq4d15nhYPCNe1dvmWPGxR3sWv82SRR2miDMT6PwLu0CdJX3d81Ev
	eSClOqKyhwWcj2gAfVSiVMw4BpLvgUT3Z+JA+xlLdn0eQ3eug+hkwFZfj2aMgjtMlUcZWx0BUbk
	5BLh7zIi/0=
X-Gm-Gg: AeBDiespxYaySHIe+Udf9EXRB7gCfczloNEJ6UnlP7AvD0GZ3Py3aAwbexgXihvSoI/
	WGkR33Xbo4ag5WY7At7OIP5UoUtCYeO/JPIr1siNW6zKylg8tKN0YW1keRe5mIk2bYbm7VKLCao
	d0wCmqdLRNi6yOd6FItZrDr+PN2BYiCL6QjEV4HY0N3zO5MqANCGTkeV3FgABv/wW8zQPUG3TL9
	sLAY/O1efB6nKQP8w/WtKMommbrUS3+rH7HZVncY717slaFJSxuMe2r0SyDidMU3i2dLctURidf
	D52zASNnvcW3JkkG7GoTPc3Ow/luXAvGtk4rrKPylEIHFItnP6PU33rZedO0zZq0NEEIhOuw6/6
	MPc2/+HtfkIJWHMDV9KQQj3/cpuk4gZEdyILfDKY+5fa7dmb2D6JzI1fK8ObU48AhpX0EM4DiC/
	5jc9cfNvYRKxL2nDL9wfhaRrQ3CdJd/C2fAYyKeg8IFQ3Trlf4iqcWG2YI7axoY3cqz0Y=
X-Received: by 2002:a05:690e:4842:b0:650:849:db44 with SMTP id 956f58d0204a3-65c3daf997amr8210546d50.38.1777939159409;
        Mon, 04 May 2026 16:59:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65c2e4de0d5sm980550d50.20.2026.05.04.16.59.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b46c014a26so104295866d6.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939158; x=1778543958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkCm2ITKN7piLyO9VSnv0mQgUDHe1kUJDW/DbH+Vxuc=;
        b=J6N3l/NEwvrOAHWTH1Sahol/+S5VMAzjcT/TcDpMbKTtx578Kx+OFCXLcf+SEIXvQv
         eKJVvyfNVZPTpXpORidfAZ4qaAQW3kQTGvcgjxlQGfpsWCr9eVPNHgaat1Z7LPlrK2RI
         bSpzfQvXEzHIS3l9JKNPJ99M3eI7KAbfl1hR0=
X-Received: by 2002:a05:6214:53c5:b0:8ac:ab3b:39f7 with SMTP id 6a1803df08f44-8b665ffee30mr189953386d6.4.1777939157610;
        Mon, 04 May 2026 16:59:17 -0700 (PDT)
X-Received: by 2002:a05:6214:53c5:b0:8ac:ab3b:39f7 with SMTP id 6a1803df08f44-8b665ffee30mr189953076d6.4.1777939157078;
        Mon, 04 May 2026 16:59:17 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:16 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 03/15] bnxt_en: Set default MPC ring count
Date: Mon,  4 May 2026 16:58:24 -0700
Message-ID: <20260504235836.3019499-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260504235836.3019499-1-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 9D2574C5127
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284101-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

If the firmware supports MPC channels and CONFIG_BNXT_TLS is set, set
the default number of MPC channels.  These MPC rings will share MSIX
with the TX rings.  The number of MPC channels for each type must not
exceed the ethtool TX channel count.  bnxt_set_dflt_mpc_rings() will
determine the count for each MPC channel type and it cannot be directly
controlled by the user.

We also add bnxt_trim_mpc_rings() to make final adjustments in case
the number of reserved TX channels is less than expected.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  7 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 62 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 15 +++++
 4 files changed, 87 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5c7dabef35e9..a2457ffc54e7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13144,6 +13144,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		return rc;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16678,6 +16679,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 }
 
 static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
@@ -16729,6 +16731,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_set_dflt_ulp_stat_ctxs(bp);
 	}
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
@@ -16743,6 +16747,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
+		bnxt_trim_mpc_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16777,6 +16782,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 		goto init_dflt_ring_err;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
@@ -17120,6 +17126,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * limited MSIX, so we re-initialize the TX rings per TC.
 	 */
 	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bnxt_trim_mpc_rings(bp);
 
 	if (BNXT_PF(bp)) {
 		if (!bnxt_pf_wq) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9b14134d62d2..11cb1b841359 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -37,6 +37,7 @@
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
+#include "bnxt_mpc.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -1050,6 +1051,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_set_cp_rings(bp, sh);
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 9859a5f86268..cce73d56e46e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -3,6 +3,7 @@
 
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/bnxt/hsi.h>
 
@@ -45,3 +46,64 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 		return 0;
 	return mpc->mpc_cp_rings;
 }
+
+void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int max = bp->tx_nr_rings_per_tc;
+	u8 max_cp = 0;
+	int i;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		mpc->mpc_ring_count[i] = min_t(u8, mpc->mpc_ring_count[i], max);
+		max_cp = max(max_cp, mpc->mpc_ring_count[i]);
+	}
+	mpc->mpc_cp_rings = max_cp;
+}
+
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int mpc_tce, mpc_rce, avail, mpc_cp, i;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	avail = hw_resc->max_tx_rings - bp->tx_nr_rings;
+	/* don't use more than 80% */
+	avail = avail * 4 / 5;
+
+	if (avail < (BNXT_MIN_MPC_TCE + BNXT_MIN_MPC_RCE))
+		goto disable_mpc;
+
+	mpc_tce = min_t(int, avail / 2, bp->tx_nr_rings_per_tc);
+	mpc_rce = mpc_tce;
+
+	mpc_tce = min_t(int, mpc_tce, BNXT_DFLT_MPC_TCE);
+	mpc_rce = min_t(int, mpc_rce, BNXT_DFLT_MPC_RCE);
+
+	avail = hw_resc->max_cp_rings - bp->tx_nr_rings -
+		bp->rx_nr_rings;
+
+	if (avail < BNXT_MIN_MPC_TCE || avail < BNXT_MIN_MPC_RCE)
+		goto disable_mpc;
+
+	mpc_tce = min(mpc_tce, avail);
+	mpc_rce = min(mpc_rce, avail);
+
+	mpc_cp = max(mpc_tce, mpc_rce);
+
+	mpc->mpc_ring_count[BNXT_MPC_TCE_TYPE] = mpc_tce;
+	mpc->mpc_ring_count[BNXT_MPC_RCE_TYPE] = mpc_rce;
+	mpc->mpc_cp_rings = mpc_cp;
+	return;
+
+disable_mpc:
+	mpc->mpc_cp_rings = 0;
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc->mpc_ring_count[i] = 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 7a7d81197ea6..4ff8cad75a23 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -17,6 +17,11 @@ enum bnxt_mpc_type {
 
 #define BNXT_MAX_MPC		8
 
+#define BNXT_MIN_MPC_TCE	1
+#define BNXT_MIN_MPC_RCE	1
+#define BNXT_DFLT_MPC_TCE	BNXT_MAX_MPC
+#define BNXT_DFLT_MPC_RCE	BNXT_MAX_MPC
+
 struct bnxt_mpc_info {
 	u8			mpc_chnls_cap;
 	u8			mpc_cp_rings;
@@ -37,6 +42,8 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
 int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
 int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
+void bnxt_trim_mpc_rings(struct bnxt *bp);
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -55,5 +62,13 @@ static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 {
 	return 0;
 }
+
+static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


