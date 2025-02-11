Return-Path: <netdev+bounces-165314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC8AA3198E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BDC167BE2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61DA268FF7;
	Tue, 11 Feb 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh//RiFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2987272907
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316602; cv=none; b=SuEnqKVbVekYasRSmHmqGGy4lFg6Qy9uN/lj9r2hNBmreXl2zviOFplH5Vw+QRKvJvSRYZEWv+FiyfQbg2YesQ16np0f8yEJSKuXpm5QMx5OMXiPXMWRf2PUcxtEkMHz890Y6DZ6pTP7CfYklkNML0jobXA+1bSkZZ0HFjEoWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316602; c=relaxed/simple;
	bh=o3rzsN77w/QIpMRGvxLJLK52t8dONcjrDCBhRi3YDwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WGRgaDzpeFKpcd55TjSlFvv1t4phdUDrYIJKJQpt5AcMEEA5ONX7fdUXI2lrfW0NJ0CHvJKd9z3qQDp4CbwXbji7AvUiwLkCV337K/8zte0YFDz/7VZveez3R3ofASdIhRES2P9n4xBRA1iki85IdosV1psSbNAid11axNnBDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh//RiFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241CEC4CEDD;
	Tue, 11 Feb 2025 23:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739316602;
	bh=o3rzsN77w/QIpMRGvxLJLK52t8dONcjrDCBhRi3YDwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sh//RiFGZDZut5I2b1HU/edMSL4I5RXvEb0ejrv6ugikyLtmRDY1rEPfmr+PtyvkR
	 dUGuI5x67lhZK7+kvZEir+jYoLSclR3RpJVlo8+OPvwikSiTfWppXZbUOPJozcyr7m
	 N1czuiEJyRuW69W56wCzKS4IHrOcos53VJoh/fQTi+uiGhhoK8NbjpNQyR4Fd6DV2Y
	 RqbPrnIHvKPl79UqcAzzKZ9y7n+AFjCqrjdlKYgTpQGrIwEuFUVUMBPk9QKIFg2KmY
	 CBw1Ffb6msyWSzcdshIV/VeWb2XPr8IvKFZmPZZcVyhbtHQZIn5zhSUlDArT70rF4B
	 kIXGHJILhEjiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5B380AA7A;
	Tue, 11 Feb 2025 23:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: phy: rename eee_broken_mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173931663101.32942.3159849337298305658.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 23:30:31 +0000
References: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
In-Reply-To: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 21:48:42 +0100 you wrote:
> eee_broken_mode is used also if an EEE mode isn't actually broken
> but e.g. not supported by MAC. So rename it.
> 
> This is split out from a bigger series that needs more rework.
> 
> Heiner Kallweit (2):
>   net: phy: rename eee_broken_modes to eee_disabled_modes
>   net: phy: rename phy_set_eee_broken to phy_disable_eee_mode
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: rename eee_broken_modes to eee_disabled_modes
    https://git.kernel.org/netdev/net-next/c/8eb0d381be31
  - [net-next,2/2] net: phy: rename phy_set_eee_broken to phy_disable_eee_mode
    https://git.kernel.org/netdev/net-next/c/5e7a74b6a357

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



