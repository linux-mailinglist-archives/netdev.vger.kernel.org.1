Return-Path: <netdev+bounces-38537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D657A7BB5A5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C03A2821C5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13252168B0;
	Fri,  6 Oct 2023 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEk0N0+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E33746B
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75969C43395;
	Fri,  6 Oct 2023 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696589428;
	bh=PwDGNurQz9EoritH/E8ekzm5CmdKofTv6A3lCpjocyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hEk0N0+D0EV5/Ey4y6oC70WUDq1jPO4kF2LQO2Gi4oF1/Yt+CGe1SE5kKsktZpVog
	 Gba4OsnHaSrJvt8tp7RcoPj6SZWd7wgXFlOxDOUuuOKIQlWTLzydLH0/wDXbE5yXPi
	 QHKoUi9qMmFTAczZM/CFswydAMhO2y5A1HgVfzSEaeeRG7Yk2JpJDjElazELg0VlXY
	 NRusxwSK7VrsCFQ/iFCWbQM8MYdAuC07tgaJxhhsVYH2+M1U6a3Xq3sMPsoqM1/HhJ
	 R3Rix0E8W7hD27UYZw1+C8lEv40Me9UMwhDlZoHeAicl116Viz59CPI+92t6O/KIaH
	 fIxJfitLH4N6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51120C595CB;
	Fri,  6 Oct 2023 10:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: dsa: qca8k: fix qca8k driver for Turris 1.x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658942832.16254.9613514195156231945.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:50:28 +0000
References: <20231004091904.16586-1-kabel@kernel.org>
In-Reply-To: <20231004091904.16586-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: ansuelsmth@gmail.com, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  4 Oct 2023 11:19:02 +0200 you wrote:
> Hi,
> 
> this is v2 of
>   https://lore.kernel.org/netdev/20231002104612.21898-1-kabel@kernel.org/
> 
> Changes since v1:
> - fixed a typo in commit message noticed by Simon Horman
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: dsa: qca8k: fix regmap bulk read/write methods on big endian systems
    https://git.kernel.org/netdev/net/c/5652d1741574
  - [net,v2,2/2] net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames
    https://git.kernel.org/netdev/net/c/526c8ee04bdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



