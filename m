Return-Path: <netdev+bounces-193599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C526AC4BDE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2745617C0B2
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A855C253F21;
	Tue, 27 May 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbEqNj10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406E1F37C5
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339998; cv=none; b=FQKWXvvgpKar52uGOkwZv+ShfL5xDf3FI6sZnMmOYnzlHUKlsYh2Gg3OUIw8RunQKl9zNIVWhJpGFlDBUzPL4UQUfGSbjcGQST6r7bOooZDXa5vxBRLCyD1ETvHhbH5Tusmq6a5lqA7+gOAF5xgTPCEefVOzYxbCuNamm1IcFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339998; c=relaxed/simple;
	bh=8/u8mNvV42YpO/54ZJGCBWSMXvvzv7t2i1jzXod426s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NCRYAG5yPUgp2FQS2hexJWiUEIGyuhsZMUmwSYXQLoJejXDucIgIDgWL66J5P9G9SvWkxMy/yI8+8rmzfHagwFfywhxUHoUI7GUt8FxECgad4dUv9nYV/kowLKae+t4H+fUSBoEoUTBo1Hgajv+5m2v/Oqmcf616sfEWLhdLvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbEqNj10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED2C4CEF8;
	Tue, 27 May 2025 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748339997;
	bh=8/u8mNvV42YpO/54ZJGCBWSMXvvzv7t2i1jzXod426s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KbEqNj10FUF7BXIw+69JDksdYRoNbQADzNd7E2FhgzLOSp0AS4ahAvRv/wsTov/rk
	 EViEgo488P9CjzsyUbD1mtm/Vu0RkrrHqIMLjMBhuI4qsTPyR8VKz6uvdinadGrfMs
	 /Zi8gsgKulAtWjc/4O8iTKH/y9fcHhVI/1IcGBWGprqKlEtAEw8AuHqDGQ8zc5qOhv
	 oEBKGiySY0VtpOK0GhQMBS6nxMMa+XuWUqvy8x5/AYXHMuD0kWDzN4/XLsjrp8YpYe
	 kovPMAbdgZczqi1Nj9zDCAk3uM3kZxKpIPgeYMmtwPWFxVuWX+P5Iz0K8QLNN9VfdZ
	 OQh4oUOMUfjew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEF380AAE2;
	Tue, 27 May 2025 10:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3 0/2] octeontx2-pf: Do not detect MACSEC block
 based on silicon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174834003201.1237935.7363825468399799478.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 10:00:32 +0000
References: <1747894516-4565-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1747894516-4565-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sd@queasysnail.net,
 gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
 lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 May 2025 11:45:16 +0530 you wrote:
> Out of various silicon variants of CN10K series some have hardware
> MACSEC block for offloading MACSEC operations and some do not.
> AF driver already has the information of whether MACSEC is present
> or not on running silicon. Hence fetch that information from
> AF via mailbox message.
> 
> Changes for v3:
>  None. Resubmitting as v3 since there is no activity on v2
>  for a while.
> Changes for v2:
>  Changed subject prefix to net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] octeontx2-af: Add MACSEC capability flag
    https://git.kernel.org/netdev/net-next/c/732038370e55
  - [net-next,v3,2/2] octeontx2-pf: macsec: Get MACSEC capability flag from AF
    https://git.kernel.org/netdev/net-next/c/5fa6f0245960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



