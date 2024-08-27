Return-Path: <netdev+bounces-122547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD4961A9C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969D11F23C92
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B61D47AC;
	Tue, 27 Aug 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLtezV2p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BC19ADB6;
	Tue, 27 Aug 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801428; cv=none; b=DFWhUXp1Uw/lXFYKwmr/GLzFZdyAhPmIlChxtynmdl7eI6R+GcR8AvAmCe58QN98gAAj0/uxKNhkjaT7hB/ZPpIR0s+UoiG5BQ9IHHIgTa8e7EgBNQ3iGHAoppw+yu9tw+0qQgQBxe42bD+bVJJdq2X6rHm3LTreQl8U6TWNtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801428; c=relaxed/simple;
	bh=OHtRyluUSbPA5B6XNHOqGUUEKLoUDID2bnW6fHjqOq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B+gOjVYr9E6kEMdg9kjyBoLni2muUaRJ4joI5oU+TwV6iKxf4R7iJzUdig/yp5m3bkPzbHMX7Dp5nqHaLFn+O8zwSyua8XDy4bUpTch546MYcn5FBIEDdX/JUAEj6ABEzOVulsubozK+t2giEkngNf3kTrAt7Eg41z+mLj1lRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLtezV2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB95EC4FF03;
	Tue, 27 Aug 2024 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724801427;
	bh=OHtRyluUSbPA5B6XNHOqGUUEKLoUDID2bnW6fHjqOq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mLtezV2pnhp6PpJ4yV9hj0iN8AbUKUCQj+yqtHebLpLlGu2KLriqzmU5egzpgOA2R
	 /qTLsvMLJnLbNblLopkNrrJXtftEwRzInEVuewOfKkq/CHJVFQf7BbaBegD1xN/3x2
	 O5XxlHv37ijZi7oCZZaIXYedLaF38VBn6DhIVdas2orOK1N96GhlyX4enKL2uXt3/9
	 BTh9e240RIHxTzodTx4nBM+rKxncUuuonDS8dA7VtqVDHPaAS/C28eVuJ7ggo1g9AS
	 UL8XI1kfzFVgkfWmrbhscg0/NaT2ZllZhCR4uW0decZ/dFMcpqe4dgKVoln5Vr/Gip
	 c+eHJlguOGB2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E053822D6D;
	Tue, 27 Aug 2024 23:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172480142801.789446.7884606391817765339.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 23:30:28 +0000
References: <BYAPR11MB3558B8A089C88DFFFC09B067EC8B2@BYAPR11MB3558.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3558B8A089C88DFFFC09B067EC8B2@BYAPR11MB3558.namprd11.prod.outlook.com>
To:  <Tristram.Ha@microchip.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
 devicetree@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, o.rempel@pengutronix.de, pieter.van.trappen@cern.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, marex@denx.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 21:43:02 +0000 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> This series of patches is to add KSZ8895/KSZ8864 switch support to the
> KSZ DSA driver.
> 
> v6
> - Add reviews of Pieter and Oleksij
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
    https://git.kernel.org/netdev/net-next/c/e3717f2ad1a2
  - [net-next,v6,2/2] net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
    https://git.kernel.org/netdev/net-next/c/a96c5515d0d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



