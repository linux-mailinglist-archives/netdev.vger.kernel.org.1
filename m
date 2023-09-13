Return-Path: <netdev+bounces-33541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D704779E6C8
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918512825B1
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F921EA90;
	Wed, 13 Sep 2023 11:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810221E539
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E33F0C4339A;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694604626;
	bh=fys3AwpYMFkt4YpMz2d9cBa4HOo29zLSnKJq0CztGhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HoigTJxBqwRaERj0uhNCxnLnoW8QdbIdiKARdggVKYc4BF94U8xJ9jLO8vpKvZCIg
	 +Tc6HJXn0UBZE/QFNZw5+NBrOaFd+jr8M7WtTev9Rprbpu8Mo5ipDsK5fkQzqjQ32l
	 Q9MITKDV0bDOyh591rVUBvkCOv6bjRPKwnKdtrqaFa3Eptl/lVI0b6JvosIcrgovIo
	 fZ4DQvxukMTSyKErFxumMx6LytrSXyzI/wxB0oUIK/HFl/FqnTrgvEtm9zZhAtHK2b
	 TlyD5lw7wsfyfG1DT+8kwuIBcatUPCrzXJTfk9dJfJJGPSjV5u/b69CN4IMldbZ2lP
	 S+mjqMQup/b+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D08B7E1C281;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hinic: Use devm_kasprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169460462685.4298.10103672469852664707.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 11:30:26 +0000
References: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: cai.huoqing@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Sep 2023 21:50:52 +0200 you wrote:
> Use devm_kasprintf() instead of hand writing it.
> This is less verbose and less error prone.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_tx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: hinic: Use devm_kasprintf()
    https://git.kernel.org/netdev/net-next/c/9cc91173cf1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



