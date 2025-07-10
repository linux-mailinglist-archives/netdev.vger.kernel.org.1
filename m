Return-Path: <netdev+bounces-205633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5CAAFF714
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765C71887DCD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEA541AAC;
	Thu, 10 Jul 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyGsGyb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1013208
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115788; cv=none; b=OvmIzclLhMAThd/ulwqfirWyuGNcrKQ6Cu94J+xdpmGvjtT5MwEfWI91RB4cRWHhkZaiB5KryCK/1mBYiTdOeQuAH3mIkBn+VD7IL1MHXJCWeqHETKvneMJk2qBllwC5oEglBxxK7aP8axAlxHb1+nrZ+tuSxzFlnz+KUZkEjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115788; c=relaxed/simple;
	bh=zqwdFVyklO7A+Y/CxRG9iDj71a/B0BIIXZdgMbxZUIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JOyWKmPnzx22n4cwSEuAA3qcSdiK4cLNIk5vkqHfaae9dxtbvZIWJHB3nthNL64ROgqLiRhHOUBmNV6mlpvy3t4L50ZN1DkejeOgXl82vpc2wDdVrb+IUcGYWX9OMcT6mL0Avbm/7ifp6u7I9TtEN5f0oGhBdUsRiK76HwG2D44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyGsGyb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6C6C4CEEF;
	Thu, 10 Jul 2025 02:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115787;
	bh=zqwdFVyklO7A+Y/CxRG9iDj71a/B0BIIXZdgMbxZUIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JyGsGyb29GiEIMB3C/S4UDl2/h3bbSTX7F/nu+cq3NJt8P/ZIKyATSLqO7ZReAtxb
	 2WbpCH+DlFhmM7c2weOUXZ29k0KUOnvvyatUbwITIFXJZhhMXIDAxGX5eD1PVu3LQt
	 gQfZzGnF7mr+ZxgdctFZv6tSUB8aqh3X0jXYeLTk/s3m6AJO4RCTF0kY1AnPHU6Y70
	 S9wXj0VH+2vFt4IOwVfufckFtF/2IelNEY8Ywhqi5A3meoAfuZGeHJBl9KZpjl8pil
	 xw+KPipYuRvyoXrLt1lZfgONl2Ml/xxEGhivjIoISk0LVJ3USAb3hDTrHd6tH5LMf+
	 RnZ1O0r8MSjpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34097383B261;
	Thu, 10 Jul 2025 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] tcp: better memory control for not-yet-accepted
 sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211580989.967127.6755941966699309987.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:50:09 +0000
References: <20250707213900.1543248-1-edumazet@google.com>
In-Reply-To: <20250707213900.1543248-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 21:38:58 +0000 you wrote:
> Address a possible OOM condition caused by a recent change.
> 
> Add a new packetdrill test checking the expected behavior.
> 
> Eric Dumazet (2):
>   tcp: refine sk_rcvbuf increase for ooo packets
>   selftests/net: packetdrill: add tcp_ooo-before-and-after-accept.pkt
> 
> [...]

Here is the summary with links:
  - [net,1/2] tcp: refine sk_rcvbuf increase for ooo packets
    https://git.kernel.org/netdev/net/c/1a03edeb84e6
  - [net,2/2] selftests/net: packetdrill: add tcp_ooo-before-and-after-accept.pkt
    https://git.kernel.org/netdev/net/c/b939c074efc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



