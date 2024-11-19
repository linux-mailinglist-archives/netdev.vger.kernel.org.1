Return-Path: <netdev+bounces-146080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ACE9D1E8B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3991F22798
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA0149DE8;
	Tue, 19 Nov 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5eudC+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13C2E3EB
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985232; cv=none; b=rByivrMLVflEdWSs03kW26X2jcpsDeQUE+XuYc3D3cCq8fhOlUciN/HlWocNuTVYiWEtA4p3WTiiZvC6zdlEeRq7BHj7YWPS1ic3FPCH/8MF/h3CKvnUczoKRSw9/EacKfB+ogbpHlIbzTckMU3THceINiceb5Rcuv1rQqDmkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985232; c=relaxed/simple;
	bh=Rppt1LCKJLpxTMA8JWP+PlcOfVcwJGidFXhEjX4CTXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nxdmXNuQVJ8L38PhPmWEp3lxZ7tZyALXvMzp0fyRefG201xqbyyE+QaN9AylsfX3F5IWNdzbWXtMTSVPPEKh3zriNFppsAvYvLZfOF+OKZmd1opiygp5nEv5RGtZqbIbM/7nH46XXC3/xHLALsp5CBIFNNnnoh5T9CPQAFFi1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5eudC+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95039C4AF09;
	Tue, 19 Nov 2024 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985231;
	bh=Rppt1LCKJLpxTMA8JWP+PlcOfVcwJGidFXhEjX4CTXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5eudC+JjtWZy31e3NWzf9OzO0U8cOJO8uDXUchCLp4mWgqm4RimHjos/vDkbldgG
	 R0Z8I1eQfsf6DqTu4n32iAiS+ztqcTtQpEoXofddHUsQsX3PwnE7W0eG+vZpyVw7L/
	 SHmqSVlxFRDLsWxrW2SlVR82AkqDOGr+qOIAZEIDwUWZnHkH5Zcl4G9mFWG3ec19uV
	 RKoNfgQogN/c/b7N/VhP8l9/MtwHiDm4OQjHtxNPZu36gaP8hYvVDL+IG1MooskOkL
	 ztiiVz5K1BATBNnm2uKsAqyrcyAv071DcUV4r4fVLpmI7FLJ78ABZb1hysYFnLCjOT
	 Imek0mtEGmy3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342ED3809A80;
	Tue, 19 Nov 2024 03:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: txgbe: remove GPIO interrupt controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198524276.84991.1686147884253596686.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:00:42 +0000
References: <20241115071527.1129458-1-jiawenwu@trustnetic.com>
In-Reply-To: <20241115071527.1129458-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linus.walleij@linaro.org, brgl@bgdev.pl,
 horms@kernel.org, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 15:15:27 +0800 you wrote:
> Since the GPIO interrupt controller is always not working properly, we need
> to constantly add workaround to cope with hardware deficiencies. So just
> remove GPIO interrupt controller, and let the SFP driver poll the GPIO
> status.
> 
> Fixes: b4a2496c17ed ("net: txgbe: fix GPIO interrupt blocking")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: txgbe: remove GPIO interrupt controller
    https://git.kernel.org/netdev/net-next/c/e867ed3ac8aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



