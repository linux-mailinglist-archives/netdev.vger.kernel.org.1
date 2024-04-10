Return-Path: <netdev+bounces-86355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A689E6FA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F58B1F2202C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865F19E;
	Wed, 10 Apr 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPlnTlPM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DD391
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709629; cv=none; b=lMu1TAjxrGW5l1nugQ6xb4zcSGFpYWpwBgmOJAnff2nm2OtHgLrF3LTuILGJwGIEGgBylAewnz2gR3IwPDepUY1roNne7x5xmKSJkfNjPosypeG2Vmqiy46OHd1IY4/X8WjDj3vYSzcBFglGk8vOdAcT3o6bjOi23kRAgrN8R0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709629; c=relaxed/simple;
	bh=R0D0OgIctUQSgGJ9/goGXaPBV3qc0GV1U+cvAnzxNok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aCsv7YkolJxRPBE/5Hfku9jmUTKW3QYtiMmWM1Vm1KG+fIAuCWXZcbXUDcgyHx/Lkx5arKC3FnLzkudTiNQ/918Hk4fCogjRd7w1hnglMFPWwuWgkQsrct/gUUj7Rx6yd2r72yvHWQKXN3goKGoL4hTNLk+wMDutHi5csqTd97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPlnTlPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4655EC433C7;
	Wed, 10 Apr 2024 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709629;
	bh=R0D0OgIctUQSgGJ9/goGXaPBV3qc0GV1U+cvAnzxNok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qPlnTlPM0GVPNI5qf+SFt06fTX9De9X0e4DE05eK4/ANOXUe0OFa13uNbwSfpVs0a
	 BZJVJkdlwpN+Tqe9rHID6GiP3ZZtn7Y/Qn45RGrmalXb1hZCFdsnDnOaFMfZ5mxgSU
	 U8jjYBhKvKfF+Vq1NZuurQWAYnnWN+je+75FpKwKGBOgL7BAVHl3z31Jr7Wy9kUgYM
	 yYrfexCQI6+tkkm9WkmLE8kwvzJ+KcDQ6MzFOg8RY/3f/DymrTG6hLhzsom5VxNkx3
	 mAqBljh0XBrIecGbHLMfUXUGEl5BgwLnhJH5xxaTRb0G5ibf6llVg48vwOsbsg5E3O
	 fl9Nj+bwxl2rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37516D6030D;
	Wed, 10 Apr 2024 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] bonding: remove RTNL from three sysfs files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171270962921.13694.333195424865632113.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 00:40:29 +0000
References: <20240408190437.2214473-1-edumazet@google.com>
In-Reply-To: <20240408190437.2214473-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 19:04:34 +0000 you wrote:
> First patch might fix a potential deadlock.
> sysfs handlers should use rtnl_trylock() instead of rtnl_lock().
> 
> Following files can be read without acquiring RTNL :
> 
> - /sys/class/net/bonding_masters
> - /sys/class/net/<name>/bonding/slaves
> - /sys/class/net/<name>/bonding/queue_id
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] bonding: no longer use RTNL in bonding_show_bonds()
    https://git.kernel.org/netdev/net-next/c/6c5d17143fa4
  - [net-next,2/3] bonding: no longer use RTNL in bonding_show_slaves()
    https://git.kernel.org/netdev/net-next/c/d67fed98caa1
  - [net-next,3/3] bonding: no longer use RTNL in bonding_show_queue_id()
    https://git.kernel.org/netdev/net-next/c/662e451d9a62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



