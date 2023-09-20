Return-Path: <netdev+bounces-35210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C67A79ED
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7330E1C20994
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083A1863A;
	Wed, 20 Sep 2023 11:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47916438
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFB9BC43395;
	Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695207624;
	bh=q6NPHTdLIJ7RI/7zOZQ3KCd40OPqqToSztFaLpAMoDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cZ6uPpXzLFkqWWxeVxd2b965QMsTokYpUUM7ExuDOaRlFo9PxQMonp4Vx1m+vudu8
	 bt3vSfhXuartYFs3siC93UTyiSWQK6ycbj6mw7mK+mFPAyuyav3VheB7NOWcuvotXw
	 4G33d0GVB2Cqg1JTTRIXca+qHc7hB5prR9ePmI5Uz+e3srDuPtKV0AuLXnUrdu/GSD
	 WG/1aY9C96nMQskYVT22CAPmnHnZfH9xzwTv7c3ibfUScccgyO8nZsmw5AtUSATYdM
	 1fDtEcPkAAK8MBrS0JMEBpQ3Oq/g3liUNOzBpr0auQzidJkjkYcuzZTC2i1llZWBTE
	 v7H7jhkvZHOOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8FBCC595C0;
	Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: mv88e6xxx: make const read-only array lanes
 static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520762388.31903.489961378827553101.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 11:00:23 +0000
References: <20230919094021.24699-1-colin.i.king@gmail.com>
In-Reply-To: <20230919094021.24699-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 10:40:21 +0100 you wrote:
> Don't populate the const read-only array lanes on the stack, instead make
> it static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/mv88e6xxx/pcs-639x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: dsa: mv88e6xxx: make const read-only array lanes static
    https://git.kernel.org/netdev/net-next/c/ccd663caffc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



