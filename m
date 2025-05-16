Return-Path: <netdev+bounces-191219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F90ABA693
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AAA77A66CD
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EF280320;
	Fri, 16 May 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJWOx007"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2EF2798F9;
	Fri, 16 May 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438193; cv=none; b=gss5HuxQNr3SFlQiQEtOPEo9Z8ohBOpl12L6vqf0WS9XVao1r9PtH5OpkhYLd8PjYyW2f6i30nBMEcAZZylwCRNOqCWOfTq2O7jWRq/02rRsqorZTeynln5cVDtUVngHn5S7rocS6WGl2eqiAjK1ElfGrbeeeXVSOly0MRWlGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438193; c=relaxed/simple;
	bh=S9KP9pyp5Cw0/B4s3gDa+GWacXE0tVau3M3d+PJ+OeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p6a4J7qMA7ltNqXF+JzaqnU6dxGfwYZR9JpauXCvnAmJjZ485ZUyp5/g4Be9dD9isTHoPY9C1tJNSX0bydf/mPiq2eTBL41P3O4CzJiUhj5fGh8/RwIdZXlf6PKSCbFOlyeRaHIf/pshEWhOPSBl08tXd0xDC6gnA2bgId3cdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJWOx007; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FF6C4CEE4;
	Fri, 16 May 2025 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438192;
	bh=S9KP9pyp5Cw0/B4s3gDa+GWacXE0tVau3M3d+PJ+OeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IJWOx007mG8pIjnRpbSCej1u11zVy10VZM/NG+VTTvj5vT1zvw1yak2/9ExXt9YJL
	 c84T8JX11t31LbreiHTPk/u4eka6AEGRr1dHN40y4Z0ckuoilygGEg8GgbL5OnD2Uq
	 ITAZfA8HzFk6rXazPWMR6r/cbjLb36DIyDscmMWUvYdDXgAVjKUcGWrmYwkTdGebQp
	 DhSMvXqYVzmTluv9ajmHe3LJcWdKKB94ROFqOvqv2cDewR6F53bLHrgtz4z3vILkxb
	 S/DB9UUvk+rsxAbLkuXsFjyLQueImYmWYeTpAkJyh5Nb9ZxlAJrcygTcxymJ6MaMsU
	 CRRkAz7oNTWMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB13806659;
	Fri, 16 May 2025 23:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: phy: microchip: document where the
 LAN88xx PHYs are used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743822950.4093464.8865364121925600971.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:30:29 +0000
References: <20250515082051.2644450-1-o.rempel@pengutronix.de>
In-Reply-To: <20250515082051.2644450-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 10:20:51 +0200 you wrote:
> The driver uses the name LAN88xx for PHYs with phy_id = 0x0007c132. But
> with this placeholder name no documentation can be found on the net.
> 
> Document the fact that these PHYs are build into the LAN7800 and LAN7850
> USB/Ethernet controllers.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: phy: microchip: document where the LAN88xx PHYs are used
    https://git.kernel.org/netdev/net-next/c/622b91e0f946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



