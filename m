Return-Path: <netdev+bounces-81886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550F88B80D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4247B2C6885
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E6129A9E;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4cAogem"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72E12839D;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422630; cv=none; b=fhjb8OPziRvWVS50CS6fWsHShuzJIWQme/kWdh6kIGnW9DdENqQOwHEqEBa47hPuLQUGAx8rzDCVXFZt7xckLB1tPOd86KBG6gmw1gouStQvWQlGjx8OBhV7hkYOWCP5dboV92kqA3vi/hzugkd2jn8XCPaIfQRJLUQ1NFrhf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422630; c=relaxed/simple;
	bh=VCzsm8+oqab452/8Y18pSmS5G3d1zEXJCGijns/dcIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqICKAlwzMmQ+P1ZoF+KpQO14kL09e3xsAOp2fvpnIhOxocf2ykaVoNE+szOQx/foyecJAaSj3nNImI8momacmR5NVuDf44Txk0S5MIVBgqnQA2Hbb3wSL7tfj7OO4LuygIkFSotJusdz7T7PqyIJevTO9vaPfgkjjp1ju/C0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4cAogem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75D85C43330;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711422630;
	bh=VCzsm8+oqab452/8Y18pSmS5G3d1zEXJCGijns/dcIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X4cAogemiKNFygqrQUyy4Pl4KA7BldxBNy+ceXGYqG+ZR4dCLVFQ8eS9AYVCKxsU3
	 4S02AOknlIK1O7Jzq2HUvazmmwCPeS0RG2Pa4w6l+dCqCuXbTaiVbDvUrkS6fLBWjw
	 c9e7lNDd1eGvOuFksaSRp3To4FrBzcyWhENOsNEi3nYpiPSxjbnka4GSalTUukkg/7
	 c1TKmz5aedlR18B3oCtxXC4uhQYb267Q+Zaret06t1lAFXLrdhuvu4EyHleIvOHtGK
	 6kj5kgftZTSZIyXyHiILJUPH8ZoNO9PKdeT+6f+79EjL+mXkYlrrpCUeSZ4PPv2qc8
	 WSiDc2+OVDzKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67F75D8BCE8;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ll_temac: platform_get_resource replaced by wrong
 function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171142263041.4499.11330999568533443925.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 03:10:30 +0000
References: <cca18f9c630a41c18487729770b492bb@terma.com>
In-Reply-To: <cca18f9c630a41c18487729770b492bb@terma.com>
To: Claus Hansen Ries <chr@terma.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com, wei.fang@nxp.com,
 yangyingliang@huawei.com, robh@kernel.org, harini.katakam@amd.com,
 dan.carpenter@linaro.org, u.kleine-koenig@pengutronix.de,
 wanghai38@huawei.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Mar 2024 13:08:59 +0000 you wrote:
> The function platform_get_resource was replaced with
> devm_platform_ioremap_resource_byname and is called using 0 as name.
> 
> This eventually ends up in platform_get_resource_byname in the call
> stack, where it causes a null pointer in strcmp.
> 
> 	if (type == resource_type(r) && !strcmp(r->name, name))
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ll_temac: platform_get_resource replaced by wrong function
    https://git.kernel.org/netdev/net/c/3a38a829c8bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



