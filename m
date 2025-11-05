Return-Path: <netdev+bounces-235689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C454AC33C0F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFF63BC7A9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B810C21885A;
	Wed,  5 Nov 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTlt6/mf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFD1E9919;
	Wed,  5 Nov 2025 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309248; cv=none; b=OQfjnJDV5tBNfqqBF8LdvOgl/BIoRkV/vhptvoC1kV3BYjIyRNCPgj4KdJIf5cZu6cjiyECBmMxKfrCzzuxTEPClYCMrgP2lvCJUt09lHByZGhD/92ngGM1kiaEXsPg88FJs/evWQtWc98T+AYW1zKanScKpvxJ+WcDw4Gc/lAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309248; c=relaxed/simple;
	bh=Zr+j+565XvfLm2SsJQls3yEiyOWPm+Rp4hCYDk/hfMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4rgIpilgbMYHPwgovdV27ROJpd7+EJdBVRB2aMFgxAVETYerZWlO9u9cWMKCqmakAUBFoo6eesE9wIaWvfORdoSJovhIlbdUOoKOptPCnH5Zfb9dyQy5w1Dx5/lQOhZt70z6qmwXMScTyWaxkJC7QEa898MSNkz0fe39yX6T20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTlt6/mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C8EC116B1;
	Wed,  5 Nov 2025 02:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762309246;
	bh=Zr+j+565XvfLm2SsJQls3yEiyOWPm+Rp4hCYDk/hfMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TTlt6/mfwNYAeXcYZVsj04yfi3BxoCxKnbDh12OvrwUbwinCSls2Ya7CGR5y1z6wc
	 L33AsUzJEkNoiKSPXmfxh0eFHmzssZI3uMzSr5XgmkP8eAOGyMu5hzJojGJ5i/CTrG
	 LXmAsWHcL2KyCSad6aqSk8gvxKtPYQkNretC3L/J/Osc4Ztpup9Ggqa53ot/5bvnnE
	 Xghw62eAUx2/MuSatdVi/2lTkz6R6UQH3qZxJS8dNtb+Fp2sjB+yloQ0BcteWU0GZE
	 kmuROI8uLR/tuEt+hryeFHMcKPjUpaqhqU07S4zDEEq5bq3bzr57KjGWxltrmqMiuZ
	 fLgyrBpuInHgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE89380AA57;
	Wed,  5 Nov 2025 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: altera-tse: Cleanup init sequence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230922050.3062547.8083675540294624198.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 02:20:20 +0000
References: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
 boon.khai.ng@altera.com, alexis.lothore@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 11:49:23 +0100 you wrote:
> Hi, this is a V2 for Altera TSE cleanup to make sure everything is
> properly intialized before registering the netdev.
> 
> When Altera TSE was converted to phylink, the PCS and phylink creation
> were added after register_netdev(), which is wrong as this may race
> with .ndo_open() once the netdev is registered.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: altera-tse: Set platform drvdata before registering netdev
    https://git.kernel.org/netdev/net-next/c/687452051886
  - [net-next,v2,2/4] net: altera-tse: Warn on bad revision at probe time
    https://git.kernel.org/netdev/net-next/c/dd2619d38d7e
  - [net-next,v2,3/4] net: altera-tse: Don't use netdev name for the PCS mdio bus
    https://git.kernel.org/netdev/net-next/c/9350ea63fec6
  - [net-next,v2,4/4] net: altera-tse: Init PCS and phylink before registering netdev
    https://git.kernel.org/netdev/net-next/c/055e554b8fff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



