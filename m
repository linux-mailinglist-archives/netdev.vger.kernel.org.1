Return-Path: <netdev+bounces-105670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76712912332
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EF7284F0A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5261172BDD;
	Fri, 21 Jun 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stT/+7D0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698412D771;
	Fri, 21 Jun 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968829; cv=none; b=V5ttm1TXtaYGmN2x+8mXopxipxID35CW+NrEK7vWTX0N2QnR5M3FQoKURElxzTlJZ38fc89sQ1VGfMd7hiPPrfhC2pc3qPneozucCXUeQ62JkJk3KxAHlvq6iCME6o/1Jixplgx3yGwkiK95VP6xOm5hCPTewG99c5buGn3npZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968829; c=relaxed/simple;
	bh=hltoIhzrRyXxQ5wEaVgtxM9YEOs/N9nyFiT+slGiE5I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cUyFJxbV8FHIVvOiDz8cWWP483Om5VlnYdQ2ti45PNlJEBbQYNj/Ui8LJ06ikrH2R/f1Jo3ZwjQuHVh14adirMYOHdQQleRl0HEHVHxiPvdYhaNV64ApVO0bRCyye3cmQ8JjvuNkKnZO++arjHeYqDoWysQ01p0qO7sIvogpnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stT/+7D0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21E0DC4AF0C;
	Fri, 21 Jun 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718968829;
	bh=hltoIhzrRyXxQ5wEaVgtxM9YEOs/N9nyFiT+slGiE5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=stT/+7D0fM0P2iBHCmst1qlRmVzt7vBdPFX5ApAIPweaI4V4iwZPDwnypsKJbNI5g
	 p4KdTmKndzjSd0O0omqMciBm7lk3zfuqCH906zybC25dpMyU4rj47+5Tn9sVDyjVyu
	 9XjkCIiL+XVIv4a2eH94AK+4fW+uRmttnXuANKT1IC3JhBKQ7VYU8H4xHezVrqUU6t
	 2vH/e68jKxkimk5WQIYIKN3XrEHhRI6QkVTJyVhhr0HLBLm2zPylBtojUByswKPff6
	 H+73gR8Hjd9NZL2VaK84YawdUWQWdBZuownZ2jjJuM0tmNewNwWbBI9vgYoKDVtIsP
	 Pj7Oiz6AT6/wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16A19E7C4C5;
	Fri, 21 Jun 2024 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Handle switch reset in mscc-miim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896882908.29143.8985611703497220524.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 11:20:29 +0000
References: <20240620120126.412323-1-herve.codina@bootlin.com>
In-Reply-To: <20240620120126.412323-1-herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 p.zabel@pengutronix.de, alexandre.belloni@bootlin.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, allan.nielsen@microchip.com,
 horatiu.vultur@microchip.com, steen.hegelund@microchip.com,
 thomas.petazzoni@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 14:01:23 +0200 you wrote:
> These two patches were previously sent as part of a bigger series:
>   https://lore.kernel.org/lkml/20240527161450.326615-1-herve.codina@bootlin.com/
> 
> v1 and v2 iterations were handled during the v1 and v2 reviews of this
> bigger series. As theses two patches are now ready to be applied, they
> were extracted from the bigger series and sent alone in this current
> series.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: mscc-miim: Add resets property
    https://git.kernel.org/netdev/net-next/c/e5efa3ff412d
  - [net-next,v3,2/2] net: mdio: mscc-miim: Handle the switch reset
    https://git.kernel.org/netdev/net-next/c/9e6d33937b42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



