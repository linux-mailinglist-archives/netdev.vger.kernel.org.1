Return-Path: <netdev+bounces-129488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19073984194
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F49B25558
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B859155308;
	Tue, 24 Sep 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBBCEkka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357C1474C5;
	Tue, 24 Sep 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168539; cv=none; b=h8Ud7nvQ/oSwxH+Qqt2sbbzjb+UpJyummxNaWQ7kXWlyPkEBN1BzmJNZ2z5IZorMD5dD4rPkxa9OoNdCP4ywZVCaZNiCTmYyiAR50ctIqw64C3axw7wtyYavSQnUdpVvUQbzafVBogAUldb55e400CS9NFPAYlCqSM9h6F1VlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168539; c=relaxed/simple;
	bh=XGDX134FSG4Fp47B80thHQRWRGoHobKxUbRN/NRHEoY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XtkpioxZIW2oR2+jol1fZ+EkTCvrV9sFbd6od3yH70Yt+zqf2PC1FbXP0iiupLXFd1ftA72GBL+FpJClhP69LVqTDwDHvKrKw4xrxeSvoJ0lR5pXxz+a93Rx/ncBUWupCdkvjZAnX0hLSUg6zRDRk34IucFmOkluipmAaVDUKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBBCEkka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E36EC4CEC4;
	Tue, 24 Sep 2024 09:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727168538;
	bh=XGDX134FSG4Fp47B80thHQRWRGoHobKxUbRN/NRHEoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jBBCEkkaY1p7jkYQLdh+FqWvQY0c3KTXC9XcyGtqoV1x3O2VXcG1+mDXJgTy0/Wsg
	 bR18Pw8NwovY/haOFc48i2CIRjPXgyg0M1yimFa0kqidjFHDpqw5K1KfWmiUXPBGRk
	 eZIWMfgyjDqX9oa4hOIWdN4Ksl9Nlshowk4MNK1ZRP2Wkkxrt9cewUnvUxKPkht+36
	 zHcPP3R/+wDI+Zytz6vNS7RPuNq8qFNvf+K941XsElrEQkYQRqZz0/+C/cdhy1LmWe
	 l28sZ+GGekdIp81MCXD7xeCold9vkFTXE304xiQjh74z4fdtnsODHxKhZz31lql6GA
	 x+HX5OV1B/fTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344793806655;
	Tue, 24 Sep 2024 09:02:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: phy: aquantia: fix setting active_low bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172716854102.3946404.10055646169989118874.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 09:02:21 +0000
References: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
In-Reply-To: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, bartosz.golaszewski@linaro.org, robimarko@gmail.com,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Sep 2024 14:49:40 +0100 you wrote:
> phy_modify_mmd was used wrongly in aqr_phy_led_active_low_set() resulting
> in a no-op instead of setting the VEND1_GLOBAL_LED_DRIVE_VDD bit.
> Correctly set VEND1_GLOBAL_LED_DRIVE_VDD bit.
> 
> Fixes: 61578f679378 ("net: phy: aquantia: add support for PHY LEDs")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: phy: aquantia: fix setting active_low bit
    https://git.kernel.org/netdev/net/c/d2b366c43443
  - [net,2/2] net: phy: aquantia: fix applying active_low bit after reset
    https://git.kernel.org/netdev/net/c/6f9defaf9912

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



