Return-Path: <netdev+bounces-27883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B694D77D828
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4ED2816AB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF13FE6;
	Wed, 16 Aug 2023 02:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2B17EA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4E38C433CA;
	Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151822;
	bh=TvIcGdfs/e4rVml4DBfZeSRdAvc8xZa3p4ubeI6k6Zw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RqlYx5H82mJJTuVHRJqQyRpvpzD67Chg7cjNxu7B59I7ymNWVpQvkXYUyDgpB5xQC
	 MkARVpIgBu2BUTwXN9kmkpBNFylxhzjBkfX2h+6wLBcMSqx4Y0e3bi5egrW58Z/a+0
	 aqn9aRSUap9/f10MyUH5mpCTpjSvCzYOmTdow1XKnizfSbSOQntHaf/GoWXCkac/qV
	 p8HT/pvXr7UqyG8IzxwgNe1nbgTJHCnhkwPcPHtKfjy2BSQ/DFQl8SU3on/Rtw45Hu
	 LnLfhp/YXduUXSmE3brfDZ4VH0ZMXHbigVj78CEtMd5AtgCvT69L04L198nKzOYdEB
	 c38362cfKzmcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8753DC691E1;
	Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: e1000e: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215182255.21752.11821443988284205958.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:10:22 +0000
References: <20230814135821.4808-1-yuehaibing@huawei.com>
In-Reply-To: <20230814135821.4808-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 21:58:21 +0800 you wrote:
> Commit bdfe2da6aefd ("e1000e: cosmetic move of function prototypes to the new mac.h")
> declared but never implemented them.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/e1000e/mac.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: e1000e: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/3bfdcc324a04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



