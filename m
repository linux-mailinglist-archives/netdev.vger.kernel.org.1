Return-Path: <netdev+bounces-22143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E62C766291
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAD91C217A1
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC205239;
	Fri, 28 Jul 2023 03:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D773D86
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 774CCC4339A;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515623;
	bh=7wl96arjuQcdUlvjNs/Cps02MRx37rBRVnxbcG0AVhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nRB2rqy7pTEN/EyeIzcQ+tzt7NSS8zxJPMicHSEwRdR1vdXOS/9bG04eNaqOOyqUf
	 dF2OnB6WsTIKm4hX6iXTuQt+vRvz7lvhEM2hJQ94e2dUYsLDAHH4uorStrp/hW/lZH
	 TBbvJgLCXYI8IKuXwVyZW1DrDqHCaFF9Ab0gdyIBbpue/zpHIOEmg10z2XSTIHzd+9
	 5R83956wYSERcmWplREOPGaUmvb8dAC0VV2F9K//azT37oTkeFWPCRfckZTTmxaAdY
	 lEphY1DxlywglGI30EjhgwnM3IyJLgh3TsuqdXaE5aQ8CDvOkhqhStdBzBQ9W3qUA0
	 vsH4mYzcQwNrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57F1AC59A4C;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Revert "net: stmmac: correct MAC propagation delay"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051562335.23821.5064102823353959912.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:40:23 +0000
References: <20230726224054.3241127-1-kuba@kernel.org>
In-Reply-To: <20230726224054.3241127-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 linux@armlinux.org.uk, j.zink@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 15:40:54 -0700 you wrote:
> This reverts commit 20bf98c94146eb6fe62177817cb32f53e72dd2e8.
> 
> Richard raised concerns about correctness of the code on previous
> generations of the HW.
> 
> Fixes: 20bf98c94146 ("net: stmmac: correct MAC propagation delay")
> Link: https://lore.kernel.org/all/ZMGIuKVP7BEotbrn@hoboy.vegasvil.org/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] Revert "net: stmmac: correct MAC propagation delay"
    https://git.kernel.org/netdev/net-next/c/81b04a800d3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



