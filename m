Return-Path: <netdev+bounces-21698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3290D764510
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5321C2149B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9A1FA9;
	Thu, 27 Jul 2023 04:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188A1FA0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3B4EC433C9;
	Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690433419;
	bh=MkujO+AHnKa+uJ0U9wZ9p1P1wFZ14Hb6A67Wo9vtzxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WfYz5HxsGEL+ZESXhE5rvdM5h5AbH9Wp/xzTKt+6KziGrF/HLkSIjeLcoGyj9yL/P
	 HiztTbQ565EfcnXZcvaSd3bo2mvLFnxJACNLQAJ1CId5PDiZEEV1HhUsxIXLcIH2/F
	 q5KqmwryEd2z3taSXJoExDusp5MTK4eYTkggyYl5NoCX+iuK7mK/fi7Wu+PQ/i1BMo
	 ddHdHSQne79INxqzMP9Ur5kuwLYxp2SKv/BylGHhODyWp2J/W6VK3bj1Ww80NJ6Zyd
	 m/gEnk49dqm1g6/SsVH7d91fpxebfwm5EwRWGWgCsvnwbAqn5EL3mZ6anEB4MFHD+e
	 +3mpM2WmBdfwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94AF9C595D0;
	Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043341959.19452.10457255901157094054.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 04:50:19 +0000
References: <1690329270-2873-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1690329270-2873-1-git-send-email-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 16:54:30 -0700 you wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>
> 
> Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
> Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
> of frame data, which can be used to implement ARP or multicast WoL.
> 
> ARP WoL matches any ARP frame with broadcast address.
> 
> [...]

Here is the summary with links:
  - [v6,net-next] net: phy: smsc: add WoL support to LAN8740/LAN8742 PHYs
    https://git.kernel.org/netdev/net-next/c/8b305ee2a91c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



