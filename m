Return-Path: <netdev+bounces-242218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E845C8DB1D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B9834E1072
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35B2FF672;
	Thu, 27 Nov 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDF+Dk7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A412E0418
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238257; cv=none; b=U9Yc79Y3Q3waBoFIFhM3dGOjZn1xfB9LZHPTrf/2jYy6QwEkmJvFSJkb6kwE4n0wP5/waQyxP395zNMSwhHd0Pz/a97G0XI4y1xfypQJlCpEwrvSqtLG3FiDjgarOvs+hhjvxKoCWVkq3RbVb1f+onWe7E4uVBhBrLM1L+ge0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238257; c=relaxed/simple;
	bh=DAF01hAWK4F1G2WkXZYb493HZknwri3FfkNRByBwVZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bz0hn4AdOfHVjDjkbfIh6mi6ADbELsCz6tvQPlR3ta6/xbGAumgBVFqyUK6W/AcmB7RSvgvYdZV/4w6QdvNEiH4k7Qw4CoBrC8KCq4IbB7oVw9krIuQr6mndAnMZCZ1Ipb8y5rNTEz1REJmwdxZ/pjVKUkh7w8kC4ZftprTzPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDF+Dk7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2C9C4CEF8;
	Thu, 27 Nov 2025 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764238257;
	bh=DAF01hAWK4F1G2WkXZYb493HZknwri3FfkNRByBwVZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DDF+Dk7+4GjOrElfMB7ViPBg0+pdJHUrgcmqfsOKMs4cYJ7voaKDlPZGhD0FVwHjF
	 4UQ5u9IsLcSsS35o7DSm3falOX83DxXkqnhDh5FjUjPPTToWKLMlSr4CObdMVmBoLz
	 xYw0oEl6s8irFPnk1UqbC6KNjGnahjcrvUQYbSMiHfyuDsJLNcxUTVpEXein3VELa9
	 o1IdcZbT3ucD+Z+8KVQVkGRzJ1Kfvy2yUvwLWn0uSNHAV0XXioNC1pX0E+W2XH4BwV
	 XzTG5BoTzllcLrB8kKicXgE8WaPw1l7ARX5yrEG+mpssEmcjVtuOlzHaarir60b2dg
	 4FYyW4vLlq0pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAD380CFC3;
	Thu, 27 Nov 2025 10:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v5 0/9] net: phy: Add support for fbnic PHY w/
 25G,
 50G, and 100G support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176423821850.2508458.8740995882109823586.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 10:10:18 +0000
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Nov 2025 08:39:48 -0800 you wrote:
> To transition the fbnic driver to using the XPCS driver we need to address
> the fact that we need a representation for the FW managed PMD that is
> actually a SerDes PHY to handle link bouncing during link training.
> 
> This patch set introduces the necessary bits to the XPCS driver code to
> enable it to read 25G, 50G, and 100G speeds from the PCS ctrl1 register,
> and adds support for the approriate interfaces.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] net: phy: Add MDIO_PMA_CTRL1_SPEED for 2.5G and 5G to reflect PMA values
    https://git.kernel.org/netdev/net-next/c/e6c43c950090
  - [net-next,v5,2/9] net: pcs: xpcs: Add support for 25G, 50G, and 100G interfaces
    https://git.kernel.org/netdev/net-next/c/7622d5527693
  - [net-next,v5,3/9] net: pcs: xpcs: Fix PMA identifier handling in XPCS
    https://git.kernel.org/netdev/net-next/c/39e138173ae7
  - [net-next,v5,4/9] net: pcs: xpcs: Add support for FBNIC 25G, 50G, 100G PMD
    https://git.kernel.org/netdev/net-next/c/3f29dd34f75a
  - [net-next,v5,5/9] fbnic: Rename PCS IRQ to MAC IRQ as it is actually a MAC interrupt
    https://git.kernel.org/netdev/net-next/c/f18dd1b15f7a
  - [net-next,v5,6/9] fbnic: Add logic to track PMD state via MAC/PCS signals
    https://git.kernel.org/netdev/net-next/c/9963117a2b9b
  - [net-next,v5,7/9] fbnic: Add handler for reporting link down event statistics
    https://git.kernel.org/netdev/net-next/c/1fe7978329d7
  - [net-next,v5,8/9] fbnic: Add SW shim for MDIO interface to PMD and PCS
    https://git.kernel.org/netdev/net-next/c/d0ce9fd7eae0
  - [net-next,v5,9/9] fbnic: Replace use of internal PCS w/ Designware XPCS
    https://git.kernel.org/netdev/net-next/c/d0fe7104c795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



