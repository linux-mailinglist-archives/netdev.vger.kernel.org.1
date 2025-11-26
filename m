Return-Path: <netdev+bounces-241743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF68C87E60
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F02BF4EB3AB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7630CDBD;
	Wed, 26 Nov 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jc34WEF8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55130C355;
	Wed, 26 Nov 2025 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126063; cv=none; b=ezbJXk8QMOv/aa9fBYRVC+I/O25EvUgZlGbc23tHLoCrV+elcy+YYCxBKyTrQ7hYqw7CtPqrKrybPcrxdVL2lJ1DiPjrLQS4o5Mr4P9+4d6E0dQAqM1FpzHhzeO2C7l+DAxkmhlBApLZh80zrHRt3JBmmhVMXib0M/CrZtPBPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126063; c=relaxed/simple;
	bh=qsbLUzalVKf0rwa9lcoahHNoYBjk16XGSgT5RWFpQyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tA9LFOCWp+5YW+LNNlEfySKLWHTAr7gWsSo9wSvPYBrmRCsB/K6kybbGAyfeBbDCX6aMkSt5d1dT6Y/cgDPgYD/eYub9/bkvwnf+vmhKY11MYLBPWZNQKoeOuOXdD2KGk9dpLmLsfvxBtPwZRxbpFbQ2HA3KUkioDlYy+gmJc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jc34WEF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04C2C4CEF1;
	Wed, 26 Nov 2025 03:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126062;
	bh=qsbLUzalVKf0rwa9lcoahHNoYBjk16XGSgT5RWFpQyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jc34WEF8jSkRsAWJ9FBv459wB6gT3/LisQQJbGqBkj/o6l/HsJ3wobPYqZRo9RAhJ
	 rJhJfJ6jTqLHg+lEnD/XdFuu0va/EDQsWaLkQ+rVBHPPt/V7XddjtCIJ3JezJdvE3t
	 afhpOkcXA60Q/7koTLD0K85idHJQ4b4jI1qNLbSAWO3TlDkpz37jPtObHqG3H4sKGR
	 yP6fJ+rRjXk1efqnYMROTc1GD2EprI4PAyzvBUttv8h3Er9Tc19m71a/9sujsG2kWL
	 Bn4IlK1ZKanW4tdTg9J9/8xwKRl9vVuO2FfLJxU/XVudSQGEY/xOjpqWityT6Bb1Cz
	 zS/2rX7nmwqNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6C380AAE9;
	Wed, 26 Nov 2025 03:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: mdio: eliminate kdoc warnings in
 mdio_device.c and mdio_bus.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412602425.975105.16959868795408680063.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:00:24 +0000
References: 
 <7ef7b80669da2b899d38afdb6c45e122229c3d8c.1763968667.git.buday.csaba@prolan.hu>
In-Reply-To: 
 <7ef7b80669da2b899d38afdb6c45e122229c3d8c.1763968667.git.buday.csaba@prolan.hu>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 08:19:15 +0100 you wrote:
> Fix all warnings reported by scripts/kernel-doc in
> mdio_device.c and mdio_bus.c
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
> V1 -> V2: consistently use 'Return:' in the kdoc
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: mdio: eliminate kdoc warnings in mdio_device.c and mdio_bus.c
    https://git.kernel.org/netdev/net-next/c/a11e0d467da2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



