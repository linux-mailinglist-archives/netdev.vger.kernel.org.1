Return-Path: <netdev+bounces-272799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAA2JSQeyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF334F9A5
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E5FD3087EA2
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A913A641B;
	Sat, 28 Mar 2026 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jKv0NNEc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51E3A7586
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722434; cv=none; b=j3B+1fM4gCU3r/L4j2RocAkOTiriXQ6G88ZUBvN1u72rD/fNeiJrnFKEwazbp2f9TCUyTYDDxyQXUh/uA2wGaUYDQ/GRi63yPbPTZ2PqSSK9M0W3GJFMaF4qHIoNxLzJvz4LZmuTjHN78NPjxYtjUn6OETaiiULT5g7W4tlMN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722434; c=relaxed/simple;
	bh=SWg8L6uuWco3cS12n7DkcRHrGPFWu23NRGVl6A+OY40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/2z90ahdk3HxsH675vi3hTqeUt8pL+NsdbXEgS0/6e1VtKflUqhRmU+kin4EW9xL4avo6OlMeLJPOQpfHWHLYQC9aFYvMXDQe3fP0iW2iFKBjNsVe//qYPQiycXbGJU2+aMwdQHeExnFh0wXLfAC0WpbJgtYkOIzVoTtE+CCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jKv0NNEc; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12a695044a4so4377181c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722431; x=1775327231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2ZbLPQZvohPDkPozjnrqd1E31roY/uNx4kiTZpqtWE=;
        b=jKv0NNEcT2F56byzs6xrNI4UxD6OhDh3v6bmW6qj9Kd3FAVD33QPk8Tb/ZuSqNDlLY
         URC6KBRL/4nr9HP0QIl3JdA0U35eos+y1kM9gpYevuuKQAVLDwYnETggMn+vSqdNd3Rc
         RgPn9C1lo70ZGGQi0ZdzImKHekYhtpER8imOh1i3Ac91QD4Hxg2jSckr6ylfMqpp+LZo
         7LuAtW1Rg/GNWFek0x5z0sRJmc0Wk6dJRkzUvrkDmSZy3Dr/yEmCJhWm49SC0T2/bA/t
         b0YAWbF5W8MNVhMhJ7PjrfHZfsPRLB41TP5tFXdjSQC2CPVXegtKuEuYWA57X+zX39Ae
         pu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722431; x=1775327231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2ZbLPQZvohPDkPozjnrqd1E31roY/uNx4kiTZpqtWE=;
        b=fNkHKJqwism+AFbVUsH0r5gkEkRY4LBkpURxckQ1gHj1aRBdc6I7CUGFy6LLJWWig2
         IIezmHoCiHUCrFeHG5lr3d2DZfxG1jn4TaHpdreOHaPgHIrQsM/nuCGsiu4KtpYTyTma
         Q9Ib/puW34jwLo1znMZLe5bjnBdupgBeEIMjluFj7p/DT0hhlWET1Imx6Y69c1XzZ2wk
         ecwQKgNn/T9vQTrGtamGXXu0lhsCMYCcPa7SIdLccgN3UI5ChPeFqDAao3JWMW+aJV3M
         zFuoW0qjT3BrFikOsmJp/iLKyb8XvXECElk3OCOR0kjvCruYqGzzSASpaUYyLEaSKIDZ
         RCQg==
X-Gm-Message-State: AOJu0YzAzf21AN3gI57DHwIVWofqFF4ofP6DlSvXvyuGHu50/i+n9R8K
	mKIaxLt+yiVc5rUFCPbdhDfKsRIMXtuSMhCPQgGiTMffDz4c2SG1XPqC6CQ75yrayHVHg690iFV
	CQVDc
X-Gm-Gg: ATEYQzySR6YD2GknFo1d1q1xTHE6tUJXfGMzmurAVMSqK/7gdwrdNfhoKsuJ8ZUu1yG
	RvdDsm5r+TeQIl89whZuJFR+qaXmt9FYjlTl7WpHE0u4JAz3zGfF9QzVDZgwrRALRRZcEBEYq5S
	cA5AaHO97j3miQ1nLTUKjl2MdH+Gv7GNKY6herlDC35e1j7Xb0VJY60Gan4Skp+x0XbnHgekwtq
	O3Z6EJV++k/HOKvPGQzESMGu8WLN1+toQ/ZI0h/px0yL1q270yiaoPsF03io/QJV1G42dd9SwiI
	H8GjhA0vyUKRt+sUsnF1Lh3sGMHc+vq3+ZN+tvlIFbWKaemEAYq2xzOlFMX2BPi1SkqGR+mvPOB
	Y6KZPl/UdGg+ooDOQbAmelRLVhPZdjJMCHPuQtS4wzH8g155zBIT76Exh0i8eFJAnHapItNsESY
	ppMWAg/79WXkYpT5RePAh64CB8iF5AHXHyqaHFoXIWjFQ=
X-Received: by 2002:a05:7022:eacd:b0:12a:713b:8964 with SMTP id a92af1059eb24-12ab2866749mr4684581c88.11.1774722431162;
        Sat, 28 Mar 2026 11:27:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm3909263c88.3.2026.03.28.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:27:10 -0700 (PDT)
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
Subject: [PATCH net-next 3/6] net/sched: netem: fix slot delay calculation overflow
Date: Sat, 28 Mar 2026 11:26:04 -0700
Message-ID: <20260328182704.456993-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182704.456993-1-stephen@networkplumber.org>
References: <20260328182704.456993-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272799-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16EF334F9A5
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
index de22d754cb79..69c93f7ade62 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -658,9 +658,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
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


