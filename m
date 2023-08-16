Return-Path: <netdev+bounces-27923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E7477DA45
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A051C20F25
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92853C2D6;
	Wed, 16 Aug 2023 06:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596243D6A
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C413AC433BA;
	Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692166221;
	bh=Uw8bTVFIBNZcxW+KxD6j2IfyOEvIwjpoIZwuxS/bQwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FUEPhoQ6BnLEBWxEAlOK2b35sOck++bagDPDWDDbqfnNOYLb01cM4DJuIBnK4Tnh5
	 jk8GyAKx0NhsCA6YZDUhb92SjXoKODsJQX6n90ap+rnqsJRqaWkuMElfg4EnVPiocR
	 Fbjhj9ONjneBLttYkwIm7gfidZjbaZp5ZD4k+dEkrcKubFZ+Z5uFo29Owe3JbUDJeK
	 1E4PZCPm61Gxuzp1KsRSjPxF2UR/C85nJllpnaYDt4jRgjfFW3j1A5Unqp6cU3HA0O
	 wM4J/zTHruK3LF6YZ1ZiWPehdFBBOw+2K5q5ibsoU37Po4Pf3yoCg8c5jIKnP3Ul2E
	 igPGGD/B12uEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE7BBC39562;
	Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: bonding: remove redundant delete action
 of device link1_1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169216622171.7878.6507698004399073444.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 06:10:21 +0000
References: <20230812084036.1834188-1-shaozhengchao@huawei.com>
In-Reply-To: <20230812084036.1834188-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 j.vosburgh@gmail.com, andy@greyhouse.net, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 12 Aug 2023 16:40:36 +0800 you wrote:
> When run command "ip netns delete client", device link1_1 has been
> deleted. So, it is no need to delete link1_1 again. Remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  .../drivers/net/bonding/bond-arp-interval-causes-panic.sh        | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] selftests: bonding: remove redundant delete action of device link1_1
    https://git.kernel.org/netdev/net-next/c/e56e220d73ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



