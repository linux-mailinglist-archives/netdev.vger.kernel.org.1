Return-Path: <netdev+bounces-246283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448DCE8148
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28E9303372E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C61723A984;
	Mon, 29 Dec 2025 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ACkCnhKq"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF6246766
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037419; cv=none; b=o4Ufgib7g2JRmQG2KBgnWry8GXEUWHeckenDn6WxBTDilB6PwfDx2SVdCmPT1JFnSEr+M2HqV7b1lCOi4ND9M0rMawAWTCCh+d+kLkspPRgfd21surppmqEG4JZtl+v+IpYxjt2m2Tiw6RE7bM0RPVulBXyTKBVMCda0WuDrTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037419; c=relaxed/simple;
	bh=cJnrWkTrM9BqnF980ApPVLsFX3lGeVXOMLICrOdkQgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqltcLbHfdzsBpvrKPVvejATWjgAmEHCxWYADT1l1yjErKWZmzrTRRlAxBmCNU5KupT+pX5S6XjvOXB42IFB/XENyHC1LinKvzjt2IJS/LVW4ZJTkwzgiPjWmGKaK4HWXR7vggv0rMLjfp0fKNzN3ujmGot82leahdUYYjEEwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ACkCnhKq; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9Q-00Cgrk-Q3; Mon, 29 Dec 2025 20:43:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=LxJRcNt1H3n/G01g5/IvxN20LnKqGALHfiDAONsEvug=; b=ACkCnhKq8dcz0n5lNUmJvefVok
	7VGkCyapgxh9c7zFhhDfTFO12Bx0Lpjn2h8Jo9htkAvi9e4fFIAQ0wzCkJKsGakJJ92/Q6zBIpFQk
	BWjf506L6QpPSiysXPmyCxIOqy43CdQwwwKso8yTPFG6oaQ3tUO1Q2FFG2rgdpKPArFCKpizTy9dG
	ne07KumHj1dgi19wSkSTi8KtkL8UZRxmGow1XRVsjtKK+QlJQSeEngrJ9dfN6WxEPo84yyBtNN5Aj
	ZamwpAGwKFRMLPhnvd4SS8TCuI5U2vAK3ywmYJ6SUgJBnEa/ZwTxh3u9kUAVz6K3FgAb0OamlV0e5
	wa5U+++Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9Q-0000NL-FP; Mon, 29 Dec 2025 20:43:32 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vaJ99-0055FL-F0; Mon, 29 Dec 2025 20:43:15 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 29 Dec 2025 20:43:10 +0100
Subject: [PATCH net v2 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-vsock-child-sock-custom-sockopt-v2-1-64778d6c4f88@rbox.co>
References: <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
In-Reply-To: <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

SO_ZEROCOPY handling in vsock_connectible_setsockopt() does not get called
on accept()ed sockets due to a missing flag. Flip it.

Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7bf74..a3505a4dcee0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1787,6 +1787,10 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		} else {
 			newsock->state = SS_CONNECTED;
 			sock_graft(connected, newsock);
+
+			set_bit(SOCK_CUSTOM_SOCKOPT,
+				&connected->sk_socket->flags);
+
 			if (vsock_msgzerocopy_allow(vconnected->transport))
 				set_bit(SOCK_SUPPORT_ZC,
 					&connected->sk_socket->flags);

-- 
2.52.0


