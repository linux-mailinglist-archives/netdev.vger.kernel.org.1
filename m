Return-Path: <netdev+bounces-267609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBq2Ed1+tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46C28A159
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 217B43026B47
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FDE372ED0;
	Fri, 13 Mar 2026 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qpBYLL31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83953382398
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436633; cv=none; b=eudxEOTZy+TNSSXXdXO4gic3SJZglHvsoO34qVZOZMrQ/YcwGLZbSJl/u1VQq82SDjfoWXUcVpjklvSMKMHLlckwKxAhj4Bc/cmXI98y22hYFzmG0DoCrwfwT6WgTJa8r4ZJZALnGRPzrTAvRpxMuEUbqjlSQtNAy5kj27h7naE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436633; c=relaxed/simple;
	bh=SRQC0qIPvPH4Zaa4Lji9uCOOr/A7JrWIHbpG6WWxAWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huH2xajKCay0kbbAKYJ/ugBkoIMKRZmwkKU2mKIyhDom4RyWhwud5suNLLAo4P4/YVNbT5wZCQcdn6ns4puhfGT3j0tYNLcm+djCR2bS9egwCA2/VXKoBLIGjTnF7xJDKV57Uox1dyQA6ZS/8h2sp3N3FLnypU5wn5WF4wi2upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qpBYLL31; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b04075d1e5so2452865ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436632; x=1774041432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cWWpYe8hBBs+rQMuihqYMwajplJtF5OuTV/SBkrQGg=;
        b=qpBYLL31HyZlOmzmld+fd+JylsF1/4HIx5Tbx0Lbwkkr7+kB9velrjC2RWSjrLzOpX
         je0dAcw1ZVy5AeR+ncq7Np83D5Wdh+Z2mURnETGM6BoDr6ezWVnszQlVEnXFfpgnqaF6
         pvlucZb/EihHWL0+i0Io8QiOP9ZnrN6gyseYY8bWSUz26RLsUwMSF6n3hR3M+2vvRMVQ
         6jTpwEKTnrBJX6BEI8ekSHG3EyTOVENlTCGsKjK+x4Xd3kfvdCwdPh/1Gt4NXP7WGTag
         zxUxYvdkWS/rGChCQrLKpQskHaaDHcLR0FPh39x/lIrnC/Pc9D0KrUp8FIOAiwgh94eN
         KJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436632; x=1774041432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cWWpYe8hBBs+rQMuihqYMwajplJtF5OuTV/SBkrQGg=;
        b=mnstRfJ5BiSzqWYebFgq8Ecj6ofgAFztVGNZpmLIP1vCuQ5RdY7bMoscCxx4R1r0Ov
         m8vauNFtLdvsOnn7K0lbiPaE2p0cFW6AKZKKRQbCa7y+oFGMJKQhd7T0af3P43u3EsBT
         nEdXYymuVR8neo1UgHUNSc9cNy9+tpxngGWhv3eGadnIw8DpyCC8qQzaoQzWZZmC1pxy
         W35m231IMa4oKbkLAcGPj+jmQ38l1Nj7/b4Lc//9mKPzD8J2FUVKLS1aeQYQz3orptul
         rmTlaObXBvAh2ijQ83psEiVvInuGvFFao98bUkys4WJmYfUjiVFClOqwwUiCw0SKIB+h
         TcZw==
X-Gm-Message-State: AOJu0Yw4nuwE5dRQcZLEGNOFKQKTXXEYwzJ/QT7OxTfW869d1aVLKqq3
	H+aXVaYLsdP3jMazKC3gZ/yPJRiN0l7vqR2I6182GD24dn8nfemW/yC+f96LuvsHeEury4QjRQ5
	/gMqaVQ0=
X-Gm-Gg: ATEYQzyT371ZlfIKkYrpwPbosrXuOv7sfajuMh1uRF9QiCkT+TmfGZUAPKauZXVBh0v
	MopnCw1n1WUpS+Ug9pKUJUztfd/w67Uj1qwRdgFl+pO2UqXmKHta10dBT69I7HvDa2vIDueEOHq
	lP5ok1QigvLLdXIut1GL/P4bnDLhxQLUXh8BZ7I+0Z3vYyXB/YlbAcEM45gZcPekAM+c0bsvXD3
	a7zYpjZ6M+qXtXttGv03E6mtWvY2jeG+wsCYlTYLGIx5cpBKXYuglac9zUYhOB4yXFJW+/TGMEc
	1mA6vIoG56hGv9q6N/GbqXjSnDjTrV5fJQ8wu9cYy88NjaJMbTTWbb80AIlH7/grwgbPvtmgoLc
	ePaWRlPiO89IjwrtQcNXUFcXyh5rP/Es16LOXi+oFDTLsdr6CibQQFrXY5RIHLzlz9HV2jUbe5a
	60N/6gy0P/AkppQTG/HnXCWtHtU1rOKBdh
X-Received: by 2002:a17:902:d548:b0:2ae:5f65:171 with SMTP id d9443c01a7336-2aecab1ee59mr50093605ad.33.1773436631908;
        Fri, 13 Mar 2026 14:17:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/12] net/sched: netem: fix slot delay calculation overflow
Date: Fri, 13 Mar 2026 14:15:06 -0700
Message-ID: <20260313211646.12549-7-stephen@networkplumber.org>
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
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267609-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: DD46C28A159
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
index 00ece854280a..afb89d318f41 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -680,9 +680,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
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
2.51.0


