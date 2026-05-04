Return-Path: <netdev+bounces-284112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMYCEyY0+Wl46gIAu9opvQ
	(envelope-from <netdev+bounces-284112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:04:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D573C4C516D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60773080459
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E7401490;
	Mon,  4 May 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QPUvHTl4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056D4014B0
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939183; cv=none; b=oBElpUFlSXc3fxzRFFK2+aPDFI3nWERqpNuh2qYeeHGBwzmORCWojYtiCFhlrcT7MHKU4Df+LlUzlrC67qq0OzBRYrnnU+lvyf4VhqE75q5t3fDru1jhJt+MEq+obusYxqxbDGDcDZAgNXk5o3hktjzRUgmENqm+bnKZERsaab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939183; c=relaxed/simple;
	bh=8Nj5aoYU5s7+HRDV5ELLD/fITatjqN5811HyGgM0Ypc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8W/WhHlEu7NFyWJRLJ0OGmXfmEpPtJXGQ9TG1N174sBULIDTVYJJE1K+eLCt7nAJ1dBl+UP3ZgTomYNp+ORtjwv7cunkm8dH7ZgZDdj68ZxlbQ74E7cUESMqS3dWyIxt3QQiDG0R8hQtF3b8GjcWJyxD77Njv3UVFGCEoP0ryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QPUvHTl4; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-656d749109cso2552347d50.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939181; x=1778543981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGDf+MlTJGRipU/uMCNjS0aZakqQTfCyzrjwvc7D3AI=;
        b=kk8q6ZNMsxkW/XcN4gMV/XeEqDyPlF9GSQgGdklJlNr4TrCMXCFuiSDqJQ58YCrWxA
         /0t6qCSSsieP3CcTdYPiUXVbnnW9t0FO/CqtGEVdmw2wRrng6byrata5d5TknK6nq7AK
         qsIyn2vTy7goZCzRQlsnWYp3HTLVcD7SQIWc9DGXVXd1KYiONKevHGJ1NlwYzaP5Y+T5
         Ci9inxWwmMlGrW2BYuCoTin9SVfDNsYhjbY5b7nyPRDocr2hew7eAWG4WfgKtHJKPPWD
         KpHQLG2ydVuOl6MFy49tHB9yelipPS/47Rkx3LXLXuRkjCsZK8rV+H9CWWQ6A5GXEJtp
         /wFg==
X-Gm-Message-State: AOJu0YzLrOG50YgTa7RNaD9rqH9EsHUUMII/emr0Jz0fwLDvHCCi4T5g
	ueYQXXMnSNACpBcuDWZLzTvtitESDku1PI4gkDxX1ornsP4aoTi0VOLxROuKNBmrgr3WJjy8bgF
	LujRYaD+MD+Wc4mOn3aQy8g+xooLUCx3Av+Vq+M+vfr3xcHU4GHUGUF0AlnDiZvJpdjj2M8dBHP
	ZgBMHVul+zcBMknt2Fzy35Sq4YL5b3YOphdBKm58aKfECkxdQoYkbvDPqEzZ7PRPk9vzljziRBF
	GSWcK6PKZA=
X-Gm-Gg: AeBDievDZQNPAnwfx0emTXhQBocE44up07nGWBacl5O0Gpay/s4wwgTBKTFbH+XuaIh
	3dvMj0gi0uv1aiolR/+yVPYMA33WSQcq8Oc70ORYlpH6CfPVusCu/NSpfYg8RwxGUmybfyTVL7U
	hrN+4xu72VhcMN0vP1zemkw29obBkeSk2pzQaSWsSj6bcyRAiau98gDqMqC0Kjtu4X57u7A4p1T
	7g60Mju16EdVE3O3V7SmNXSRap03MZgQMJsKAwDXo6J7DiWN5Gkskcux/MWMrN8jA/zmWB2zrS0
	v/WUlBOS5upE9XpmzEtcki73hlLBIi7U2v+9SqujbPq/03NJVTmxWiHMDFL+K+hrtFYs9HkT8DM
	u/GLQXNhKt+m4e+ipqcGKK9+X/8U8tS/83HdS4LUOuhQ9ZKqP0d+TEiwH1KuScHESXRk8ZO611r
	2Pwe0UHS4zFF4WilQdWEjGT627jdAexIlOPRDI0T+YTKpky15q9460/TBJkgxGYh8FRyE=
X-Received: by 2002:a05:690e:b42:b0:64a:d479:bfbe with SMTP id 956f58d0204a3-65c69c4985cmr1186790d50.11.1777939180843;
        Mon, 04 May 2026 16:59:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65c2e4e02cesm966751d50.19.2026.05.04.16.59.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8aca4660827so133048566d6.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939180; x=1778543980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGDf+MlTJGRipU/uMCNjS0aZakqQTfCyzrjwvc7D3AI=;
        b=QPUvHTl4JOJwV/QnvOc8T0ZMOw+UjIlVCHeflpvcUiFb+osvusg4n4SoQ+Vu8XRHMO
         RBQ/PPEQtfEQnUFg6Q/tgbWW3RxiYzebKpho6WxONCurIk18YMl+bPu1AbfclMHWDLTh
         ULY1sOo6PYPXAnBy1kETSEWrYiTJ9xScOTbNg=
X-Received: by 2002:a05:6214:19e5:b0:8ac:b1ad:3a24 with SMTP id 6a1803df08f44-8badaec8775mr16606176d6.27.1777939179692;
        Mon, 04 May 2026 16:59:39 -0700 (PDT)
X-Received: by 2002:a05:6214:19e5:b0:8ac:b1ad:3a24 with SMTP id 6a1803df08f44-8badaec8775mr16605746d6.27.1777939179125;
        Mon, 04 May 2026 16:59:39 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:38 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 14/15] bnxt_en: Add support for inline transmit BDs
