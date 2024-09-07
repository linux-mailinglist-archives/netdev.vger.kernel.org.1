Return-Path: <netdev+bounces-126153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226196FF21
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 04:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F81F23B84
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAB1757D;
	Sat,  7 Sep 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkGkO0ZU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445C17571
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675038; cv=none; b=XNxX2yEo6NICCVFgSEuuzA6kH/NMPN/J8kFZMCtrINWLADgxIAa9e1snN+ZUwudApN6VY5QQQwdNbotk5qeiyWIfBp5H1eitTovLSqAnTFSkVyaSKDz3/SEQd14gS6mQ4OkZjezopK0hNAYGafF/dlO4/WyZu0t6HurVmjfEC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675038; c=relaxed/simple;
	bh=+fJeH0KfaLz+6t0eeZcllm58N+azp6r6YqXlCY6u7Eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jtkao5fwiVlKlQqZdEA7Cpagx2k3tUJZ8ddySGC4URYwOMSCTXeU4Y7ib4RHPQ0wSHQ8oBxemDIcFSnh/GEBPjc8kLM3YjsiT1V3z+vuzJ4WmugqTnTu+RZsFbYX85lDBGA71Gp6e0y3ZM3QP1OXZ9QNL050sWnQqLGRARdG/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkGkO0ZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566C2C4CEC4;
	Sat,  7 Sep 2024 02:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725675038;
	bh=+fJeH0KfaLz+6t0eeZcllm58N+azp6r6YqXlCY6u7Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nkGkO0ZUm4FXs2sIMzNGXTBFLOVhfYXIimnUEYjYUpmdLoeonrIG4FaQKXibQa7pX
	 OGhrTGEWlv7HEumksqy304NaITomUu4XPxpRtKA6MF+fqPEzN4V6PxGd6gBvyFsssN
	 GI9ikOlInyMAbS/QBs4D4PL/i+uoGJkH8sW4fl/DeXqjjtC91Oxn7bqfAhHie92t3u
	 TAnewa81JKUDI1KSyQYu+lckFXuN9YAjf8eOk5qJHdxOTj7IzypVX+BpwFUIYB732m
	 bouCYMyWDcnZGlbrnOTkMqc1kgR1Ty8S0TZTQ05O5+ru8uMobzz6PHTdPPrP64mxRg
	 UXBDmfWesP6Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D813805D82;
	Sat,  7 Sep 2024 02:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ptp: ocp: Improve PCIe delay estimation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567503909.2582309.5936192905565257390.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 02:10:39 +0000
References: <20240905140028.560454-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20240905140028.560454-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, jonathan.lemon@gmail.com, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Sep 2024 14:00:28 +0000 you wrote:
> The PCIe bus can be pretty busy during boot and probe function can
> see excessive delays. Let's find the minimal value out of several
> tests and use it as estimated value.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> v1 -> v2:
> - init delay with the highest possible value
> - use monotonic raw clock to calculate delay
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ptp: ocp: Improve PCIe delay estimation
    https://git.kernel.org/netdev/net-next/c/aa05fe67bcd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



