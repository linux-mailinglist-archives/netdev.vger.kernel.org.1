Return-Path: <netdev+bounces-242480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C02C909EB
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B83C3A8D75
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF718286D7D;
	Fri, 28 Nov 2025 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpN6Gpa9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47782868A2;
	Fri, 28 Nov 2025 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296607; cv=none; b=tE0JmgdWwFJ4B9eY3KFjCOjOMxh7IzG/RrUiFW0bvqj08BrTDW3A39iCTBENRweV3qQKyyKDoIYA94hl/RKgfZM1VzpyACgcN8sMNT2S/xPzNeZ7apfUe0IflFE12sp1p5ldDboWMuF03zAnZrf0jPO0LBDeXNs9goz6lMsqg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296607; c=relaxed/simple;
	bh=sIEhYCgNivDWDCd6xPbHTxW/TV8/fKsRCPInRtMQjNk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hSWRT3naTcq5PGKnRbB3jQpem61VQHqyfrUuts75sLkl0XyTbrRuE5UF5e7ApHbOV4062+Esv3xorTJ9VGyVCSNqObV8nQyBmqADTN76U/gRTZUPqvATtv4kY45BAtycW+mlRaOQ3fboZsNDA9jvCZS+BdC29kF60j2dZcH4kSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpN6Gpa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7CC16AAE;
	Fri, 28 Nov 2025 02:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296607;
	bh=sIEhYCgNivDWDCd6xPbHTxW/TV8/fKsRCPInRtMQjNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XpN6Gpa9XLCEL50QQ99MAciulyeRSJkJnr5LbvQQjZgk/K9roFVDEGss9e485TvJv
	 WINW1JiTtq56JKSmJiulTEMPhNcu6qNsfTscxgQdBjc9ZXBUPBg6pcfDwmOU5IJvv/
	 el1mGVlOqXZe2wSxbhbzzO/5up/KuNB4oVYbArFly99gWA+A9A+n2/cK/NaijpiB9F
	 m1CePe6YupRqPxFsKrfVIjOre4GYQr0S42ze5u0yCo3WODTe4IPj9EJcJSG/cqrx9o
	 9Zved4/xRdFpnXIhEpjzCUIpVw6KokNHRXMssIJNj9kQRuOAXM74awyIRZmX0xh/nO
	 F5PM+uBOR001Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29193808204;
	Fri, 28 Nov 2025 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netmem, devmem,
 tcp: access pp fields through @desc in net_iov
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429642952.114872.9731749260937365998.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:29 +0000
References: <20251126043646.75869-1-byungchul@sk.com>
In-Reply-To: <20251126043646.75869-1-byungchul@sk.com>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, toke@redhat.com,
 kuba@kernel.org, asml.silence@gmail.com, almasrymina@google.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, sdf@fomichev.me, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com, shivajikant@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 13:36:46 +0900 you wrote:
> Convert all the legacy code directly accessing the pp fields in net_iov
> to access them through @desc in net_iov.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
> Changes from v1:
> 	1. Drop 1/3 since it already has been worked in io-uring tree.
> 	2. Drop 3/3 since it requires the io-uring change to be merged.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netmem, devmem, tcp: access pp fields through @desc in net_iov
    https://git.kernel.org/netdev/net-next/c/df59bb5b9af3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



