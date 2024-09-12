Return-Path: <netdev+bounces-127667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A2975FB9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 05:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E88281E78
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E76F30D;
	Thu, 12 Sep 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dikDMS4c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAC38DE1;
	Thu, 12 Sep 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111829; cv=none; b=LRtvknufJGlm61dU0+H6nT07S8xrTS0R4dJGrLCyUfjV8waPdLLa3ASrdFq0lV5V7MLxBeWvvsQlyHyYREn06DGGdymG0k/kZ7cTVkMDuikY7PyJYZLOOpAptKo6IacwhSAmoUub/sgvWpUHkAiccy2wxr9KrrgwErgbp7Xl9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111829; c=relaxed/simple;
	bh=QZu+4xV3LZUNN7Sfm6G0q9k4hp5C4LSFH1bQsy7zm7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HIN/Da/ZlcSzh3LHq9VLJmrmsG4pAEYxMH7/jOVL6i8tdu9ktJSD8X/rfnnVkswTV2ho+J4wwY5uMxZrzX8sUCFo50B2WvW06ubOvBT61yCv9zOUzPTCL8x+cKGL+3/ZeDkxyYWBsMWbI+p+aWtP8cmglg2seLNbvpk3swlY8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dikDMS4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9965AC4CEC0;
	Thu, 12 Sep 2024 03:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726111828;
	bh=QZu+4xV3LZUNN7Sfm6G0q9k4hp5C4LSFH1bQsy7zm7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dikDMS4cFgSF0R0QvcgG/AvDShyEBTbF6azbRiE9On0z8Zs3qg3qEuFlEtEmezAcR
	 QunW117FEA72ZerC2b/NTWuArQaaxQSUYw4l8SLEY6GuSuFnRL9LPyQX5GzX/MVI3O
	 n4kUPGXe1tofdDj4Nkn4yL0lC0CunnPxmoQsoJKQo7zhU9enOg21deev3F8hw5/pyh
	 oq4lZtFyi0Ai5In63+l9AZzxqjXZAhJY7K2wkHeRoK+xCFTbyykqWh+4NWNkkJGpbB
	 navoxdjxQsGpWR3zwxvujLg16Xxtt45OQBZUei2lgPxQmyLU0VcY6YnnrR9tQkFVda
	 YNVG0gm1IjKmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB26E3806656;
	Thu, 12 Sep 2024 03:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Cable Diagnostics for
 lan887x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172611182979.1151055.4219099086765234993.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 03:30:29 +0000
References: <20240909114339.3446-1-divya.koppera@microchip.com>
In-Reply-To: <20240909114339.3446-1-divya.koppera@microchip.com>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Sep 2024 17:13:39 +0530 you wrote:
> Add support for cable diagnostics in lan887x PHY.
> Using this we can diagnose connected/open/short wires and
> also length where cable fault is occurred.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
>  drivers/net/phy/microchip_t1.c | 413 +++++++++++++++++++++++++++++++++
>  1 file changed, 413 insertions(+)

Here is the summary with links:
  - [net-next] net: phy: microchip_t1: Cable Diagnostics for lan887x
    https://git.kernel.org/netdev/net-next/c/b2c8a506f6a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



