Return-Path: <netdev+bounces-145134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D899CD54F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15395B22E6D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D1D13774D;
	Fri, 15 Nov 2024 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Nakrhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF584D02
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637219; cv=none; b=CxteIqgX2bDEiS1UOcy8U7cG5JirU2lCnEUTMRTXO/Yn/lsKyav8n7q9HYcCk/ownV3sPxCRs3JLLSqcetKRarrMaPQZog2PZGoTynn0QB+J9TzLZMdsPgugyKVv0tp0UxNpzuO1lLzort3Euga/UmA4G6Xd1A6nuhTpq5/ZrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637219; c=relaxed/simple;
	bh=4k5ohMHJ8YwZPlqRj47dSnk8oCSvB6cnpYtP9gVDiyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7IowPzCii71xJFlSXmcbdemWiTK77ivN+Wuv/ZV8npDhmb6BYZSU0+VZUs+HE9PltnA5vnqAEuyzrlOq6zKV2QhkQLvl99lw+d08BNXdBY14TUEnWERDOIMLMHKjYZ4QbQb2CdPxQMhuBYkBtV+G94FTlMP78MV5rahVdHLlfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Nakrhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6127C4CECD;
	Fri, 15 Nov 2024 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731637218;
	bh=4k5ohMHJ8YwZPlqRj47dSnk8oCSvB6cnpYtP9gVDiyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c+NakrhiRqPGF4Bc9UmVNkdJ6aCWvKzVRpHx1XQPq+K1Yxm94lw4E8kvAE+zJMSAT
	 MAU8Il4EVYH61w4dXjzKpSDgt2wWrviyhA1zl4koNN2tkSmQLgo8Rak4SDinPTGU94
	 v/1tCfafqgk5707Fukilz2UR9aTs9iV8gPGGLA+2wPuRMtE8AP6kR1OPm0ix4GMUdA
	 1mVrL8zYf/PDUCcbezFtNM8l0Ii51ui1Rpg9TQ0bkqWbvPjCJUqWcDqrfFiBnxSiBF
	 qn5z4V9VQLzo41oLkt1FuXPK2QMYYKeYdc76QTi/QradCrmN4+EZHhBI0MmV8uUWkH
	 XkaZpu9YQp8ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD173809A80;
	Fri, 15 Nov 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: phy: switch eee_broken_modes to linkmode
 bitmap and add accessor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173163722950.2124848.16955505461860459539.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 02:20:29 +0000
References: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
In-Reply-To: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Nov 2024 07:53:17 +0100 you wrote:
> eee_broken_modes has a eee_cap1 register layout currently. This doen't
> allow to flag e.g. 2.5Gbps or 5Gbps BaseT EEE as broken. To overcome
> this limitation switch eee_broken_modes to a linkmode bitmap.
> Add an accessor for the bitmap and use it in r8169.
> 
> Heiner Kallweit (3):
>   net: phy: convert eee_broken_modes to a linkmode bitmap
>   net: phy: add phy_set_eee_broken
>   r8169: copy vendor driver 2.5G/5G EEE advertisement constraints
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: phy: convert eee_broken_modes to a linkmode bitmap
    https://git.kernel.org/netdev/net-next/c/721aa69e708b
  - [net-next,2/3] net: phy: add phy_set_eee_broken
    https://git.kernel.org/netdev/net-next/c/ed623fb8e38e
  - [net-next,3/3] r8169: copy vendor driver 2.5G/5G EEE advertisement constraints
    https://git.kernel.org/netdev/net-next/c/e340bff27e63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



