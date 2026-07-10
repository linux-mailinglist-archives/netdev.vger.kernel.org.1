Return-Path: <netdev+bounces-306431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LPe7DSp0UGotzQIAu9opvQ
	(envelope-from <netdev+bounces-306431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F97371F5
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=MpSL8TYy;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306431-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306431-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97137302548C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EBD36D9EB;
	Fri, 10 Jul 2026 04:25:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9F2C236B
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:25:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657504; cv=none; b=ipN9eR3nzYtncvn02oaBqhUQamHTNwXfSLOltmi/7Wx6wWm+fS9VzlBGHQFoqRgYoMlJEaKtVE5p4Rvd2jUfWIWLSUQ1b4Pm9vJSb8AfvCqllxTe1JDKzO5NDGF4ONwNgH5e6RYkO/qcDtRiQ8X2ctU2Sfbsj23XhxcJxVarvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657504; c=relaxed/simple;
	bh=Qthswh7/e0G8OUoyLGOwl7aPjSw3HzCN57CIt2kaDK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuC8FdNgymx2cjn4y+dVj4T4w32bw4zzQ3b2TNxmtYK2PGTYvXBBsymqTNaMwWVzgounjmyhQzScHr5eliSHTnTZzeV+beX3mGB/eyLsGPar03hCPW7kJWzL5jBaOxXY/sIlc/bz28xCihHFHt+Gwrh07G/wembSvbaWfR+mwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MpSL8TYy; arc=none smtp.client-ip=209.85.221.225
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5bdd0779366so123480e0c.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657501; x=1784262301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdVNttbpgyYJlr/RK4uUJyBfa0wOByJbU39W0r5qtBU=;
        b=EJhecXdsP77Ngz7awJNS7ProEBDomoHlpBmbVtY/WtPRfDzweiWEBfFlUpN7QfHNGw
         WVnrK0wa8+9PwY7BoM0cdHaDl8tjoIITVU1N/hy4t8h+y2eKvia3wrNOnFCGEHMubZ5T
         Gp7zXZmeHXInLsB+LDSvegky8dl3qDxUBtCZoACsMlDAso25SIderRmegR72pHTgGnft
         6plM3OkdlI21iqFGKK9AoxwYNkuhluxGl1toLnRbpyAE1g4gllQOB9+3BLLg97DrLF+a
         ZRsLPsXOKBuzGf0q4PJZFrwrch6dZjlQO/oNSfsUOm0Ma6cx06FM+fr6jSH4Z95O9ue2
         r4pw==
X-Gm-Message-State: AOJu0YztiMwtYdAV29mHwnnNjwy7qCC951KZK6wCAPgdDFvD5Xupolpk
	tAxCkT2Fjj4URlyObm10sLD4olx65ZGwnZJsEMjg7v9tFAsUg+MkfuBZ3EWoUj1+11xMsrSDIEq
	od9w1qWFm0fGCTBPvGN91HA78RY4pGHwkGqMvpv0LSAKADUeM0qOKgUk//i8MVZWPHwfb/GS2sm
	O4ILZWYD7xjfp4aEpPf6dqLBvJ+Kj9AXn9a4BNFATjy3L3G8eEMUIrfZL6quLMzpRaR9NfmTPDW
	mmjCsW2H14=
X-Gm-Gg: AfdE7ckeX1/7m2c8ISnXQrDsMQ+QoBzV0PB7EwXX+uI+WUPEB62TgdsrKBEBu97mfuE
	WgG939zbmWvHjJg8UVAiTnLXFd2h/jd/Unn3tjf20ftS08N+A6f3iiUSf0IiPjGrtHPZwZf6IXM
	xNi6XoocSqFSV3kvf3bN788J94aNnlSiUtCGXGKDvbqSEAbfe6a0/Ld09LP4w93WUs1NvAI+Q11
	ly7U25pTBehGIniGzyrIxRFYqCy6Stujyfyi4y4znq8Vge3ldyJAUVct+xEYqDJUKBcKu9uOpWc
	5areCfXBkJtm9DZbaDu0TLynw9IRBSVhKjez2GFNiCfvK3GRae0yEhhWo7qA5IQ4xs41W7e9dYU
	bLxB0sNE6MXyonxGI6lTT07XPxZp2j9NKsiyL1HUZhfFevyp/2SDGBEQKJfQgvyOtKBFuFp99oU
	grWhLV7ilNqN1KMxo6ph/ystqgmI7f38BTKfyiiYuOdjNI+Q==
X-Received: by 2002:a05:6123:52:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5bf75d46250mr5683112e0c.2.1783657501296;
        Thu, 09 Jul 2026 21:25:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bf6f822c20sm834903e0c.7.2026.07.09.21.25.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:25:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso6230995ad.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657499; x=1784262299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdVNttbpgyYJlr/RK4uUJyBfa0wOByJbU39W0r5qtBU=;
        b=MpSL8TYyGBu6lEAel/3OG/Cz+pH/sNkejI1WsNuKiaFi/p+wDmnEDuP7Z+IN9EpVKi
         9+YWuJnIe1un0jB7ZeO/C3YTKKVyhQzj2XYCcj2ugCDHuTdxE78SNdkYzDDYKh0jxSc0
         KGIGaG73syBSAlnIpdRebGSO/KhLYw1AyUiq4=
X-Received: by 2002:a17:90b:3fcb:b0:37f:9cdf:f0ab with SMTP id 98e67ed59e1d1-38941cc76camr10464183a91.26.1783657499132;
        Thu, 09 Jul 2026 21:24:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcb:b0:37f:9cdf:f0ab with SMTP id 98e67ed59e1d1-38941cc76camr10464145a91.26.1783657498541;
        Thu, 09 Jul 2026 21:24:58 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:57 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 10/15] bnxt_en: Add MPC transmit and completion functions
