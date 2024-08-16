Return-Path: <netdev+bounces-119339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0149553BE
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A96282BB6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDA1459F7;
	Fri, 16 Aug 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBLHb37c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F813E8AE
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850443; cv=none; b=FYgV4zXRMKcgLCrJzvP1xPOtgOg8n7b4bfWR25adAHWv58q3HSFWMpRXQVDxMzAsHnfcZ5QGsZ1w0aOqd3gCFcOFrJ9wHUNEbSa6JadjQMO+NWNpubp+EPoQQNoK7BNQ02G4/i6t3Zjs4Ssah3GM/gH3w3CWjUh6iqe9/pLP/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850443; c=relaxed/simple;
	bh=2r3zhAd2RnwiNYj4brw8O6EHA0Z3fEoPub2iUX9BFUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWdbWiunyG8P1SCFevQPpHqZ1U9NxG9946tmxjm2mwzAmaL7N1QufrwGnok2CBaVKjRDeBhWOJ9EyHWGiTeot/bbHaFhHfFaOeo/GL97s46nyX/lNfiYzDfKeAWa/DjSgdi3CLPFaMJ1r3KYylGAM8CExd8+UIPiAs3/2iyhQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBLHb37c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2FC32782;
	Fri, 16 Aug 2024 23:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723850442;
	bh=2r3zhAd2RnwiNYj4brw8O6EHA0Z3fEoPub2iUX9BFUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TBLHb37cNC7MlbzbeNXd1K4dsFhEExd8ngYpy0X24DYfkafSdR2x8ea7wGOFUCDlf
	 sgsxPFBpTJ8Jm2TdybXR8WMxn/UrIKytH/NW443EetrBIMrk79mkrEbi3qvnMK63cH
	 vhnRG2mWSYwKzYyihXUm6y1ux4rZ53VZx8CpVK9p8bOGIfZimTYgcYj05WJQtb7Deb
	 n2s22RjqDlfwfUrWCoA0x/3ZL5IO7OaFTLHwXM3ETfeQbiiRH+dM+57HOcFNxr9IKB
	 yUwlcxbTJ2Kl6ghmiNbSGTteZw+wHjJhYkAbFzd7snGECADaSOSFgUVLXE/Qni6yTx
	 hAhjRgHCvSBpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8138231F8;
	Fri, 16 Aug 2024 23:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mlx5 misc fixes 2024-08-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172385044202.3653439.17648367767714125156.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 23:20:42 +0000
References: <20240815071611.2211873-1-tariqt@nvidia.com>
In-Reply-To: <20240815071611.2211873-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 10:16:07 +0300 you wrote:
> This patchset provides misc bug fixes from the team to the mlx5 driver.
> 
> Series generated against:
> commit b2ca1661c7db ("Merge tag 'wireless-2024-08-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless")
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/4] net/mlx5e: SHAMPO, Fix page leak
    https://git.kernel.org/netdev/net/c/f232de7cdb4b
  - [net,2/4] net/mlx5e: SHAMPO, Release in progress headers
    https://git.kernel.org/netdev/net/c/94e521937839
  - [net,3/4] net/mlx5e: XPS, Fix oversight of Multi-PF Netdev changes
    https://git.kernel.org/netdev/net/c/a07e953dafe5
  - [net,4/4] net/mlx5: Fix IPsec RoCE MPV trace call
    https://git.kernel.org/netdev/net/c/607e1df7bd47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



