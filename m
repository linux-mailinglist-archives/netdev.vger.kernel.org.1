Return-Path: <netdev+bounces-22101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0F7660EB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891F328252C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40117F0;
	Fri, 28 Jul 2023 00:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD815A5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E2B7C43397;
	Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690505422;
	bh=e9oNV7ZGuvUs9vo/i9F7rmaLnHMQDv2cTspikLSRME4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8NcaErtlFsq4U3C93Wih0HdMGkULslwMJmEY1C9u9NE0v5iGK0V/nclJybjom1Y6
	 kwNwauu2zaIiohTpXdgsG21r1AGer0fFDOBDWB1iPZ1fDl5gFvMVibYUtHaxPN0WDT
	 P7XPe37+yjPpSjsoVvQmavXlkfRSevE0259T3Drgxdl8w9Nfh04OwiXCpSwL3Al45v
	 TkPYNPOdR5/R1H37dvdL46bp3LWsrWbcctSXAHCZkp/Ro88TAPX717Bwji7O1EQeqP
	 EPuFlFTguXFLxTpgyMK3Y8XRDUnbNmqCOYH7wvZflIiRrf8hnY88CPScTl+qN5DN7C
	 W0aEjXv4QJNMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69B2BC64459;
	Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: datalink: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050542243.6763.7729312365050648608.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:50:22 +0000
References: <20230726144054.28780-1-yuehaibing@huawei.com>
In-Reply-To: <20230726144054.28780-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:40:54 +0800 you wrote:
> These declarations is not used after ipx protocol removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/net/datalink.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: datalink: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/994650353cae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



