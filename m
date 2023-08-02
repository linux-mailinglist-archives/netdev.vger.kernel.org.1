Return-Path: <netdev+bounces-23564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAA76C844
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E0D281962
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32B5661;
	Wed,  2 Aug 2023 08:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71A5392
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 054BCC433CC;
	Wed,  2 Aug 2023 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690964423;
	bh=VuSMhTQ/OQWlzez2CcMsKBO1M8l3TUcs11autt3WxxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ove5y8kF9dvVQqA4LTEn+xRUq88JSCOg7OGORbQgR9CnbvgVYQpO7YFM9Q5Y3Zgga
	 yLFcZu+lcdkfsxx5MmsXOx7AbV8K0/cgTd1gspZavkVnAAuptv/ZrM1nqh4kQ5qMYR
	 7nIuJ+/j9ZSZapwIwi7mXMue7aAnOKn8cekBBzNy2ZQQTW3YTt+dSeIgGGjyxWOx8n
	 FxZCQemhjPwlMoHGET/7qdcmIp1qFrsnEdHgNQeRSYBOZS4iTDoi30IYBpzOfAJO/m
	 qBnI7QeTJhv7twnlkpsY1CJ7hn5iM0taYYQzyOtzVUKygRayGgUqTGae9t92peH3An
	 i0wb+nC+HOvpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E039FE270D2;
	Wed,  2 Aug 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: XGMAC support for mdio C22 addr > 3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169096442291.23876.736146422814364637.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 08:20:22 +0000
References: <20230731115041.13893-1-rohan.g.thomas@intel.com>
In-Reply-To: <20230731115041.13893-1-rohan.g.thomas@intel.com>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 31 Jul 2023 19:50:41 +0800 you wrote:
> For XGMAC versions < 2.2 number of supported mdio C22 addresses is
> restricted to 3. From XGMAC version 2.2 there are no restrictions on
> the C22 addresses, it supports all valid mdio addresses(0 to 31).
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 36 ++++++++++++-------
>  2 files changed, 25 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: XGMAC support for mdio C22 addr > 3
    https://git.kernel.org/netdev/net-next/c/10857e677905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



