Return-Path: <netdev+bounces-104447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30490C90A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE712815BE
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D415B142;
	Tue, 18 Jun 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT4f4Ii1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC313BC31;
	Tue, 18 Jun 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705433; cv=none; b=K4C7Sndfsjmqbr53G92GLKiUS+hhG994j+rlmjP1cNmdIAAzwAAbWEqi1+uQJnYd7/EV/xcFEWwRV/BtG/OSAr8UcEhu06G9K4ZyBHzCOWofD0lOEnS+/MJ49OI7LkF6G7fxcmhwUyv3Bl0w4mkDFk7ufzOo2Yt0dTQkwW9+2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705433; c=relaxed/simple;
	bh=a7jB79oONKETKnADzdC0pB8BUr9yJfbstgM1k2AIKjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NWOvfencx98yli12D3JttWWwMdBkbX1YufBTwZfpnTB+k5Cn7WBIhJA/VGjRkpRTiC7Opj0GLCWqnSzLkpACTA6DXcabgQ/+Vd5pNvPc4qpp+2AUiAm5thEqbyXAMKwUexw4CsWYvq0Q9wPwEHhbczyjqqRqX4O8fgSoul4sVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uT4f4Ii1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CEB7C4AF1D;
	Tue, 18 Jun 2024 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718705432;
	bh=a7jB79oONKETKnADzdC0pB8BUr9yJfbstgM1k2AIKjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uT4f4Ii1ATHBM+fVZLNywfp7tD1l7orghJkVWL8BnUFAprG7yqOCNgT+7Tw8sF3xy
	 jVMgHFVIcrRejjfOkERgkXGEbq1w335MvbzlqXtE8e2LInGUGEXGx0Yiw+Kib+8KVd
	 SHrTa6N84fJ50/pvRezCaxJc8BVah13hEOmVsi8Ty3tCisGO0P+H9PZQW/rqSWOGpM
	 5pTLYhlz4pzicexUZSPj9xKHZPFY/slkPPhT6pcHQpDckxh2v2jXk/oCn2VXlWlydk
	 jeoe445rbma5GOJ9i9vM/X/gzwb8AVN35qWZ0u29HTZreeYX5w6YMDeZOkj+HEecyy
	 AeHBzFfyCby8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 507E3C4361C;
	Tue, 18 Jun 2024 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V5 0/3] net: lan743x: Fixes for multiple WOL related
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171870543232.18151.11499833236578491242.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 10:10:32 +0000
References: <20240614171157.190871-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20240614171157.190871-1-Raju.Lakkaraju@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com, andrew@lunn.ch,
 linux@armlinux.org.uk, sbauer@blackbox.su, hmehrtens@maxlinear.com,
 lxu@maxlinear.com, hkallweit1@gmail.com, edumazet@google.com,
 pabeni@redhat.com, wojciech.drewek@intel.com, UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Jun 2024 22:41:54 +0530 you wrote:
> This patch series implement the following fixes:
> 1. Disable WOL upon resume in order to restore full data path operation
> 2. Support WOL at both the PHY and MAC appropriately
> 3. Remove interrupt mask clearing from config_init
> 
> Patch-3 was sent seperately earlier. Review comments in link:
> https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/
> 
> [...]

Here is the summary with links:
  - [net,V5,1/3] net: lan743x: disable WOL upon resume to restore full data path operation
    https://git.kernel.org/netdev/net/c/7725363936a8
  - [net,V5,2/3] net: lan743x: Support WOL at both the PHY and MAC appropriately
    https://git.kernel.org/netdev/net/c/8c248cd83601
  - [net,V5,3/3] net: phy: mxl-gpy: Remove interrupt mask clearing from config_init
    https://git.kernel.org/netdev/net/c/c44d3ffd85db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



