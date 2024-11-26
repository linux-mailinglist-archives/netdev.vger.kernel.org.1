Return-Path: <netdev+bounces-147410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45B9D9708
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3745285EEB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307081CEEB6;
	Tue, 26 Nov 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIoeXiWg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2C1CEE97
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623020; cv=none; b=J0HN87JmdUurxe5W9Dg488o/jcsQAwRPIc1mclG5qaq2zzPQ+syvawbiQyJJeN5CMfocjdILYnR9qNGfPu2MBPEn6IZVINcIh0LekG9zKvmrCiWIUiDRWtpkJeSOcre/dVs06FtpFuN9slL5q6dVvwKgxex+JXvIRe4GokaQmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623020; c=relaxed/simple;
	bh=2Pwp99beLOWovy2YFDWX9HzPD5KZ/9fCyXPjcmpr8qY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CLv/+3Y4IsYZf+Jo1YSOusYL783qHdyf5fbKLgCCYlHGIDKU+QAx6lGvYV6/p04tjho3275BlbOOz7zOwQpRRtAoHB4fv8pyttLTSiqR26/ZUnB8fmL/1gM5UaPL+LHZ0hTUxwgrAZ/Q5r5uwj0gMbj20ZlgrzXnTJBBJAmWHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIoeXiWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2804C4CED0;
	Tue, 26 Nov 2024 12:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732623017;
	bh=2Pwp99beLOWovy2YFDWX9HzPD5KZ/9fCyXPjcmpr8qY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IIoeXiWg+tPXgUWM0TcEIToiwtDbmkBKKrgtVrjiOA6LO5UhjhcF4uIXAjVPh0cUq
	 dh/ZLSNrHYa4S40BxZJJ0LPR7fI+2tAldp3Exn7g1siYDeg5mbO6M9NPzbjk4D9GES
	 B2YYxjtg00AokObRfiYNxkD+GXc5KYIckdr9jnY5FLSpVEdQ/Mcoqa0k7sM8y+1GF/
	 spBPZqSMOSF3NJ3DNGZGlM1ze+prpasZnprPsH20h4erItsq/PrOmrhW/ti71zG/tY
	 KldFKmTIrWaydjoz5P34rSnOrr8qcUjX8vSGgC3TYnL2nQi+6cCM09fC8vU3vv+ZgY
	 omAGE2ERTLQXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF3E3809A00;
	Tue, 26 Nov 2024 12:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: fix hsr_init_sk() vs network/transport headers.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173262303050.368132.9382180929301338672.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 12:10:30 +0000
References: <20241122171343.897551-1-edumazet@google.com>
In-Reply-To: <20241122171343.897551-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, george.mccollister@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Nov 2024 17:13:43 +0000 you wrote:
> Following sequence in hsr_init_sk() is invalid :
> 
>     skb_reset_mac_header(skb);
>     skb_reset_mac_len(skb);
>     skb_reset_network_header(skb);
>     skb_reset_transport_header(skb);
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: fix hsr_init_sk() vs network/transport headers.
    https://git.kernel.org/netdev/net/c/9cfb5e7f0ded

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



