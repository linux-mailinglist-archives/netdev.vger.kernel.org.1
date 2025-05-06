Return-Path: <netdev+bounces-188215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2006EAAB8EC
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC59162B3A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94427C14A;
	Tue,  6 May 2025 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIaKC8P2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19693287508;
	Tue,  6 May 2025 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746495596; cv=none; b=p1aiEvlxZL/OMOhvvvNTJEih8qABfI57gAFpmBxIeCmQ8sEi1EveKISen4i8OPKvM87qlmv+Ey1GuFFePNHxKgop8WMp2Crc6ZrFxyy5RWVb3S5Xy6adT0kzXb6E/dzfJE1O45kVkw5TBFyQmiys2h51mdOcck+9odfmCRYlUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746495596; c=relaxed/simple;
	bh=J6VCx58aPIj5qLD9UFq5VcZ5/9rOOJrDsTC8KP7EURs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D/2hA+RLdi9R/Uv3phar7cnT12sj92mH1YX+7aJD20D/wjVawDqvKHPfHT0xTeazkDwqTq1viyJET8rxx7MpAybzRTqrNyvudr1/YzOEB/YI3ZvKk7GeF+njevQkqG9AvdWwNQqzIBjVoS6d+mWquPb0MS1oNLrl9G0i5cpOUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIaKC8P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8404AC4CEE4;
	Tue,  6 May 2025 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746495595;
	bh=J6VCx58aPIj5qLD9UFq5VcZ5/9rOOJrDsTC8KP7EURs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dIaKC8P26H7DvCj/y0I+1KYUj0Al7QftxVLpD+HbitX+IJ0B5frvsOD+Obnhai/ar
	 AHglRqyWCV3UumGQCsk4FrlWAFoYaHx4SD76o/GR0Wm8RvQ62KTwUKc+cfdxbmA8xj
	 YFcmFw7/xbnFT2jxOf5eylTUTCcEyw7a1h5od0xyaubWDXFLeOqJEL/4yqnAKKnGOA
	 8hu78rxvivN+Rz7ZVICVBt6/gkUwxVREwzUwOdfvjEiCPcboD+KrEp06AtBXvSzAwL
	 8MvU9GMP/+VZXHkC7wh2bgsyxMjRW0LRhIHpBDGzorukQxdEv/MC05v4pMFqjsKxR5
	 ey1iG0FmsGojQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACB8380664B;
	Tue,  6 May 2025 01:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] net: ethtool: Introduce ethnl dump helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174649563473.1007977.7672899969747094787.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 01:40:34 +0000
References: <20250502085242.248645-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250502085242.248645-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, linux@armlinux.org.uk,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com, o.rempel@pengutronix.de,
 horms@kernel.org, romain.gantois@bootlin.com, piergiorgio.beruto@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 May 2025 10:52:38 +0200 you wrote:
> Hi everyone,
> 
> This is V8 for per-phy DUMP helpers, improving support for ->dumpit()
> operations for PHY targetting commands.
> 
> This V8 fixes some issues spotted by Jakub (thanks !) on the multi-part
> DUMP sequence. The netdev reftracking was reworked to make sure that
> during a filtered DUMP, we only keep a ref on the netdev during
> individual .dumpit() calls.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] net: ethtool: Introduce per-PHY DUMP operations
    https://git.kernel.org/netdev/net-next/c/172265b44cd3
  - [net-next,v8,2/3] net: ethtool: phy: Convert the PHY_GET command to generic phy dump
    https://git.kernel.org/netdev/net-next/c/9dd2ad5e92b9
  - [net-next,v8,3/3] net: ethtool: netlink: Use netdev_hold for dumpit() operations
    https://git.kernel.org/netdev/net-next/c/63fb100bf524

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



