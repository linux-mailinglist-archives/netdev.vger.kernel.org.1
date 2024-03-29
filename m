Return-Path: <netdev+bounces-83425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7798923DF
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07605285829
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBC213A3E7;
	Fri, 29 Mar 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6rSiEEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2586240;
	Fri, 29 Mar 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739431; cv=none; b=rWdlaXed++p+H48Xeiqs0pHu3lU+FDqg2YHxIjlhIjbm2hMzM+FyKAZdVA1wybJu6llaUORy0SLCZi+9W7CjCNz/7dQ1q2a9HMJ533lriJqKbqUSW4c2sL6Y+nGx6LHTK/RlbHpIhiJq20pTALajIaZhF4edLIpx3orJadqwzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739431; c=relaxed/simple;
	bh=LwexX6POalNI1Bt1kaOj6vLWByTLLvZkDTZniqphLx8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hS18xDE03CXc9zh6FAhIFEVfL81LESujv1OpZCatd57mLB+k47K60vilt0T0x1IvO8FI0m1k5wodkwKK3Jh6TR6rhi8ixMzvK/u2YiQmghQxGFIwqwfBpPBv4EoyB1jLvLY9tVtG44AkRxBSZ37v7Ojq3CCluV4zbpupVHJCPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6rSiEEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2046DC43399;
	Fri, 29 Mar 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711739431;
	bh=LwexX6POalNI1Bt1kaOj6vLWByTLLvZkDTZniqphLx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h6rSiEEiiydPD7PotmoyC+HCCcU5XaNI1azgKkysAAIw7gMZk+Iibtt8JpLJTdrzC
	 P7WctSiIO2+CvZGTEI7jX3y1uErAnEY1Wpnc9DA8j2mZ/tYkbH21ZJR0j9kLAuDptM
	 E+7VO4RtW6A/AQG0L0++qSwcEEhlzQmvuGngH0uROg7e68Gw2HUNzTxeaJd201gptW
	 YHxiSevuniHKhrfk1zCRDKDUb5KKt12wF5nY7HAGlFriioRJLmSTXcDa81OqOR81AC
	 ogEhc60CdemA4bNNhfwCbBBviXYjgEVWhiKcBXatsAbjIgvRxqmHNdXvFf0Ozj5PTU
	 Wc48NmAhw1+nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13DE5D2D0EE;
	Fri, 29 Mar 2024 19:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] Add en8811h phy driver and devicetree binding
 doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171173943107.5976.10666505315366635692.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:10:31 +0000
References: <20240326162305.303598-1-ericwouds@gmail.com>
In-Reply-To: <20240326162305.303598-1-ericwouds@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, frank-w@public-files.de,
 daniel@makrotopia.org, lucien.jheng@airoha.com, hujy652@protonmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 17:23:03 +0100 you wrote:
> This patch series adds the driver and the devicetree binding documentation
> for the Airoha en8811h PHY.
> 
> Changes in PATCH v3:
> 
> air_en8811h.c:
>  * Dedicated __air_buckpbus_reg_modify()
>  * Renamed host to mcu
>  * Append 'S' to AIR_PHY_LED_DUR_BLINK_xxxM
>  * Handle hw-leds as in mt798x_phy_led_hw_control_set(), add 2500Mbps
>  * Moved firmware loading to .probe()
>  * Disable leds after firmware load
>  * Moved 'waiting for mcu ready' to dedicated function
>  * Return -EINVAL from .config_aneg() when auto-neg is turned off
>  * Removed check for AUTONEG_ENABLE from .read_status()
>  * Added more details about mode 1
>  * Use macros from wordpart.h
>  * Set rate_matching in .read_status(), fixes 100Mbps traffic
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] dt-bindings: net: airoha,en8811h: Add en8811h
    https://git.kernel.org/netdev/net-next/c/2434ba2bc851
  - [v3,net-next,2/2] net: phy: air_en8811h: Add the Airoha EN8811H PHY driver
    https://git.kernel.org/netdev/net-next/c/71e79430117d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



