Return-Path: <netdev+bounces-204776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2861AFC08A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FC71BC05F2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8572264B8;
	Tue,  8 Jul 2025 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WulhMJaD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B9225408
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940623; cv=none; b=rw84GRhSyqzKBh6cquyPCMFD8478n8mxp4HvTrreaE67xcDVX12qW5sjlYJzVZygkKfKRNxBTXkIH1S50oQwihhKIgqc8rnWynZoIpK1yp7ze1nHg023IdcAm5kGxCKBwRga3HAeX9gvukGfAe6amh6V/jkV2yy0uQ/AY2m3KGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940623; c=relaxed/simple;
	bh=c8wMtNGdItjvu5hVqNQ8Pc56RJD7BdkWFIQr/JcthdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lIthgyChOh+lkzptoLCK6Ub/o54vCEE+qsoqbOlrdj1GG6DmWS02FqSkG236FC/I/6xW01wfv/5p4aShDUESA5nHfw9GD/iKNapLQMAmYk5nqGvTA3PtxyYEgjUeyGmNEp7CnHdJQZpW5Lt/Ehi+/NYUU3/aFu/VSAMRpjiuF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WulhMJaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69FBC4CEF5;
	Tue,  8 Jul 2025 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940622;
	bh=c8wMtNGdItjvu5hVqNQ8Pc56RJD7BdkWFIQr/JcthdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WulhMJaDoaEvqJ1dptgRmeW83b9wj9HSNQVBEFxAGhy4UoL1yCO/QytUVpM+A5Rp/
	 OZkR+WB3F+EOnurD6qi7nBC1xgiXqnfUdp60tiB8z39KFdvcKsF5oHcvbstXppQM7S
	 IOZd1WkIRbBKsQteGKib+cu743poFraee5MIlSgjIz2/xscWGtuYlgqNf7CRbg//Ue
	 GYOUKUIEUayFVg/mXSOjo+ycazAaPzw5WDkdQwfe4+DjNb3vcnymM3DLDLXHlA3Fxh
	 BRfgP9nX+0P6z5p1Ng3GvJR5yOr+uVhAMNs7ZKHvTmh3uDs3ZE8ieHlBTFsbX8ulJZ
	 ViGhEnUgR7f6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1738111DD;
	Tue,  8 Jul 2025 02:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: phylink: support !autoneg configuration
 for SFPs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194064574.3543842.2237520128566246088.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:10:45 +0000
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
In-Reply-To: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexander.duyck@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Jul 2025 10:44:38 +0100 you wrote:
> This series comes from discussion during a patch series that was posted
> at the beginning of April, but these patches were never posted (I was
> too busy!)
> 
> We restrict ->sfp_interfaces to those that the host system supports,
> and ensure that ->sfp_interfaces is cleared when a SFP is removed. We
> then add phylink_sfp_select_interface_speed() which will select an
> appropriate interface from ->sfp_interfaces for the speed, and use that
> in our phylink_ethtool_ksettings_set() when a SFP bus is present on a
> directly connected host (not with a PHY.)
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: phylink: restrict SFP interfaces to those that are supported
    https://git.kernel.org/netdev/net-next/c/ff1fce1bdd7b
  - [net-next,2/3] net: phylink: clear SFP interfaces when not in use
    https://git.kernel.org/netdev/net-next/c/b0fdff22d520
  - [net-next,3/3] net: phylink: add phylink_sfp_select_interface_speed()
    https://git.kernel.org/netdev/net-next/c/320164a6e172

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



