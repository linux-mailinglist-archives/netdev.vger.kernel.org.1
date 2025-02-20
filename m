Return-Path: <netdev+bounces-168317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32362A3E81E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640C119C4461
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B242676E1;
	Thu, 20 Feb 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy8EoEJ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3285265CD8
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093016; cv=none; b=BJaSbnoDv7YJfdegs3ozqrFiZAEuwBkeU2my9lbEKKJbl2i/DzrAM3zVwJD0SF1PV9kQ0llmsUEiUfZ0SrMbUsZnChS9nN37GyL/UMRikiHaBbp6nWQ7UYQEwPuzz9pdIVwx8kiWlUZWSkIEbLIabULEjGY7HyezTeoLawmbgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093016; c=relaxed/simple;
	bh=bcV1a4/6jpWNP4upmRpTcLPMJwjDJ1hVxZcRmHqZKqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FI1ORFLamdKQs1UAENxIfFRj0CEsLutsmMgEP+Eb52eh7dZl6zJ7mViDYBeNmSEakDgSJIQD+HDjHgprk9dT+hMhvZnqCM59L4bcqCku7mrJqUPgtwyv9d2PObV3f8algAq+M6QA0FC1H3xfrhnDkCw2zhjxcEPe1exx1+R3my8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy8EoEJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38622C4CEE6;
	Thu, 20 Feb 2025 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093015;
	bh=bcV1a4/6jpWNP4upmRpTcLPMJwjDJ1hVxZcRmHqZKqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iy8EoEJ9SYNQ6dMMVjUiGWI9dDF0hiVSpEZFyFpWu6FOk3DTr3FgFld6cDtKAvBZt
	 hxnX9izM1jg04/PxzbKU1dpZALUqfJTewNZglgASi8+V50xgvXPDTrRoNEcVaErNsZ
	 xj/5DniEvEWwmeMZcijqOhFnK4CJ4YpqqbIRhDrCuDNmKt9LNyQhw0m5Ev1UHqFuxO
	 uMBqAQZLfYagEOsRyrJ4QXMUCy0YqDb2PEVwKTsIavqcXdH43QmccBZjbBdylCC0Lr
	 KOQ/l+cTe5BE9eG7r/g005GGRvwfEvnFMEFrHb4PoGWySEm4zyqV2dipGNuzZbtM9i
	 SBYBvxzkCEbDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B6E380CEE2;
	Thu, 20 Feb 2025 23:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/4] Support PTP clock for Wangxun NICs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174009304603.1506397.4994195392689366309.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 23:10:46 +0000
References: <20250218023432.146536-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250218023432.146536-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux@armlinux.org.uk, horms@kernel.org, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 10:34:28 +0800 you wrote:
> Implement support for PTP clock on Wangxun NICs.
> 
> Changes in v8:
> - Link to v7: https://lore.kernel.org/all/20250213083041.78917-1-jiawenwu@trustnetic.com/
> - Fix warnings for kernel-doc check
> 
> Changes in v7:
> - Link to v6: https://lore.kernel.org/all/20250208031348.4368-1-jiawenwu@trustnetic.com/
> - Merge the task for checking TX timestamp into do_aux_work
> - Add Intel copyright in wx_ptp.c
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] net: wangxun: Add support for PTP clock
    https://git.kernel.org/netdev/net-next/c/06e75161b9d4
  - [net-next,v8,2/4] net: wangxun: Support to get ts info
    https://git.kernel.org/netdev/net-next/c/ce114069a654
  - [net-next,v8,3/4] net: wangxun: Add periodic checks for overflow and errors
    https://git.kernel.org/netdev/net-next/c/704145a854ee
  - [net-next,v8,4/4] net: ngbe: Add support for 1PPS and TOD
    https://git.kernel.org/netdev/net-next/c/2d8967e86c9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



