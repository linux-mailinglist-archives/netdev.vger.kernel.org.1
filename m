Return-Path: <netdev+bounces-216733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4A4B35027
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68455E5DD5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0D0202C46;
	Tue, 26 Aug 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajA5472H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BF1FBE9B;
	Tue, 26 Aug 2025 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167608; cv=none; b=BEP7jZlmSfoVDtJsTp8oVrQItoG64XeKe8KWkZvvEbmgd8hRR8jvLiXOhAGgWeNv1ueKT2NoMfFFsH5DDFLqDTm945e8+x9PLGVi3qS/mxcd+zSu9jeOtEmj4TZxbjFDdI0lhmdj6ZMI6C6P0S95592Phy4Lx8MOauvpxKcfXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167608; c=relaxed/simple;
	bh=ufcItHeInVLxDOUg5JkvH/qxMTNuGx9vdAS1KoJUQb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWHZHUL0JtWurMmEOMgo6GamBx+/j1RSEvL9LiHNincYcWnspf3ie4u7jhbh2AMYBreszTyqhiMz6qrVTqlaHjNfLtAoX4stIbJi6MNoKGFcokjj9bAyY4z96grBxw4DRWd/dUPoCkIlMbmbDmG022F8q9ob5Ao77LQR7EHi9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajA5472H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FAC4CEED;
	Tue, 26 Aug 2025 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756167607;
	bh=ufcItHeInVLxDOUg5JkvH/qxMTNuGx9vdAS1KoJUQb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ajA5472HKMBLoiAjeEtQFR9h3nup9xaJRLk8i8TJY3U07cRA4SlgHNUDe7aS6M1R4
	 54e4WZcOB0Uw8QRdivq/G/+z9uomlJbYGEhk+l+W862xmGvawyLqBGMi/a9G9eYnSu
	 e2gS5n2EHWBTZUx+I337Xv9A1I5AWPhlKE7zwWfH6fKZ59ZQDBnIMJss0aB9D/zeP9
	 ft5USw1y5Fn6ygrS+6pa89QH5iIBCjjh2KS+JmCi+RPKS+vzJCgbLurM9VRH6PbNvQ
	 KLpOU1PUvJAVqBNsF6ruuXqGm6InSd7O4z/nYkGBll1++jtaYaZolPBVq5Mref45xh
	 yDcCD1lh9uH2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEAE383BF70;
	Tue, 26 Aug 2025 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/3] net: phy: mxl-86110: add basic support for
 led_brightness_set op
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616761549.3604027.13517820939492264088.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 00:20:15 +0000
References: 
 <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>
In-Reply-To: 
 <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 18:38:27 +0100 you wrote:
> Add support for forcing each connected LED to be always on or always off
> by implementing the led_brightness_set() op.
> This is done by modifying the COM_EXT_LED_GEN_CFG register to enable
> force-mode and forcing the LED either on or off.
> When calling the led_hw_control_set() force-mode is again disabled for
> that LED.
> Implement mxl86110_modify_extended_reg() locked helper instead of
> manually acquiring and releasing the MDIO bus lock for single
> __mxl86110_modify_extended_reg() calls.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] net: phy: mxl-86110: add basic support for led_brightness_set op
    https://git.kernel.org/netdev/net-next/c/29c10aeb3160
  - [v4,2/3] net: phy: mxl-86110: fix indentation in struct phy_driver
    https://git.kernel.org/netdev/net-next/c/befbdee4ba89
  - [v4,3/3] net: phy: mxl-86110: add basic support for MxL86111 PHY
    https://git.kernel.org/netdev/net-next/c/3d1b3f4ffc0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



