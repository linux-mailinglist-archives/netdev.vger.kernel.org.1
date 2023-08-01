Return-Path: <netdev+bounces-23436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9D76BF85
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5061C21028
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A126B7D;
	Tue,  1 Aug 2023 21:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954A263D7
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 21:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2612AC433C9;
	Tue,  1 Aug 2023 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690926621;
	bh=qg8R7Qj9T4gqti2LnGBxP2LG1W3NNHPhOHo+JMMtBHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lV419Ir23v+Z9lw8JQsxLGh4XDrja7hgj1xZZfeQmOnxL434rzQnrlD8j8BqWd6Mk
	 UeqF2KIinFgaoOY9p3g+3Fw/0MKKoXd/qUEIlhjOTMDPfvQ/oDrm8KzzBzr4VVWobf
	 5S0phITd4aVoWCAU5fBniUhjKzwrXZivOBR7xDsn8Nnu5edLA/sTKB0Fzy11QGaBXs
	 4bZtD1CCvGzwpfZA/ATdLDKUn7qvqcGpkVZZ5Hs2ZsN8ZsZOURfn0wIM6N8lK5f5Vd
	 47ZGjmAwbSrUKuuQbdHtoxxlrz/o0/1xGo7NlqL86rmDPaKM2Tr6Wv0uCCeMDYm7iH
	 pGHw/OD3m6ipA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09650C691EF;
	Tue,  1 Aug 2023 21:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ll_temac: fix error checking of
 irq_of_parse_and_map()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092662103.6936.6671891204915051164.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 21:50:21 +0000
References: <3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain>
In-Reply-To: <3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: esben@geanix.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 harini.katakam@amd.com, xuhaoyue1@hisilicon.com, huangjunxian6@hisilicon.com,
 yangyingliang@huawei.com, robh@kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 10:42:32 +0300 you wrote:
> Most kernel functions return negative error codes but some irq functions
> return zero on error.  In this code irq_of_parse_and_map(), returns zero
> and platform_get_irq() returns negative error codes.  We need to handle
> both cases appropriately.
> 
> Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ll_temac: fix error checking of irq_of_parse_and_map()
    https://git.kernel.org/netdev/net/c/ef45e8400f5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



