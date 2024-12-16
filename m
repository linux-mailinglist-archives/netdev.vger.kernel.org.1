Return-Path: <netdev+bounces-152197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4009F310B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597EF1670E5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3E82054FA;
	Mon, 16 Dec 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhVN65rZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E52054EF;
	Mon, 16 Dec 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354014; cv=none; b=RC+afxNbhenuaGyauN3miFM2oft/1dGI62yFuSD5cnPVOKok0hgsDeP+6VfqRqdeksSIWQ5sg04H/xNbotgPAqc5tCVvAs8FuiPWpPql1yrBEKqBW5WJ/Cdk3g+Cwf3NW1QOKfByDMSFaHCtSGeRPkzLy1FQjRAbAqpyamFgib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354014; c=relaxed/simple;
	bh=sr4NAeo/7zopeTyqAezpSOvUbsG/1bsunxopKYT/1Dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p3GwgT7gOBDGSG6OB+PGMMPbR6SS6g+ZfIjl5sJBwIOwlwK+GDGDwZF0sQ6ClZm2sgI/fdbLnHTtPRCFZIB2H7AMh9xuep/goL+DxFmOVLmkJb4EAS2tRB+G/uTnFAVovdO6mBUoM4NFBT7c83g3nXsi/l8bv6TMPSi9SpJ90ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhVN65rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0716C4CED0;
	Mon, 16 Dec 2024 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734354014;
	bh=sr4NAeo/7zopeTyqAezpSOvUbsG/1bsunxopKYT/1Dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XhVN65rZEK40j30RgkPs7MRj/W5wWcVGJIscBqYPjtyokJs1eflG7fErNfVSIB9bS
	 WtjhY0IPGHc5nzwP7zVbBo8cPh0zRW7wX7jVlYfZ84tCth/DVLVWxyPL7gQJWjbKip
	 XFEYOr2qXkvqwe8/na1dOLebXRVujUYs667+9XNr5xPh5kB0YgbbJggVQR7Hqjx2Wy
	 4XXpfobleiR5SfQcFnF0f+VoQrVbcQ4h5U0ueYPzhgsr6RaIQIKkNigtRo6ygrD0te
	 t1iPrRO4yIEjNUklxGuXi38AhI3KnFUJLigSc6DZb/6XmsU7JXxoXHXbQH0kXwVBx+
	 kwfbqhUReVmww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D793806656;
	Mon, 16 Dec 2024 13:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v21 0/5] net: Make timestamping selectable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173435403101.199619.15275877652330173258.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 13:00:31 +0000
References: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
In-Reply-To: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, radu-nicolae.pirea@oss.nxp.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, willemdebruijn.kernel@gmail.com, corbet@lwn.net,
 horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com, horms@kernel.org,
 vladimir.oltean@nxp.com, donald.hunter@gmail.com, danieller@nvidia.com,
 ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, thomas.petazzoni@bootlin.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, maxime.chevallier@bootlin.com,
 rrameshbabu@nvidia.com, willemb@google.com, shannon.nelson@amd.com,
 wintera@linux.ibm.com, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 12 Dec 2024 18:06:40 +0100 you wrote:
> Up until now, there was no way to let the user select the hardware
> PTP provider at which time stamping occurs. The stack assumed that PHY time
> stamping is always preferred, but some MAC/PHY combinations were buggy.
> 
> This series updates the default MAC/PHY default timestamping and aims to
> allow the user to select the desired hwtstamp provider administratively.
> 
> [...]

Here is the summary with links:
  - [net-next,v21,1/5] net: Make dev_get_hwtstamp_phylib accessible
    https://git.kernel.org/netdev/net-next/c/5e51e50e2324
  - [net-next,v21,2/5] net: Make net_hwtstamp_validate accessible
    https://git.kernel.org/netdev/net-next/c/b18fe47c0c09
  - [net-next,v21,3/5] net: Add the possibility to support a selected hwtstamp in netdevice
    https://git.kernel.org/netdev/net-next/c/35f7cad1743e
  - [net-next,v21,4/5] net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology
    https://git.kernel.org/netdev/net-next/c/b9e3f7dc9ed9
  - [net-next,v21,5/5] net: ethtool: Add support for tsconfig command to get/set hwtstamp config
    https://git.kernel.org/netdev/net-next/c/6e9e2eed4f39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



