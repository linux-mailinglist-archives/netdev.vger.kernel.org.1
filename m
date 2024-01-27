Return-Path: <netdev+bounces-66410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8883ED86
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 15:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689A0B221CB
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDC625629;
	Sat, 27 Jan 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6eSF/oV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA92560F
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366427; cv=none; b=gufjI0bcp7fadF9HA5sFNRL/7h1+AAuPPdukA5SYI4M6T7zzbMid11p00nKld9tM4Sa2fyfJHtPpaMGQUYG6BmC1y182R68Vn1zJZNRIldEVkGwdhPn7+jmnJqjzoWXiNjKISxgeA9IyjcNmNL4bB3VR/S4ijAQi4pjGIaYpVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366427; c=relaxed/simple;
	bh=2mGBykoBz0tNCS1O3fW4o8YTeLUNNbZudKYH0pEgQAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kVbKzbhvn5TA1bi2g5HBJdclmAnz4mNJi7WVwx+Oun9pNnFBQzJfPnadEI8JjVSan4F0yD7XrX/cWmpjiFsL0ch9W4BZbYUR0oFiuMUAHDsWy9sr2ixMl8+1xkTlhW6xoulIHHv96P2f9S9HaTRcZJ0p0WO8duQaOCIzZi48zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6eSF/oV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D43EEC43399;
	Sat, 27 Jan 2024 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706366426;
	bh=2mGBykoBz0tNCS1O3fW4o8YTeLUNNbZudKYH0pEgQAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E6eSF/oVasjjWmBYIlOqOg8UrX8hiSkeVV0lBnarMeLq7dgkiSNbZnjKE9muI26Ou
	 7UUSHaQuIX3Y8y0TXldrkFMXmLnlV0sm/jqLZ+aNJlsMO6rpbuIjF/hVuk+AwR5J/B
	 x+mkzVw4X7Vp3cV/UomSnYe4bTiernbJjcFRTE87aXx/gME8qcdTkqQ0NvYRzN/Y3s
	 TXbbdQPa+yYXnMPRKmj48ZAYK/KkTU1+xwUMv4mYCsW7llgSHDSu3DlRUo/0hnpNIg
	 gpnUCfLKb4shZ2PvThCigND9cblzcekszAFJHFd1EfMbc6tcnR++TASNZ4RNoFr4xK
	 SnxaiPwUys/Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA86CD8C962;
	Sat, 27 Jan 2024 14:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Implement irq_domain for TXGBE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170636642675.25681.647929549466185563.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 14:40:26 +0000
References: <20240125062213.28248-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240125062213.28248-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 14:22:11 +0800 you wrote:
> Implement irq_domain for the MAC interrupt and handle the sub-irqs.
> 
> v3 -> v4:
> - fix build error
> 
> v2 -> v3:
> - use macro defines instead of magic number
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: txgbe: move interrupt codes to a separate file
    https://git.kernel.org/netdev/net-next/c/63aabc3ef196
  - [net-next,v4,2/2] net: txgbe: use irq_domain for interrupt controller
    https://git.kernel.org/netdev/net-next/c/aefd013624a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



