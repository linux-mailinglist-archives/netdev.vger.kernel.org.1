Return-Path: <netdev+bounces-267608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNzqJhp/tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:18:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8828A18E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A64E30C6661
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808A372ED0;
	Fri, 13 Mar 2026 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QCTH4Ntm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A5381AEC
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436631; cv=none; b=AfSN6ET7KwvuEntiVoqvbuotNaU57m+eYf2QlTfc6tqKU0c2t4gRlvz9NLXyCf6VzS++DoPOxrO08XQsV0IA6Mf7QxhQoYfI41KBt7hbLKdSLRCxK3MD4QZGfSRS7AB2q1AetO3vgx1iL5ZxxX20SH+/0QTjfeUbwWTZw7rro/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436631; c=relaxed/simple;
	bh=VkL7NwnVyK6lwRKvHFcm/DjShL/SWgHYHXNJch2eLl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0igwe83MimwDgB6+Qgw4oDv5PSAmY7m48rLnTDl+lAyh/tSV+WxbVTWZambccSyuE5VvyL++AWN2fnO2fnv6G34IqdtQ9mZRPSZL+jGqs6ZVWAFSA/zRxkOBMyvCmbYS5IkwL5vcfBSCjBZyJY/yC5MtgS8HyJGqJxROa1VAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QCTH4Ntm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae43042ea7so33013745ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436629; x=1774041429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqaazxaF0oL00PqnTnSE6dh5S+NYDElDLDEd9qHoVEE=;
        b=QCTH4NtmYXcrSVTT3zB2cMFhGsIfU6wRPWVDen+EFopQFpPvt6f6Pg4waAQ4owwzgt
         xKsCUG+Ht5+E74lG02NdNphvDtXtM5i4BrEQghlG3FPX5mWzh7T78hZ4JU601kcWpRii
         weUQJaj+ke88ztJl7RiatrS1cJMKOLJz3r/p6RpVv/h8LBWSYqKJL2X8kf7uT/BKznCt
         4SLl1x140talhh3EGDCsSvKIhNJiKqtLNs8tpEvnDjxtKroQJqdUuLrW95VxKdL515OM
         T/zBVUUAwM8XEUV5Px45Bga6V5GCHFpRx+Jxf9L0VMqIc4o/vhuBUItbyoPNf/eahqCQ
         IqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436629; x=1774041429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqaazxaF0oL00PqnTnSE6dh5S+NYDElDLDEd9qHoVEE=;
        b=RQxIy222of6KbGjcAIwUn/eSX04ikjnH1I6GaECq2uN7ndE4xOVI6mJfy5eUerX1Ze
         g/NC9/fvU8ojSw4suHUqoOMxbhPu0VqLCBgnkX3f02pAbKoPLbHfERD7Rb0rhICS74+0
         xafD/h6C1yqpRVCK/GMlETctxnP5WoAIWd2JE32pyaYuthXbFHZJmUfpzlAmlUlPQf9Q
         2ul54NT5o3ygMwt3blBTmXeZFem0myzMdmuOL2sJ8jQOOPWQYvQFVs6mxrmeSg11wD0+
         r5TE59DI7ql+Bb8pUeMg6D0FZekGfYPxcrRAs0mIQIBfZBrvsLm4AsmiW/4gFptsT0TT
         BvJA==
X-Gm-Message-State: AOJu0YxLPBgcxjV4UsSEWBCkaLyipunnqxvp+Y0STkvs7VtPQ8Iqfmw2
	33hlF++5TeKLYk7QBlz/W9uIi1Q22F56kG74B5miWd74qmw1Y1wA6F8Mk4JwOCkbI/kVKpgNCcR
	/FQigbjk=
X-Gm-Gg: ATEYQzyyNQMBIwaXQ7f9YvY3pQr780+fYz/b1QF4mSqvNoVYxVFtxrR7//sSIHglb7D
	m9UxX7WtzEjebucCHh2eWWKS9+wwHtNANaQiSf3Sp4rdRULyobv9KyTshc1k5lLaC63btgfMA4/
	ZFDHQZoMbOW7g70qAdSRuRx0IZ+tAva9QVkaAdXBgZggZyvt3Mom8YhZTt/MQN0uRli3kI9TrFS
	bC2zkhbujQNUSNlQmb7yTQurDUaO2AaLfjEYivAMrMXnOqy/SpLxvoTt9W/13gwzqkza3y7Zne6
	+v+ofd4pa+jaPfKil206GfQFzf0UJjVTcZBZ0/zilWN3wYqww6FEywWQoavaGJLZeXGzG6elHVq
	0SJerWQ0sscU77fPNr+rthBRGj3k9ZjANModZalbgAYH7j4W7AtTi4JRa3+9sAMXZEdNThBpXa/
	1CTuPoKCONWeDO34hVJH5TM3CqO/CYpBrX
X-Received: by 2002:a17:903:1aa7:b0:2aa:d67b:ef96 with SMTP id d9443c01a7336-2aecaaad119mr48063805ad.31.1773436629333;
        Fri, 13 Mar 2026 14:17:09 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 05/12] net/sched: netem: fix probability gaps in 4-state loss model
Date: Fri, 13 Mar 2026 14:15:05 -0700
Message-ID: <20260313211646.12549-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
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
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267608-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 06B8828A18E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 4-state Markov chain in loss_4state() has gaps at the boundaries
between transition probability ranges. The comparisons use:

  if (rnd < a4)
  else if (a4 < rnd && rnd < a1 + a4)

When rnd equals a boundary value exactly, neither branch matches and
no state transition occurs. The redundant lower-bound check (a4 < rnd)
is already implied by being in the else branch.

Remove the unnecessary lower-bound comparisons so the ranges are
contiguous and every random value produces a transition, matching
the GI (General and Intuitive) loss model specification.

This bug goes back to original implementation of this model.

Fixes: 661b79725fea ("netem: revised correlated loss generator")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 08006a60849e..00ece854280a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -237,7 +237,7 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		} else if (clg->a1 + clg->a4 < rnd) {
@@ -257,7 +257,7 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
 		} else if (clg->a2 + clg->a3 < rnd) {
 			clg->state = LOST_IN_BURST_PERIOD;
-- 
2.51.0


