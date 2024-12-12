Return-Path: <netdev+bounces-151295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7309EDE83
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7206280F94
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2D189B8D;
	Thu, 12 Dec 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfKpjCTB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F816189B8B;
	Thu, 12 Dec 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977830; cv=none; b=e+rqBFfvRmIGBDEoiIqj58ghRiGBZ0gaEHWfz4hYj/O6oqF533nTuGBYgM0tFlVWlfoh70EOMDikYh6MSo9qRAps4Hpgf32ybQYQV9glE6rlC5Sc0BojKWKqG+PnKeJqpG5jmshjEKrSkbqY5vW35CyKea/RbTigcUXMcyAmFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977830; c=relaxed/simple;
	bh=0Vj80Ta0OW9QfO74TR+rFZIcL08hS399Iy88X8eLzYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iSupZ+QKsVKdWzghV5xlpHjJB9JpFXxhYyoATwJmc5A6py3M1IxEVxdgI+i41xQ4j7HFOZXLDHFauhK0ja4OYqNA382Tq0Vc40ReIxS3f9VBhhQtsZtoKRYwLA1nE4RZsdpEYPiKeo9yDs04rm6spbB6leRSzNjaTgvQ2Dl3dhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfKpjCTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74734C4CECE;
	Thu, 12 Dec 2024 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977830;
	bh=0Vj80Ta0OW9QfO74TR+rFZIcL08hS399Iy88X8eLzYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SfKpjCTBHkdF2wxAjn/oQA+DT5eJWNYFHOikz3ifqdSrOI3UQtG9noDgjZTV6hRjQ
	 23FR8iOiKZwEfAu2bX6IheCAI0UbvxWMNreo0YOr1mu2Dyd8DevGF9ZBhhlevk2H1E
	 Q5n6wNdl8hG1ZLl0SiPJOqFxMHA/BBTLrA/cszYvoZORMIBN0SqnKgbFR75I5O1tdi
	 dgvMeunyEJtEVZgJgpPuYBy57Q2ZebxnrlTLm2QGKCkGU1wib0i6aZLByjDhoMEvm1
	 bgcdf3yxNzSxM1vxajmNyV7XNbIt7qGbzHhYi9iRed6TKNcwyuH5xu25UGuHiATpyi
	 CR/3CyVIpV9eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0A79380A959;
	Thu, 12 Dec 2024 04:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: use phydev->eee_cfg.tx_lpi_timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397784649.1847197.3581070398078320436.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:46 +0000
References: <E1tKzVS-006c67-IJ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tKzVS-006c67-IJ@rmk-PC.armlinux.org.uk>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, wei.fang@nxp.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 imx@lists.linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 12:38:26 +0000 you wrote:
> Rather than maintaining a private copy of the LPI timer, make use of
> the LPI timer maintained by phylib. In any case, phylib overwrites the
> value of tx_lpi_timer set by the driver in phy_ethtool_get_eee().
> 
> Note that feb->eee.tx_lpi_timer is initialised to zero, which is just
> the same with phylib's copy, so there should be no functional change.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: use phydev->eee_cfg.tx_lpi_timer
    https://git.kernel.org/netdev/net-next/c/3fa2540d93d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



