Return-Path: <netdev+bounces-56816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A557C810EA3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6166E281C7F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE2022EFC;
	Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJkFjeOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372722EE5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34E42C433C8;
	Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702464030;
	bh=c+1PFNEkC4A+LLxD+XpEmnkymaSi1JXA3p6IX0GBiB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AJkFjeOCfla2AmGTd2F1swbwf6j7K6mgJFuitMNDYhs336vFXXgUIFrro4srJT5/6
	 KB2DTPDR1Y16rIr+anN7cmDgG2yxkmT7u4e1R+XUbAYF+qkxzfkxMOtBDo1T2rVH90
	 /TYUqI4V91t2FUkf4OIAYtmp4jHTgt9fPIKIE8ASysLF18/URwMgb3kF4P3HiRqf1N
	 +nIADHaQ3dH1+9EseQPakA6hEpeLZIipWlH+VyqWNZ8fhb9L7cv2dHW+M27VkX/arE
	 ttWwj/FPs/lXbBUiCOt8tSmoUkwsTc5ACMq124Zg8mLTUXooU+0e4CwoSJpxukpbat
	 mvbY4/HCmQuCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20545DD4EFD;
	Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4 00/13] net: phy: at803x: cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170246403012.27343.9115433848514834171.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 10:40:30 +0000
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Dec 2023 15:51:47 +0100 you wrote:
> The intention of this big series is to try to cleanup the big
> at803x PHY driver.
> 
> It currently have 3 different family of PHY in it. at803x, qca83xx
> and qca808x.
> 
> The current codebase required lots of cleanup and reworking to
> make the split possible as currently there is a greater use of
> adding special function matching the phy_id.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/13] net: phy: at803x: fix passing the wrong reference for config_intr
    https://git.kernel.org/netdev/net-next/c/f8fdbf3389f4
  - [net-next,v4,02/13] net: phy: at803x: move disable WOL to specific at8031 probe
    https://git.kernel.org/netdev/net-next/c/6a3b8c573b5a
  - [net-next,v4,03/13] net: phy: at803x: raname hw_stats functions to qca83xx specific name
    https://git.kernel.org/netdev/net-next/c/07b1ad83b9ed
  - [net-next,v4,04/13] net: phy: at803x: move qca83xx specific check in dedicated functions
    https://git.kernel.org/netdev/net-next/c/d43cff3f8233
  - [net-next,v4,05/13] net: phy: at803x: move specific DT option for at8031 to specific probe
    https://git.kernel.org/netdev/net-next/c/900eef75cc50
  - [net-next,v4,06/13] net: phy: at803x: move specific at8031 probe mode check to dedicated probe
    https://git.kernel.org/netdev/net-next/c/25d2ba94005f
  - [net-next,v4,07/13] net: phy: at803x: move specific at8031 config_init to dedicated function
    https://git.kernel.org/netdev/net-next/c/3ae3bc426eaf
  - [net-next,v4,08/13] net: phy: at803x: move specific at8031 WOL bits to dedicated function
    https://git.kernel.org/netdev/net-next/c/27b89c9dc1b0
  - [net-next,v4,09/13] net: phy: at803x: move specific at8031 config_intr to dedicated function
    https://git.kernel.org/netdev/net-next/c/30dd62191d3d
  - [net-next,v4,10/13] net: phy: at803x: make at8031 related DT functions name more specific
    https://git.kernel.org/netdev/net-next/c/a5ab9d8e7ae0
  - [net-next,v4,11/13] net: phy: at803x: move at8031 functions in dedicated section
    https://git.kernel.org/netdev/net-next/c/f932a6dc8bae
  - [net-next,v4,12/13] net: phy: at803x: move at8035 specific DT parse to dedicated probe
    https://git.kernel.org/netdev/net-next/c/21a2802a8365
  - [net-next,v4,13/13] net: phy: at803x: drop specific PHY ID check from cable test functions
    https://git.kernel.org/netdev/net-next/c/ef9df47b449e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