Date: Thu,  9 Jul 2026 21:23:55 -0700
Message-ID: <20260710042400.3996847-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-306431-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B6F97371F5

Add transmit, ring selection, and completion functions for midpath rings.
These will be used to send control data to the crypto engines.

All TCE/RCE completions are short (16-byte) completions.  The long
completions logic in bnxt_mpc_cmp() is added for completeness only.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
Add description in commit log that crypto engines use short completions
only.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-11-michael.chan@broadcom.com/

Use WRITE_ONCE() for TX prod/cons.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-11-michael.chan@broadcom.com/

Fix unused variable warnings

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-11-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 157 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |  65 ++++++++
 4 files changed, 227 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4f7042d91078..d8b9c39dda5c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3115,6 +3115,9 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+		} else if (cmp_type == CMP_TYPE_MPC_CMP) {
+			if (bnxt_mpc_cmp(bp, cpr, &raw_cons))
+				break;
 		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_ASYNC_EVENT)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1302c39a7af9..e62b856e78f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -47,6 +47,7 @@ struct tx_bd {
 	__le32 tx_bd_len_flags_type;
 	#define TX_BD_TYPE					(0x3f << 0)
 	 #define TX_BD_TYPE_SHORT_TX_BD				 (0x00 << 0)
+	 #define TX_BD_TYPE_MPC_TX_BD				 (0x08 << 0)
 	 #define TX_BD_TYPE_LONG_TX_BD				 (0x10 << 0)
 	#define TX_BD_FLAGS_PACKET_END				(1 << 6)
 	#define TX_BD_FLAGS_NO_CMPL				(1 << 7)
@@ -160,6 +161,7 @@ struct tx_cmp {
 	 #define CMP_TYPE_RX_TPA_AGG_CMP			 22
 	 #define CMP_TYPE_RX_L2_V3_CMP				 23
 	 #define CMP_TYPE_RX_L2_TPA_START_V3_CMP		 25
+	 #define CMP_TYPE_MPC_CMP				 30
 	 #define CMP_TYPE_STATUS_CMP				 32
 	 #define CMP_TYPE_REMOTE_DRIVER_REQ			 34
 	 #define CMP_TYPE_REMOTE_DRIVER_RESP			 36
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 40351b7c0b82..a8d757712b38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -418,3 +418,160 @@ void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
 		}
 	}
 }
