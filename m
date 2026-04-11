Return-Path: <netdev+bounces-277666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ErKI97a2WlOtwgAu9opvQ
	(envelope-from <netdev+bounces-277666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:23:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CFD3DE6BA
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39A1E309EFC9
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920812E7631;
	Sat, 11 Apr 2026 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="bbn+9Xtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E12D46CE
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884677; cv=none; b=d8cPJ177GK3ddCYH8ybsEa6YN5v1+X1Vee7N6FhcUEsV0dhx9BfO4sw140EymoOrdPkEESKtQIMYfG6ApudAzt+k3C+zW4917GS0iXUgP57fxDImmHtwZYihiY6dxdewUE1blGz5oQacgasBwfjoDYovvKTO/UT42fekCFIq/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884677; c=relaxed/simple;
	bh=WS1gt+XCorljBOXpBR8SOXGA7679bm4YgmPp9vko5wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz5Up4yYvrvBsqjMJamgtdmLgNZg5GZMnFHOlR9HmH8/d0CNLeHuU3WYfdJy4j1EHXkrktKD3U6ejmbFvcA6OPPLVxDooW6SMcd93oAqCPiZraf3CKCJv0qlUOtu+R8ChDgfV2npJzN9NzpKoLj3Q5E9wOXMtZT4r3hZTapYBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=bbn+9Xtq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f206f2b54so101958b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884675; x=1776489475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4cg21lgYYt40QuLQd5kc+RjBMnnTeniExtdTY1DO68=;
        b=bbn+9XtqQFCNI3dVeBrvEdWCiwuN53YN7GdYCYav44XuYtiujb1/dA35epvPLGI6H6
         l121AthqsfevpIjEF95v7L6McHO8b4iFqKxH8Pvw3ecRLSPfm+/tOpnkunh1F2QpFHb0
         /qBY0BAW4RuWIe+OTiG7kgr5euY4DcaqbTkkQwOW35GXM/o+bDLhMb8+t+J2GiMNhtV3
         aO3tp+DYqYGAtDQTrAM4B+pjSloRF9VYsNeNZTOrFdnyWqlnQb9dr1ubGFwfhRo2bZQ5
         9PJI6woNMVKyBiR+eeZwgF2jKL3ELS0tqQIxp2dh8y7wYCM8Vfz4Gpa/JizaJsFb6gHS
         vZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884675; x=1776489475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4cg21lgYYt40QuLQd5kc+RjBMnnTeniExtdTY1DO68=;
        b=KdsEz3vVQIrFi/+Q69rp+5NWQ9l2phP1w98DmFKV+yGoluuctuauJsG/YcTM2QKHHN
         jWBbUT+tyVaEZN6O+9SPAZrpi9b/WqZv54kPfSzwMPaxk3KOAg2MilsI88cnhmSmpCtU
         78lkM1IoD+gFBOhFK+SMdv1m50Icc2LAJuDURcdbIeOd4kKK1cBZk5NAGyJ0EqMJNm6K
         4Wt/1Dl93WlmZK+yFhZ4pPcMK24uUy4PV1w4JeHd9o/cz+f5yftKARmlfjct+m92HnmZ
         +kSBowKoS2Bhw5/jXRbw1D/7ks7h09pGyWG7/yy46BzgdgAOfp6XlYABQUHsGrbPL1xF
         olPg==
X-Gm-Message-State: AOJu0YzTas7mxptGkUhHH9F8iLpFaPhmwWRf4d4lWph41wLoY7042wp0
	fbfLfyWUzziV5pLJBvVD5gQvs8jdk5B2fqC7JdmMU5ROmpQhVF0L9IaQG4L+qQQl82sim5E3gxw
	+Xqig
X-Gm-Gg: AeBDietnRdiRiJ1XZ3pdXnF1PMkqQ1+PZCPkdDjBWyrFCoLnE72rC809rVKQYgKSwHG
	ZU3bj1NxTO/zmDadbBh2GtEeX+cu4anhZ6AnW96ZqcX0XsewPU0Mc9i1PB22X2byQ6Vh1DPc9m4
	2nW+VAdwiCxFIsf4pGI9lE4DDRbAF+aT8r6jMGO+Y1c1kumVdyItmtQf3zJBso/IuklbC0iJEzH
	W3yHxv8rXphCslij3tZocNBf30qKgZMTVbuHw9lz9FIaCN8aLcVomXlzitCHBnz4U7tbjEColTw
	9J9Lk10gjiQDISKywtgntQqGrbx/XcABUIy1sbFLdYMIFb3cyDIbikX94fq17BnDOZeGooYcLKz
	xVwB7aLjJiG3v+9UMGwakoCVZkI/UfIOfeT1SGKwL3/F8oH5oD0oN6E2Y2cvHN4WoKSrLi8emG0
	KDZh5EYMeIOhzRBRmsmAwYuaxTLg2k9a03
X-Received: by 2002:a05:6a20:7289:b0:398:7ed3:a005 with SMTP id adf61e73a8af0-39fe3f15059mr7124353637.29.1775884674957;
        Fri, 10 Apr 2026 22:17:54 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:54 -0700 (PDT)
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
	Neal Cardwell <ncardwell@google.com>,
	Yousuk Seung <ysseung@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v5 8/8] net/sched: netem: fix slot delay calculation overflow
Date: Fri, 10 Apr 2026 22:15:57 -0700
Message-ID: <20260411051700.311679-9-stephen@networkplumber.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277666-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: E6CFD3DE6BA
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index ef4965f20f17..6a09627bafa0 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -660,9 +660,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
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


