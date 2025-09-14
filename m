Return-Path: <netdev+bounces-222880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A416AB56C05
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23AE3A683B
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D02E5B36;
	Sun, 14 Sep 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioa37xFK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C922DCF55;
	Sun, 14 Sep 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880621; cv=none; b=bIYBH9WR0MzhuzbQMZKhv2vOjhj3k5menRtQpV5xHzVw8yAa5nQtkZUjUu/VS14+B06c/rL8+PBir+JbhyancDzXXMpFiaLMP03D6BJBH4kov1NDg8uyBLp/V0E6xSan7n2Aw5dK6IoR+tL+JsNoWoa8ZAiDGlPKuQcqvNV7IR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880621; c=relaxed/simple;
	bh=jaRrPAgWKjDQlUKhFim10dcggCFExzmEAeZ51T9N4xM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g1osSENyMGIHtHuGtvvggMqt4dqQOXxxjYoDhNXxcPid8gF47RvVYPXXVCOXIbQ8mTRO4cc5ITLhIM88HkKspLd46AyXJL7gnk9OITXHTTaOEghuWDIk+Hw053hE98CNLN9A/7+cKUFCHYtrjd/ITuwU5Py4duNroj+COUZj/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioa37xFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA54AC4CEF0;
	Sun, 14 Sep 2025 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880620;
	bh=jaRrPAgWKjDQlUKhFim10dcggCFExzmEAeZ51T9N4xM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ioa37xFKekcZtgaxszIXsoLrlcf9VeQ4jiJy8Ujo7j9mZK9elQuYamTRAX+Xg+Nt6
	 FM6t88R56qJrsRyJaa5fCYjLvE71WMNyJ/8CS5hYvq/NSLxibnMEXHB6Z3WFuesxPC
	 B+X2ihYTNHfUpLmGIz18GnKsPl4mOvn7OykGZytzokHDD13pYqCXs/AqkIal0EGt7e
	 8PTUUzTT0G8DbhvedE9cjJ56BoLeLTg0qwH6OzqtosUmBmfb1Q80fSqG/XmqscJv14
	 1PR+08FPb7cCMfiH032SMQJIWeu6+HTrnwuOIS61yTc0cEuZBgeqIbldtEfZzcp/qp
	 nToUB4GK0VytA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE83339B167D;
	Sun, 14 Sep 2025 20:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v16 0/6] PRU-ICSSM Ethernet Driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788062248.3540305.3507616475736965699.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:10:22 +0000
References: <20250912104741.528721-1-parvathi@couthit.com>
In-Reply-To: <20250912104741.528721-1-parvathi@couthit.com>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, m-malladi@ti.com,
 s.hauer@pengutronix.de, afd@ti.com, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, johan@kernel.org, alok.a.tiwari@oracle.com,
 m-karicheri2@ti.com, s-anna@ti.com, horms@kernel.org, glaroque@baylibre.com,
 saikrishnag@marvell.com, diogo.ivo@siemens.com,
 javier.carrasco.cruz@gmail.com, basharath@couthit.com, pmohan@couthit.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 vadim.fedorenko@linux.dev, bastien.curutchet@bootlin.com, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, mohan@couthit.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 16:14:49 +0530 you wrote:
> Hi,
> 
> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
> Megabit ICSS (ICSSM).
> 
> Support for ICSSG Dual-EMAC mode has already been mainlined [1] and the
> fundamental components/drivers such as PRUSS driver, Remoteproc driver,
> PRU-ICSS INTC, and PRU-ICSS IEP drivers are already available in the mainline
> Linux kernel. The current set of patch series builds on top of these components
> and introduces changes to support the Dual-EMAC using ICSSM on the TI AM57xx,
> AM437x and AM335x devices.
> 
> [...]

Here is the summary with links:
  - [net-next,v16,1/6] dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
    https://git.kernel.org/netdev/net-next/c/eb391228ae08
  - [net-next,v16,2/6] net: ti: icssm-prueth: Adds ICSSM Ethernet driver
    https://git.kernel.org/netdev/net-next/c/511f6c1ae093
  - [net-next,v16,3/6] net: ti: icssm-prueth: Adds PRUETH HW and SW configuration
    https://git.kernel.org/netdev/net-next/c/a99b56577da4
  - [net-next,v16,4/6] net: ti: icssm-prueth: Adds link detection, RX and TX support.
    https://git.kernel.org/netdev/net-next/c/e15472e8f2e7
  - [net-next,v16,5/6] net: ti: icssm-prueth: Adds IEP support for PRUETH on AM33x, AM43x and AM57x SOCs
    https://git.kernel.org/netdev/net-next/c/1853367b76cd
  - [net-next,v16,6/6] MAINTAINERS: Add entries for ICSSM Ethernet driver
    https://git.kernel.org/netdev/net-next/c/7d4b52174dac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



