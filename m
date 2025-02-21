Return-Path: <netdev+bounces-168602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D201A3F954
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3B5701EDF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD11F0E5C;
	Fri, 21 Feb 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTwudj4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E11F0E53;
	Fri, 21 Feb 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152659; cv=none; b=qLtBFskrEldmGVRWegt/lBO4jswJKNvdpaBC+ugXEXygMWGG2Hrz4UMGeLVauCBJx0csj1G+UIZ9MYjnwRRh1dIm+EOn0PTEsW/79jnEKulhUa0KT7rzDxvHp7iXSqqGwZzKsdtQ4/MQOZw4VW+Ou/33+X/qb9qaG+PGXnHdMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152659; c=relaxed/simple;
	bh=EsW9e6Eg0I9JNIJvlDYXbl4uPz2m/7BkgOhtt9NU6Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHq3+WcWdcPSr/fbk8KZ04sU2Mck1aaCNUzQNSLdpcctOeBNBpdHWDm84VSjpPCz55XzscNrwCttA9QwB+01+225NEzZz4asAj+V/3NMW2tto4qwnUwIk7momVz5o0eebP2d2pKyPKtyWPLdqBaMO686oo2dfcatmiqQNhLxOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTwudj4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC077C4CEE8;
	Fri, 21 Feb 2025 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152657;
	bh=EsW9e6Eg0I9JNIJvlDYXbl4uPz2m/7BkgOhtt9NU6Xc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JTwudj4oqBNhPBjgdLQYlbbUO9gqGeybyLDPIhxE8RrNDd+tBb9SCo5IruHzee/xQ
	 dfXs9Sc/Lb9xHhzYKQBn/4jT8g80HYgY4QK8OrU/bS66hpDuMy9NXUDaqorCxkQNUN
	 QHve6mJYdAoi7YBws73RP8nRdNiPWR2yY3l5I0rfvqF6lEk9l5JktyJuffw2Ukt/GT
	 1ONbNSnkCHPji8ow0GYAB/R+7d1IuAqYJjDaNNb6zfkWX5SchnHCXD0zLhMa8vvi8s
	 JaOp9vOi0LIp/1tBlYeCpLjuTcFfeCXzL/httuiu1DEzgtgdb7DSpf2WK9ZcU04sck
	 kxd561POrGijw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:43:56 +0100
Subject: [PATCH net-next 03/10] mptcp: pm: add a build check for
 userspace_pm_dump_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-3-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y2doNPKbwP4ZssZleLDCUG9nylLqdDhuJyTbstOxm8c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HxAq37NZ9S27yQFeiBPr6GAcT1KnqKezbk
 uB2A5m72g2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c7YtD/4k0leI+NarknZoKPH4L0e7WIVhkXgA9vMcQ1VMJVISVQ9gRa3jKfBYZJz2nQ+NNgFF6G1
 riLmFZiTeA6FpPSjbtcLe1FKmazyMBeyq1lPZuST+Lghfvt0CL6vzV1bSHyaACm0uXYQzYYgOm+
 LWXREfUEyVwNJu51oZwQ5/U3jypIaFYXs0tKUtV6IxFTGZhtYqjxEOvgXMBxvRBsACifYczsaal
 ua8VcE0Da+U7hDU+jKLsWWfC1f3kQjye+W8OUye6Gg0mtmEWC0GNgy1tdObMAzx5TVI3p4tc2Ok
 zdQsAb3yxAGqPQtjCzOlvgJeusxBJjEWlBpj5oCUgt9ifkO9yACFXjR8fkzt9VwPWF5pN3aWr/C
 X5FkcrBleJFZJPN/8pK1hAqGwtbwFOyDg9cvanzMGuZ5R4MvMSkyZOsUjaGLxZNhPWIxl7FBfcr
 Y1T1DRx9H/dseCYdag6lu3gu64Hhw/lybTqmVsU/d9oOAAYM0iDntWxIeX+XBCsDd93M923BMvH
 NnaMiFmAMshNwNq/ouGt6ZVJ8TyUaH1/G0kqmtmvYyWBl1gIgMCw71Dg4u1AtJdntRkQO8rIZJ7
 NLDHM7ZepS34LMgxk9Ot4tROaB6o7I2rnbFxBpXHp2hWpY9xZKWxzCZK6nSXV0ID5sBzBIr5ok6
 +cEFZYIt9dhPrsg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a build check for mptcp_userspace_pm_dump_addr() to make
sure there is enough space in 'cb->ctx' to store an address id bitmap.

Just in case info stored in 'cb->ctx' are increased later.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 277cf092a87042a85623470237a8ef24d29e65e6..b69fb5b18130cb3abd08e3ef47004f599895486a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -643,6 +643,8 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct sock *sk;
 	void *hdr;
 
+	BUILD_BUG_ON(sizeof(struct id_bitmap) > sizeof(cb->ctx));
+
 	bitmap = (struct id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);

-- 
2.47.1


