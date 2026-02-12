Return-Path: <netdev+bounces-258394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LQhAJImjWlOzgAAu9opvQ
	(envelope-from <netdev+bounces-258394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:02:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55259128C06
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF3B30B2AD6
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EB31DDA24;
	Thu, 12 Feb 2026 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7dU3k2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CBE18AFD
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858111; cv=none; b=TkLRUbGfiK1XudkVWOknyczBTVnI2aPPXqm6Eu+e9aQPutyX6UkMKqCf0wvNtxomA26mfOqGeyvV2Ot8bCNtJGP5CrRutCKv/8LX1Vf4C2w8XJAyZyHsTYyFh7KeSS8qokzriK+wl1s9mo21ROIxbvvfUJFRPfs1KCUEf55qPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858111; c=relaxed/simple;
	bh=Mjn2rwH82IJpmlJxfXR9v1Sk/LuhHoeUzV8gbCAibkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLXHFx3UgSE/lGP/nVGNsEJEuyI2Oh1TwyIPw06XuuyCQ0RLf4Vxo2+ZE+6VxJZq1jyje2mhdk+PPBREGalhvmFga1iMwwX9KHw8LqCst5CNl1PzKDwa0CnAJtirFQ8yo0M3pkGPhHxwLzsgUyfbI5sBoYFgmdKBL89xrjkSTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7dU3k2W; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927b1620ddso24123657b3.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770858109; x=1771462909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1R06yw6EKxaPJEYAiD/GC4GWXLKfIpFl/ud9jyPw8/Y=;
        b=X7dU3k2WcYUkgJLhVzbY2udeBLv97xg/YP0NtrmwUiGb/GSwVtIiF1i7+jzabHjnHw
         Bttk9SO1BRd6sH6f2SymOjJhnRQpkNBwrVbL/1HyNDTpRR1jWTYmZn3Xe6iHaAeJT1eQ
         LlC3crS47iWNwNcdRNtcVo/ecPtWgPfCawpoWLZXohUETlt4H89WGIedm7y6wNdxnY6x
         EelmpMLNWuk3g6Tm4HH2of0Brk6UL6tlPxIUOCqgT81ezlKG+eer/hg9IrfPi/fzEEx3
         NJIFnEmwDaB57ixctX84JKPDD1ebKaC2r4qSlc1CUF3cfVzMHT9HJfiWjELr/VV1gym2
         EouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770858109; x=1771462909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1R06yw6EKxaPJEYAiD/GC4GWXLKfIpFl/ud9jyPw8/Y=;
        b=YuHd4PmVU/r0CUYIeIqGkqasYefVzGYAswCUAahaWD8PaV4K7Rz+cgkHjMxwJS8xLu
         nsqVHJ0JfW7twE/jGOrrEFJVz/btgwQQKT+d/E+Iw/SooYjwnEiXYK0T3nC+UYhQjPqd
         qDCBiMAzLTBRu+EUyDKenuXsfNxP1jE+2719eRgFlXB70TN6Eu20XjJCC0iSysEEQDaI
         e5NL3Ehta4EfNmVqqb3P0J+2P8wnBjh421vqZ1D+QyLr7gEQiWE7IF60QiSrwULa62jG
         59xhk1z/XrJKE8RfU4GhDi1G2Tbke3y6SUIkNVe+yFZb2CcX5MjjtHut1EIv2vG3t0dG
         E9Ew==
X-Gm-Message-State: AOJu0Yz4upRb6aJYbNzxdrDeVDIgE1L8wu9u1QCEGuQ6I1Vlt718jj3j
	IQsMR8gCouBGMB3Y31xdInRrmTVKNBAw0MpGaW4iPTFK6T1ZjiFLUKQreZ+gRw==
X-Gm-Gg: AZuq6aKkMiRPvMWUw5pq0G0JHbsPpCy5y2S+fOV1JgxonhNFzTCuCnCH3BklVd8Ut2E
	0sgluMTBzNmtPV4o4XOKapk/kKeOzPhc2cW7OA3vNsknnYxQ+WXqIxUIPoMgJxNrMYeYPwwDC3c
	o9qTNsPkVlobSrafQyqmo0CQ0rsRhOM5/lePaZ9yWq3tL38Nq4k3FmNBvILRIq5j5JVb/yubbOe
	DlgHpx7kKTj2DlBVD1UX8WLclj7ny/PDR6L+j2xcrhgPtw6ZOeGP9fLExO74qz763pG+/88wVRc
	FedRANLtl7lleA7YSNayqzEfo9Vfz83F3/JHgWctQZR7fCVSr2go0+K2kq1IX3ZmfcTI3OBLWmu
	9Rph59x6UR+6tmr1F2GAnxk0wWnx86w+Oj4W35Er0foEpLstOTajZBapW9TIKRCNlL24XE0M2Xp
	oBxzYfOZLXaCJEGlznqHm9cqZD377UdpLQ
X-Received: by 2002:a05:690c:802:b0:796:3e25:3e95 with SMTP id 00721157ae682-7977171b436mr6476207b3.18.1770858108692;
        Wed, 11 Feb 2026 17:01:48 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254d1esm32678167b3.41.2026.02.11.17.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:01:48 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 11 Feb 2026 17:00:41 -0800
Subject: [PATCH net 1/4] eth: fbnic: set FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT
 on RDE_CTL0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-fbnic-tcp-hds-fixes-v1-1-55d050e6f606@meta.com>
References: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
In-Reply-To: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258394-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 55259128C06
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Fix EN_HDR_SPLIT configuration by writing the field to RDE_CTL0 instead
of RDE_CTL1.

Because drop mode configuration and header splitting enablement both use
RDE_CTL0, we consolidate these configurations into the single function
fbnic_config_drop_mode.

Fixes: 2b30fc01a6c7 ("eth: fbnic: Add support for HDS configuration")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 13d508ce637f..e119526fce14 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2575,7 +2575,8 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 }
 
 static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
