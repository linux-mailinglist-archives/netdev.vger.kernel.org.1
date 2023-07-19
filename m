Return-Path: <netdev+bounces-18988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C9975942C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90721C20DC8
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E236134DF;
	Wed, 19 Jul 2023 11:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48523101F0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E71F3C433CA;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766221;
	bh=3BC8lChgn5oAnIRDdYVjsOIF7fPuMWAEDhoYSJTqvRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xnzm4T9x+OQr8jmpB7tNSi0MFU4X6SjGU9dFJnbmfl4gvctHjtH8Bv5h7964URjRp
	 VUkfHTPQgSGO3uAbC9D60UEivcbPkxXg2uXFYTVzvM/DpMT1uSE5eRVdbi/DLanIu8
	 iQ4u4b2224sbo3r7qp2+SrFGhTyG7krMU6Rvf4Q6nWrEne9qr166HAMrfwZiPmSaWs
	 XeahV5ewGMwupPiBfZv6IbFozbOwdHBfqnd0lnv9/a9V7eX8J7Xl7e4L5NDCk45tlt
	 8y9Y/RS2v3IisFqi7lHJQVV+XgI3Con4HU2zcgy7g4OPlOKKaG4FnHo0LNYHvuoDiE
	 SLYHXBo0JmXYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4D70E22AE2;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] drivers: net: fix return value check in emac_tso_csum()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976622080.17456.15040360736920624729.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 11:30:20 +0000
References: <20230717144621.22870-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230717144621.22870-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: edumazet@google.com, davem@davemloft.net, timur@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 22:46:21 +0800 you wrote:
> in emac_tso_csum(), return an error code if an unexpected value
> is returned by pskb_trim().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/qualcomm/emac/emac-mac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/1] drivers: net: fix return value check in emac_tso_csum()
    https://git.kernel.org/netdev/net/c/78a93c31003c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



