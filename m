Return-Path: <netdev+bounces-113050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7028593C7BD
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7B1F2279E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810619DF65;
	Thu, 25 Jul 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjrS+pm6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326B54759
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929231; cv=none; b=d6CW23cHMzaReLyj52o++a6V5ZCN/xyIMvaSyucJAQl6AXzSvnySfJmt443F3GJxgitCHV7jTJztSMsPCNkWuzY9dla5uxB6fz9QoOkd4ARVATOpvfV/y4EjvPOLSAye/a+28Sp8mkpHZMbfvGOUHCZKvx6jUDk24dW9A/e5Low=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929231; c=relaxed/simple;
	bh=Pb5MKhX3kZJQWo38/7qMsElvnHVoruAsDlbCbIk4cxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AGD6EDYVQxSMjjY1vrfykT2gDmPX3/R2jgOZ8GaRyrpXm8QRQb9vp1kpKla0khFcTYcKr3C6NbY1cVxUwKO7iQOkgXVwtHSEJ2lGdzDuucya4zMa27ymfPqokBa4dgk8CzsKkFq3yyFcJEEyuZQ3204zGD25QbbqES29uTNml68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjrS+pm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 731F1C32782;
	Thu, 25 Jul 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721929231;
	bh=Pb5MKhX3kZJQWo38/7qMsElvnHVoruAsDlbCbIk4cxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LjrS+pm6nrCinPOQRDN2dJKRNEcurTuyyWG3PhctztNTm5uTyu+X7RnUdlBIlPVfU
	 4dDRvojpQ18B258HPF54HUga74KBygcSyOXoesG/NX/ck38CSrOuLdep/mewDe85YE
	 vZUa/eQfMFvmigzwR4o92Lb582bPkMhGcpRc0ORtKv1UpjGeuQgWE7MVW4mK+sjMGq
	 51dsN5O96mA9y/hqX4GQ3knTKpTWVNz/QHrD1Fg1caYBxykD+M3K/OFN5LUO35DUU5
	 /vYORTB2iX7pGWBTgkyFMeq5IsM9bD6JBHB8nFFRpXptYWO1Mu+EaMvUfFDSRvCRVU
	 nQeaqtr6WfoNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61A6FC4332D;
	Thu, 25 Jul 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] ss: fix expired time format of timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172192923139.10017.10817656814151362713.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 17:40:31 +0000
References: <tencent_EFD6593E69AD867624E4518D515816F58505@qq.com>
In-Reply-To: <tencent_EFD6593E69AD867624E4518D515816F58505@qq.com>
To: xixiliguo <xixiliguo@foxmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 20 Jul 2024 23:23:27 +0800 you wrote:
> When expired time of time-wait timer is less than or equal to 9 seconds,
> as shown below, result that below 1 sec is incorrect.
> Expect output should be show 9 seconds and 373 millisecond, but 9.373ms
> mean only 9 millisecond and 373 microseconds
> 
> Before:
> TIME-WAIT 0      0     ...    timer:(timewait,12sec,0)
> TIME-WAIT 0      0     ...    timer:(timewait,11sec,0)
> TIME-WAIT 0      0     ...    timer:(timewait,10sec,0)
> TIME-WAIT 0      0     ...    timer:(timewait,9.373ms,0)
> TIME-WAIT 0      0     ...    timer:(timewait,8.679ms,0)
> TIME-WAIT 0      0     ...    timer:(timewait,1.574ms,0)
> TIME-WAIT 0      0     ...    timer:(timewait,954ms,0)
> TIME-WAIT 0      0     ...    timer:(timewait,303ms,0)
> 
> [...]

Here is the summary with links:
  - [iproute] ss: fix expired time format of timer
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3e807112fdf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



