Return-Path: <netdev+bounces-49618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880ED7F2C0C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C239281665
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10D487AE;
	Tue, 21 Nov 2023 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDoL9u7W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E748795
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 11:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C202BC433C8;
	Tue, 21 Nov 2023 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700567422;
	bh=89rqKRO0kd/JzpWJQNy6UxDOfd01yIfmkYOIn4EMCMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eDoL9u7W3c4zKMm67dAYB3goDhZMrABqk7LS94agQHjooZg5lb017TESs/fn69Zl/
	 gy9B/U3AGXd2QiLE8AWwY9j70AK7NCNcnaUrg+yF4chpEBIsmiLuxinHMbZMRYTbgM
	 mYLOwPQN6F7k5nhw6g6ORBmlgG6zK3kimJad6SPYybhYg8gUpDMZS//gaZC1NnQBFo
	 RcRe+dT5u3u0XXv5OWk948l7P7Np9uOw20yqqUjGEIeKPX4JxDjFDsL7UNL3uOvGwz
	 oL0vgIkkr4K9LAfuUTsxPqzokc12Arvnn3Zww76XQuKRWOeFokcVYb6pbbNaBzA4ji
	 +wvwox9KyBg+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1C6FEAA95F;
	Tue, 21 Nov 2023 11:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: remove extra newline from
 descriptors display
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170056742265.32090.5713757301002366239.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 11:50:22 +0000
References: <444f3b1dd409fdb14ed2a1ae7679a86b110dadcd.1700372381.git.baruch@tkos.co.il>
In-Reply-To: <444f3b1dd409fdb14ed2a1ae7679a86b110dadcd.1700372381.git.baruch@tkos.co.il>
To: Baruch Siach <baruch@tkos.co.il>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 netdev@vger.kernel.org, fancer.lancer@gmail.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 19 Nov 2023 07:39:40 +0200 you wrote:
> One newline per line should be enough. Reduce the verbosity of
> descriptors dump.
> 
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next,v3,1/2] net: stmmac: remove extra newline from descriptors display
    https://git.kernel.org/netdev/net-next/c/7911deba293d
  - [net-next,v3,2/2] net: stmmac: reduce dma ring display code duplication
    https://git.kernel.org/netdev/net-next/c/79a4f4dfa69a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



