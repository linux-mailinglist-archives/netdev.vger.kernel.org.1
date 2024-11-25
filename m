Return-Path: <netdev+bounces-147208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F27A9D839A
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9191661EB
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8095D192B99;
	Mon, 25 Nov 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="E5uuCsWL"
X-Original-To: netdev@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F704194C6E;
	Mon, 25 Nov 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531238; cv=none; b=CHOUp58Z6SL6sRWBkBID6H8Rp//x2DBVWD8Ef2wQ3y7WL0h/C7UUcQgXRqhtYDwiX6K+wHt2T1XZSPAzrDGD2bAqTtiZW6+2kvBp71xUkkHS8gKBt59AQQeGcLxBfIZnuLDTXKLI0PkTo+7NVelloDJt7ROP+k3iq4CAc6TOmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531238; c=relaxed/simple;
	bh=cO1yPL6/mL7nkUA25VaU+cKW9bIPnwazWGqCpFKgihI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjuYjhxY4XmeTo8jcP2AgS5YuxNxHOWJ+Dug0xqI3Urd1wxQY5d8dWh+azmJG5M7/uobr0H2wHTY4syDGArp9pQyqTP7oYxbuaob93cgx5oKDza3fFHG66v3lGotOX3BbNt5HZ48R48kKSqP6VhCt1TFk5KGx4xSOQCGRlaoBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=E5uuCsWL; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531232;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wVOSUhPMHDDdyWhZb1LxKVvZ0vAeRZe7OwxlJZ3FIg=;
	b=E5uuCsWLjd+f5UuRf0P4XipqTBXRFNmMzjfboQYwQD7a/vLFsAnUw1bZ56W3QjCp1wdjVM
	OQqtKYGM/yAjFf3k+3k1jtPdsniFUNb11UryVGQwNUTop3xUf7ZVrtrQIjGWtilvfkdwKr
	f5CG7nKKLyLEXJFWK+BEEtF1j1ADNYhVn9diBKye0NPtrUUqKFn0jTJ5XhnaMFybt60XFV
	uhN5+nVRzW98zFouj+AP1ej6JEOdLWJAVW5VkO4tgX3YPw80iAP6cfcRI6i4Iann0ici2p
	95U/wJpEbE+4mWtxePvaBHXM6KM6ysgwRRr0AE5h1TyAgH1Xmd3ufqAcedwbtQ==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 07/11] ipv4: reorder capability check last
Date: Mon, 25 Nov 2024 11:39:59 +0100
Message-ID: <20241125104011.36552-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
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
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..bd3d7a3d6655 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3406,8 +3406,8 @@ EXPORT_SYMBOL(tcp_disconnect);
 
 static inline bool tcp_can_repair_sock(const struct sock *sk)
 {
-	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
-		(sk->sk_state != TCP_LISTEN);
+	return (sk->sk_state != TCP_LISTEN) &&
+	       sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 }
 
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
-- 
2.45.2


