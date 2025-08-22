Return-Path: <netdev+bounces-215852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF01B30A6A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E73A1C2086E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7A15539A;
	Fri, 22 Aug 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNBYSdKR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B0153BE9;
	Fri, 22 Aug 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822623; cv=none; b=JasqfuMTVvJozPqYe36aR89ZgCUaZ3adE7nmMl+Ekno9SpJYDeNMlnur1FO/sw8o0UKgi98DKvro+WEAYMq72DiBpoSnBit3SPmtJa9cNvS2RIOAohwNQ5rfoCHTbFm5jq0US6EdSV/yDq5w9An4dFPUbXCpcQtVOPgeAt8hQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822623; c=relaxed/simple;
	bh=VKRl8cnNoiINeeX3AA2VXrrO6NBigYUCFhxRKeI7hKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MQ9ucZdDOOusT443ZFMSMe0owPi8yPxdn0aNgccHFpap7XCdc2OZtPIAQO7r51MTS9sR88aG60qgVyRcom/2Cc3fHncv3y2kIvtaMqPCrsxzxwF9LC8Ryxr6TyjGxn/syiku9SoiSMGslsa6wwOIEHO/ZYWIAJ7q8S3RgidToCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNBYSdKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5E9C4CEEB;
	Fri, 22 Aug 2025 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755822623;
	bh=VKRl8cnNoiINeeX3AA2VXrrO6NBigYUCFhxRKeI7hKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lNBYSdKRL4Syci8ory0BoTOzrTklutL1HCnL3g+AiI1vbl+8UdPngk/H1INGwI6z6
	 zQ4cGvdKk/EdOZF4HmaEfLR0oOKaLzmWy2mnAPPS6DrU0M1StK4lCZK9lzpVCo5SCf
	 4wKnqZQiEidRiOYmAOIb422ogAMgadVhOYr/5q8mK+BiUepX5WBpebiiZwrkFUSFIF
	 Ead4OgZ+uaZ0zQjjO4ZESkIjht7svDysQHYkLGqcFnJ/4LTjkh+Q0OjqftQ/vcAK8t
	 lTHpTmsLgIoLAfMwJQgnZIFHedoie3Kpac3sM2fTSpyO1YSPVoVL/phSRCecH4GGaC
	 8nTjTeqWwzvmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC58383BF68;
	Fri, 22 Aug 2025 00:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: Remove the use of dev_err_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175582263224.1251664.3095429249858247888.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 00:30:32 +0000
References: <20250820085749.397586-1-zhao.xichao@vivo.com>
In-Reply-To: <20250820085749.397586-1-zhao.xichao@vivo.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shaojijie@huawei.com, shenjian15@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 16:57:47 +0800 you wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Xichao Zhao (2):
>   net: hibmcge: Remove the use of dev_err_probe()
>   net: dsa: Remove the use of dev_err_probe()
> 
> [...]

Here is the summary with links:
  - [1/2] net: hibmcge: Remove the use of dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/ed1e7e22571c
  - [2/2] net: dsa: Remove the use of dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/5e91879a7a4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



