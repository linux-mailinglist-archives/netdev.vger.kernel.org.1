Return-Path: <netdev+bounces-99937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA688D7273
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6541F217DD
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46617282EA;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfxyzOOK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE741F5E6;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280434; cv=none; b=X7+rABkRZ921+UzwYudKEqYqSpLgYx0QXtiJIc6ZjAuynm3I6oRyPk8Y4XobzkDkrzKY/cfz+zfwVpP1EsEWNwzEbBxPDlmuKX2yxduiqFIooVdZpRwUTDxdZ8e6LuEmmFCoLPdcdeclkheJuWqK1V08SbLtqKcmwLySZwBppVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280434; c=relaxed/simple;
	bh=7/1tmtyhXsFUawLjblsvtYBKs6aOXxiGkCNCGbfinVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CBOFapN3x2iefLQAe7LPra7ljdEaiK8G9fK36lUHKWxVjD5A0Kllkwoh/obCwjavySRRqBtgybROKngVkqmlGvVHWiGK9qEDb0pcc7OnxYdSpzrwdAww/+y97xruA95xiym5xOnn/Q/9dyKZyq1vTUtLepnLfNFGebcW3zzOuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfxyzOOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7087C4AF09;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717280433;
	bh=7/1tmtyhXsFUawLjblsvtYBKs6aOXxiGkCNCGbfinVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sfxyzOOKPgjOb0SUD91u+2ctHhuizZFMR6OdMW/A3oGu750kcTFppOazS5CgncKyS
	 15WCJwMnOZ+pfw8oVr3vL1vQduLUlrDn1Zg4s37/hHxSpAxbh9IT5YEYllcCzTv7ms
	 TL+uAMlw88hTuwUzVZg2pq44Ylvf0XvLeXHt69TS2eNo6oieT8HTl9wcbfFzOBx4RO
	 6BW3utOtJmK5X0uXak1NCB9QFbiz+ih4pPeqNXdcLokol8WRE4GY4VTbJk64jMU7C6
	 tgH1Y43Nid4SvwYCOocFvh8LFMr5sK4K62QyFsMuyuMeRqa3ahmHnQnOOcN6zbYkYE
	 is57nUldimP3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A76B8DEA718;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: remove Peter Geis
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728043368.17681.2598399426972352004.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:20:33 +0000
References: <20240529185635.538072-1-pgwipeout@gmail.com>
In-Reply-To: <20240529185635.538072-1-pgwipeout@gmail.com>
To: Peter Geis <pgwipeout@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, linux@armlinux.org.uk, hkallweit1@gmail.com,
 andrew@lunn.ch, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 14:56:35 -0400 you wrote:
> The Motorcomm PHY driver is now maintained by the OEM. The driver has
> expanded far beyond my original purpose, and I do not have the hardware
> to test against the new portions of it. Therefore I am removing myself as
> a maintainer of the driver.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: remove Peter Geis
    https://git.kernel.org/netdev/net/c/7679935b8bdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



