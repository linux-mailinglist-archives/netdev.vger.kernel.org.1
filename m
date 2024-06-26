Return-Path: <netdev+bounces-106740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746159175F4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFDE284C36
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B614AAD;
	Wed, 26 Jun 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmBXz2dv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC22947E
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367231; cv=none; b=WyEL+KS2FiD7yM4ofEk0gdb6mYE80xQHbvADr9EWRRb5driusBUpclGfbaYZX+JhqNjIyp8BBcrzotwXbFiWjaNhvoKnvQmD+r0t65HrwhVdV116zEtXvJ62F9aYebB3VEUo3eVZmJDmd1UK4bDW6Yo/oVFJb0Lvi7+8E9X5nBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367231; c=relaxed/simple;
	bh=xSNj/USwXXhZl19nmEL5i/+3vQTAkaJNTpYEfZZdeFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pqwO7L7TqvnjIqxQLmms6u5NSBk7iQJxITQDINFTb9QV6zqO32UJCimnDjAxxuOt1/Gn18MKyiWLF3b9fd9n4DA0vhqSWPAq62RjBmf+qWPIR0MAOWZUIhoT9SWY20hBq5RKOAN1YnM9z/gCZ6rEHUMwQ/6sp9G3bLPYeR9h1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmBXz2dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59A62C4AF07;
	Wed, 26 Jun 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719367231;
	bh=xSNj/USwXXhZl19nmEL5i/+3vQTAkaJNTpYEfZZdeFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fmBXz2dv6k3EaZGD0zVNB1TqbWue+BmZYcH618izH/S2KZZj2tNo4cmpwBCRH6w3E
	 6O1GuCwo+5PZZc2dPSj8q7UfthkP2Lvyw6NXfrWWlaaHsMqIZI+3l4SF06OddYELMG
	 lZqv8knbzxXe9TFF0s0HFxSYRGxwmcU4VvPe5xGTzKjFZIDQ3TQoJUHynbI9GbcgMO
	 ztPK13EtUwu/YUfDcmXfgQR4Nj7JeZWUbDUN0SukestirNY6mPLHMv+YSlmtQekCw5
	 3+zpf1HmoRBtEBlcXOng4UGOhja1ucWftGV7YWRTzmHybC66METKZIQ+u2zNSYjXkc
	 ZH8uxPZxWNCTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45135DE8DF3;
	Wed, 26 Jun 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/7] add ethernet driver for Tehuti Networks
 TN40xx chips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171936723127.29418.12595539339201439511.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 02:00:31 +0000
References: <20240623235507.108147-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240623235507.108147-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org, kuba@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk, hfdevel@gmx.net,
 naveenm@marvell.com, jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jun 2024 08:55:00 +0900 you wrote:
> This patchset adds a new 10G ethernet driver for Tehuti Networks
> TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
> (drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
> chips.
> 
> Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
> based on TN40xx chips. Tehuti Networks went out of business but the
> drivers are still distributed under GPL2 with some of the hardware
> (and also available on some sites). With some changes, I try to
> upstream this driver with a new PHY driver in Rust.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/7] PCI: Add Edimax Vendor ID to pci_ids.h
    https://git.kernel.org/netdev/net-next/c/eee5528890d5
  - [net-next,v12,2/7] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
    https://git.kernel.org/netdev/net-next/c/ab61adc60001
  - [net-next,v12,3/7] net: tn40xx: add register defines
    https://git.kernel.org/netdev/net-next/c/ffa28c748b38
  - [net-next,v12,4/7] net: tn40xx: add basic Tx handling
    https://git.kernel.org/netdev/net-next/c/dd2a0ff55408
  - [net-next,v12,5/7] net: tn40xx: add basic Rx handling
    https://git.kernel.org/netdev/net-next/c/37c4947af44d
  - [net-next,v12,6/7] net: tn40xx: add mdio bus support
    https://git.kernel.org/netdev/net-next/c/7fdbd2f2bb5d
  - [net-next,v12,7/7] net: tn40xx: add phylink support
    https://git.kernel.org/netdev/net-next/c/308241224224

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



