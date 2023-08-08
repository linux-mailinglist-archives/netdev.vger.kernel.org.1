Return-Path: <netdev+bounces-25594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217C9774DE4
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7A1281983
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566AE18007;
	Tue,  8 Aug 2023 22:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70A17FF1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A7BC433CA;
	Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532022;
	bh=C0NTCNR5CFkS/JA5rIJm0bLzcxqLkSsSNsY6g3aQy0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L8Ur7Dnl7Gh8nydvAeTfRbJK+GiNZ1VM4W1dQ24HiaGZZoIY1/BcyjXT3EzdP5jQ+
	 6tM1U5B1SzKwTooXdMP7r87nObsbiohJhUHWTAJ/agWA0LZ713SzfnInXlfAnF7rJG
	 n2Lj/xrj0CwtSVTjUgSQUX+X2g3DQ/KvFv/sGmb2+CUgX4lwyfc9SrjUboL8M3eWeh
	 ag1vrB/Ul11GXIHlIevx5BvPP2Q6o+qtsmbH7Jq/sk32/XjzggYiIv3NdXCSJ+ooUO
	 TjeRvlSat6lYA15KPY195deXWQRE/8JF3jegmZjSP/ieOTfLqNnPPKfE3epglyT+PW
	 OQ1vfml7cJt+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7440EC395C5;
	Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hns: Remove unused function declaration
 mac_adjust_link()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153202247.6931.15704455132988684999.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:00:22 +0000
References: <20230804130048.39808-1-yuehaibing@huawei.com>
In-Reply-To: <20230804130048.39808-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Aug 2023 21:00:48 +0800 you wrote:
> Commit 511e6bc071db ("net: add Hisilicon Network Subsystem DSAF support")
> declared but never implemented this, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: hns: Remove unused function declaration mac_adjust_link()
    https://git.kernel.org/netdev/net-next/c/6ff0490cd810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



