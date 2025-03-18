Return-Path: <netdev+bounces-175686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E24A67205
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C343019A572D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8A320969B;
	Tue, 18 Mar 2025 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0iw2/mn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8095209692;
	Tue, 18 Mar 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295597; cv=none; b=RKQ5eEbKEquTiT5MvMNC7DJ6370oznU8IETL3kZmYbkPxuoTIJLhXXGTKcTYRiMKgDd7uQZgWgsbMIh5iwbKs8zi30sRYi6xlcglbDcm5EUtNHesNs3/QCaWvt3gZgGGYANwgnEYIe797BAMa0+v9glYkjNgnyL5TNvR3Teq538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295597; c=relaxed/simple;
	bh=MeKQa9xnUmCm2pC1tiMZl/r5ZF1OOAcA2J4UFNSacu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NKfYlir95CVuHv5/lUUHYOZccrCabZ9en5kg5StikwFTdfQ6yikMmo68im1ELSjJHko6pAXSfB76HTE8yF9sOWZ4zek8FSHAgFWhXOGMW7S5bRImOxqalWrnHnb47LgGxj1wj+VFI8wY+Ndppjf4ybawIUUjoKAwhQUPhALg2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0iw2/mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7ECC4CEEE;
	Tue, 18 Mar 2025 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742295597;
	bh=MeKQa9xnUmCm2pC1tiMZl/r5ZF1OOAcA2J4UFNSacu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I0iw2/mnNmaiY9UxRrdx/j/AUSLCNx657uVPjxGjSuOd+ifhlXVIKCNwULSYB8OC9
	 b90uBOUetnIP1cshelJwU6Syp68CkO1YFcZnxPkUT/H7XdVF9wLWfKp+weiznRDYex
	 fU7BvHCPt5dMcFcw4IisW3z1eep3n1SCRnPr31fLIPNG5tdnShk3m1Kj/JOF7VEVeP
	 ZZXummXjvtLaTPflXfVSLQ7AZvBq6kGvwqHl1Fky9jDLZTc4dhmIGLbD6gORg/Itb1
	 JPyKshJICpgic0R930MSj1FNVMsa7qjj3PDOriEmQXlipSffJZzvlAVzXt2LW4Mu0z
	 iiMCNqtvP8JFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD37380DBE8;
	Tue, 18 Mar 2025 11:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ipv6: fix TCP GSO segmentation with NAT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229563276.4127989.1515899663358533031.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 11:00:32 +0000
References: <20250311212530.91519-1-nbd@nbd.name>
In-Reply-To: <20250311212530.91519-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@amazon.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 22:25:30 +0100 you wrote:
> When updating the source/destination address, the TCP/UDP checksum needs to
> be updated as well.
> 
> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> v2: move code to make it similar to __tcpv4_gso_segment_list_csum
> v3: fix uninitialized variable
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ipv6: fix TCP GSO segmentation with NAT
    https://git.kernel.org/netdev/net/c/daa624d3c2dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



