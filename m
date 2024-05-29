Return-Path: <netdev+bounces-99018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2AA8D3632
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAEA2896F3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5550A17F371;
	Wed, 29 May 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arF9ebZd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CA13699A;
	Wed, 29 May 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985231; cv=none; b=Rv3CED12J0AS7mQoU8ceZQxjjT3tN5zB2a7Ae/iVlD7RjP1uYDmoxi8Xs6+MZHF62ypkhsLYq4UIpTbw32zlmz4wJUn2Xulx4hEd/CGrvR103i9q9lXmOOzSoesen0Yw8tR42kRvqrGV54zGT9syRsPfGZKHclDRSWl6jMTxU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985231; c=relaxed/simple;
	bh=zjr/Vpc8ZTFCMrq5QTgDG0SNTzCLyB69RToX1iQy6pI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RPxLLhBFN8bDWiN2JoH68kag+kUWDYAwotdSFQJySrQWkDar5JsDEXLWZz+8BmMejtDuf0aWfUK6r6ZWTjWXBGw/UzucShThpkWx5oIPyDOImNKtWoxRM5VsXyVeXv0Q6uUja0MWYe1hGjG0sMhu4YbebcB04cDJEuWVzked/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arF9ebZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0BC6C32789;
	Wed, 29 May 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716985230;
	bh=zjr/Vpc8ZTFCMrq5QTgDG0SNTzCLyB69RToX1iQy6pI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=arF9ebZdTVp5LM2K8ZRf22mDTCKyhPoQ++0dmHnGOzjRvDFSClVkx705QFLFK/+9t
	 VlJK0w1aMwE8MOHhC9vOn+cR1T/JacYA7j8EJ/mrDqGVQWVDAaqnFD8u+x5dz9mjdC
	 5/R8dVfHpKewpqd7ea5KCBz/UL16vnZUt754Pc+aofUcWcVOCF7Md+tHXiz9y06M1M
	 +PAzZfm+n089A/DfSe1ck6Wq1hq9YO0K7S+8yorG7UYBNYh+iy4SDgVuIr8d+8uxno
	 //HfExEXUMIu82YUwfOU/PZsOq4TnQxWOj2Urn8VtJPS6X0EysmXPLfF/NpPr9KpAR
	 9XlAkKhKl4OKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FBB1CF21E0;
	Wed, 29 May 2024 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: xilinx_gmii2rgmii: Add clock support 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171698523058.1887.13954040665462825862.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 12:20:30 +0000
References: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: git@amd.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 harini.katakam@amd.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, michal.simek@amd.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 28 May 2024 11:50:06 +0530 you wrote:
> Add input clock support to gmii_to_rgmii IP.
> Add "clocks" bindings for the input clock.
> 
> Changes in v3:
> - Added items constraints.
> 
> Changes in v2:
> - removed "clkin" clock name property.
> v2 link : https://lore.kernel.org/netdev/20240517054745.4111922-1-vineeth.karumanchi@amd.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: xilinx_gmii2rgmii: Add clock support
    https://git.kernel.org/netdev/net-next/c/c1d96671088f
  - [net-next,v3,2/2] net: phy: xilinx-gmii2rgmii: Adopt clock support
    https://git.kernel.org/netdev/net-next/c/daab0ac53e77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



