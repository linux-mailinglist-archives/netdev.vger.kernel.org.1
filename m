Return-Path: <netdev+bounces-213142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A88B23DA8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16341B60C9C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3AA2A1BB;
	Wed, 13 Aug 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rckoJnAb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D92C0F6F
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048010; cv=none; b=MX2KFQ8+TFkNb5VGoR0l7NgsvdObT/UWGUNEfsUc/AorsDVCSQdsucWGnYrHyBhQjCYK2P+3i4por0lt+OXdD7anVOodP3gNKvYubof76dsFvwROOhvXnV3fNwDrh9YGor90xQswAd7AmLn0l+59mQ4/6ixYdGJQglerr763RVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048010; c=relaxed/simple;
	bh=0OvQcSBq7+nWfUTs0J8PYw0DBRmzFTWE1hI4XBot3Ek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jKmoZkc0qJNMWEgNrZxQuklWsi3oweAT8jptolXYMhjOFFY7Eww8Aj/gyIrdTiNVEdgGlVtLfJUm6k6ihSaVjbNkq3bJqaY20PbDLKrBzLiqzjLqchvRlEISCZfCExJs/2JjNV649Wpa5id7ViPeXX4LBaJE1QF+HW1x/u5WDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rckoJnAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12942C4CEF0;
	Wed, 13 Aug 2025 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755048009;
	bh=0OvQcSBq7+nWfUTs0J8PYw0DBRmzFTWE1hI4XBot3Ek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rckoJnAbdr6SDwFTCpifJP3CXyIKCp2JAyVGAJCMzU2Yb50Z8L2QyT+g+C36PYcIQ
	 XbAU7olp91xZdfzeOjZYFmIRQKuN4Mn4RpwaXGLq00JHa98ZITidgRvOudkM9pkArv
	 xCkatqb2CpqtPbhIVJNeIwtxDVdctGOgDKWNqRZ4+A7e4aSczfe/3S44AEgbnIDbtH
	 FrVu1y0ffWLJ6WZFmy//1Pq4cEoFEAaPEv42JmzTNQuZ4UgxeakTaq6z618Row18qu
	 rFte8M4R022SDwy1JvuKYyP2XqQb6Z4cM+JqUGnWDQyRfzMVJ17+lcAKFlHqtS/j9E
	 QlYDpSdwp2Jyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A9C39D0C2E;
	Wed, 13 Aug 2025 01:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: stmmac: improbe suspend/resume
 architecture
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175504802100.2913300.7913222842711784004.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 01:20:21 +0000
References: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
In-Reply-To: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, matthias.bgg@gmail.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 19:50:58 +0100 you wrote:
> Hi,
> 
> This series improves the stmmac suspend/resume architecture by
> providing a couple of method hooks in struct plat_stmmacenet_data which
> are called by core code, and thus are available for any of the
> platform glue drivers, whether using a platform or PCI device.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: stmmac: add suspend()/resume() platform ops
    https://git.kernel.org/netdev/net-next/c/07bbbfe7addf
  - [net-next,2/9] net: stmmac: provide a set of simple PM ops
    https://git.kernel.org/netdev/net-next/c/7e84b3fae58c
  - [net-next,3/9] net: stmmac: platform: legacy hooks for suspend()/resume() methods
    https://git.kernel.org/netdev/net-next/c/b51f34bc85e3
  - [net-next,4/9] net: stmmac: intel: convert to suspend()/resume() methods
    https://git.kernel.org/netdev/net-next/c/062b42801733
  - [net-next,5/9] net: stmmac: loongson: convert to suspend()/resume() methods
    https://git.kernel.org/netdev/net-next/c/38772638d6d1
  - [net-next,6/9] net: stmmac: pci: convert to suspend()/resume() methods
    https://git.kernel.org/netdev/net-next/c/c91918a1e976
  - [net-next,7/9] net: stmmac: rk: convert to suspend()/resume() methods
    https://git.kernel.org/netdev/net-next/c/d7a276a5768f
  - [net-next,8/9] net: stmmac: stm32: convert to suspend()/resume() methods
    https://git.kernel.org/netdev/net-next/c/c7308b2f3d0d
  - [net-next,9/9] net: stmmac: mediatek: convert to resume() method
    https://git.kernel.org/netdev/net-next/c/d6e1f2272960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



