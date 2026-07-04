Return-Path: <netdev+bounces-304727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dUF1LINiSWoZ1AAAu9opvQ
	(envelope-from <netdev+bounces-304727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D2708486
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:44:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ihGEask2;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304727-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304727-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A66E3301A519
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4D331F985;
	Sat,  4 Jul 2026 19:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC0322749
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 19:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194233; cv=none; b=WzWq+hic4gILpdEMk63G1zxou6UWqrX+2ok9Rz8hNSpESOYgE6kOYtxnu+sub7S/af9w9myCbtq3TbHVnvN0fogOR1kp//6Nwwwz+1qg/cmnLFfFNH+5F6AmoKkkOD6Fr1b8wV6RDBFVcqGIBWp42U2UC9HXBE9WxOg84oy28mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194233; c=relaxed/simple;
	bh=8qkaK9CJewoSBHJsNGqdS9I798dwSpqf9f5A6hyIKWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CW4XXbDiw+8pqu2mdLLiGwiFpeyTzZmiNUtUBOdCZqbxwjwU7S4fU5kKnrwYs2NnWWVUEpgTKveJkbMv9bTLCV1NU/EzFPySk06NQjwRKz4ZLFjOB6cNIn5QFGUl/9gK7hwOpLpLefkIzubQzNpLo/yoKXaXaHsfxRbj8+/wR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihGEask2; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8dd6a429cb6so20257946d6.2
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783194231; x=1783799031; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOkxqmtWVMJorKeOZAzUaMm6nv2RJ475cStWQHNl+sc=;
        b=ihGEask2AB681R5jpEjCBXA3Hkwv0lZg2nDJCrbKt2p+5tEksRBk62J9X6WggDG48J
         x8m4xhHqGUC4u3hh+btNqV4fXuJVJqdYotbjK8FcMfd5mZpJGGm4ZKG5pfUTt5DTiMYK
         yALgB2ISV2OIh/d4bFXsR4fRa+datO8wTN+9dW/s+XXfeNzIOjqGhzrROsTOjOrwqBvg
         szpxRPZ+goOc5bspKN5q5oeN2DMTquxXG/CJbvQPllwElDpjIRbbIb8Mk+2mJG6xCyqY
         5KmHYBpUKuXn34ZG1iGOBpiERkSHW7z9h/WIDovQTYHDhyVJcrjqMiQBPBsRXxAcmeA7
         8fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194231; x=1783799031;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOkxqmtWVMJorKeOZAzUaMm6nv2RJ475cStWQHNl+sc=;
        b=dHmXpAAYzohLlzUKvSRv67JdMJaIDqBN0heoofJqMq8rml74Dv4cPP/BL6xanRYbLz
         N5Bp8C1qCnbkfRtKrGcowmksV4yBGjg9wl6WTEXhTcnxVfMi65Qxtyg7hmle74KVb2Sa
         f/FMIoI0xcuOTT8wRlJfcmC65w+Wp1sNatTCUDeWCHy9wyo1Ca4C4KjJJffjLVxjIXrn
         0YCgoJWdvfwyRk59jJeZix4tl4HFqKU3P+ijVwNcUd25o8JImZ0MKA+3t9zT9MiA0ZVl
         vYWzOsirxWzli1JhCckyr0pNehSgsyvGMxjKc6X35Z/bwSVfWB8Dg7PECumu+/lz8CaS
         3vkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpY5AbNMKvt0t5EjlsTsEwnHWU4D8KnVpdbGAFx4kWdXekqJKSqbiMjz9kMKg+qwOwwNd1f+xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8jLBNC0ZLOXnLQX0oypFSsVujWlTEbMBHQy2ubfJdY4N0rbr
	umKG27CL6KxG3vbg9UWhGmnHPpedI+GMd1QBoL7vsDjKBCI5Jz64zNsPfKh8KSsOjDZIjZP+T2H
	aV8FqqzloLzB3Sg==
X-Received: from qvoa16.prod.google.com ([2002:a0c:e910:0:b0:8e9:229a:7b3b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:ac5:b0:8ef:b2f4:c686 with SMTP id 6a1803df08f44-8f74a9f4b37mr69358506d6.13.1783194230674;
 Sat, 04 Jul 2026 12:43:50 -0700 (PDT)
Date: Sat,  4 Jul 2026 19:43:44 +0000
In-Reply-To: <20260704194346.4065071-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260704194346.4065071-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260704194346.4065071-2-edumazet@google.com>
Subject: [PATCH net 1/3] ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:zdi-disclosures@trendmicro.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com,trendmicro.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trendmicro.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 230D2708486

A race condition exists between device teardown (inetdev_destroy) and
incoming IGMP query processing (igmp_rcv), leading to a Use-After-Free
in the IGMP timer callback.

During device destruction, inetdev_destroy() drops the primary reference
to in_device, which can drop its refcount to 0. The actual freeing of
in_device memory is deferred via RCU (using call_rcu()).

Concurrently, igmp_rcv() runs under RCU read lock and obtains the
in_device pointer. Because the memory is RCU-protected, CPU-0 can safely
dereference in_device even if its refcount has hit 0.

However, if CPU-0 calls igmp_gq_start_timer() and re-arms the timer, it
attempts to acquire a reference using in_dev_hold(). This increments the
refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
Since the in_device memory is still scheduled to be freed after the RCU
grace period (as the free callback does not check the refcount again),
the device is freed while the timer is still armed. When the timer
expires, it accesses the freed memory, causing a kernel panic.

Fix this by using refcount_inc_not_zero() (via a new helper
in_dev_hold_safe()) to prevent acquiring a reference if the device is
already being destroyed. If the refcount is 0, we do not arm the timer.

A similar issue in IPv6 MLD is fixed in a subsequent patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/inetdevice.h |  5 +++++
 net/ipv4/igmp.c            | 14 +++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index dccbeb25f70141982160c776f3cc727296def2b7..6032eea2539a60d0476d85667bda3bfcad8f1425 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -293,6 +293,11 @@ static inline void in_dev_put(struct in_device *idev)
 #define __in_dev_put(idev)  refcount_dec(&(idev)->refcnt)
 #define in_dev_hold(idev)   refcount_inc(&(idev)->refcnt)
 
+static inline bool in_dev_hold_safe(struct in_device *idev)
+{
+	return refcount_inc_not_zero(&idev->refcnt);
+}
+
 #endif /* __KERNEL__ */
 
 static __inline__ __be32 inet_make_mask(int logmask)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b6337a47c1418589bf8ef31e00fd98b6187f5271..f5f9763895641bf86bfcf9fd7fd7b06012fa4ece 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -248,16 +248,20 @@ static void igmp_gq_start_timer(struct in_device *in_dev)
 		return;
 
 	in_dev->mr_gq_running = 1;
-	if (!mod_timer(&in_dev->mr_gq_timer, exp))
-		in_dev_hold(in_dev);
+	if (in_dev_hold_safe(in_dev)) {
+		if (mod_timer(&in_dev->mr_gq_timer, exp))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 {
-	int tv = get_random_u32_below(delay);
+	if (in_dev_hold_safe(in_dev)) {
+		int tv = get_random_u32_below(delay);
 
-	if (!mod_timer(&in_dev->mr_ifc_timer, jiffies+tv+2))
-		in_dev_hold(in_dev);
+		if (mod_timer(&in_dev->mr_ifc_timer, jiffies + tv + 2))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


