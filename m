Return-Path: <netdev+bounces-175613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3EA66D8A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB5D169AFA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9389B1E1DE6;
	Tue, 18 Mar 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWjcObUZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA121E52D;
	Tue, 18 Mar 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285400; cv=none; b=QEzwHrdsJEvn5ssl9r0l2Ad0YBqrRVGsRwXC+Xo9XthdaT0dUrfz562MzjytUdO3Jg4lz58QEXzTFt9avJTY/QS140y6H5OdBvD676JkHRm22egd324NcNyqfFsgx2SIgfVxalpZHVP0pASmsEndU+oMBva6dDfrqMG8TIEJ+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285400; c=relaxed/simple;
	bh=e4UkUqezG5Edul9MR9g7cuOdXGh4POpZl16i1wixQDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SrZmgWkaHwATxjHa8r5JZG+vXRORhLspxHFSvyiQiK+Po43nH6GFZ8SnR5dHq2v5SpQmmMOSMnWwttl3uZGJMRJ4ML1z/aKI5Ss5Aw09SWyBu6n3KdA04gJ/FY6SJvDMPw3Au5pHLcNnvK55Y/YG6qdlvgXaGSn0vR4ubv9zOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWjcObUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE585C4CEDD;
	Tue, 18 Mar 2025 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285399;
	bh=e4UkUqezG5Edul9MR9g7cuOdXGh4POpZl16i1wixQDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWjcObUZxhGiH4eIk1yWPqxDOE5HkuArp5QehkKNI6dRN9NBC7+htVOdEkVXhhUqS
	 yZ6t/6zxWh4M7++33uZERs75I4qJMmZPg8rwPACrkP9AU768Y1BajdVFGn1B3rIf1i
	 soZ/X1MkWoTqesRTXq6KABjtY/9szNg13Ap6lHIgA3poaB7NOYCji+pgbeQNfR5/5c
	 Kip0rplrjKD66t39hV4AEzqv6WZK9WqPtC8W7YyGQLuTSk/J12P5UQbaeZ0Sz044VV
	 io4OfxejnSAQToQbHLpCUAwXUYoiNp0DdFwKqiK2QE9QSgJnYHGfB2HB92nWEy53/Y
	 /u4vLPFKKK1aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E85380DBE8;
	Tue, 18 Mar 2025 08:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/13] net: phy: Rework linkmodes handling in a
 dedicated file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174228543527.4071400.14783355936899188267.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 08:10:35 +0000
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com, f.fainelli@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com, o.rempel@pengutronix.de,
 horms@kernel.org, romain.gantois@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Mar 2025 18:35:57 +0100 you wrote:
> Hello everyone,
> 
> This is V5 of the phy_caps series. In a nutshell, this series reworks the way
> we maintain the list of speed/duplex capablities for each linkmode so that we
> no longer have multiple definition of these associations.
> 
> That will help making sure that when people add new linkmodes in
> include/uapi/linux/ethtool.h, they don't have to update phylib and phylink as
> well, making the process more straightforward and less error-prone.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/13] net: ethtool: Export the link_mode_params definitions
    https://git.kernel.org/netdev/net-next/c/79f88a584e35
  - [net-next,v5,02/13] net: phy: Use an internal, searchable storage for the linkmodes
    https://git.kernel.org/netdev/net-next/c/d8c838a57ce2
  - [net-next,v5,03/13] net: phy: phy_caps: Move phy_speeds to phy_caps
    https://git.kernel.org/netdev/net-next/c/8c8c4a87933d
  - [net-next,v5,04/13] net: phy: phy_caps: Move __set_linkmode_max_speed to phy_caps
    https://git.kernel.org/netdev/net-next/c/4823ed060919
  - [net-next,v5,05/13] net: phy: phy_caps: Introduce phy_caps_valid
    https://git.kernel.org/netdev/net-next/c/87b22ce31235
  - [net-next,v5,06/13] net: phy: phy_caps: Implement link_capabilities lookup by linkmode
    https://git.kernel.org/netdev/net-next/c/dbcd85b05c5b
  - [net-next,v5,07/13] net: phy: phy_caps: Allow looking-up link caps based on speed and duplex
    https://git.kernel.org/netdev/net-next/c/fc81e257d19f
  - [net-next,v5,08/13] net: phy: phy_device: Use link_capabilities lookup for PHY aneg config
    https://git.kernel.org/netdev/net-next/c/c7ae89c6b4d5
  - [net-next,v5,09/13] net: phylink: Use phy_caps_lookup for fixed-link configuration
    https://git.kernel.org/netdev/net-next/c/de7d3f87be3c
  - [net-next,v5,10/13] net: phy: drop phy_settings and the associated lookup helpers
    https://git.kernel.org/netdev/net-next/c/ce60fef7fecc
  - [net-next,v5,11/13] net: phylink: Add a mapping between MAC_CAPS and LINK_CAPS
    https://git.kernel.org/netdev/net-next/c/3bea75002a05
  - [net-next,v5,12/13] net: phylink: Convert capabilities to linkmodes using phy_caps
    https://git.kernel.org/netdev/net-next/c/4ca5b8a258b6
  - [net-next,v5,13/13] net: phylink: Use phy_caps to get an interface's capabilities and modes
    https://git.kernel.org/netdev/net-next/c/3bd87f3b4405

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



