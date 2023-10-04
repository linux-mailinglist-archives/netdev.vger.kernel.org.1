Return-Path: <netdev+bounces-38060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700487B8D6D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9C80B1C20444
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD8921A13;
	Wed,  4 Oct 2023 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDM501ce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CDA18E29
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C8AC433C7;
	Wed,  4 Oct 2023 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696447833;
	bh=Rll2hLODlO0jmujFPX4lrfv0Ine7ZvmL97hOB+GB6RY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hDM501ce2NuFndagwuaawZtKJIGNc+HB30HRbNGnHEARoTlNypCWEBGYxJWMgmP6Y
	 PaJXTNmxofQLvPi0cPNlTTRZb+ht1MrSa5P1eRwy27NCN/ETtNTuAxO4DYz4Dkmi7S
	 JjCO0XGHneUF7PgmgQLREd2ka2OXk1ItQ2h/J2eE9vS8UisOiamVWDqq4Tsfxt/IJ4
	 6c4nwh9iVBfgrCziALT2eT4f95gU8V5dneMMZU8kHFuhOyb0XouGbFHzS71dAD00vO
	 5QsMm4fr+7QNoTl4BYcg8xnugsUFiQGMStS7hkC4ymMoFqfo6NViSmvgGw1x1MVvPZ
	 PIl8HDWxMMgHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA586E632D7;
	Wed,  4 Oct 2023 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mt753x: remove
 mt753x_phylink_pcs_link_up()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169644783295.9933.15690171576616695923.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 19:30:32 +0000
References: <E1qlTQS-008BWe-Va@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qlTQS-008BWe-Va@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, arinc.unal@arinc9.com,
 daniel@makrotopia.org, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 13:13:56 +0100 you wrote:
> Remove the mt753x_phylink_pcs_link_up() function for two reasons:
> 
> 1) priv->pcs[i].pcs.neg_mode is set true, meaning it doesn't take a
>    MLO_AN_FIXED anymore, but one of PHYLINK_PCS_NEG_*. However, this
>    is inconsequential due to...
> 2) priv->pcs[port].pcs.ops is always initialised to point at
>    mt7530_pcs_ops, which does not have a pcs_link_up() member.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mt753x: remove mt753x_phylink_pcs_link_up()
    https://git.kernel.org/netdev/net-next/c/d5a590b1b614

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



