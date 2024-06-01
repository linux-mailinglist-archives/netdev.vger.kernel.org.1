Return-Path: <netdev+bounces-99956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5618D72BC
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB2C1C20B31
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD544366;
	Sat,  1 Jun 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB4XYslc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6452208AF;
	Sat,  1 Jun 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284630; cv=none; b=Khl0WE/Xo+XyBI/Jc/MfPq3glXqOGvGNj+7Sf11iYprjDuXBpBt+Q0CwRjREuu+YhiFyZt1IoaAnByshNxdbNoLO7KBZ/4AKKDJxCmUss8UBGsvVMUjCwydZHu1uaAnzzbA0Rgt+FCllaypA/aVWAYN9GKMEVJa4+TTeQSmosVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284630; c=relaxed/simple;
	bh=HtIY8x63o4gVdI41Mc4Yw+56jEwaKmExL0kjyQf2kow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMcxA4hQvvyNFHk/mo6MKYgYrrbcrAFQm+9bGS2wkFYADn1akzDUOEQ6kwhU3iCBKQs3XbG55AEYrH+rUMRhkOuo/RQbKhoCjvrRcRVMvea+UwtHrXvWdxkIB9uljDcOnuV24CskLgiUXTJnccH224n2wTsUnya3Vmpp90bsq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB4XYslc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B9E1C32786;
	Sat,  1 Jun 2024 23:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717284630;
	bh=HtIY8x63o4gVdI41Mc4Yw+56jEwaKmExL0kjyQf2kow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jB4XYslczypI1UzS3ud8z6ErderAdRCufOuuyJqHPt4pRICpE9dLOgCWSAB+D0UkO
	 1Fe/ozK1MCp9K5vMKTLWbbgDV4QxE+ZbujE9/vIlkIW9umCO6ZNE4tuIXwUa+nmV4s
	 yPLGjS9hSUEcQ73lCpUtGSMAr9Yrfo8tFP5rwspavQ6IwPTP6YKfSsB8+kjeLiVrN6
	 nHp0cqxFkmZmOms9NhoFYvQ+UnvgfuaCdF4BBYSb6S1LIn+R+xPqA/yn0zhRztVoI6
	 U2x1ttQY2C4rS54rEADknfyTZb7oBYLFsU1pufwj/BzRKpvdlUbVhPUpthdUakU6j7
	 UJLQjnrgOZ5tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A689DEA711;
	Sat,  1 Jun 2024 23:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] lan78xx: Enable 125 MHz CLK and Auto Speed
 configuration for LAN7801 if NO EEPROM is detected
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728463016.18107.17504072310645117786.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:30:30 +0000
References: <20240529140256.1849764-1-rengarajan.s@microchip.com>
In-Reply-To: <20240529140256.1849764-1-rengarajan.s@microchip.com>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 19:32:54 +0530 you wrote:
> This patch series adds the support for 125 MHz clock, Auto speed and
> auto duplex configuration for LAN7801 in the absence of EEPROM.
> 
> Rengarajan S (2):
>   lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is
>     detected
>   lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801
>     if NO EEPROM is detected
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is detected
    https://git.kernel.org/netdev/net-next/c/5160b129f65f
  - [net-next,v3,2/2] lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801 if NO EEPROM is detected
    https://git.kernel.org/netdev/net-next/c/799f532de136

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



