Return-Path: <netdev+bounces-88647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F58A801A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89BE1C2162D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58042136E13;
	Wed, 17 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4VNWHbg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E412F37C;
	Wed, 17 Apr 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347430; cv=none; b=obf+DrtAme43mavk6x0G7Gsiuvme9evBnk1rbhVhE/jH0gAfJ9XnIfNpui585DyYK9TsOgZhCNUB+B0Bc2J36pqrwJE9sN51yjB3SyiLOYiv9ZSA5dDTHC9lgHGlQwEpDIfgXmVhLUw74K5PniEbGPyHXmwgz82woTbNqKfETjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347430; c=relaxed/simple;
	bh=tBFygEfgSUOLTCcaP5hAlsAek9UxTj79UaNMYkCENrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JbhfUySeoLDfaoitW0WaQoyXu04J7vAosENR50d7Cbso2BXrRV4niuBuUvUUMOmiS2GYSG1HFJdSWRm0h9K1FiDGCSAwJj3e362xvlFLT0fkU4xbhTESUCZqsqX/DePuDx8/tG1Ln8wu/2IdIXLr9JCIN7vFKsTEKRWAAZEkvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4VNWHbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2538C072AA;
	Wed, 17 Apr 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713347429;
	bh=tBFygEfgSUOLTCcaP5hAlsAek9UxTj79UaNMYkCENrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S4VNWHbg0UIkFb04/UpCUqvZN9Au5SJjFlsCVGBIkENYVpRDtdJz91xAVMmda8XVY
	 uQZ12U7P4m0+G3aXiM1Te1ZcURvlELXIDoxUia5NFyoX8HpxvBCWAS/VoQXU7P5wjW
	 jroMfBLOqySTkRDiHJnK/H2ksghvy/nBsrcqwM6wIjOhNV+J9vGNzQ84joGa9JJMFt
	 PFgrH8Ed7SRtRWO0UGBYGbgdRLP8AOkgRyoDA176g1geYcpgmQ6tQ2TS4S15fbpwlR
	 O+rB9IalE23M6rO4gPtJ4mrDxjYlyUHONOuD5OZVKoXwUlSYtWty3HvFRp0T4AhrsR
	 EZaP73M64Gl/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF5E3D5B3FD;
	Wed, 17 Apr 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: mediatek-ge: do not disable EEE
 advertisement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171334742971.18271.14228801300401339058.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 09:50:29 +0000
References: <20240414-for-netnext-mediatek-ge-do-not-disable-eee-adv-v1-1-2fefd63c990b@arinc9.com>
In-Reply-To: <20240414-for-netnext-mediatek-ge-do-not-disable-eee-adv-v1-1-2fefd63c990b@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 14 Apr 2024 00:08:13 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The mediatek-ge PHY driver already disables EEE advertisement on the switch
> PHYs but my testing [1] shows that it is somehow enabled afterwards.
> Disabling EEE advertisement before the PHY driver initialises keeps it off.
> Therefore, remove disabling EEE advertisement here as it's useless.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: mediatek-ge: do not disable EEE advertisement
    https://git.kernel.org/netdev/net-next/c/af3b4b0e59de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



