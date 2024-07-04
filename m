Return-Path: <netdev+bounces-109094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC7926D9C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684CE2825F4
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73892FC0A;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQCiKcMu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E01CA87
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061431; cv=none; b=lwnLX08X8TydzFlsxOMSwgNWeC4860urB0QKnx4Vq3dDVPWCX0EMCGCiUGEDYg/ZZDJq26UsWvT0Q22MF94IzcOZPMKTb314I6CM+V3M6xqPB0SYvOSlYt9LToylWq2BoBPrNNg/sGlhi2NpuVw037H7T+7gld+U9mTBaP5ZFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061431; c=relaxed/simple;
	bh=gclZ+2zjuH1oq9ztBlqJDA/UoqWdgL1tgyta3bWIqnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A7Wm4kIdVCR69YozY/s/tj5IQI3d+rabi+W0hWqeLF7kPlTJalfnjxbZ8K3+gbw1ZnWBhRaPUJoF5Vr/sU42ArQgDazUbQXoXyukUs98b9G1DoZ58C/zTKu4qZMJ66jbbl3PtNVoa1mfyIZ1V6ywabSp3AmCtOuMer+xi+enYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQCiKcMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 237B9C2BD10;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720061431;
	bh=gclZ+2zjuH1oq9ztBlqJDA/UoqWdgL1tgyta3bWIqnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uQCiKcMud4n0csl9ijcdg0wBslH/UvRnX7ZdtiCEfR7dZnM3PObdNGaCWotjd5evy
	 JKjRoknNSap62y9VfWV/n+Y/oIrjuEvZKnrPJ0BnyzC4i0AFbPj73reRT9f5SJdWZd
	 aLKKsSnMVJ62urxrzON05tDiSeA4bhNDqNDnvcE0Bgc99p10EUsMSAfyA8kWp4Ybx4
	 B7+0m5dx+WgT+PcWWSSm76f3alT0LL9rsC7AaEcFz4Gskw4jPWv5obcRs20zuXYLf6
	 BP03D7OYUKqIVkVjW7GtfOqdPzNcg8GTXp208kJrkYeMlC0faCPqty9vzM2mju3+x+
	 X6mAjSu9hjiPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ADC3C43446;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4][pull request] Intel Wired LAN Driver Updates
 2024-06-25 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006143110.17004.2903147614385421882.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:50:31 +0000
References: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jul 2024 10:14:53 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Milena adds disabling of extts events when PTP is disabled.
> 
> Jake prevents possible NULL pointer by checking that timestamps are
> ready before processing extts events and adds checks for unsupported
> PTP pin configuration.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] ice: Fix improper extts handling
    https://git.kernel.org/netdev/net/c/00d3b4f54582
  - [net,v2,2/4] ice: Don't process extts if PTP is disabled
    https://git.kernel.org/netdev/net/c/996422e3230e
  - [net,v2,3/4] ice: Reject pin requests with unsupported flags
    https://git.kernel.org/netdev/net/c/be2a9d12e6da
  - [net,v2,4/4] ice: use proper macro for testing bit
    https://git.kernel.org/netdev/net/c/7829ee78490d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



