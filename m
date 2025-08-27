Return-Path: <netdev+bounces-217122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9BDB376CA
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EF27B4A19
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AE1DF996;
	Wed, 27 Aug 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEHm7nRf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E61D5CD1;
	Wed, 27 Aug 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257603; cv=none; b=XjIozm+D5Ac4W5p91j8QGkwP9HfBlZ6uehUXFUhVnxDYjf2FW58WU/jRHJ1Fvyek1x820xmmLBvfo8jMFBKMhALBSid8Gr55Hi+HVa6caPTp6agQv4m6t/PHXHXJ5jWZz7yDZWcD2jx+qKgjU7zjkobqgRLTL9/g69PveXzj5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257603; c=relaxed/simple;
	bh=p+ihllgmoY+nsmIVwqerK8uRJ7BnZjZqB4wY9eVZWy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RxigNUDz1QSSgLSSZaYFIvRq8SiRcI/GA32w0vxNypR/9ykN3b5Um1xJWH+jnNBrEjxcmlX5EQpzCUl+3NHhhTC5m2U0EPjBAyb1yttGIJ6xvj6oE/O8BtHXUq9ybnVnSXhGUsjjsH3NFZk980GIJgvorbVsqJROSw6Z2Jtaaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEHm7nRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8285C4CEF4;
	Wed, 27 Aug 2025 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756257602;
	bh=p+ihllgmoY+nsmIVwqerK8uRJ7BnZjZqB4wY9eVZWy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FEHm7nRf0liNFVqr6IVBtN+Llmi1Z4YAbD2qMwydFCjWh2geKyAneXXuk17OyxvJ1
	 Y9F9xSU0dGkd9F5z0plz08DKXmEIb++k1irI8ke+THqNR7W1RaztyC52sr4YAdtA9W
	 qDiBV8d1/cY/xO8eL6qDHpHVmd1I1iUE4W351RuAUWhQeq3yUrgjza7ntOSKTd6IZo
	 LEciZ8b7cmkoOK5wqKaHgFgXQAjsTJNKDEdiELdI3abqBkWwFeX/61lM++xTlA0R+/
	 fG9SadpAePOC9negjclit5RgltKkOvfZljDJrvFB4AOyJCY8HDtkSDzDw7VnhsXjeb
	 5pgK7pK2SKN1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D89383BF70;
	Wed, 27 Aug 2025 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: stmmac: xgmac: Minor fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625761031.160020.12871390130445211831.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:20:10 +0000
References: <20250825-xgmac-minor-fixes-v3-0-c225fe4444c0@altera.com>
In-Reply-To: <20250825-xgmac-minor-fixes-v3-0-c225fe4444c0@altera.com>
To: Rohan G Thomas <rohan.g.thomas@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, Jose.Abreu@synopsys.com,
 romain.gantois@bootlin.com, fancer.lancer@gmail.com,
 boon.leong.ong@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 matthew.gerlach@altera.com, andrew@lunn.ch

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 12:36:51 +0800 you wrote:
> This patch series includes following minor fixes for stmmac
> dwxgmac driver:
> 
>     1. Disable Rx FIFO overflow interrupt for dwxgmac
>     2. Correct supported speed modes for dwxgmac
>     3. Check for coe-unsupported flag before setting CIC bit of
>        Tx Desc3 in the AF_XDP flow
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts
    https://git.kernel.org/netdev/net/c/4f23382841e6
  - [net,v3,2/3] net: stmmac: xgmac: Correct supported speed modes
    https://git.kernel.org/netdev/net/c/42ef11b2bff5
  - [net,v3,3/3] net: stmmac: Set CIC bit only for TX queues with COE
    https://git.kernel.org/netdev/net/c/b1eded580ab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



