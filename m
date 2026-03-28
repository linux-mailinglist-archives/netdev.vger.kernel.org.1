Return-Path: <netdev+bounces-272791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCvxA70cyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:23:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7034F86F
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30836300E2A2
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431A3A6B72;
	Sat, 28 Mar 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wRLNHv/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9943A63F1
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722224; cv=none; b=UuFW4L9CCz64mKz7+S1wh/wIoisHiqu29uKmo981SkNgWXLDZtQSYmJobvFYo+CAschVA2h8zauHXv3Tf3+EYAZupk8xGXyZSW7vgYMgcqFlgeN3RCHOpfpInMbPjfITqiNYNKu+38l/Vv6oKlUJrwfyp022AWkNlAr1J+/P3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722224; c=relaxed/simple;
	bh=t0CwRt1pvXLs9jaUwM8prQrR5RD1xErsce9sGZFLF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAi6zKJmmv0DARC2lmXEv0ql5H5NeAHVZ/VqIe+Oc3LoFdvKDrX+qwqj3cOdL9qHdk08Dq/EfuUAd7C9hzUiRDVRZuQzmpsYiAbEw8dDs4SJHMP0MLlQwEVhj40SIP5fEfc3gRfB0dXNcbElOUCKrmldYYuwcwsQYrzPnSSZrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wRLNHv/5; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128b9b7e3edso475234c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722223; x=1775327023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug1C/tlCnEtwGMUhMwFWNweed+dY/6DFQVGOoZU9ZaU=;
        b=wRLNHv/5DGwboYh0fopfjfiNMwsAAhHFPmUmYeVpv3+geAiXPcX4V3q+4RMFUZUdBX
         oEoSkaAJd73uh49bNCZn3cw4s+wCfaWY/km2Yg2iLpepc3F8Fr7lBVbLpbd1q6Jxq68M
         WatHAC4MgvXapTVFQuOTKquRXZER89BNOnWD1ov3+utuHrPrteI+9Efv3VfixBmExK32
         I3J2Y2wJWQnxFWdT6RRqB3ISjo6gC0udpPEHlrAq8+J57inHpjAJ5eVj6o0yXJBvcdng
         asC8JHIoB4GuobUB6CdiUpxsWBpL7nXGKtQ/hGqNc1cEKtST+xbpwrxkyc5PiKx9ibek
         Zjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722223; x=1775327023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ug1C/tlCnEtwGMUhMwFWNweed+dY/6DFQVGOoZU9ZaU=;
        b=VB/q4OpH/wKsBPjyPr9L7U5ejJE74DNZFdOgbf6v3YeS7h/bUYcmaNRLfgChxUTgHT
         c22afxyNBoIXzuuMjFa8Spp91rg3z0i8+oknW+Mv62W/vWIiFLiUfH6EV1aShTywrX5D
         oxVFZA23cqnpegYm1Ehm9pE1DlKMYiQ+PybvU3djbZaUplbaLsRBBK8CtDjRsZTZl9yJ
         QHiZTq88FrP4X7p8JwmKggVfZb7C0YWJmTudVq2LllE9hU0zodyVRC3ZIZWA9de0USov
         WatWOIwe2FlsDxZ061K+gDlZQwdle1dRyqR9owokkwHC50DIPfgkfmX4SdoS8aR0IANv
         zwKQ==
X-Gm-Message-State: AOJu0Yz54UMMqNBn6ZHG2dv7UOZhm5cXOYvQL3uFFOoyRS99cZ5hy3gi
	SmcITwhjHC5BZ/KPiAfdsv/5ehmeD4746uC4woc1FdR9pw3vkqRLbxPt+CsLo7C5SrPjjZf25Cb
	jFvc1
X-Gm-Gg: ATEYQzzrPbKwfAncprROCeJrANH8n9PeQab8YlYoTaJXiI6GxVhzj6OnwEXQvvLTou9
	vwK4c35Nf4OoUlcEjL2H7hCGZotcwW0L56osKjm2klz/AnXdbbZrv88r81w72tDL7Wplj9J4sYE
	wXKjADZQFGxqm4lL32E6cPHky5EgUUo6DMHRZ88wot7u1C0mvnZAkijf+cMBH3MOgl3jltKrpto
	ZzUriOZsMJ27XHBNfMCdKzG0k9EE45BfCMLT3SRA46UdZQ+JuVF2bMZU/Hv9KrAvAKhs3wHO4o5
	Yl9Y2kPkO4mtf+D3C9ualuDUQ1AioUswEkVx9ZjGDKSuzUPOcPJd8nU0yqwbTdMsARDSysSQKed
	hkFHM8bxNlvDyzA0m3NLoloc4+5Mt4FHH+xcdwhVYB6VGLqPDh7x9swrhE7m2qSdcfVfJVrk0Fw
	x6Tspw6S5XQlClBYwjHeilIShOJsB/oeCL
X-Received: by 2002:a05:7022:6182:b0:124:9e46:82d6 with SMTP id a92af1059eb24-12ab291277bmr3730502c88.25.1774722222630;
        Sat, 28 Mar 2026 11:23:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm3133008c88.4.2026.03.28.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:23:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/5] net/sched: netem: fix queue limit check to include reordered packets
Date: Sat, 28 Mar 2026 11:21:46 -0700
Message-ID: <20260328182336.392817-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182336.392817-1-stephen@networkplumber.org>
References: <20260328182336.392817-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272791-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A4B7034F86F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: 50612537e9ab ("netem: fix classful handling")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 2cc3acaa4068..6cc48b698e48 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -523,7 +523,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			1<<get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.53.0


