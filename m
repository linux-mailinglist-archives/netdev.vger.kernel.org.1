Return-Path: <netdev+bounces-171025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF6AA4B2E6
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 17:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5A31882A93
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C31EC006;
	Sun,  2 Mar 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dUvVRk5r"
X-Original-To: netdev@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8E1EB9F6;
	Sun,  2 Mar 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931638; cv=none; b=cr9u2nylqGOOlxyWYCwRiYMYRNSSJj3T3H+Nt1Do8GhsJ/41ifHx10jZYRpW+GNPAY9GMFaunjt3pjT0lOF2iqL+Gl/TqvHrJ9Vr3/ViVJg7BUm4q2fdb/oSJTrWXy442pVyCQ2aGWx2SEnCCVQ4fke/HtvHcZaDNUWFzQy5Zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931638; c=relaxed/simple;
	bh=gFOJT0wB0FSlXbGcMSMgBV5jMo2IV+QAp/xG5QWZs4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbdbeIxogxkQXNurYv/GiDvzcGkoDWOX16Q1Ez2ehDEOx+9oioayRrrYyeoSOQOp+WnkzpEfN7YNqhiBWWT5ZNr/j2SPP6CDtNdFKioQKBH73QSjbnEGaP458Ye5xN9xRBERK22rgBWzLBrI+Bk4ELsOX4lVxydnQY8ur/JwXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dUvVRk5r; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931632;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci2qYk+Y1xa6/y45CJ+sIl/Sp1TENvs4r3jA8ONoz3c=;
	b=dUvVRk5rsMES5GBkWhhKkXaw+xPN53mb+fYciIN3XGf5bDpEl7+9mczP3DBrL1InukvxKK
	b0dTreVkc3Zxdv3jDxO5zcTH1n9l8R9sY5BXlcHTtL8khofEs3ILoWQMspSNMue63EzBYU
	+YwZiQJDnQ+1PVyao3dSz3wGNpQEGWeTOgQcaAP1oVgJcWFaFgGeQO1jXp4uy79BtzcCuu
	6U7B98CQ1jWs+w8FVp+HATHqVbw91duaAg8CJoUC8yHNZfQi5bJ30eFRU3jYSb299OwaC6
	Um4+yVux8blZva5BIDm9YuDZQt9EsTVae9ZKAG2GSDJZptbEionJH8VsaJnOeg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 08/11] ipv4: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:44 +0100
Message-ID: <20250302160657.127253-7-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 57df7c1d2faa..9828bc5712b7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3419,8 +3419,8 @@ EXPORT_SYMBOL(tcp_disconnect);
 
 static inline bool tcp_can_repair_sock(const struct sock *sk)
 {
-	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
-		(sk->sk_state != TCP_LISTEN);
+	return (sk->sk_state != TCP_LISTEN) &&
+	       sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 }
 
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
-- 
2.47.2


