Return-Path: <netdev+bounces-52814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971CA80049E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A0E1C20C40
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88914AAA;
	Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUWwyHgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39C12E48
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2FEDC433C8;
	Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415227;
	bh=vTjtMuTcR9tfuBLdztPV147PSAy8Z/tak0LnQysHFgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OUWwyHgIEIghw9Jtcz2q8j/1bOM6y+rwwvviuAvrRpK/ambeL8n1hLyfjHGg+D9pf
	 +VT33cGbI6mke+zrXHKW7AxK+qVNQD+9Z9ziMoD9JcRXy1Ihjy0T/ADIVaFULxgHiP
	 fE180DHDC+85OTFFQoSfQEbYJZAsHIW/0MKPxQ/ChP441dzGiZ6OBOxG1WLmSHQsR1
	 l5YMcteVKN7iyZ3V1FmTBfZacMmm28YBRX2jV2gyqGDh3+oHDArEBmszfPpb5D3wFs
	 OaOer0CJ36D5rC3LTeOLQG+ONIt1Sn+iIeD9Fa4r6RiPG7YHPH25lmgy+MRdnq7wOf
	 FaiR96IZ8OXHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2E10C64459;
	Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of the
 copy of a definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170141522679.3845.12131849353944729756.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 07:20:26 +0000
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 19:48:13 +0200 you wrote:
> BYTES_PER_KBIT is defined in units.h, use that definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  net/sched/sch_cbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net/sched: cbs: Use units.h instead of the copy of a definition
    https://git.kernel.org/netdev/net-next/c/000db9e9ad42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



