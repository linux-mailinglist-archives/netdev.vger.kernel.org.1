Return-Path: <netdev+bounces-222881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF01B56C20
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316EC3B41A5
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1221E0BA;
	Sun, 14 Sep 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRRfGGCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B84A3C
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881205; cv=none; b=SRHOguMd+WyUilIIi2Gm4FQoJHCAhMcIv6/w4kLCvvcF3C9a69LKXdWmjI157U2gEd06JItKNYVdMOlOq8GdQVnUqJE9FV/3J9dO8XmwFc08mPqlAUrBmALie/jnkqW+L8JbD2Da5I1k6KXUr+dMSyRduW8yeaXfPB3N1Huhf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881205; c=relaxed/simple;
	bh=IYhLqLHW05XJx6mMbCI7n2Mg8CF+oz+vktcuKMXe9Rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ks3dZggfIR9364pMJbgbfVHSALkFs6lMh4rrDS5f0eDvvQdpBvQA1svyaDQeXcl6GoLsgtvG+WtMgNs3OxEX+isffaE3vPXOAMnVZhrbcOZ3lDFDlxKEGAqzspNcnwIwsVtPvd48yyUOS2W/cifNNotDM/v/+Ly73KvkjeVo9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRRfGGCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E20C4CEF0;
	Sun, 14 Sep 2025 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881205;
	bh=IYhLqLHW05XJx6mMbCI7n2Mg8CF+oz+vktcuKMXe9Rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fRRfGGCnPS01xNp79dABPVZPq9ACAiOcQ1K4nmA6JZ+2vpKHjVW3BjY2g4bGlofaE
	 BvNkwmskrExPPMa/x/5bgi3/u3yS3aFpesvOVPYPxEl2bmciEr0k3RNzs+IMJsEIa6
	 LXosynwPS1YpBol+Rj5oKAnzKg3w1JKCwxkphkB2hACG1jz1yxlm/fJLGap6jQms5X
	 LlMH4xDjbHbWrFaRwVVVFbStyREsh+dR/SoDN6c12uFyWsTBQtnenBkhFB+oRFmQsy
	 L3TmVldrMrVhLzz8F//g6mzi8PEaUfCnOHzF+q0VrbNylh671ICgPHYMlB+rqnwv4m
	 DFtV7sIyOOFrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FB339B167D;
	Sun, 14 Sep 2025 20:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeon_ep: Validate the VF ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788120699.3542932.13056520453321329364.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:20:06 +0000
References: <20250911223610.1803144-1-kheib@redhat.com>
In-Reply-To: <20250911223610.1803144-1-kheib@redhat.com>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, vburru@marvell.com, sedara@marvell.com,
 srasheed@marvell.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, michal.swiatkowski@linux.intel.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 18:36:10 -0400 you wrote:
> Add a helper to validate the VF ID and use it in the VF ndo ops to
> prevent accessing out-of-range entries.
> 
> Without this check, users can run commands such as:
> 
>  # ip link show dev enp135s0
>  2: enp135s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:01:01:00 brd ff:ff:ff:ff:ff:ff
>     vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
>     vf 1     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
>  # ip link set dev enp135s0 vf 4 mac 00:00:00:00:00:14
>  # echo $?
>  0
> 
> [...]

Here is the summary with links:
  - [net,v3] octeon_ep: Validate the VF ID
    https://git.kernel.org/netdev/net/c/af82e857df5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



