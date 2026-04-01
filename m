Return-Path: <netdev+bounces-274145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGNOFk0yzWn0agYAu9opvQ
	(envelope-from <netdev+bounces-274145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:57:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0521037C8E3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF94130623D0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41E4779A9;
	Wed,  1 Apr 2026 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rYE0InF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5180477E24
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055227; cv=none; b=c8c7OKWPcRr3pguBwELLoPI/Jikp/Lk+iv1tpcKyJogqQ2CBjg2tny1l1PnVk5PohPGCFSruXLKBZ2btvr94t9MssTxK6tlVyab5r/IjcGTLs4HMw2I1uu1q2xLMINr/E5AUy372vk0C5mXk5gwg6dC7Avjjal8aRoki0cU1g/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055227; c=relaxed/simple;
	bh=WWc2WPGjnLDzGTWjnud0UH8yc9NV/+PJ1u9AIBSpiuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIhsm1PhIzzJjndzHSSnFsAj/AlejCCU5PsU1i0lyENF6GtpzfMI/MaESrjx+sNcp68ARfXWg6WnJnIBTT7qguUPGRbZlv36cVIkWeQlLJNvbVbC62uKGyX7kL7PGV0rF0d2+mguSJXi641GYhAgcwMED9myvhvq0MUGSNeToq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rYE0InF1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6766047eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055225; x=1775660025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQkiQzykTuUlpr+LQhcAQNW1WP+8TnEM/NAdEMX1s/E=;
        b=rYE0InF17Hjcx9fw2kc66jzuRzXSqydwDfgGgy3y8voUavGZI7T/CikDhEVcgfekMc
         uIvazRJ0S6o+SN86qvoQjLaVKMXp+NTy2Flm0V6OvZTDK5AWw+OJeDRkr0fD6ukYPydx
         acIDiEq6V4TskpjXgw9L8AwiiweMEcWup95MFa0Jrzbq/A4mY4/5Aut/6v4uhoyAaZxN
         xeMyv7vl6qgk5l0lD3MCcKHAgoEIWNnOU2eAJwcSiv0kW+JCueL/2y24+sIpB2RvYcl6
         2AIDgpReKrUTFn5jk36xqW+8bPcOi9NarnElc77Xu4yno/Ft4kHE+IbJFKqXdXpgRgLQ
         r44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055225; x=1775660025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQkiQzykTuUlpr+LQhcAQNW1WP+8TnEM/NAdEMX1s/E=;
        b=ldAD2wJDDJUs1Dc1C/BZC8N0imYv+RMeFGSv0ndbPE06Me6GR2dpNDls2F4WJJzlsj
         NocqUT0n1ojPvB4bVeYv0PyYpTnhAVzJkl5plod/qm3kXfGyVyQozBxTgcMBBvyPrfmk
         6hXZtmEy6Yz45vMKXMEMcp95Y/SECS6wHkGTEKyKzAL1WLDA2ZaPFYDKp9idR4TbQFZM
         Lrsw4noiteNAU643oOf3usDMNzqmFyp2XPisZQb8UX+JTDqHpBthY6pgeuyIZkGrJChZ
         qQbtpQlv5sarBYVo1ClY1Q3pUrBKulN4wpTk2sQ17TjLICN9AjJ0dms+DsCdbDve8PNX
         8CYA==
X-Gm-Message-State: AOJu0YxA6FgC+aX+bP37VbZLbUQrAfyaYa5q0JPuQ2qkWfmYWBXi448a
	kRx+JGQF1/vs1z3iOQy5Qm75mDQenCiI6MtckE/84TD6Xy/kaMKJk+L8KORpk5ssyxKJD8h6vhU
	uNR57
X-Gm-Gg: ATEYQzwA+9jZl4WsjxGAMPTwQHs6BTEcETWCjZ2VwEuAuJYcl1WtAV8gz0bh1IysO53
	NpJS6XbwLQmjC1sP6e3AdKHp4+Arp0Dt7K/0IGNQVkp9KxtuDnZdS+e4zxw20t6kgMv9+D2XWAk
	E58LL1q3Wpvwz8NZJQp5sNQDsnsmpDZAQ9XUDHHCl4x8ltsNh7dI/KW0VlVJg0fXuTWs2cJSzQy
	UHOoT6VI7wmlqEe06JkjRdKJXLaP36/a2KbDruBlPTfiddTPJLoYS4fIWoA2IPJHdZuIE7Y8WQE
	g5Avumh/S3sdsIITNWNEvgdZ3A6rsXMtGLKlSNTs8e9t/MStayWSSUyo+D/LuRccWVgsWmmS+d8
	dsnpz1VWsrYhUbiCx+1NDTFUXIK8LjIbFXvdp6bN8EcG9WRBvdIDDCegJYKH/HB154RMFoW5zfS
	gFnsIPhF8OeeW+5THj49YXsw5lj2QQ/uR6
X-Received: by 2002:a05:7300:2291:b0:2ca:2f21:64da with SMTP id 5a478bee46e88-2ca2f217676mr396507eec.0.1775055224489;
        Wed, 01 Apr 2026 07:53:44 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:44 -0700 (PDT)
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
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 7/7] net/sched: netem: fix slot delay calculation overflow
Date: Wed,  1 Apr 2026 07:51:59 -0700
Message-ID: <20260401145332.78285-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401145332.78285-1-stephen@networkplumber.org>
References: <20260401145332.78285-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274145-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 0521037C8E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_slot_next() computes a random delay between min_delay and
max_delay using:

  get_random_u32() * (max_delay - min_delay) >> 32

This overflows signed 64-bit arithmetic when the delay range exceeds
approximately 2.1 seconds (2^31 nanoseconds), producing a negative
result that effectively disables slot-based pacing. This is a
realistic configuration for WAN emulation (e.g., slot 1s 5s).

Use mul_u64_u32_shr() which handles the widening multiply without
overflow.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index ca4de7ae6f2f..5f497fc544ea 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -659,9 +659,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(get_random_u32() *
-				 (q->slot_config.max_delay -
-				  q->slot_config.min_delay) >> 32);
+			mul_u64_u32_shr(q->slot_config.max_delay - q->slot_config.min_delay,
+					get_random_u32(), 32);
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-- 
2.53.0


