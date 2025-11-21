Return-Path: <netdev+bounces-240610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08FC76E4B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7502348725
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC43238C2A;
	Fri, 21 Nov 2025 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNb42sag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C0233140;
	Fri, 21 Nov 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689845; cv=none; b=Ki3OG0bNYqD+76T3guQpDmYxEna5ZYltNAbxfPErGXADjXNpItz7wHMUBezHMrr/4YjDHRFb4te0vQgNGsw+5MX1KewAKIKMXFsPy+OiG/qd8sqiOPDyTsg6KKXl/yu+I9Yfmq99VSzrQYYPa6kDbF0HmlOL8alOBwJ36K7MHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689845; c=relaxed/simple;
	bh=xhoy4nzjQBqoVBCQ3L4xKxg2ViknEvGrrieH4PpvfUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0RFy5v0G1Qk1iQlhzRjH/cUAQ/Y7GnruTtNBtTE0gEYYEB3xqOuP0Qn3SDxtD9fkxkebvbr/OLoSgZwFTiiFe8d/nIYOl+1R0yaKXknz73azLcSfFn2T3cv+BvSA6AcM6rDqOVJiSug2RVRJXSTDv1uhryBExvtZg9IlACDK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNb42sag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09A3C116B1;
	Fri, 21 Nov 2025 01:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763689844;
	bh=xhoy4nzjQBqoVBCQ3L4xKxg2ViknEvGrrieH4PpvfUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNb42sagafNFSQxVk7oFCxZPdjfpNK4oerW00i89ITcso9hfSqgs5ILPuIFlHN2SQ
	 VNV+auwFS3idrE0bG/UyMkhbLqncOiI0v4jHZcccfrfa8dUYrVtGRVOhHvMaOEYo+r
	 Wlw2gOZ1XD2aiPeJ+i9D0IvdSdqIINFQlZXe4N9OsHz7MumEgHnAFOB38lSk/1db9n
	 FzwrJPCuy7WBVmd+I6ghHN0a+C8eeL9yPR7qcCJAzEsDaLNWy4wpbagXexAf1oLsx/
	 vkdrYFwD9nUlLk5bcZDRa+Iwejnk/rHP7IB0XKESTBm91M0TYtitdiji7IRPSC9bmW
	 davVqCzb9/Z4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB19D3A41003;
	Fri, 21 Nov 2025 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: mdio: improve reset handling of mdio
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176368980975.1854606.9538399596509243635.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 01:50:09 +0000
References: <cover.1763473655.git.buday.csaba@prolan.hu>
In-Reply-To: <cover.1763473655.git.buday.csaba@prolan.hu>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 14:58:51 +0100 you wrote:
> This patchset refactors and slightly improves the reset handling of
> `mdio_device`.
> 
> The patches were split from a larger series, discussed previously in the
> links below.
> 
> The difference between v2 and v3, is that the helper function declarations
> have been moved to a new header file: drivers/net/phy/mdio-private.h
> See links for the previous versions, and for the now separate leak fix.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: mdio: move device reset functions to mdio_device.c
    https://git.kernel.org/netdev/net-next/c/02aeff20e8f5
  - [net-next,v3,2/3] net: mdio: common handling of phy device reset properties
    https://git.kernel.org/netdev/net-next/c/acde7ad968f6
  - [net-next,v3,3/3] net: mdio: improve reset handling in mdio_device.c
    https://git.kernel.org/netdev/net-next/c/e5a440bf020e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