+
+struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int n;
+
+	if (!mpc || ring_type >= BNXT_MPC_TYPE_MAX ||
+	    !mpc->mpc_ring_count[ring_type])
+		return NULL;
+
+	n = raw_smp_processor_id() % mpc->mpc_ring_count[ring_type];
+	return &mpc->mpc_rings[ring_type][n];
+}
+
+/**
+ * bnxt_start_xmit_mpc - Transmit message on an MPC ring
+ * @bp: pointer to bnxt device
+ * @txr: MPC TX ring structure pointer
+ * @data: MPC message pointer
+ * @len: MPC message length
+ * @handle: Non-zero handle passed back for the completion
+ *
+ * This function is called to transmit an MPC message on an MPC TX ring.
+ * The caller must hold txr->tx_lock.  When successful, the HW will return
+ * a completion and bnxt_crypto_mpc_cmp() will be called with the handle
+ * passed back.
+ *
+ * Return: zero on success, negative error code otherwise:
+ *	ENODEV: MPC TX ring is shutting down.
+ *	EBUSY: MPC TX ring is full
+ */
+int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			void *data, unsigned int len, unsigned long handle)
+{
+	u32 bds, total_bds, bd_space, free_size;
+	struct bnxt_sw_mpc_tx_bd *tx_buf;
+	struct tx_bd *txbd;
+	u16 prod;
+
+	if (READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING)
+		return -ENODEV;
+
+	bds = DIV_ROUND_UP(len, sizeof(*txbd));
+	total_bds = bds + 1;
+	free_size = bnxt_tx_avail(bp, txr);
+	if (free_size < total_bds)
+		return -EBUSY;
+
+	prod = txr->tx_prod;
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	tx_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, prod)];
+	tx_buf->handle = handle;
+	tx_buf->inline_bds = total_bds;
+
+	txbd->tx_bd_len_flags_type =
+		cpu_to_le32((len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_MPC_TX_BD |
+			    TX_BD_CNT(total_bds));
+	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, total_bds);
+
+	prod = NEXT_TX(prod);
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	bd_space = TX_DESC_CNT - TX_IDX(prod);
+	if (bd_space < bds) {
+		unsigned int len0 = bd_space * sizeof(*txbd);
+
+		memcpy(txbd, data, len0);
+		prod += bd_space;
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+		bds -= bd_space;
+		len -= len0;
+		data += len0;
+	}
+	memcpy(txbd, data, len);
+	prod += bds;
+	WRITE_ONCE(txr->tx_prod, prod);
+
+	/* Sync BD data before updating doorbell */
+	wmb();
+	bnxt_db_write(bp, &txr->tx_db, prod);
+
+	return 0;
+}
+
+static bool bnxt_mpc_unsolicit(struct mpc_cmp *mpcmp)
+{
+	u32 client = MPC_CMP_CLIENT_TYPE(mpcmp);
+
+	if (client != MPC_CMP_CLIENT_TCE && client != MPC_CMP_CLIENT_RCE)
+		return false;
+	return MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp);
+}
+
+int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
+{
+	struct bnxt_cmpl_entry cmpl_entry_arr[2];
+	struct bnxt_napi *bnapi = cpr->bnapi;
+	u16 cons = RING_CMP(*raw_cons);
+	struct mpc_cmp *mpcmp, *mpcmp1;
+	u32 tmp_raw_cons = *raw_cons;
+	u32 client, cmpl_num;
+	u8 type;
+
+	mpcmp = (struct mpc_cmp *)
+		&cpr->cp_desc_ring[CP_RING(cons)][CP_IDX(cons)];
+	type = MPC_CMP_CMP_TYPE(mpcmp);
+	cmpl_entry_arr[0].cmpl = mpcmp;
+	cmpl_entry_arr[0].len = sizeof(*mpcmp);
+	cmpl_num = 1;
+	if (type == MPC_CMP_TYPE_MID_PATH_LONG) {
+		tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
+		cons = RING_CMP(tmp_raw_cons);
+		mpcmp1 = (struct mpc_cmp *)
+			 &cpr->cp_desc_ring[CP_RING(cons)][CP_IDX(cons)];
+
+		if (!MPC_CMP_VALID(bp, mpcmp1, tmp_raw_cons))
+			return -EBUSY;
+		/* The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+		if (mpcmp1 == mpcmp + 1) {
+			cmpl_entry_arr[cmpl_num - 1].len += sizeof(*mpcmp1);
+		} else {
+			cmpl_entry_arr[cmpl_num].cmpl = mpcmp1;
+			cmpl_entry_arr[cmpl_num].len = sizeof(*mpcmp1);
+			cmpl_num++;
+		}
+	}
+	client = MPC_CMP_CLIENT_TYPE(mpcmp) >> MPC_CMP_CLIENT_SFT;
+	if (client >= BNXT_MPC_TYPE_MAX)
+		goto cmp_done;
+
+	if (!bnxt_mpc_unsolicit(mpcmp)) {
+		struct bnxt_sw_mpc_tx_bd *mpc_buf;
+		struct bnxt_tx_ring_info *txr;
+		u16 tx_cons;
+		u32 opaque;
+
+		opaque = mpcmp->mpc_cmp_opaque;
+		txr = bnapi->tx_mpc_ring[client];
+		tx_cons = txr->tx_cons;
+		if (TX_OPAQUE_RING(opaque) != txr->tx_napi_idx) {
+			netdev_warn(bp->dev, "Wrong opaque %x, expected ring %x, cons idx %x\n",
+				    opaque, txr->tx_napi_idx, txr->tx_cons);
+			goto cmp_done;
+		}
+		mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
+		mpc_buf->handle = 0;
+		tx_cons += mpc_buf->inline_bds;
+		WRITE_ONCE(txr->tx_cons, tx_cons);
+		txr->tx_hw_cons = RING_TX(bp, tx_cons);
+	}
+
+cmp_done:
+	*raw_cons = tmp_raw_cons;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 3210ecf29c76..91fb27ba8090 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -30,11 +30,53 @@ struct bnxt_mpc_info {
 };
 
 struct bnxt_sw_mpc_tx_bd {
+	u8 inline_bds;
 	unsigned long handle;
 };
 
 #define SW_MPC_TXBD_RING_SIZE (sizeof(struct bnxt_sw_mpc_tx_bd) * TX_DESC_CNT)
 
+struct bnxt_cmpl_entry {
+	void *cmpl;
+	u32 len;
+};
+
+struct mpc_cmp {
+	__le32 mpc_cmp_client_subtype_type;
+	#define MPC_CMP_TYPE					(0x3f << 0)
+	 #define MPC_CMP_TYPE_MID_PATH_SHORT			 0x1e
+	 #define MPC_CMP_TYPE_MID_PATH_LONG			 0x1f
+	#define MPC_CMP_SUBTYPE					0xf00
+	#define MPC_CMP_SUBTYPE_SFT				 8
+	 #define MPC_CMP_SUBTYPE_SOLICITED			 (0x0 << 8)
+	 #define MPC_CMP_SUBTYPE_ERR				 (0x1 << 8)
+	 #define MPC_CMP_SUBTYPE_RESYNC				 (0x2 << 8)
+	#define MPC_CMP_CLIENT					(0xf << 12)
+	 #define MPC_CMP_CLIENT_SFT				 12
+	 #define MPC_CMP_CLIENT_TCE				 (0x0 << 12)
+	 #define MPC_CMP_CLIENT_RCE				 (0x1 << 12)
+	 #define MPC_CMP_CLIENT_TE_CFA				 (0x2 << 12)
+	 #define MPC_CMP_CLIENT_RE_CFA				 (0x3 << 12)
+	u32 mpc_cmp_opaque;
+	__le32 mpc_cmp_v;
+	#define MPC_CMP_V					(1 << 0)
+	__le32 mpc_cmp_filler;
+};
+
+#define MPC_CMP_CMP_TYPE(mpcmp)						\
+	(le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) & MPC_CMP_TYPE)
+
+#define MPC_CMP_CLIENT_TYPE(mpcmp)					\
+	(le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) & MPC_CMP_CLIENT)
+
+#define MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp)				\
+	((le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) &		\
+	 MPC_CMP_SUBTYPE) != MPC_CMP_SUBTYPE_SOLICITED)
+
+#define MPC_CMP_VALID(bp, mpcmp, raw_cons)				\
+	(!!((mpcmp)->mpc_cmp_v & cpu_to_le32(MPC_CMP_V)) ==		\
+	 !((raw_cons) & (bp)->cp_bit))
+
 #define BNXT_MPC_CRYPTO_CAP    \
 	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
 
@@ -64,6 +106,10 @@ void bnxt_free_mpc_rings(struct bnxt *bp);
 void bnxt_init_mpc_rings(struct bnxt *bp);
 int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp);
 void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
+struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type);
+int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			void *data, unsigned int len, unsigned long handle);
+int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -144,5 +190,24 @@ static inline int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
 static inline void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
 {
 }
+
+static inline struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp,
+							     int ring_type)
+{
+	return NULL;
+}
+
+static inline int bnxt_start_xmit_mpc(struct bnxt *bp,
+				      struct bnxt_tx_ring_info *txr, void *data,
+				      unsigned int len, unsigned long handle)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
+			       u32 *raw_cons)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


