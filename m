Return-Path: <netdev+bounces-235691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD27C33C18
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5A34D118
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52E248F57;
	Wed,  5 Nov 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJO5lMQH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B79247280
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309251; cv=none; b=T05gIoYmZq+ANY5Bj+6kAmWtnefrL08rFHnQDbW9K4xLrGGjv1bUQ4qDyb8iPF0W5uXKK+PYhwf0P83X3yqYKayjD+gwHG0OnZqUQGWSL6+n5mUzbmr/yj79zMBlKZZqfoDBd+ty1r22o+rPVNfehPKXtauCb/RmuM6sIuAcdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309251; c=relaxed/simple;
	bh=Y3cA/K96tzwyo7NHB88Gyzss48qiwuBmGbmSQVnyKmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pmxO4+y/7MtiN5LwE6h6rt+29cYfvr4K81/+jV5xPf09OpcU2N0dpbUX0fHIdV42pBVCCxncMuRCUKS55gCrHoGF7wkcECk0eo6jfxmmNy5sBAEY4qf8nmBmdYq3mFcLgf6AyMqWgLLlTGUUnGJOe3IqGgSCXXQnQIP8D/vhpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJO5lMQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B908DC116D0;
	Wed,  5 Nov 2025 02:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762309249;
	bh=Y3cA/K96tzwyo7NHB88Gyzss48qiwuBmGbmSQVnyKmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJO5lMQHaal8WU8le41wziGuJVLNfj09V/8lgZA5rbukGoetrV2ZcweKPpz4xTydh
	 Uu2ZXI3CJ167xl7cM6Ec02tDIfD3Y40TqWXB6+ND4QipBA+z19/DpE5N4zU7+I4HZo
	 nybzs3jQZmzmDVrPJSQi7ym97bXyG9KED78rBk7EcH2BZnDRp5Te2KF/RloMGuCqsY
	 Z3+OH6HqV8LjdX9lPEmGPCbVLKiX9OWPalnFd+9yUZ60krPv1bshqwwTCtw9T7znrP
	 Utu0D9NLsNnowceMF3xsS50Pa/HykinzdTyJhbcEm8GSW5/jHzNU4eFPiSJ5y3kcLI
	 555+1CXY720Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD64380AA57;
	Wed,  5 Nov 2025 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: make phy_device members pause and
 asym_pause bitfield bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230922324.3062547.1584343255762586704.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 02:20:23 +0000
References: <764e9a31-b40b-4dc9-b808-118192a16d87@gmail.com>
In-Reply-To: <764e9a31-b40b-4dc9-b808-118192a16d87@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 23:26:49 +0100 you wrote:
> We can reduce the size of struct phy_device a little by switching
> the type of members pause and asym_pause from int to a single bit.
> As C99 is supported now, we can use type bool for the bitfield members,
> what provides us with the benefit of the usual implicit bool conversions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: make phy_device members pause and asym_pause bitfield bits
    https://git.kernel.org/netdev/net-next/c/617a0dd24ef2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



