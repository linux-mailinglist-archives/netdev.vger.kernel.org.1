Return-Path: <netdev+bounces-297040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XXsjLn4HKGpj7gIAu9opvQ
	(envelope-from <netdev+bounces-297040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D254660118
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:30:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=U+J6Tjvy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297040-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297040-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBD173033AEF
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58CD38B7BD;
	Tue,  9 Jun 2026 12:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2A4183A2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 12:26:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008016; cv=none; b=lFcoEtKq0sSwnaa6sCrHMwDrC8nBzOWLUjnRndmC4/djOet8S5NTN3scW5wWWUKBA5QktQ1L80TjHCpH5yQH+IPjgyAWPaM9yNXZfnpWKcvWsRW4BPGQQQYu33jDJq/CfH/otv5WvSUkc8+ZPoeGt/cR5fxkKHiHvcSfrwvj4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008016; c=relaxed/simple;
	bh=VFoF5DQlSbS5V+oNvEguNMpshhkJmMJvM/OjwwToQxk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PodwJnNGduR/aqrxToXWZ6+x2Xar/P3sLzgC2XWKVgquV2Sy3e/8+t2//zDVtPhaOcpu1mt06kA0PP1UuxFI0QBv0AfS2YcJgW/3KYwTjlhNQ4y6m7XyQTRZv3sQ4KrvoMrIlrwxB0CRp1KtGNbqP/MVnmAgTyIHiy47V7dwg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+J6Tjvy; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso6021365b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781008011; x=1781612811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nh4uo1ID0r54L4hLgT4uJy+Sb68L6GnZjfZbUG2JV88=;
        b=U+J6TjvyHRLjZcroQY+/bM6j9hN7d0pGl3eofIl6ZDuZ93lF6HfgyfJA3J34ok1QSy
         46so9FHKLVkZlXFw22X3a9JKRzDd+yxYepgfkS4ruYru+tHDfd7jsbGFAdlhhoiPtmD0
         9oDr0/kxW5/VG1wFFF5wM45PGYce6IrU+LlV5U/yOREPaINbVoT7SRu9+rpmLQyVmU+5
         I6XlEx9X5JELDfYucbi+1+p8XJdI2ZJ0RoWGYC/9CxcGqgttPkUcbz9Tm4Agq+SR1u/O
         wG4+bHHzwZB3LCAIFBOyUiyXSu79780+MYFdKwe96pZAzw9Cd+BZzX2AtxEsGHnQkirF
         FUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008011; x=1781612811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nh4uo1ID0r54L4hLgT4uJy+Sb68L6GnZjfZbUG2JV88=;
        b=Z+ez4Rny1etdhklly6xZbUw1qt/9xyA504rg1PikovBv90Ea1V4s1gP4AHO9g/ubdN
         PuSiycWbRKLPcmH096UpNBbE7EmY6z4ds84uNJtH6DLR/CmsqjZ6Hch5eDI+clPU2JNy
         EHvBhCKuEmVxPRCY+P2rJmvQOFUHrszm3aQkQfXHfV/UQNPus9/4BSTMZgR3UdYRuAff
         B9Ec1fbP/AHe5uJBfyStEGH0ubpjlT4x82fFYNprXgmSqrTAmW/qKgkIpDocpGDOFPtq
         yIYWQYQzV9r4KmHzT/qKuPVYbMw565RxYDj4kdsI37/ENmF+qX9xda4/PDGgd2myaRry
         i6Ow==
X-Forwarded-Encrypted: i=1; AFNElJ+BKezPZh2rby4oYA8qquSpsWZ1tYJX/oNzpIS9mw1K8pGEWjmhqKwYf6NyvBlI3ykR7Pvdfh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUgHvCBh+3I2VMjxdheOAZ+7/H+D36rkRGn29c6CQBVll3EWUI
	20e5RUa8LZ8Tx286F/FlFTKoPR9RMkHaCt6LQCX3KzT9LHFG6oJ1CXjVJK38B+9L767XVgxKBJw
	vFFPyiNKCcpJNqktED3yjTLsA/A==
X-Received: from pfbeh14.prod.google.com ([2002:a05:6a00:808e:b0:82f:c134:e67c])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e07:b0:842:6419:3ed2 with SMTP id d2e1a72fcca58-842b0eecc85mr20522482b3a.33.1781008010894;
 Tue, 09 Jun 2026 05:26:50 -0700 (PDT)
Date: Tue,  9 Jun 2026 21:26:46 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609122646.2297540-1-yuyanghuang@google.com>
Subject: [PATCH net-next] ipv4: igmp: remove multicast group from hash table
 on device destruction
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297040-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D254660118

When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
the multicast list and calls ip_ma_put() on each membership, scheduling
them for RCU reclamation. However, they are not unlinked from the device's
multicast hash table (mc_hash).

Since the device remains published in dev->ip_ptr until after
ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
can still locate and access the multicast group after its refcount is
decremented. If the RCU callback runs and frees the group while a reader is
accessing it, a use-after-free occurs.

Fix this by unlinking the multicast group from mc_hash using
ip_mc_hash_remove() before scheduling it for reclamation.

Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/ipv4/igmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b6337a47c141..af38073a822d 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1923,6 +1923,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
 
 	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
 		in_dev->mc_list = i->next_rcu;
+		ip_mc_hash_remove(in_dev, i);
 		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
 		ip_mc_clear_src(i);
 		ip_ma_put(i);
-- 
2.54.0.1099.g489fc7bff1-goog


