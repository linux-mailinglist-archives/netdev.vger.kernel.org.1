Return-Path: <netdev+bounces-38697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D377BC27E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F40B1C209AB
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6003F45F4D;
	Fri,  6 Oct 2023 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr7RpFHU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AB37150
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA2F3C433CA;
	Fri,  6 Oct 2023 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696632631;
	bh=lFVMZxrxgu2mLgsdaQIPMtturFqWL5orwm6KDhXTac8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hr7RpFHUKyrGtlqnrBPn2DoWNvI0XCMUMMABXSwZUKAw/tkRP2Z0j0J+GNzwcDOKJ
	 Lk74wJqtzN9LK635nTiTBx3vdqif4GSGj3A230O1NmMCkZLULCwplJsltKt8q2S7Ph
	 o7p4wa7PJugL8xn7LrH5Jcb+LkP/YQc9VxTIx42vReiWTld1lCmYdI+4dueVZFleYH
	 YcQt6arP52gQ3zDlNy3K3CuVs3ERn7kV8XrwzezHWeQ7SyGQO3cOvtN7i2yji37imz
	 5HbAfqxWaISX/b69CMmk8h4vWXQD1Xssl3Y9cixgEKyW7KAA0xegUbck8GC70WvRGn
	 MLrZ9IOfUO9DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB9A1E632D2;
	Fri,  6 Oct 2023 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Update LL TEMAC entry to Orphan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663263174.25368.668151367419972633.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 22:50:31 +0000
References: <20231005131039.25881-1-harini.katakam@amd.com>
In-Reply-To: <20231005131039.25881-1-harini.katakam@amd.com>
To: Katakam@codeaurora.org, Harini <harini.katakam@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, esben@geanix.com, jsc@umbraculum.org,
 christophe.jaillet@wanadoo.fr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Oct 2023 18:40:39 +0530 you wrote:
> Since there's no alternate driver, change this entry from obsolete
> to orphan.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] MAINTAINERS: Update LL TEMAC entry to Orphan
    https://git.kernel.org/netdev/net-next/c/0ff85cb9ce66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



