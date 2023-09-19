Return-Path: <netdev+bounces-35025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C447A67A0
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E628528145C
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7063B7A0;
	Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89013B782
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44B02C433C9;
	Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695136222;
	bh=wrqC6REkEJrkRzfwAscQTd/GQ3EwDBjwa+nBdT4zorE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hRZBH2mRC+9x0jnRcoJj/8vSiEbpNPMMVLx+2BRpC36iWRIP0c/814EkbSSEd4WEP
	 r3iJ0aI4ZMVAXGMMTqoTKj4Uy73IGK0ZQWfmUbIKpbCgmm18Q5oDCx0VwDvNS6bHZi
	 djewUojBorSM0g1Lfr+9QFFi0tXFlRbSyZi2jPiomWVpSmkyAV/tb37GmEui/oBjwz
	 c5FICpWs+CU9qV3LlvZl/IPBTzeieMc7lSj8ZPisRuqCe8HyFcomZ7+N61dEzSeTjr
	 jgByjGxT6+cC1QxM35NvM6Qgq4/qYO0QSU+Ycqh5jO9Ek8NxEQViKpLgf9sZ0mdsrE
	 hlUNrWCXeGvRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27214E11F41;
	Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: microchip: Fix spelling mistake "unxpexted"
 -> "unexpected"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169513622215.19882.9342395230402169534.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 15:10:22 +0000
References: <20230918132142.199638-1-colin.i.king@gmail.com>
In-Reply-To: <20230918132142.199638-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 14:21:42 +0100 you wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/microchip/ksz9477_acl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: dsa: microchip: Fix spelling mistake "unxpexted" -> "unexpected"
    https://git.kernel.org/netdev/net-next/c/1964aacfaed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



