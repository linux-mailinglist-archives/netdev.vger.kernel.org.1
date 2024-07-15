Return-Path: <netdev+bounces-111482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84730931547
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68021C225BD
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF9E18A926;
	Mon, 15 Jul 2024 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoQL4ffM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A0172BA6;
	Mon, 15 Jul 2024 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048433; cv=none; b=gmthYUYx/Fm3CMkd6lKsF+BV89NcQ54tRIfbRgdjBfraO+7tcukpj/asVEXSStcHceAnmvnc74UUCNLdYiynEMDh6XVuc3Wp6nMrrRl7Q85mCM5W7A4D2ThA6N3N7mBW1/pmsyXVm2mR2clGdZre5URDnJm0p9v7yP6vbrQu7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048433; c=relaxed/simple;
	bh=xBp6wVPgvsV2DDw1J9KEqgZp6b7FI6NgpSBWW1KGY5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4NFE5gt2SdamGYWjW+k9PxAejjOrxtrDZyQUQY3C8wsKx55I3OV+IypK5BTosN7ff+OKzG55oD8LT4XfCN7Qjx/ACz2WlGfO/FYctSFMaTfCNkqHgyX1FjDOU/rsxUI/wn+V3D6TRXgIqadVNDoeFLGmY+ix1Bz6zgOP9FLbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoQL4ffM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5541C4AF0A;
	Mon, 15 Jul 2024 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721048433;
	bh=xBp6wVPgvsV2DDw1J9KEqgZp6b7FI6NgpSBWW1KGY5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UoQL4ffMw4JVCnc0lByBfRXvY0EG5mldxmXxgUWA49Wmx04yllSIo+UEo2aZbND+i
	 +xiSh8FloNN5cwdVwRhuGvYEbdvbAnrgviQFl5N+68U1IBEZgBgh12iMpxuZoAi4K0
	 3kydD34vRYNgGXOI0scKSsCTpsix/X+E5eVjwZKhLUzZfzLp3qAdFeeqlG2b+gkRNM
	 +cM/5slN3cCCD/cMhOGO3cpd0Bv10lsloGfpfEJgkLhjg+caLWGsaU0EibnFmVmw3W
	 oQh9HHpxJCZ1cSJot+iMocAtWSXf6DbktKlX12rijjCoR7l/BUO8b0OSYCMO7YJDbf
	 dSiEQnEC0gPGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4C93C43443;
	Mon, 15 Jul 2024 13:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ti: icssg-prueth: Split out common object
 into module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172104843286.23241.15744127998585161383.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 13:00:32 +0000
References: <20240712120636.814564-1-danishanwar@ti.com>
In-Reply-To: <20240712120636.814564-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: hkallweit1@gmail.com, horms@kernel.org, dan.carpenter@linaro.org,
 jan.kiszka@siemens.com, wsa+renesas@sang-engineering.com,
 diogo.ivo@siemens.com, andrew@lunn.ch, rogerq@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, vigneshr@ti.com, linux@leemhuis.info

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jul 2024 17:36:36 +0530 you wrote:
> icssg_prueth.c and icssg_prueth_sr1.c drivers use multiple common .c
> files. These common objects are getting added to multiple modules. As a
> result when both drivers are enabled in .config, below warning is seen.
> 
> drivers/net/ethernet/ti/Makefile: icssg/icssg_common.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_classifier.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_config.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_mii_cfg.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_stats.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_ethtool.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ti: icssg-prueth: Split out common object into module
    https://git.kernel.org/netdev/net-next/c/a8ea8d531d1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



