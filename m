Return-Path: <netdev+bounces-275664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA0JDSLt02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:28:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B53A5AFF
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CEFB303EC0D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10246392C2F;
	Mon,  6 Apr 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="OlwNl7LX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04538F251
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496410; cv=none; b=slXdww7TEaggcxX3v7PX8mpWz/5Keoc4PWIxieoQHWpfwicj2IK1jQ8uDfKRMTcwbz+l5gPPURRo0E9pn7KKvX00YwYOn6+0OgRGI6+pQKnPKGKz7IGsKaPe8JmBtit79nTqSaBkGQFTzQfEh0VP+ULEoq+S/Vw86fts/i8t+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496410; c=relaxed/simple;
	bh=s4lztYW+o3nGIxFjsxucEcD/mHJsr45a8yPmtPrgowY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzGq47E7tUttoirUAAvp7Upo6OekSzYbR3if2cJJG2YD50Ss2kFT9pzivW7WKGQ8ZtZ7GHu/HlVIu9lB1gqZ2oSEGVDDNU3LIGBTSzxSOYciCQLu4qvztXKPsxAinq8XlKyr2ucTHC7o5hL3uLByA6YKDHEHmH0WdnH4FYjdlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=OlwNl7LX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1979749a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496406; x=1776101206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia5I7mTnznx5IS5yxdTatjnN99ECF6Uimb8GJ43NewE=;
        b=OlwNl7LXifqiMx1+n+Uc8hdsmajCKLRdRx12oK0pAEqk1HsspMYMmURMm6ZMcv19ga
         2eT35Z8DRH29NkCpKupv/IvsqGXhRm2LcETSYyWTjhgMFLaiU5DpwFR/pyG/JRWmQNRF
         2aTQ+9HEo0FtyQ4lBnd8uGYbrYUKtkhKz9LB2TdK5/GUBlVulhEc7litdlgtuBXe1wOv
         B5agtUTNtuNA7UuK0zac7BpTuGdoiQ5slFS4o5ezaUAVVh6CJD+oDFxizunuTQ3IdTSG
         3P8I82VWNb2QDiikhJJfMGGr0i3s9Hcur4U4afSlWz9D44IIDU+tFT0FLbCw0uXpH0ZT
         /ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496406; x=1776101206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ia5I7mTnznx5IS5yxdTatjnN99ECF6Uimb8GJ43NewE=;
        b=KcpL4H8VL6c85jpsSl4+O5btiNExG2f85Rplkt5g2fRRIEiusfifKsubkb+DlUlw1Z
         n5Q/vAxUMbUgeXrGVJMe5FIHAvQ2GMe7dyJQcgSwdchyyoJONucrI+/rT30i8CbNZIsG
         4vPikdoGI3wRl+qRrnCYRn3xoZaaxSu5QowJ9NJGHTFEI2lEO03fnufydOcTzad8jPvN
         3yXgzkoj4i781MxIR6A1sYlTKvUdS+sIGGECJvqZFVMIlhlI0tyPaz2gl+8TcEgAxT8n
         +OBNfY5Ey2ndZAOjNkt/BHetRph00pSg6k1sOmc/xpZvqi56Vh9Mgt73lGua25mII5dK
         E3wQ==
X-Gm-Message-State: AOJu0YwA+I5r6S27RtaoVCwjJssvTqeozG0F7X0KMKBM8JDmajgJKIGb
	8VxwUVqmO6fsNeCqkUrptdC/oKWniJ8MKEWo1E2syz1TcWBalxv/zaXudIUtXbK+k3y8NAZeZJQ
	WA+9q
X-Gm-Gg: AeBDieuB0DmuvUKdu9TQhf/76BB1bt11i+zwZqT/iwak3CZBaO47PHI7MJiT7VVYaHD
	AidkCw2DZu2PQn4rkhmrhFroVS8+toc/x7sLyCKczncooa6OUm70VzhEMzBnBMZiArxuQFWK35l
	YOixM+RSf14pvIvl61WQ+bZ8wtCiki4QkojpYaqAA37J0WTqAOCud2gultgzzrOvA1OlI5drtEE
	lqNS0PLvzPAdyeCKTsk4/RcjWWc6yN30MtqYZSEQO+rQxSMg9ryS6jgSvNRjr2KZR9/raaUGKxF
	85f/OssY2ardsAvQgpUAKdp1cHojvCT0fM20u8Hqb8nQp28WBkPBnFQEBYEhxRDUsLcNnr4UTSI
	2r6MVQWN8LDAoZpW40gmwby4NXrGDACIrK6NOC8rBWwk7vL2+iIvcr6yTgtvX7SC/zIvVjNvU7p
	tfPnxGGvMb5pDEVU4R4vJP5idSfWKMXZAF
X-Received: by 2002:a17:903:707:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b277e52d28mr88982855ad.24.1775496406554;
        Mon, 06 Apr 2026 10:26:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:26:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 2/8] net/sched: netem: fix queue limit check to include reordered packets
Date: Mon,  6 Apr 2026 10:25:10 -0700
Message-ID: <20260406172627.210894-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B66B53A5AFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: 50612537e9ab ("netem: fix classful handling")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8ee72cac1faf..d400a730eadd 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -524,7 +524,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				1 << get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.53.0


