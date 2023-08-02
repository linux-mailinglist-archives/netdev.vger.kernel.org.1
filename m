Return-Path: <netdev+bounces-23782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB2776D816
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7741C21154
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB311CA4;
	Wed,  2 Aug 2023 19:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5510966
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F8C9C433C9;
	Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691005223;
	bh=oh81ctC1cekNu7KmTEJrGMWSiZHlF8k/JlSpfOmVdNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X5vM8KC7H0wYpTNyZhyxzEovISfLD2fJmk3TVKp4IFOb1oamvLX2KC44sA2hIighx
	 1XZz4F9W5Aaw2RgV4aPUiDBI2+LbAU8TGPsC52yQ/OJpaCFsFjAKjIpMYc5gmDSpN+
	 Hqj4bwVdJ+TX2TSNyiysnISvSlk0NZQ2AUygTJG/KHQzc5NwrLQJ7XB60A1zTV0e6N
	 xn96VPXb1bfoobokkIDAuEfSGyGcIVxWFohQRmHmoC2bsp4xFNj2n0DyOqqvFMRWKt
	 dveZiHACXWhbjK5qTBhNeo1HJa5bXM3YBCpooov5mDJc6akrrRuuJEP6lQRdpvwizZ
	 eH8HCUET9kXYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34BF0E270D1;
	Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ila: Remove unnecessary file net/ila.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100522321.7181.8472449666217446859.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:40:23 +0000
References: <20230801143129.40652-1-yuehaibing@huawei.com>
In-Reply-To: <20230801143129.40652-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 22:31:29 +0800 you wrote:
> Commit 642c2c95585d ("ila: xlat changes") removed ila_xlat_outgoing()
> and ila_xlat_incoming() functions, then this file became unnecessary.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/ila.h       | 16 ----------------
>  net/ipv6/ila/ila_main.c |  1 -
>  net/ipv6/ila/ila_xlat.c |  1 -
>  3 files changed, 18 deletions(-)
>  delete mode 100644 include/net/ila.h

Here is the summary with links:
  - [net-next] ila: Remove unnecessary file net/ila.h
    https://git.kernel.org/netdev/net-next/c/2fca1b5ef898

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



