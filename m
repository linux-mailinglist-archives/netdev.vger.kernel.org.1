Return-Path: <netdev+bounces-277818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DbMDPy522keFwkAu9opvQ
	(envelope-from <netdev+bounces-277818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:27:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6EB3E47A2
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C482305C8F9
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C3383C63;
	Sun, 12 Apr 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="HMDQabcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F9382F2F
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007485; cv=none; b=kaUqdavA4NF8ge/txIUBkFzlQbScNuDlc5HpeCKUwLLZlF/jBC1Dblh5oJ/45wWcEBsostKffVpmk7DtTEg+NigaEfv60opfDTTufsBudUqcYOM9jQzkjtz0D0n4ZMY4L4lqEeqIXXBy5CgRrksyOLRInw3UtjDJFSmjCTgCWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007485; c=relaxed/simple;
	bh=V2tJ/vwxtv1JaoqQpiwU5wG5dp1eaZ/b5hMOD+aRAco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2boAgAX6wWYeXNc/MTjc1WqxyEfyQ/7bVHr2+xWW+PhYVJx0Klk5RTINjQimlwWGXlfdjd5AIqecfsw4QH8jhm6A5ibAqbzd92CorIggMGprSlunm3gtmZZpsx9mB2xsmN8huy/rx+Cu/DOa+VZQk4I+YpOHOj+wuomCm+0wOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=HMDQabcM; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4704fb0d5b8so2337455b6e.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776007483; x=1776612283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7qXhqZv5DD8Qd3CVsBEDZPd4YmYSOSggm0tUgn0D6c=;
        b=HMDQabcMBu/0742knKA9uTg4AniBsR4K22gotHxjEsImqXM9Gx1xFtRvNwLmJv67ay
         jQXRlFVOSj02qgsehuKdeC4K0axUIObmgPd8aWaNYAdSbfCFampDXsOPN/Zp7j42P+D8
         xOzklt4LrZWjUwqKiPtLPmmAX44UcpXu1dR2a7jX/5hlb+TipDdUy7SWW8StdIIJWgO6
         AQcxMB6iRWLNsN41zdpvLTsaHyJUdunmXAPyBljaPJcrw1+66lg60DQR1e5mFYXnG240
         DGa8BvX6JUCcaqX+PlhUGd+fqpFMfb3ChTJhRoT4xXsS8CY1CZrSyGJejszXGNgtuGw9
         WvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007483; x=1776612283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7qXhqZv5DD8Qd3CVsBEDZPd4YmYSOSggm0tUgn0D6c=;
        b=nDfUa1upn+SGbu9Y2Anaa8Ltll1I4Q4/bQ1gDc+ZXuKR4FZv8QjLP8l/ilBB5E5I6U
         x3y6TwF6CO5TUczN/sUQPakVc8+bN5wq1EyK0IEvVs744eIKGHkKvw4b00Y7fHO5S/cg
         m1GNuvntSIGKe8KcZhOkhoPzgG3F88i2HWbBDh7ucspn+jX36sykRsOJyOBfJujGvLbo
         AqHLgCJRiLlEa8n2wW0lmJh5bRrs9AeMORloRo83tucBEYZ0yIpcUjyU/Ofyib1wpSlV
         YulmWEPRmuHRp9QeVxx3XwMaGSrIsTOy97rwoqEmP2MQeq/xmqE8NcsyYyCjXN3KCkpy
         MCEg==
X-Gm-Message-State: AOJu0YwNlcs4y6Msp/9J7ewrVLqFCxBQ916WNdc+48m3+Kw6b/i/mu/q
	AKP5os7KpuwyYD3ekjHv9aSzKU6lm5jbFJE84vBHfBn6b651/ezkYhUUJS0+P9Vp60pCim90a5j
	c6B69
X-Gm-Gg: AeBDietHJLijFEXinTr971yOaeQ41OcB94faGfW29gUwDLkJj4Uyed785Kt0+3GnUhE
	wQKz61yU9OGUE5avWqrNXlBtIsGuhohsi2euiFNgtl8aYZY3gWnzxQ2lKU3o2jFh0GtNb22TRR5
	gonkmkdShaVidzkABR5GQWK1bB1Vzms/1XwZVBN5Xin1Xa32rSIoI+FOcRjNMQ/z+qbQ56aKNsx
	A0GTVphqxlnVR4JGnpqNmmnpZ1ZsRqehw/YL5BZZWEZLRCLDYiLH0lnKNofcgaKu1KLzMC/rGVb
	JHEtwRVL4HWat8c5RrhE9fVNOwDuLWA5kVII1FsnEk32vpGnP7Pk037i1SW1EuJpfhJqriFJide
	bjgeZP7nSHRs4RQLiGLzvOAaKLF3LaIdA02n0/AHij5KeOC+3GI2w/iv2zd6L18drDK/O7L0OCL
	wdbDh+Fv6ogX5zOWYkCee7TK4Gtl+9SJPc
X-Received: by 2002:a05:6808:1807:b0:462:a91b:b080 with SMTP id 5614622812f47-478b64a385bmr4834819b6e.1.1776007482976;
        Sun, 12 Apr 2026 08:24:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f557b5sm4911726b6e.11.2026.04.12.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:24:42 -0700 (PDT)
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
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v6 5/5] net/sched: netem: fix slot delay calculation overflow
Date: Sun, 12 Apr 2026 08:23:55 -0700
Message-ID: <20260412152429.143474-6-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-277818-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7B6EB3E47A2
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
index 16368948bde9..452ad2b483a5 100644
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


