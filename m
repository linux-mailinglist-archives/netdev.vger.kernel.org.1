Return-Path: <netdev+bounces-192118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB0ABE936
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD9B1B665E9
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA561AAA2F;
	Wed, 21 May 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkbtB2dD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BCC1AAA2C
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791597; cv=none; b=QOkk4E7swVTm9Zl8RXHatL6AGIIYmzE+ZqBR9XmkRnsKVa9FNQTDS0bia5SBZzZkEVcBsCSJHoy0X5UjzR2Q3aD6kM2Cv5ZZhZGYO4WxsomdNoE675j/OrQrh+6DIUCiTO7t+G2wkNQteAbdyVToRU4+HItMBnyUKSgDXwaPcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791597; c=relaxed/simple;
	bh=WBnpoyQcQIjSMziLRXxinDs+xuAl4QwHm/SzqE6bq5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TI9SckTW49S7pvJRRDpx6+6QIoFIkX22gLOkJyb2APBog3SoF098/XP86bSM9mzUWM+c/jJMOuttdWduFwSjpaxE/2DIYkn2Y1apXHQg+yj/mtstoF5E7x38yITgaRAdzeBNUZ2hWUilRFar5KF57Ensyrl+DUKqi4AKCzNk1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkbtB2dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A097CC4CEE9;
	Wed, 21 May 2025 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747791596;
	bh=WBnpoyQcQIjSMziLRXxinDs+xuAl4QwHm/SzqE6bq5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YkbtB2dD76GE3n1l7FkNvNJOsGwGK4ERriEZb3ql73lVkyanUiBuRERNAVVPJvYEA
	 xm0sSQLiYp6Y2DVsll+oUJll1Ela1N6HJKZBC+F/gshfmbNcWNVqoEevUPFC1w6R6Q
	 Z6XCLpQ6apEiGzGYa3hlUUhcsmttf5P+h1MRtzKwWGR670xvb9BPz45mJmShCiuX9Q
	 H+aI7wfluhOjVo0/EcskZkW9pDmYk7n5qTkg9quR1yEweZQD24E5eQS+eZb+dtn7Sj
	 M+++gFfAzmzexOhByW09x6kpbdGLPxwsHkkIknTvTDG6ugpOgl92UtLNxa5ppaRiYR
	 v/M2LSlo3fY3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4E380AAD0;
	Wed, 21 May 2025 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2025-05-19 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779163232.1531331.15953808943135735793.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:40:32 +0000
References: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 19 May 2025 14:05:17 -0700 you wrote:
> For ice:
> Jake removes incorrect incrementing of MAC filter count.
> 
> Dave adds check for, prerequisite, switchdev mode before setting up LAG.
> 
> For idpf:
> Pavan stores max_tx_hdr_size to prevent NULL pointer dereference during
> reset.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: fix vf->num_mac count with port representors
    https://git.kernel.org/netdev/net/c/bbd95160a03d
  - [net,2/3] ice: Fix LACP bonds without SRIOV environment
    https://git.kernel.org/netdev/net/c/6c778f1b839b
  - [net,3/3] idpf: fix null-ptr-deref in idpf_features_check
    https://git.kernel.org/netdev/net/c/2dabe349f788

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



