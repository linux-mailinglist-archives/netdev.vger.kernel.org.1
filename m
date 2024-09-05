Return-Path: <netdev+bounces-125508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCC96D712
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CEC28742C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B788198856;
	Thu,  5 Sep 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyWfqEaO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10A19415D
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535827; cv=none; b=RL6uxZ4ZdKUUPucY3x43KwEVhqnxpQ4iSmSyr1qX9CEaSC63ujrlhP8AXn32ye9djjO5OS1TSPtdzOLDzC65YJsWE0PaNdYcTvbEtRk4be7mIn5Aj7WYk3KV+ztmdhUS0WlsGeBD1zne7GZtrF/qLj4N55bsKvNs+EH3GhH7Z0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535827; c=relaxed/simple;
	bh=eZj04L7cCW5pZNpVpQrzes+TWCv0q08iHeNSNZ9plgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OeCx1qRzNcrbuz19AVXWl4P4vT/ivnKNDj9c5VZX51ZUUrs/Umanij6ReSDNW5EPMFzCv6dkLyeK1Idh1xbTcNKPhODvMH5wIkZikp73cOdgwRrgexwGq38wYTjebU2pBCArnnRRya/lyZ6uU43XdhHbhT5AriifH8/mV4Bla/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyWfqEaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9ECC4CEC3;
	Thu,  5 Sep 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535827;
	bh=eZj04L7cCW5pZNpVpQrzes+TWCv0q08iHeNSNZ9plgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nyWfqEaOhStlu/znIWuXhxtG2JvL33jV6f3IqM+P7p4cixiHM7elsgzbOWUS2ZfuP
	 nY2IwL1PXqtnyvXmW/M26WjfJNWByeDYgvypKq+3YpxP+By6E2q64ScfUYUQLklhFJ
	 rPUk9jINGqdUFilCgfHlRokM/YlruzTOfSDfmai+VJLUpF6u++dQzIAaKtH+O4Mu8/
	 3v8mQNGSw3zs17AwyV0SfnBa1u+7F1BPp3a3xu6OVvDsCNNsAPhSWyyT6Z7iHCJKMp
	 /U59BbZhzNyNNmLH7ZPx1yLJwg9qaDHQwhF+3naONkLKPw/xyuice07USl9CtCOJ6D
	 aV6m+BTAIv0Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE03806644;
	Thu,  5 Sep 2024 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv7 net-next 0/3] Bonding: support new xfrm state offload
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172553582826.1653140.17922176663161486689.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 11:30:28 +0000
References: <20240904003457.3847086-1-liuhangbin@gmail.com>
In-Reply-To: <20240904003457.3847086-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, tariqt@nvidia.com, jianbol@nvidia.com,
 sd@queasysnail.net, horms@kernel.org, steffen.klassert@secunet.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Sep 2024 08:34:54 +0800 you wrote:
> Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
> xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
> added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
> in future.
> 
> v7: no update, just rebase the code.
> v6: Use "Return: " based on ./scripts/kernel-doc (Simon Horman)
> v5: Rebase to latest net-next, update function doc (Jakub Kicinski)
> v4: Ratelimit pr_warn (Sabrina Dubroca)
> v3: Re-format bond_ipsec_dev, use slave_warn instead of WARN_ON (Nikolay Aleksandrov)
>     Fix bond_ipsec_dev defination, add *. (Simon Horman, kernel test robot)
>     Fix "real" typo (kernel test robot)
> v2: Add a function to process the common device checking (Nikolay Aleksandrov)
>     Remove unused variable (Simon Horman)
> v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com
> 
> [...]

Here is the summary with links:
  - [PATCHv7,net-next,1/3] bonding: add common function to check ipsec device
    https://git.kernel.org/netdev/net-next/c/1ddec5d0eec4
  - [PATCHv7,net-next,2/3] bonding: Add ESN support to IPSec HW offload
    https://git.kernel.org/netdev/net-next/c/96d30bf94109
  - [PATCHv7,net-next,3/3] bonding: support xfrm state update
    https://git.kernel.org/netdev/net-next/c/68db604e16d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



