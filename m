Return-Path: <netdev+bounces-100881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB58FC744
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D61C22AAF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFED18FC74;
	Wed,  5 Jun 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWizGOeR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353418F2FF;
	Wed,  5 Jun 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578628; cv=none; b=CH5iY/jFEzZAycPRbST2iJA4aZa0d9UfueKHb8N0lMWpvafGGbmbT+o5TghbxRSaioHddjKEXbbcqL46WN/iUdnQvgp+dAUeg3uNLptHOi0Y1DUl1fH9/tgZQF1Ztwrq7aA0dGYe/X3KEur5FQSLFFiuvtpy8fSMkJ83Rgajsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578628; c=relaxed/simple;
	bh=ghYtGslKc1bk6prdMqzaGE3ldvf4OpaAFUsroNQ/5TA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hLm93x/dUmmgWBKJCzi9mVsVefYdVoqbepnKdw8rEYOf1TkyGbR2pQII8XIbXXfLsndGkf7n1/NmqkvBpM8HBJvw92AVBbBhTmQkR86iS5UBtvfmgpPS/ul3CwEKAZm3I1EzfOJZR5VY1L+SOjFNCnCwnfWIYNAhbXXjxo+gxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWizGOeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3201FC32786;
	Wed,  5 Jun 2024 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717578628;
	bh=ghYtGslKc1bk6prdMqzaGE3ldvf4OpaAFUsroNQ/5TA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWizGOeRiSjM0Ar2HC/moePEoLKClXxSN7G2BpUtVSTsT+mb30Lrm1ox2X8kPQTeH
	 yZVrO/LO/JAec4N+nOZymfTTYOmRmvtyPV0E3NCaiHn9j/6C2VY422X/M3Gix+6KI0
	 XFWlE2/VfGjafnO7nk6Km/9YJZQMlzqllZWWELKGT6Ny5dTxSpfqSCCaY63SZ05qRm
	 P8Tru3dRx8FWiQ6aTVsO7AgQywD95oXDDbRdCaTh3pN/fpXDYJqNUQCiZF87ZuSHl9
	 bD1EtxaSp/VNRCikR8fD2sN2u2IWO/gVU7AiqM6JA4RjVHeO7XXOV9aQv1XFz4On21
	 K12pq1PKFRgyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F6FFD3E997;
	Wed,  5 Jun 2024 09:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: phy: Micrel KSZ8061: fix errata solution not
 taking effect problem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757862812.24611.15288736111467368389.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:10:28 +0000
References: <1717119481-3353-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1717119481-3353-1-git-send-email-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 May 2024 18:38:01 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8061 needs to write to a MMD register at driver initialization to fix
> an errata.  This worked in 5.0 kernel but not in newer kernels.  The
> issue is the main phylib code no longer resets PHY at the very beginning.
> Calling phy resuming code later will reset the chip if it is already
> powered down at the beginning.  This wipes out the MMD register write.
> Solution is to implement a phy resume function for KSZ8061 to take care
> of this problem.
> 
> [...]

Here is the summary with links:
  - [v1,net] net: phy: Micrel KSZ8061: fix errata solution not taking effect problem
    https://git.kernel.org/netdev/net/c/0a8d3f2e3e8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



