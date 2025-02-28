Return-Path: <netdev+bounces-170495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74562A48DF5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A523A79BB
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E111C13D62B;
	Fri, 28 Feb 2025 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyuvtjOt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DE13213E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706122; cv=none; b=kREgIpszMRgIvhxuK62V1MwGoWg5g2XE2GqGe2oTWVwlCIWIHXbeuqwQgcFPCLPhHpfQlFTUJVp6GbvdNa1qUkb5stUMHMcqembbewE4o+Z52TjEX7OKTQpZ2EjkAhtlCE/JLgghP5VqxJVyUUbJVToUzo+hFI2jcgoMt8u8vgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706122; c=relaxed/simple;
	bh=ySqNFrN7W0kPba9Wmk/Duuo2HQyeqPRFv6LMY5/cArE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I5kp3A6Iir2jamVieb62tcjvrk3aKGfhq6sTOQDs7VDgLUlTsZpDnEKd08DdOrhEaW8ZxG2/70Tw6rTGoxbhgqSg+r9TpUBtREHhEsr9VU1NV0c9Z/neZ1iojEL7E91k9yBxngF7W1dzO/OQr//c48a1Rk8QyNzbqXABqJtrCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyuvtjOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B74C4CEDD;
	Fri, 28 Feb 2025 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740706122;
	bh=ySqNFrN7W0kPba9Wmk/Duuo2HQyeqPRFv6LMY5/cArE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CyuvtjOtRfktqcIcLr/XfXgx8iVWoO6hs5+BkVT60RqZW/iqnJa47wZ+NuCG1cnn5
	 PBVUydBTYfzEPvTE1K/fUd0GlYric59DqLL8jfHVBDbYbSyPB6CeoZBgF9nNNjd5eb
	 gK690gJwhIapyBd3xuRWmp68K0LTPgwLKBUWsFO8edTcNV0TNGlzh+69ITLGxuSfCv
	 GJ04bDC4yBa7IWErk5RfuBRwW44k2K4LT9i8xkIOsuKzY5L4kuUSRSwKZ1xywN28RG
	 IaUhm4OUnN+/EWtPJVj0Sh+lp+TkbGbVwfYALx52OEvMq7CtvFkGa6EIjBDgu6S635
	 5KPyK4Lp9Yg8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA2380AACB;
	Fri, 28 Feb 2025 01:29:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] geneve: Allow users to specify source port
 range
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174070615474.1621364.16941794449284060101.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 01:29:14 +0000
References: <20250226182030.89440-1-daniel@iogearbox.net>
In-Reply-To: <20250226182030.89440-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 19:20:29 +0100 you wrote:
> Recently, in case of Cilium, we run into users on Azure who require to use
> tunneling for east/west traffic due to hitting IPAM API limits for Kubernetes
> Pods if they would have gone with publicly routable IPs for Pods. In case
> of tunneling, Cilium supports the option of vxlan or geneve. In order to
> RSS spread flows among remote CPUs both derive a source port hash via
> udp_flow_src_port() which takes the inner packet's skb->hash into account.
> For clusters with many nodes, this can then hit a new limitation [0]: Today,
> the Azure networking stack supports 1M total flows (500k inbound and 500k
> outbound) for a VM. [...] Once this limit is hit, other connections are
> dropped. [...] Each flow is distinguished by a 5-tuple (protocol, local IP
> address, remote IP address, local port, and remote port) information. [...]
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] geneve: Allow users to specify source port range
    https://git.kernel.org/netdev/net-next/c/e1f95b1992b8
  - [net-next,v2,2/2] geneve, specs: Add port range to rt_link specification
    https://git.kernel.org/netdev/net-next/c/5a41a00cd5d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