-				       struct fbnic_ring *rcq, bool tx_pause)
+				       struct fbnic_ring *rcq, bool tx_pause,
+				       bool hdr_split)
 {
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 drop_mode, rcq_ctl;
@@ -2588,22 +2589,26 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
 	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, FBNIC_RX_HROOM) |
-	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM);
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM) |
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT, hdr_split);
 
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
-void fbnic_config_drop_mode(struct fbnic_net *fbn, bool tx_pause)
+void fbnic_config_drop_mode(struct fbnic_net *fbn, bool txp)
 {
+	bool hds;
 	int i, t;
 
+	hds = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
+
 	for (i = 0; i < fbn->num_napi; i++) {
 		struct fbnic_napi_vector *nv = fbn->napi[i];
 
 		for (t = 0; t < nv->rxt_count; t++) {
 			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + t];
 
-			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, tx_pause);
+			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, txp, hds);
 		}
 	}
 }
@@ -2654,20 +2659,18 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 {
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 log_size = fls(rcq->size_mask);
-	u32 hds_thresh = fbn->hds_thresh;
 	u32 rcq_ctl = 0;
-
-	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause);
+	bool hdr_split;
+	u32 hds_thresh;
 
 	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
 	 * be split at L4. It would also result in the frames being split at
 	 * L2/L3 depending on the frame size.
 	 */
-	if (fbn->hds_thresh < FBNIC_HDR_BYTES_MIN) {
-		rcq_ctl = FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT;
-		hds_thresh = FBNIC_HDR_BYTES_MIN;
-	}
+	hdr_split = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
+	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause, hdr_split);
 
+	hds_thresh = max(fbn->hds_thresh, FBNIC_HDR_BYTES_MIN);
 	rcq_ctl |= FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK, hds_thresh) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,

-- 
2.47.3


