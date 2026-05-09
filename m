Return-Path: <netdev+bounces-286200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNxaDzlr/2kR6QAAu9opvQ
	(envelope-from <netdev+bounces-286200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:13:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD88500AAD
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 268B830330BA
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121D3BBA1D;
	Sat,  9 May 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="EHGAzw1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9E2E7657
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346697; cv=none; b=EG27KpYj3BZP6qzRGsYoYu2hbMyOgkMcHpOBOGTnwboAXu0Ma8u9cfWpBbgvZFxi4vZBVy88DMTcLwfUZVqRoS+7/m9JnYbdOtRmI4j4zOoCf6feCfjCnAi7dKssdoaTHRtFiSJxEEIuNlWv2BIJdhgonoavUd0xx0uwbp/I8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346697; c=relaxed/simple;
	bh=Sw43AkoSvDMMeJLAW+KDgGC585WgCfvDTeessNwipiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYXbXj2QmNBlglrO3qnTtrh9cL+3nHmaoC12LgIRXV/1Gh2iG3gM8jbiFmRlFwTwXRIkicn8IJ3u0iPEv4T+E7Yv7IUFXD8R/X0MYh1KPWfrQYrCS5ODcQjp3GAJK8WTUOI+HWEtKvzQHZdKy+RH5enNezKRaaQA75BCqVA4p3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=EHGAzw1X; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ee990e8597so5272909eec.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346693; x=1778951493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gphQzyzeWSnwruah36S7urnd3Z4kKtOMsUVtGkgWLLw=;
        b=EHGAzw1XHfaP6ECTyhVNpQACy/Kv1lSTNhFSvCNmi9eodf5XZiNevsutMYZ+z4Ovfz
         BIoSL3mvTldbnrWa+hXe/ilSWVVxV0P0q+KnuxuMNZsunrrfo2rtyOb55Ql+U8z352hf
         EvhCdv7VoQdIM13DDzMPWGiSD7ECJYYNxLY5PXipdjlIEA2BjIwx8zNGDFgD7P4Ndg2a
         /0UCjAvG4Mi1YfYBIsInRzDWGlJevvS8gGNm6L4M8VAC72inZXQFIN7R1jTVGUZD0YTa
         0qfvHNAoxDGh/pRmWKTeJiFXEqoaI7cehbJr/JV/bd16BKicjdO+31Ovkmt4OqsTEPhv
         2ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346693; x=1778951493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gphQzyzeWSnwruah36S7urnd3Z4kKtOMsUVtGkgWLLw=;
        b=gkX2yQCFG0aC6CDnYkbmbCv37xB9cFW2XZ65Ck3wnN3uuOvb8zqr3m2Pp3UNHv4d84
         wRdJdUcKFLzAQP2AN3eOUaEuOq+0ukYGdp09W6fQdidy6uf6MoothXKrQif0/jIu1kRC
         UHxhn29IIMmI5xxUuG/LX5RZj+aFxaMcGfDMj64SxRkNsotkkDDVq8TaDHs3iPmyV9yE
         gBRd9cSEbYFsoi/UnyoPNUOFRG/8tz9m261Us2pAydUKnLr9fxeVepOF3OjNEfzlGprx
         +fkjnjTb8mGUD87sMSOksvOiU4tPy+WLsTkbw76tCBApaiuRbhmvQiR20C3ZScKW38uT
         4Jvw==
X-Gm-Message-State: AOJu0YxagQKyepBhUwtWhN5FMZXQSbX50eUOtNkfhSM3y/TZV2jS4BTd
	YIOzeNRf8Ia6FyhffJMvCnghmACliiFFZXnNHm44OIzO9J5jBNb7PjuUwdGhv7Ydn6yBO6dnGqy
	W5tDz
X-Gm-Gg: Acq92OFxl08qkEv9E1tAjWV8Vqcs+hc3gTUFvyNmCmUQX7ZMcetrdK6ZzbKOPozWXwB
	MZ3VNHIlF9gi6QxWOrv5gr75bKMyPU141mFZcBe3zEPo0KBUSzv7MUfrKisT7OgNbTQrLJbs0w8
	zcwFB1065rYtQqWS0pyzi3sc4JWw1UdpwZZUveR1qGln7dShiBd/Mqd7RJ7amFv7Qzg7KmAVNyK
	4ksLNifY5fzu9wUhe/e5dzDyRicvWtk+hYrtYxI1ORtNJAFmLWKXZWrbVMORMSqa9o1wPjozv7D
	EAuDeeqcaN/lAFOKD1cEFZFeIyCryR3lSHhf3fOHa20qYfOCo9FhjIIqjPOD1ykLfn/FJ91LTan
	I3Dfhb8Nau9Aht/J1+L67Uaw3tWJvFDyULYaQV9Pt/wLgZQrbDKgA+5QGeuaSTmmV/fj3uhDz7T
	ZgmMjYZs1VfCIVlObIbZyhQwzQx3YvpDRR
X-Received: by 2002:a05:693c:3015:b0:2ed:e15:c927 with SMTP id 5a478bee46e88-2f54c0815d7mr9476066eec.35.1778346692790;
        Sat, 09 May 2026 10:11:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm8524568eec.6.2026.05.09.10.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:11:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 4/5] net/sched: netem: handle multi-segment skb in corruption
Date: Sat,  9 May 2026 10:03:25 -0700
Message-ID: <20260509171123.307549-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509171123.307549-1-stephen@networkplumber.org>
References: <20260509171123.307549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8FD88500AAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286200-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The packet corruption code only flipped bits in the linear
header portion of the skb, skipping corruption when
skb_headlen() was zero.

Linearize the whole skb if necessary before corruption.
Extends d64cb81dcbd5 ("net/sched: sch_netem: fix out-of-bounds access
in packet corruption") with a more general solution.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index cea6b6182913..699c734e4c8b 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -513,16 +513,17 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qstats_drop(sch);
 			goto finish_segs;
 		}
-		if (skb->ip_summed == CHECKSUM_PARTIAL &&
-		    skb_checksum_help(skb)) {
+		if (skb_linearize(skb) ||
+		    (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))) {
 			qdisc_drop(skb, sch, to_free);
 			skb = NULL;
 			goto finish_segs;
 		}
 
-		if (skb_headlen(skb))
-			skb->data[get_random_u32_below(skb_headlen(skb))] ^=
-				1 << get_random_u32_below(8);
+		if (skb->len) {
+			u32 offset = get_random_u32_below(skb->len);
+			skb->data[offset] ^= 1 << get_random_u32_below(8);
+		}
 	}
 
 	if (unlikely(sch->q.qlen >= sch->limit)) {
-- 
2.53.0


