Return-Path: <netdev+bounces-277660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OqRCmXZ2WkItwgAu9opvQ
	(envelope-from <netdev+bounces-277660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F83DE63F
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D805302F41B
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBF2D3A7C;
	Sat, 11 Apr 2026 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="kmJ1DrSB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F362609DC
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884641; cv=none; b=PtofqitAjNQQXUa5ROBOlJZ2Mklz7VOHZwMjDNs0O4uilbolMtxdxt5oWqhZdGRJzPC6OhzLL9d+//b1K39QLObwDIg3A6kUz+E9JhghK7lwEX2U6u2d1hO+qsisQaSMe4dqqQQGn+cqevzQZX0v4Dsoxta708ykWL07gyHo8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884641; c=relaxed/simple;
	bh=s4lztYW+o3nGIxFjsxucEcD/mHJsr45a8yPmtPrgowY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGgUaZJWF27i4MB/uBX8/BSzlfrlfVECLv5H7NfX3f7F4RvZer4kqvIHGoHi5hkzzGy8gJBfZQEPehTsRWhzoCYg4MJ/qpH2rIgMEQDE1Y18DX9T+iee0L/Ll1TyrBtEXYSLZzkm0mp7y6odUKeC2ZD2BwPYpKD2TY8PD0azVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=kmJ1DrSB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76864f4e58so883973a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884639; x=1776489439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia5I7mTnznx5IS5yxdTatjnN99ECF6Uimb8GJ43NewE=;
        b=kmJ1DrSBRDt7Xls71Dlld+62IKkcnB66N8p6wMX8f7/EgDupuSL0fg8ZrPzQtkjAA3
         Ewi6FFmZt7RgFBB/bUVyUCLz/9b6SNgUM0LdA342EKjKmU/ew/LsmQgtNqG0Eq1eicHa
         knu0z4CRQnZj05xgkjcLL4KY0xqoqA1DLy5LY7SpawfEpskYF8s/X54DVUrD0acONYI1
         HlGoMrT142rRwcLc7kIYrbdG7OQhkxC0arTnII08ZViN2YNZUJW7KvuIMWIgySqHZosN
         0iH0y3yFNvLs2UmF4Dz9R3+juw8ggCjhbZkllpV4nhwAZDstcXmpDYecF0bEAEsrPi8S
         +Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884639; x=1776489439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ia5I7mTnznx5IS5yxdTatjnN99ECF6Uimb8GJ43NewE=;
        b=DXrmBk6604uk0wvY/qph+rC8w84jQegGVWNmxpcO+F2/qezhCRLUm+GyFrxlUuLRXr
         p7AWNHirZ9ebrPEZ3vx6l47tJAZ44nasQY3jkTpbjtSQX5mHXeWR7Sv0+6rVPXsgLJ+V
         uxiiceJeZpKIc+yClziktCcawkjl2NCadOXVTfFXzWautsm5FMPKf6SRSiZ1gfwGN7rk
         i+IBZhPSmUt/PY1WaRRiz8jA18008uitHWRRXv0kBKiUIfRxsb3ufpTLvnizv3saxthx
         IJDYIvkM/whdEhk72hwUGivavjI2QN4Y+KdC8G4fI49Ejs/TqNAOt73mKDRZGwAIEkK3
         wN4Q==
X-Gm-Message-State: AOJu0YwyNw+eb0Ng5H5cNEy8Ww96AuuY7pucY2pRj/EIHB//Z9aoLOGt
	sIHSorVI+zd5sC1HaYFb68yKoQdCMSLhrjTG1x8WWHSxZ4B0DgfiEqj/kLxNT5r7mU8XftuQRp6
	4/YE4
X-Gm-Gg: AeBDietWhD61DZClJAJQhfRlb5mSvLOp0aoZf5k4KEg1ORg1TPUrtYCQb8v7hiejhtJ
	eGMGrBPNAxkM5jkXIHj3ZcdspzoI42F01c5e0TE/2tsHvWnYNcN8SvcHPBonjjzn5Efvg/wE3lt
	3m1lINvsemjRKaNgi499XZS2OlKK0iEBxWCpDHNOZ2m31pOnVBG6dE7+vdfTLYCQiF6JcWyD1Yz
	QnCg3yswa/qhzXfV5nRdVXMECCP7gd0PJK+cC1+GGd9z+TEL2F2FBvopqR2fIrptzw/i7Pd0/cb
	eFP17R0I5eTww+z1gVc1jDXxayFdjtj1GXEQKXo0FRT4Vpkd+KuqvtfGelT7YmBccH4DeBp3yDd
	9NwsqDzgvGaHES7IBQ5J/2n8n/gHskr9BwInprBkLteFee06bbxFV90CxHS8S6oGGzwRyC93ZVu
	260RZ6wCiiZEYEKEGdJ2iCJCtRRH/umqEw
X-Received: by 2002:a05:6300:6c1a:b0:39f:2af3:e937 with SMTP id adf61e73a8af0-39fe408406amr4679437637.49.1775884639495;
        Fri, 10 Apr 2026 22:17:19 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:19 -0700 (PDT)
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
Subject: [PATTCH net v5 2/8] net/sched: netem: fix queue limit check to include reordered packets
Date: Fri, 10 Apr 2026 22:15:51 -0700
Message-ID: <20260411051700.311679-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411051700.311679-1-stephen@networkplumber.org>
References: <20260411051700.311679-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277660-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 8E7F83DE63F
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


