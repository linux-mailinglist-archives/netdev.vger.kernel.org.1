Return-Path: <netdev+bounces-154867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC935A002A8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FACF3A2CE7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1EE14A08E;
	Fri,  3 Jan 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwgzKJBS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774414901B
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735870813; cv=none; b=bhElva4yCUEgqOADVGkUW0mq62c5dvyCqpgDtNb/I8kVgjC15tXpVicSPzCfqkJCN4nNOxwvPUHOu9QxsQhs1nvOGMv0B/4p7S1F9oCOllEjvtaJmLQj4ZRZvorTCkcROxOVRpOMWT//cBMbdV0k/TuUf1Mc6JcEVC2djp0GC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735870813; c=relaxed/simple;
	bh=1mhPv95K+7KcxUH1gb2FyZEupFCY3W+l1nFTix5hOAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iQZT29xds5Hk5Bmda+0pcrTQTuYmFiQ6318A0lL2A/NXNREtRyCgu9ZM2cEHG+y8eLH48y8Mc3G9yXNCvymQ8/wZH1LQ/IHvW7zooqCZuqCoOHBI1d/ZWukwAWtIUO3umh22V2hwtsdjYpmNFvgVzkrztvSi7ZUJc27Vu89uLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwgzKJBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9F3C4CED0;
	Fri,  3 Jan 2025 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735870812;
	bh=1mhPv95K+7KcxUH1gb2FyZEupFCY3W+l1nFTix5hOAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QwgzKJBSDWnaeArBxspyJfLfn9/KsG9YSrYPOjUR12DONwa2psqMt/oXs3Ke57MBP
	 EIiDgU3+0KYyGT1sO7iUH2PGRqv2BadrfUbtCkM6+VCLz6BoMhxneouGeh3UOoSFm1
	 Wvp0B/Zubo0SPkofL+qrvD0o/tvhSaBABe+1hFAVm374NuNZj/+6LKZfdGs+MpwY5M
	 saY73e2+RemmsIumSmoZUT9tSFuqz5zU+KO5umF8ApqiXwf1iQdLeOTO1ZvlgApLpC
	 n/p1BWWENC8b+8SYpg6MtPON+oI3XgSCa7Sg3JfdDVCcAmkfbgXO1ve+fPKBEt1/7Z
	 HJjTmyWCRmDMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E34380A964;
	Fri,  3 Jan 2025 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587083301.2085646.12235810630024319748.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:20:33 +0000
References: <20250101164909.1331680-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250101164909.1331680-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, benoit.monin@gmx.fr,
 willemb@google.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Jan 2025 11:47:40 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The blamed commit disabled hardware offoad of IPv6 packets with
> extension headers on devices that advertise NETIF_F_IPV6_CSUM,
> based on the definition of that feature in skbuff.h:
> 
>  *   * - %NETIF_F_IPV6_CSUM
>  *     - Driver (device) is only able to checksum plain
>  *       TCP or UDP packets over IPv6. These are specifically
>  *       unencapsulated packets of the form IPv6|TCP or
>  *       IPv6|UDP where the Next Header field in the IPv6
>  *       header is either TCP or UDP. IPv6 extension headers
>  *       are not supported with this feature. This feature
>  *       cannot be set in features for a device with
>  *       NETIF_F_HW_CSUM also set. This feature is being
>  *       DEPRECATED (see below).
> 
> [...]

Here is the summary with links:
  - [net] net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets
    https://git.kernel.org/netdev/net/c/68e068cabd2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



