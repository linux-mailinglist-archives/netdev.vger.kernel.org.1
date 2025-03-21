Return-Path: <netdev+bounces-176818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49CBA6C485
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CE74849D7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630CD230BF4;
	Fri, 21 Mar 2025 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn0O6218"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE451E9B32
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590199; cv=none; b=bCyEUbYezlbxvHM5ogfVUwYngeZJ5nJF1FyUIfKVpRDcsFfx5DbNpT320IHYNmlGwxn57X9/BVSV9v2VI9U9DJy21kwfDT+d9Wa/xmTgaSGFw2gkRTJV/G2LEpL1wDvF2DITfHmDn/PPKtGWpGxvk3gzE/lPF/Vg3ocMnwNJ/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590199; c=relaxed/simple;
	bh=ScYzvyw/Eu0uHr7Q4/v3AWub7uxlANqoKlGR6KP6aEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VUhV+TWZiwOJrwndu/EqpuIBNGQlSy5ouWR0+Mz8y2I42qGGIT2NsOzPLxdWrJhjbY+ufrKp/Zk6/XzKwQa2aLYYnFTu/vPDUNCEqaf/vEKbmGnrt5ptXxEHQkk8wuAhL05hQcWOn9GpFoYXSlGDJ4gFuKQLCn8V8XE2W/99/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn0O6218; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A017AC4CEE7;
	Fri, 21 Mar 2025 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590198;
	bh=ScYzvyw/Eu0uHr7Q4/v3AWub7uxlANqoKlGR6KP6aEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qn0O6218FkambvyK+oPIEfUL81SPQZLb8ok22e3Z34oNP1iwFRkpkr5GEjM6mhiWA
	 s2vOKpCx4kVmKxvkOVA/Il4ucOdJ4FaCk++Aphxqf4ydbHF+Xe+quEFgLvxOq2c8kj
	 IPJxC8fCG+rTmJBlVkwD/g2X7uqqD+fSXDGDA7vKSpubQstI4mVR6KfGi6CEp6ZtzO
	 mggRlMX9VyvCEpVyq2j0V6SMPvAouComrjHmIJ4PyUJpRTX2Pgj6X/ybY210n3GAOy
	 LFzNydebnmrGPmEz1cwgDVi8uWZYIgDUml8GC13NoMjXGFs0yL8kddFiKihqGH9Uih
	 JfUtym8NL6AhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11D3806659;
	Fri, 21 Mar 2025 20:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: disable PHY-mode EEE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174259023475.2618986.529982351265877058.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 20:50:34 +0000
References: <E1ttnHW-00785s-Uq@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1ttnHW-00785s-Uq@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Mar 2025 12:39:54 +0000 you wrote:
> Realtek RTL8211F has a "PHY-mode" EEE support which interferes with an
> IEEE 802.3 compliant implementation. This mode defaults to enabled, and
> results in the MAC receive path not seeing the link transition to LPI
> state.
> 
> Fix this by disabling PHY-mode EEE.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: disable PHY-mode EEE
    https://git.kernel.org/netdev/net-next/c/bfc17c165835

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



