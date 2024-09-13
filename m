Return-Path: <netdev+bounces-128012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A9A977792
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394A4B23F2B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757D1B011C;
	Fri, 13 Sep 2024 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKSRE4Qs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72C3716D;
	Fri, 13 Sep 2024 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199432; cv=none; b=b3RtSlTVhg2gMu9MEO9geDTX1GGS0JVEQcz8AnGTbKvYjs2s9B63BZRjUsu/q7flfifwSSLwqyqLxTXoxzN6Ip2zlT89UWqRbi7SWQ9+fYlROmiGyf5kamaMOzjrh+DZQa8/IFKCB3x+y68vm3W5MtQtElJlAHWEGRI0//qSLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199432; c=relaxed/simple;
	bh=z1vXkUWcddixT0zB17I2f9ujOWzkaGyhAjO6gkkfYFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HfTXUkfPtZNq+/w7z7AYYwUBU9Smo4tGeyTTu8i/G75Lkhn2XuzXkwF36PCBGeZCodCmujJHQZwx4xTfMtucJiK2y+uPcQ4Qec5hx9RDSO6XBb+PXAVoyuE2lLq6tNFL9ri3ZKZE4kZcEB6dJ1GEnTiVupM4x36JiDkGsQrXYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKSRE4Qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F128C4CEC5;
	Fri, 13 Sep 2024 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726199431;
	bh=z1vXkUWcddixT0zB17I2f9ujOWzkaGyhAjO6gkkfYFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GKSRE4QsrqnKt1toGLfM5SSFg9lnn3C34zH8lUPmHN0bZMIBrdJEXR6N9j3rd++xf
	 RhySnQ0xbSIEMEodQqskcPUTWZaiep359k39WXZFdnRgPP4g26Bgz3ohPkM7noGIx/
	 r1uJ7xOY0LXqaGxt+QDtHMOTNAQlrhI+DoqrvttAvugL5C79HrPjUCWfsu796tVtsZ
	 0nUiTK8LoLxfJLh2K+EUvsmamQyr9438f7AuEfic+ZLXtGM6d8Aix55gtcFK6fmn8h
	 F0Dkci6u0tr7YwdFxCtP5FIJw2MQPzGeu9yD5xaBH07gJtI7rr5Euvh3xkAdRunth5
	 wB5xGSs3iSjaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF93806644;
	Fri, 13 Sep 2024 03:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND 0/3] net: Use IRQF_NO_AUTOEN flag in request_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619943277.1807670.1465452734410848226.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 03:50:32 +0000
References: <20240911094445.1922476-1-ruanjinjie@huawei.com>
In-Reply-To: <20240911094445.1922476-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 louis.peens@corigine.com, damien.lemoal@opensource.wdc.com,
 set_pte_at@outlook.com, mpe@ellerman.id.au, horms@kernel.org,
 yinjun.zhang@corigine.com, ryno.swart@corigine.com, johannes.berg@intel.com,
 fei.qin@corigine.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 17:44:42 +0800 you wrote:
> As commit cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> said, reqeust_irq() and then disable_irq() is unsafe.
> 
> IRQF_NO_AUTOEN flag can be used by drivers to request_irq(). It prevents
> the automatic enabling of the requested interrupt in the same safe way.
> With that the usage can be simplified and corrected.
> 
> [...]

Here is the summary with links:
  - [net,RESEND,1/3] net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
    https://git.kernel.org/netdev/net-next/c/e08ec0597bad
  - [net,RESEND,2/3] net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
    https://git.kernel.org/netdev/net-next/c/799a92259977
  - [net,RESEND,3/3] nfp: Use IRQF_NO_AUTOEN flag in request_irq()
    https://git.kernel.org/netdev/net-next/c/daaba19d357f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



