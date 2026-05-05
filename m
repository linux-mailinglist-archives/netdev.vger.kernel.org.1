Return-Path: <netdev+bounces-284536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAgjKhws+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:42:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA714D23D7
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71F8A308D253
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCBA4ADDA4;
	Tue,  5 May 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="d3aTrxD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A194A340F
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002872; cv=none; b=X4ompMAr5ZjBpMLb5RKlViiCSYnaSOehdfSOOP3682KgJEt1MllYdHYu899/1Qo1jqP3Jcu9Z3LOpcidyhulChLRC8hvYxabys4bY3plDx7VpAclnh+qIWmctjIdkCiOV9wUzm3XWB2JPbvp0yoy7udd8WPl3J/XRC5xQTAXg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002872; c=relaxed/simple;
	bh=6Xq/3Ljtm/N7NeHZkXqexNlUKIyApeoZ1QIRCzYvhSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI3VBoPrGhy24gBUNHIuIClFmShVsRvgVSOcP0eCsLe5ouAWK82i7FMZ0CwWUxW8ZO5X0yGgIQkDW2+FhMYlkYrEmFUUNKeIg9r64s1r658nbCTCdhThM9zqz6bCB/eLN9UAPA7OUXjdqIGM10OZiGjxWQBUi538C49janwWKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=d3aTrxD4; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47c7b282d73so2248647b6e.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778002870; x=1778607670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVO5+hGEKmP4M1ycG+h64oElrwrlYVJ4Wqx0KlXlxOU=;
        b=d3aTrxD4itTwptNZ/EHT5SNQyE8JsHCOxJw7q74JrnoXE+6MtgAlZT1X0QOLHXeXbS
         Xr3ZLLlJbr3zPcaIhjCLIUT9VuwJDRnJ9O/1RUeIdmOczbuSOTk8XZZiPBgcHSxQiRTS
         oKoVba6DfjjY3jVS8JCkCsM0TWFxHlYOL/DQhmVvAz+dB+wWwGInyRjNNXgJPiMQp5b+
         HQCJ5nNo41D39DWPjP8axMwagXXLo6RVYZAsFvuezgy722rJmtiBxgHsz/v8+4KXTx8p
         FJSOboytC/l4A0tB8nLB6oIAMtOiF7Cuh5Ds9/0EEpKTIxXKotelRrOxUrz9QAtWc0oM
         Qu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002870; x=1778607670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVO5+hGEKmP4M1ycG+h64oElrwrlYVJ4Wqx0KlXlxOU=;
        b=i+LlhC5FTnMnQ7eujTEefYagipn0bZBVRpVVIWQa1048srXZk5qD4EzagpbMGyRXuj
         CVmfeuwYD6hq4F4tiephC4CYJkZAId6wCDpdFZVyVhcvLC2BbCJEWVmycueyYebKhreL
         HJmzPSATlSPTMKxomNuB+kPrY7+wCZW1ks7BfxkKbyzE5p0wvyNqWzI9lkhUfqOZl+X5
         Vx2DA/TBlQl6DF+v2fi/ZNXjM8bwLWL/p+w4wqV4SvjVVWSSvQFzfmfaTXqNY2KTOuS9
         8gqG08iO52O917cb8tAB9Xzr3xVccOHEG60KgXKFQB4AN1YNTnL0KJQKZ4DG7cdVJloI
         N3Dw==
X-Gm-Message-State: AOJu0YxpMieyhb3HEhTbHhZyKDuXQ2sjFqcwBy3o7A/NOFNVsV/c9V88
	00H4Vk86HNPxvmKKLMoeEIOKCEnRBARPYR8/5g3ZXkJOpax+9e/kaPZ2Meq37174cZdwU3nrmG9
	p/ApQ
X-Gm-Gg: AeBDievtA4OvR2+nMVo83bBmfRedxVrZMI3ZqsJgUKhun5BVklBUJkX1v4zJ5Wrs7B6
	Q5FU5FgrfF0cGCQUNhk0QNnU98Bc8SD8BtOaH9MBErW97ApLCQ4Bk8HxFd7T1mf9ErXl4d7R1T4
	dJuaHvLbsCr2gp1TGuhEbw84U3rJ0TQY33PbslNxz9LIqbGWQ+1QvCX93aeFbaczeqQ4mQotUaz
	KVFbQShycGObjGnBiJgs15AQUUPg/6EWhoMlnB0U6CXZTFJ02k6NsXMO7qoXzhFpl3WrsmunbYX
	3e/fpzuEeOZBzOMqs8YKfZ0adgt7wmjt82OuN7aO8yh5ya6ncDY/ujp4j/3lTqaHpfRSSGLgFc5
	0d6o0WJc0/vIrZt12pttQAVim/rTKcaWENXSb6DJVknz9TGaHuZrOfk+eQ84y0OyoOCySe58mod
	e6EHMOXOxIg0XkiVUPOXAiJQQkEb9Lc6ts/epQv3gzpHg=
X-Received: by 2002:a05:6808:1b07:b0:479:ffcf:52e0 with SMTP id 5614622812f47-47c89333253mr7360512b6e.45.1778002869736;
        Tue, 05 May 2026 10:41:09 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c769c9b12sm9006504b6e.17.2026.05.05.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:41:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 4/5] net/sched: netem: handle multi-segment skb in corruption
Date: Tue,  5 May 2026 10:38:44 -0700
Message-ID: <20260505174059.651260-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505174059.651260-1-stephen@networkplumber.org>
References: <20260505174059.651260-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CA714D23D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284536-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]

The packet corruption code only flipped bits in the linear
header portion of the skb, skipping corruption when
skb_headlen() was zero.

Linearize the whole skb if necessary before corruption.
That step also makes calling skb_unshare() unnecessary.

Extends d64cb81dcbd5 ("net/sched: sch_netem: fix out-of-bounds access
in packet corruption") with a more general solution.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 53bdfa77ee2d..020dbfb6e4a7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -508,21 +508,17 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_skb_cb(skb)->pkt_len = skb->len;
 		}
 
-		skb = skb_unshare(skb, GFP_ATOMIC);
-		if (unlikely(!skb)) {
-			qdisc_qstats_drop(sch);
-			goto finish_segs;
-		}
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


