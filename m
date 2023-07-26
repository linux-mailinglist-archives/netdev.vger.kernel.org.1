Return-Path: <netdev+bounces-21159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5976297A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17ED21C208A4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA25236;
	Wed, 26 Jul 2023 03:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1755235
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99B32C43391;
	Wed, 26 Jul 2023 03:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690343419;
	bh=LlxH6m3gJxKW+Jx8L4JTmLBmIoATMBBpcofInJbVcIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l0Qv2afVZjK/quzpQaLNYWcbn60W+6jf9HhnGrtfPlGcRe2x1WF4CooGoHsI+UeR7
	 i/9FKj5JuFz/6zVcLSz60v49AkPwFA686+hmi4DHcsx9Nq/gW/m/7qBv+kOIEL2mLZ
	 AqhQEpxX3lc67FzXl8ETNoSSdWVNxMwum216BASWD1yFh48TRwudmCiQ3XyThr9WFF
	 h89XcDjrRaS4WjhxEJ9fdtVeG+XwlsnJiJWELqtHpHjq7TtbNBhmyBRDvfZgKSm7XZ
	 0te1FwoMkGAErHd4C/aBQ7QbfU6ubq1fYw9mOzFELzJ+8GOGzUEdCY2KUmV9neKz7m
	 Yg9miv+KGTnXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68CDBE1F65A;
	Wed, 26 Jul 2023 03:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169034341942.4604.1855470719545245647.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 03:50:19 +0000
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
In-Reply-To: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 richardcochran@gmail.com, linux@armlinux.org.uk,
 patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 12:01:31 +0200 you wrote:
> The IEEE1588 Standard specifies that the timestamps of Packets must be
> captured when the PTP message timestamp point (leading edge of first
> octet after the start of frame delimiter) crosses the boundary between
> the node and the network. As the MAC latches the timestamp at an
> internal point, the captured timestamp must be corrected for the
> additional path latency, as described in the publicly available
> datasheet [1].
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: correct MAC propagation delay
    https://git.kernel.org/netdev/net-next/c/20bf98c94146

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



