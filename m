Return-Path: <netdev+bounces-219398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97BB411B0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74119188E8A7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ECB1D63CD;
	Wed,  3 Sep 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxwHj7nc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2E1C8626;
	Wed,  3 Sep 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861810; cv=none; b=XZNnXenQBTmmIiCcJUsX5j6LzxJ8eb+3V+6TTHL/hCiBozPf2e6+KioWfYlganPL9glBAf5Oo9XSjzjWi5nQX3412KgGJToIPA5TbIPTncgpmnkhOyEyhwLNw7ujK6F9AwkfvTjRrISp8OydA/hQ4UtRgU/MZ6VF8dn12Y9cYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861810; c=relaxed/simple;
	bh=QBmkWKwNwxQ4GdmLxS27OHjY+gWexIU0Pvfab0SRP0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tsTna+M/jJkC8DIVkwa73Oz2loSCkaO6nhUMVsdlcReUa/8XKlpQiuvDeNh/Yx8v8AfY9pbU2wRRx93Uk/rmBWG5nKzteXo2nyDuDVjI1tD6eLbFUxNFJLsGVa+CcWLI9pHFr4iEOeqNfImdlFMpEyFgaDeAbMj4TmiQdBRyi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxwHj7nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C32DC4CEED;
	Wed,  3 Sep 2025 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756861808;
	bh=QBmkWKwNwxQ4GdmLxS27OHjY+gWexIU0Pvfab0SRP0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GxwHj7nciPp2pmbB4WkD5jjq4SSTQxB5WdGrUFo/0pxx6ozNLAfL70H6tlKNYs7hi
	 8Br/zJSihPudLmWuY0mbxxY5vTVOiN5MqY3otAH2qIYKppbD8Z3cNDPuub8NMwVBJQ
	 YXh4FDk7qJaayY31BcfmSqSkO37HGYvESARauaA7WLQgrQr1UxELCgl0+OQzuiXZ+1
	 3EjWWXE8ZhO4+NnPr5BXOirr9xaxySaVNM4FtbYRzbXgR+K/+BpUqxNdRRQH/GiMA9
	 9ZXC/yAWhvrmLud2nb93bKOSa4wxJ+SzmxmOdIZtuWpPFM7enndSSAPASsIgyNyYHT
	 4/TF9Ws7wtl1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE0383BF64;
	Wed,  3 Sep 2025 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] net: dsa: lantiq_gswip: prepare for
 supporting MaxLinear GSW1xx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175686181400.488234.8908283453708565920.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 01:10:14 +0000
References: <cover.1756520811.git.daniel@makrotopia.org>
In-Reply-To: <cover.1756520811.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hauke@hauke-m.de,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andreas.schirm@siemens.com, lukas.stockmann@siemens.com,
 alexander.sverdlin@siemens.com, peter.christen@siemens.com,
 ajayaraman@maxlinear.com, bxu@maxlinear.com, lxu@maxlinear.com,
 jpovazanec@maxlinear.com, fchan@maxlinear.com, yweng@maxlinear.com,
 lrosu@maxlinear.com, john@phrozen.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Aug 2025 03:32:06 +0100 you wrote:
> Continue to prepare for supporting the newer standalone MaxLinear GSW1xx
> switch family by extending the existing lantiq_gswip driver to allow it
> to support MII interfaces and MDIO bus of the GSW1xx.
> 
> This series has been preceded by an RFC series which covers everything
> needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
> had suggested to split it into a couple of smaller series and start
> with the changes which don't yet make actual functional changes or
> support new features.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] net: dsa: lantiq_gswip: move to dedicated folder
    https://git.kernel.org/netdev/net-next/c/cb477c30512d
  - [net-next,v4,2/6] net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
    https://git.kernel.org/netdev/net-next/c/7a1eaef0a791
  - [net-next,v4,3/6] net: dsa: lantiq_gswip: ignore SerDes modes in phylink_mac_config()
    https://git.kernel.org/netdev/net-next/c/17420a7fe5e2
  - [net-next,v4,4/6] net: dsa: lantiq_gswip: support offset of MII registers
    https://git.kernel.org/netdev/net-next/c/5157820326f3
  - [net-next,v4,5/6] net: dsa: lantiq_gswip: support standard MDIO node name
    https://git.kernel.org/netdev/net-next/c/720412c4aebc
  - [net-next,v4,6/6] net: dsa: lantiq_gswip: move MDIO bus registration to .setup()
    https://git.kernel.org/netdev/net-next/c/0dc602a3c7f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



