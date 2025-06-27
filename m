Return-Path: <netdev+bounces-202076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527ADAEC2D0
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21907B6C1F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96321A454;
	Fri, 27 Jun 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri9yqV6O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3062CCA9
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064587; cv=none; b=OyQ06M3ITGvtelvOF0KNQWCzW1Ib3jMhRUOY5MguDyN3DnVH+MX7AlIVXIu18nRb88H0Ugo23RWDEuNTw1r+a9D1YyemZj7cFQybhCAPJIIQGv/JBHjBLHa7gayhrwYDMVCLdenSNVCJ5mgFLw2nzd/ZuFOW5s2oAmC7SpyW5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064587; c=relaxed/simple;
	bh=3+2pW+3TtF/S5QXuWfBYCoPE76WL08sW67zFinWHqAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HlPQM1Aru6Sv39YoYESxZnjwrYmGOMvItVI/XyzkkptACLcQzRpxxvvl5brgJPObdJpVUy21+zAQXpNvJDr/sRMnKLIH+JaGuDqDvr5wWIwfSZKv6FSgvBU/b604T+DKVddI4F98RCDKaUGDaYaHuDYEDl+7jLBhDi4cLRpEfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri9yqV6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A64EC4CEE3;
	Fri, 27 Jun 2025 22:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751064587;
	bh=3+2pW+3TtF/S5QXuWfBYCoPE76WL08sW67zFinWHqAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ri9yqV6Obd7m63BIX1yBFqqNa3Ftt8QYw45sPVLqdcfriweBqBlcwYd1tQjw8XIsd
	 7GuPR1+woWqt9rI2w/g+oMibNJXO/pvf2pm3ml2GW2Ry60UgUhxZcbcOo6lcAlxoGW
	 4ntF9koA1r0uOAug7TFtQBN1xKslBXN0bIuhyhV7j7khC9un3hvba5eP2elKFyhKGX
	 q9COosIdh2GVGf/PFZkcS8UcwopSxHjbwXMGKb9jRapaRNxyjQf12z67IdnIbQPIZR
	 CEMkrNRF9eKwxuCCqc9awXAk8SwXx3G3VlmcLVxV3Q9zgv3+Cb6r1NdBYbWEfMFXqy
	 x++G6geToI6VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C1F38111CE;
	Fri, 27 Jun 2025 22:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: remove rtx_syn_ack and
 inet_rtx_syn_ack()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106461325.2081565.15667874491898865128.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:50:13 +0000
References: <20250626153017.2156274-1-edumazet@google.com>
In-Reply-To: <20250626153017.2156274-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 15:30:15 +0000 you wrote:
> After DCCP removal, we can cleanup SYNACK retransmits a bit.
> 
> Eric Dumazet (2):
>   tcp: remove rtx_syn_ack field
>   tcp: remove inet_rtx_syn_ack()
> 
>  include/net/request_sock.h      |  4 ----
>  net/ipv4/inet_connection_sock.c | 11 +----------
>  net/ipv4/tcp_ipv4.c             |  1 -
>  net/ipv4/tcp_minisocks.c        |  2 +-
>  net/ipv4/tcp_output.c           |  1 +
>  net/ipv4/tcp_timer.c            |  2 +-
>  net/ipv6/tcp_ipv6.c             |  1 -
>  7 files changed, 4 insertions(+), 18 deletions(-)

Here is the summary with links:
  - [net-next,1/2] tcp: remove rtx_syn_ack field
    https://git.kernel.org/netdev/net-next/c/8d68411a1287
  - [net-next,2/2] tcp: remove inet_rtx_syn_ack()
    https://git.kernel.org/netdev/net-next/c/cf56a9820297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



