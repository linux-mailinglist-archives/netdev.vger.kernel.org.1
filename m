Return-Path: <netdev+bounces-277815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH1zFHS522keFwkAu9opvQ
	(envelope-from <netdev+bounces-277815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:25:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8BE3E4784
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F67D3028B2E
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A717382374;
	Sun, 12 Apr 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="xzW6xrEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6871381AF0
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007479; cv=none; b=tgV71guKDtz+hmgdQcfttQ6M1QZmQmXDJ3ZD/07SEFB2NBBf3lddCetn9mjIKYb3MlCRAqHjKjKusVAU754Ku2/nqnJC+ccNOptOAsa6g3aHey3PxHsEy+x9TVQ/eol2UIg81naOkHrLT8Y2LRPtIpzdb7sshrblp9EUwcoHYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007479; c=relaxed/simple;
	bh=s4lztYW+o3nGIxFjsxucEcD/mHJsr45a8yPmtPrgowY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH8e/RX0H5dQK6oamKI2NDPjfhPItvEc2CdJHiyskD2O7zb6WBOmHED8N5ml1qn1RscsYO8/T+yyiCiLT2kbegkYG+RuK6WCg7VtwBYLMHzEERmkeKs6VwyOwi+/kPDIQVmBxmOtjIIsj8p514wDnPWYgHcFNCDcHztDKjdXkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=xzW6xrEx; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-470145d7e6eso1695876b6e.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776007477; x=1776612277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia5I7mTnznx5IS5yxdTatjnN99ECF6Uimb8GJ43NewE=;
        b=xzW6xrExZzOhiWSZh9NAGzkSpdP2Wtk6VVHyZn3pPlQx+5+xKJcjTkc+MSX6AbuhmC
         FuXfldIQR4AO9rd3cX2tH3q+UEnKGKxH7NdN2RlYP9VBvZp+kZTlWMQklk14ZOA2PpnD
         Lk2hkzprPdQa9s0bdpk710A5VP3a5p6uvb5bj0gjzvzsgcnwW3qTkoT/dojzd3JpMp7v
         V1iDLjCdDd6VJbPY8EP23VvpjEJyxi9eyXcGgY0iHvDqnphjHFLjtmKZaChwm+YMY5ds
         BhQ5NI9e15sNRPOwVAajgb9kYueYLQdH/U9w6XSEbawFjy8iLVC6Lt7Hu9bWz5WfdJMW
         v+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007477; x=1776612277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ia5I7mTnznx5IS5yxdTatjnN99ECF6Uimb8GJ43NewE=;
        b=f6bKJfC78xNAVoeJZs4iox+81EB55tOx/JZU+9urbp3ZkhBkS2nV1IRpsXWTEz6D2f
         pdRGn3I3E8jKJQS5a0LcbtQAE4Fk/mEy7DrHHdNT86rv8Rwqg1QbdzC9fGcFbNSVMbrj
         DD4xyuZxSmowSV54QJlUaa0Tom5I1u7F1C293Pm1JN0X867/yQ65LOT+imXo7+TXLozU
         GywyAAR4oa5WUkxzSe4755j27X4r+J+XpiaKJZZkuRUUmDDRH5za3O0lXAirn781r9Kc
         JyMjpr9wOCoeFQHZN2wKLWXFvSTnxuehJG0h+M5Zk0C3jxXyji0mqt4lbNws+eJuxZu5
         Oaag==
X-Gm-Message-State: AOJu0Yy3kw9MtMDmOUgwI/pEfwaIRX08aravI/7t+A/p35IE5k0zH6Yr
	8tjPjDRfYN6P+4osuY4r6U3ltDPfWnYRfgQKO1oszpCoHDGeKS4PjnfzLCWAy4mjgMU5obGByo8
	WrnUf
X-Gm-Gg: AeBDievxaRwwZ84vDMzDTEf4+NM/7KrZD66Wj4gsu/4ZJs2rT5ijp6hGZLu0sSH/SCX
	w5XaZg/p2JpKbdHLa/GCZdypIqcdNaek1go/CzGWXeYxDCOWhO+HlchtnUoj6igk7QOq4vOyJlv
	1PlEtagKOEBhsPOCmERpIGMHrS4E+/DETIXL27QzzJof6eRdVj50kESpXrhw6Dyc4ajDf7FZFkl
	WI7hfrd73jAuCXjwyjgl+FJ+p8ypdVKyd/hHNrchXnJmAl6g30LCCsQndrDTK2DGWPah0DkYx4p
	ML+r0YzLQFT+NHsa2nacXcQburAw9PjGijXhcuWURLWGawMOHIyLW2OenZRRB+VNV+Yx4SCx76x
	uz7KgWLl6K2nktmFTzeNfpHS29ejkoYfOGntX2rjBJsHiu8kH5RXoDudgpj6oB49vzyuUuPm/DE
	nqpyEBQ6TQLH0cR/YNQvUUOkOF/CvUtXH5
X-Received: by 2002:a05:6808:528e:b0:467:f9ff:7c54 with SMTP id 5614622812f47-4789f906ef6mr5327880b6e.45.1776007476784;
        Sun, 12 Apr 2026 08:24:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f557b5sm4911726b6e.11.2026.04.12.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:24:36 -0700 (PDT)
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
Subject: [PATTCH net v6 2/5] net/sched: netem: fix queue limit check to include reordered packets
Date: Sun, 12 Apr 2026 08:23:52 -0700
Message-ID: <20260412152429.143474-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412152429.143474-1-stephen@networkplumber.org>
References: <20260412152429.143474-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277815-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AC8BE3E4784
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


