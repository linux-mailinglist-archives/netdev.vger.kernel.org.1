Return-Path: <netdev+bounces-201343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE29AE912D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BEE1C257B1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64381214A6A;
	Wed, 25 Jun 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqHIoibv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94C1B0F23;
	Wed, 25 Jun 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891181; cv=none; b=oeXAr0tGOKXt1JJ3NjRg+9m8mz3t/71HYiKnMsO8A6Dyyyg14xjsg+f9tl+PbsI+T4OYzzN0gWY+zKbqwPFYajpQ4INRV1cwU65Xn2g4IzfR55rYjERK/BOXhnCy1lZjyZAXNGIGgFvc3dx7QHXVLrj831MUDKLreeLMM3rqd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891181; c=relaxed/simple;
	bh=tbMpsmfeYisSTile89ez/hnT2au0Oeme/M6givzqt8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZGqCCX/ZvxEZANsovfGn+gre7m3hunqJMj9qbxQMcrvuO+Wu0sn13vuTW3VhQI4TF0c/vDddpLaTq5+/h9TIZ0QG/u8JWkdV/hZnRBL+7kpzIIz+lPrpbClGdyM3GFejiKSS2wPgnT3xEf0BxiIfPsD6rDYx8o0MAn8krDJ0y9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqHIoibv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A14C4CEEA;
	Wed, 25 Jun 2025 22:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891180;
	bh=tbMpsmfeYisSTile89ez/hnT2au0Oeme/M6givzqt8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WqHIoibvgPFtIsSWZyG8UPi3WxESOAGQhVQ8jk7jLFaZQMCo8ECb7OStBpo+T7Tum
	 FyWL36Rx37wp6uNB78JaPlBGqINESSQf9oBaesTaDBmRfzC2yrOeverKuVJGJjmJLe
	 QwL/ppVZCPt9SWvSdpbqr/PqTHAo847ki60z2q/w29Otfjh/azRxSLgGMGTc8qVwkP
	 cP5t50mfrnBShZvU15j5JvzR2LY7wmhN5hSf6zVQttZz4FNkme8iCGif5ChCi475GT
	 dBODwSSFnM/g1WLDVx8fcDIRwV33XDGg+6D/zc+ihclA/VRxds6Grq9lyKm/ZB44KM
	 uW1R0fevSH48Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E083A40FCB;
	Wed, 25 Jun 2025 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] atm: idt77252: Add missing `dma_map_error()`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089120725.644002.15732931146965333696.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:40:07 +0000
References: <20250624064148.12815-3-fourier.thomas@gmail.com>
In-Reply-To: <20250624064148.12815-3-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: kuba@kernel.org, 3chas3@gmail.com,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 08:41:47 +0200 you wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/atm/idt77252.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [v2] atm: idt77252: Add missing `dma_map_error()`
    https://git.kernel.org/netdev/net/c/c4890963350d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



