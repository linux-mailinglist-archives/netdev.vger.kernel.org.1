Return-Path: <netdev+bounces-70420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4884EF37
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 04:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995A11F22547
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41923FDF;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzwnzdgN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EE4C61
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448268; cv=none; b=QVB0JdhMzlWCkfEy6DB1I2IsIr8MM1dBKoKouCTQERY3pLN2IJEGaj70hFciWmZW7ur1MoifcuiseeyleFElutvavvDNko0C+gwn78kcaRelVdu2wF1koQHSUfY/ew1I43MsaC4xn6JPHZqW4BqSHwps7Rr3FIZqnJ7LPmr1ojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448268; c=relaxed/simple;
	bh=vbrXp3X9lZ4o/cSdOVKcY1Mo+XfdHnHUdIlsp552PrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=reh7nBes59fQ3/QjqnFpAZhNPj+Fv8GFp9SN693iWJ9aYpEDqwQnX8sjB4Fcoqt7EN3jesxuzQzfgxImwQiSJsShtHXDPC5sjkj1Mjvqm3lta48YMNhv4K/o7XDuHzayHOgWr4CVR1l+Ldsqx16cmDt1GT5k4yA/nl2VC8UKyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzwnzdgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FE29C433B2;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=vbrXp3X9lZ4o/cSdOVKcY1Mo+XfdHnHUdIlsp552PrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CzwnzdgNwFcztxAP2GnhOWlrrDDNjLzVs3CR7e6XcemBJIoOZC7vR0+ZmHIqbd959
	 yuWjDFMdLmFx1YPpVoEbIB31q5KsKAtAzsO8lTFWPMIOkUrOKEQRyulWs1k4Xap6JX
	 j+kfFF8QLGQZ1PFDxYWrzxmSV03T1uu0IXitKZVVsbPq43vWg8Muz6w5+BuDBkfIX9
	 oxKPRZwQVVrl1Au1IqIBt5fvXXoj9NLISVHatoVlH/zTWM+nVnuVtH2YkloWdw/Wyn
	 XEbigvXkDyFjNnhnx6ikATI83Z3nh877X2afVHX2209Ypx9ADfVjltLFC+TUOqNaVk
	 v26zu23Oz4pYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46687D8C96C;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: b53: unexport and move
 b53_eee_enable_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826828.23533.8812150266680304921.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240206112527.4132299-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240206112527.4132299-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 florian.fainelli@broadcom.com, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 13:25:27 +0200 you wrote:
> After commit f86ad77faf24 ("net: dsa: bcm_sf2: Utilize b53_{enable,
> disable}_port"), bcm_sf2.c no longer calls b53_eee_enable_set(), and all
> its callers are in b53_common.c.
> 
> We also need to move it, because it is called within b53_common.c before
> its definition, and we want to avoid forward declarations.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: b53: unexport and move b53_eee_enable_set()
    https://git.kernel.org/netdev/net-next/c/a2e520643be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



