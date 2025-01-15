Return-Path: <netdev+bounces-158649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4AA12DB3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE1C3A4C9A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0721DB943;
	Wed, 15 Jan 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMWiQQuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81971DB15C;
	Wed, 15 Jan 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976611; cv=none; b=KFxM2QY2cjFHN/lEFS+Q6YIUK5YafAnPW5RYE+410NL4KlpDYDkBBPPh98J9dmY/UJGDRHw1R8ZOhP3v+ExfmYIGMZhQCa855x+2srZ7Qh3vHpNwqduEvOz+lt5oSarzbOLawcnlYj4l1Wi7REg9ChFRvmFGl0FK+aIQyTACSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976611; c=relaxed/simple;
	bh=DAZ1OUcJEkhA34HJivvdY5l8I6j6aFS+wT4ukAJ0H9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sMBDbBLbqbuSVg1Igw65hW3TqkfjpNtxCEEQh8m+yR8sgZExM1XeMpKjlnXsHx+ITzIYaatf64d/dmO9R4lvTE76Eu9xV9MmXHrUS4Dy9tvjqSwvcKPF6V788gPPcig4VYOrNZ//fqiVQA9xjz1PDm3+YY0kQACalFAB1IIsKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMWiQQuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACF2C4CED1;
	Wed, 15 Jan 2025 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976611;
	bh=DAZ1OUcJEkhA34HJivvdY5l8I6j6aFS+wT4ukAJ0H9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RMWiQQuuzh3jEpXmFh7smJxyyvhR8ebkqqftGe0uutT76bainXh9x+A/OlOXwUA9X
	 O4O4Qyj3vl8dXgyDmveien1XFBtp+2SNdUq+L5i0WhuZoalwscXJsdu9IMtcsfMaqR
	 r1wAlTegA1rksl8CjCghRkN0+rzrnO+xAnSW1hQLhWXtgRAahr5zWy29QYSU1YZeGk
	 Swbn9JKSavP5+WQwat3AuPHihzPDUuZjsxkntHX2NFjNFxPfA4Xdi2n42YjZ0lfu5s
	 IUfSFou9z5ElH8Vw8m9yN1ZXuogOChv3MJZMdnxVcbZ0H7KDNpjWlzfOmodxLnOq9y
	 jYoO1XZOgVIww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71F81380AA5F;
	Wed, 15 Jan 2025 21:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: pcs: xpcs: fix DW_VR_MII_DIG_CTRL1_2G5_EN bit
 being set for 1G SGMII w/o inband
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173697663427.885620.13714707273486620208.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 21:30:34 +0000
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Jose.Abreu@synopsys.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, weifeng.voon@intel.com,
 michael.wei.hong.sit@intel.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 18:47:20 +0200 you wrote:
> On a port with SGMII fixed-link at SPEED_1000, DW_VR_MII_DIG_CTRL1 gets
> set to 0x2404. This is incorrect, because bit 2 (DW_VR_MII_DIG_CTRL1_2G5_EN)
> is set.
> 
> It comes from the previous write to DW_VR_MII_AN_CTRL, because the "val"
> variable is reused and is dirty. Actually, its value is 0x4, aka
> FIELD_PREP(DW_VR_MII_PCS_MODE_MASK, DW_VR_MII_PCS_MODE_C37_SGMII).
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: pcs: xpcs: fix DW_VR_MII_DIG_CTRL1_2G5_EN bit being set for 1G SGMII w/o inband
    https://git.kernel.org/netdev/net/c/5c71729ab92c
  - [net,2/2] net: pcs: xpcs: actively unset DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII
    https://git.kernel.org/netdev/net/c/d6e3316a1680

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