Date: Mon,  4 May 2026 16:58:35 -0700
Message-ID: <20260504235836.3019499-15-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: D573C4C516D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-284112-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

Newer chips (P5_PLUS) support inline transmit BDs that contain extra
data.  One such use case is to transmit out-of-sequence kTLS packets
with encryption enabled.  To account for these inline BDs during TX
completion, we add the inline_data_bds field to struct bnxt_sw_tx_bd
(tx_buf).  tx_buf->is_push will always be set when sending these
inline BDs as the operation is similar to push packets.  tx_buf->skb
will always be NULL as there is no associated SKB.

The next patch will make use of this feature.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 ++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9ef3f967e77e..f3fae3ad8aa1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -842,7 +842,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		head_buf = tx_buf;
 		skb = tx_buf->skb;
 
-		if (unlikely(!skb)) {
+		if (unlikely(!skb && !tx_buf->is_push)) {
 			bnxt_sched_reset_txr(bp, txr, cons);
 			return rc;
 		}
@@ -854,13 +854,22 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		}
 
 		cons = NEXT_TX(cons);
-		tx_pkts++;
-		tx_bytes += skb->len;
+		if (skb) {
+			tx_pkts++;
+			tx_bytes += skb->len;
+		}
 		tx_buf->skb = NULL;
 		tx_buf->is_ts_pkt = 0;
 
 		if (tx_buf->is_push) {
 			tx_buf->is_push = 0;
+			cons += tx_buf->inline_data_bds;
+			tx_buf->inline_data_bds = 0;
+			if (!skb) {
+				/* presync BD */
+				cons = NEXT_TX(cons);
+				continue;
+			}
 			goto next_tx_int;
 		}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ab3a86634a20..e0880b8c4b73 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -917,6 +917,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_push;
 	u8			is_sw_gso;
 	u8			action;
+	u8			inline_data_bds;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
-- 
2.51.0


