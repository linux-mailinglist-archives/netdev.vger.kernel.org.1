Return-Path: <netdev+bounces-279453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKcXDbX44mneAwEAu9opvQ
	(envelope-from <netdev+bounces-279453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:21:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792DB41FD39
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60128305E8E7
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982593264C7;
	Sat, 18 Apr 2026 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="I/G8QY6D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6374255F2D
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776482436; cv=none; b=JSC71ikUH5LNUx67S7naz45JbnwIKKHmFTuvzca6ZqwJN7LFuqgewXb/+XqEzILI3Ki/v8A9p4ioE3sDi2GpXwIw8vC7xpxNndWSfGRLwVjepjArBJ4fmTHD9In4/rz3CHgqyX2aOLXpGvxSCPAtSdLkLKi0rrmOgrBzYMn4IgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776482436; c=relaxed/simple;
	bh=fbqM3x3GD1CCUD2vyX99XNBmMghubH80srElmDJt3Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFfSp3tj25lqTzJ+AQGgnQ8FukRlohdloDwcg9UStKcqBr0dT8GokmBSWMSwTwMnAFZgM7HGcRHTrRIwxoLO1AmMMAMGbguWZaiyvlt6Q36Pqa91HW9vqhldUyKWe80at0p0A8AAu3G/m3HM64Ke5OcV2lPyjeRYFJ+3fWdCu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=I/G8QY6D; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d7ebe11bffso1298974a34.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482433; x=1777087233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=I/G8QY6DtJ+X/6T+Hm5vobmVWjOxVGayuA5gJ1m5ZmviY9YD6p+vldJTAaAN0ley4+
         tF/fjngWNm7eTu0NYdQL+asm0rh/M+KTQLJOhlOuU6eq2OzyEpwZh3ODgUDf76Pv8FX5
         pmowS58lhAG06S9T7yGacJeKo5xlznlOAg8D0/g532oSd5al/+jDjJuGqigOO0ia06lX
         UuE3SzdqhlcC/TUyoRNbpI19yVxmCBBUbl2Yf13CHjY/y+NRiSDzu64gdQoLCVrDX3Qk
         qshijwDRp3Qp8cPDr4P9tglkxCBDkPogBhyD1MEZLZgeA4V05Y4bf4nL8UUFcuwjIUtF
         U39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776482433; x=1777087233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=bKnmJoT2Gdry60RMfwdLPnna66+awrgdI9uwOYzJrfIpGXl07E2M4OzhDuPzZPYuVg
         dAn7xufdOSlTyA+Y9ewmzNhbR2Yxf+3AMYwIpatsq31aVebKvCsRuMO7E9SB8gTqDNU+
         tPRijNGkMI+Q0mTK2Siay3o7bLEc1rlR79+UnUR8exVUzqLrXtFhiikLClaBIaNvtnt6
         Q+BW74jivALWVlTHLkfEb8l5pF9TVcXNE6TQhA3GBJEiKTFdEoqeynhcUiG9euj4afLV
         odn/TFQip5Pz7oJw8tJS2udvwnjE95fpQTZ30mk9YYXOwLgQp85v+ZWY/699mJkgg0v/
         JoOQ==
X-Gm-Message-State: AOJu0YzgN4Tkt4HVx7bzPHP88TpzvCebvFECQag6vkhtypUsLdHFO5PS
	ZndY/liKmY2i/jeNg+rcDrtFaVmmu1mO23wYvsxKOfQu7hHQn5+KAW+Rz01mDscQECsIYLr6m+6
	g0b66
X-Gm-Gg: AeBDieumlMP/AiTlBuV/AjqIaIjaL8XQmbf+kLrRvvkIifKk36ddcT9YT+WQc4uSafS
	l01Q7gTMEMATSprNwOOpHNh/07GuOyekVu7eDR2MY2XOA02CRmBOg6TG6GvwUHIiY4xmoDfk6qI
	afp1svE/8ZJ2/BxCQlgn+bdslt0fTTxi86+e4LtvroqceERmKDsd8KTDQMqJJTv/9VIXyDNL932
	xVY0O0aZap7Wt/nVTLW8/lunyNbLoDsLtwOchz2a3IPZmuZTPlFP9Y5gPYDVRTAMmuo42rTPO8P
	wcK01a8WuTH74NhSrX26tS1siqlH4ge2xW5t12FFx0GMdLtAMTsR2jARttS3cm3vxQTt010q+Km
	Nuq3zkIUgw0ff9BB5G4V6A/VYzw6ROCJFgo4F84IAFdZJWczDvQj5+32ouVGK7dpeyotNVq/X5v
	Nq8DzogQ+Zgei8WI56U56kBt8fkQ9rKW41YJ86g3mxIHY=
X-Received: by 2002:a05:6830:6a91:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7dc9518bb34mr3763997a34.17.1776482432955;
        Fri, 17 Apr 2026 20:20:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca7b6b5bdsm276902a34.5.2026.04.17.20.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 20:20:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	horms@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v8 1/6] net/sched: netem: fix probability gaps in 4-state loss model
Date: Fri, 17 Apr 2026 20:19:39 -0700
Message-ID: <20260418032027.900913-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418032027.900913-1-stephen@networkplumber.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279453-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 792DB41FD39
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 20df1c08b1e9..8ee72cac1faf 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -227,10 +227,10 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
-		} else if (clg->a1 + clg->a4 < rnd) {
+		} else {
 			clg->state = TX_IN_GAP_PERIOD;
 		}
 
@@ -247,9 +247,9 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
-		} else if (clg->a2 + clg->a3 < rnd) {
+		} else {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		}
-- 
2.53.0


