Return-Path: <netdev+bounces-177471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F8A70474
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9401666AE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78928149C41;
	Tue, 25 Mar 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5Hgh+o7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8B25BADE
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914808; cv=none; b=ksArt7DDFiSefyUnQ9BueLfq/LhT4gMed3aUGPJ9YNBP4SX+j804jlT2Sq9AwGGcxsVSSMC0qarELUIrilPbNYK8JNhBVlL52lZPIUMrNPRtFs9vjAvbQuvGsNYFjV1P0GJpRGX5VHU4EdEl5dsFLAS+3wj+mNwbM4aglH5Tpv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914808; c=relaxed/simple;
	bh=OepfbIP297mJ48euTBqGHNPelDrLiJ3GR+pfwH+1O/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bmFgpZvmq7d3DjB5T+n072gTWt5hK6Q8+7m0TVzukrFKcctk1QfPHFQJxe1qTLh3nFHxz2jznYf9oR9ivTsPVe018qCjYM8yzRIsMcn6Ds+VzAubT9Fhvaw8dLII2448zdH1P9y9HP7NvHWcmB3dbUmszRTqO/J3RSdvpY7eR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5Hgh+o7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3226DC4CEED;
	Tue, 25 Mar 2025 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914808;
	bh=OepfbIP297mJ48euTBqGHNPelDrLiJ3GR+pfwH+1O/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p5Hgh+o7nEYvkQW2EczHlvta3w+oKlb4dkQz8D2kaHawh6KWCwmIVVCkY2ufcGET8
	 /skvGh4RB+EMLjnwMmh4lo8ASm+/QADn/iUfS0uC2heznbCri5EQkpIjV3rNhURptW
	 bmYTJ+psfIzBJbrRz4QtWS3mnK4sa1cUZjOnBIY8sMqJWxvWL8a+j0AElLlqTFkMVG
	 eRTXO2oYA6GuJr/nFB04uX7YW0oy5a/Sp/JgRbHBHepFO6rTtfog/wDnzQYIdGnH61
	 93H7/do+m8obvc5+CZxB7J5BAV3L+sKpulDiQGECu9D3LV9f5zFBxqoAfYzk/APtrh
	 mrvN2EujBfVMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3A380CFE7;
	Tue, 25 Mar 2025 15:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: fix _DEVADD() and _DEVUPD() macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291484425.606159.5986140541046582972.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:00:44 +0000
References: <20250319212516.2385451-1-edumazet@google.com>
In-Reply-To: <20250319212516.2385451-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 21:25:16 +0000 you wrote:
> ip6_rcv_core() is using:
> 
> 	__IP6_ADD_STATS(net, idev,
> 			IPSTATS_MIB_NOECTPKTS +
> 				(ipv6_get_dsfield(hdr) & INET_ECN_MASK),
> 			max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: fix _DEVADD() and _DEVUPD() macros
    https://git.kernel.org/netdev/net-next/c/b709857ecbf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



