Return-Path: <netdev+bounces-87327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E68A2AF5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 11:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A481F23121
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B125102B;
	Fri, 12 Apr 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSI/6lCL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A950A72
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913629; cv=none; b=cTMwnGYagvXt6EK2CPpB8fbV/wyOCh/hSy8uIjubuDiAizSXnmmyo4Qx8md/YQESIdArVlaqSIZ2k5NfawEnrblYG8RYoMacf1G9bCESryPw3mNhK0X7WXGj5f8ULYSjidExSbb2xg7gwLwePcmKAVwMSkUn5KJgbCSyHfgedzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913629; c=relaxed/simple;
	bh=AXP6wVikxCUXfX2ePVO4VpRYBAn5FA42GzvVKZc8cXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lkpsVbWzUJWgZtf1y5DNV8B0wc4eK1fLgPJhNEgaQkfY3BSj23IczxqIiRgaDx0KzPy2ERkQOc4eG6NPyT6PSvWEGMeXinmDd5zue9k6BKMA9mqJhG3cxI0T5Mh5vwkydXEF3qIyYoghmUPsOpBSgzg8oAF2xFrarPdAqfuHYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSI/6lCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCEF6C113CC;
	Fri, 12 Apr 2024 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712913628;
	bh=AXP6wVikxCUXfX2ePVO4VpRYBAn5FA42GzvVKZc8cXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jSI/6lCLcnmgaNs6SWLonQJwhf8UCu4D3k387R/2YNGDYaXIM03Jsc3/4G7K/lQ7B
	 tI5EWIXzVn01V5P0CK6TJEtIAmC8DooZLzTVQ9Y8bJXKVNNlahtJhMZhwVErC+DvK/
	 l7Ev6YJ+zi2WfZcS6R/4YSiuimX9dB8z1YQe/RzFa0dxNgvWKOcirRtvGbfrjt3Na4
	 JBjZOdr1hulZ2yjDExeKFggWzm+wTJ7fbMqzsRsNOV165cHVxd+bHdASgMaJ9rPIFg
	 eQz3gV6bwGQaYn3oRNJXwbbVVC2i5lLfMaorwNtQpwS59czgFVzCgdtsvV/tVnl/Vd
	 fs15NcxSdV5tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD5BBDF7855;
	Fri, 12 Apr 2024 09:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/6] rtl8226b/8221b add C45 instances and SerDes
 switching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171291362870.25479.143639528323659106.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 09:20:28 +0000
References: <20240409073016.367771-1-ericwouds@gmail.com>
In-Reply-To: <20240409073016.367771-1-ericwouds@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 Apr 2024 09:30:10 +0200 you wrote:
> Based on the comments in [PATCH net-next]
> "Realtek RTL822x PHY rework to c45 and SerDes interface switching"
> 
> Adds SerDes switching interface between 2500base-x and sgmii for
> rtl8221b and rtl8226b.
> 
> Add get_rate_matching() for rtl8226b and rtl8221b, reading the serdes
> mode from phy.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/6] net: phy: realtek: configure SerDes mode for rtl822xb PHYs
    https://git.kernel.org/netdev/net-next/c/deb8af524350
  - [v4,net-next,2/6] net: phy: realtek: add get_rate_matching() for rtl822xb PHYs
    https://git.kernel.org/netdev/net-next/c/c189dbd73824
  - [v4,net-next,3/6] net: phy: realtek: Add driver instances for rtl8221b via Clause 45
    https://git.kernel.org/netdev/net-next/c/ad5ce743a6b0
  - [v4,net-next,4/6] net: phy: realtek: Change rtlgen_get_speed() to rtlgen_decode_speed()
    https://git.kernel.org/netdev/net-next/c/2e4ea707c7e0
  - [v4,net-next,5/6] net: phy: realtek: add rtl822x_c45_get_features() to set supported port
    https://git.kernel.org/netdev/net-next/c/2d9ce6486270
  - [v4,net-next,6/6] net: sfp: add quirk for another multigig RollBall transceiver
    https://git.kernel.org/netdev/net-next/c/1c77c721916a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



