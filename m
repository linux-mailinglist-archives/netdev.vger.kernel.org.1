Return-Path: <netdev+bounces-35689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFA7AA9F5
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DB4391C20AFB
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B918027;
	Fri, 22 Sep 2023 07:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A7179B8
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 07:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B046C433D9;
	Fri, 22 Sep 2023 07:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695367223;
	bh=BHybtxwY47uYYHFXoDtvlNNeebGa5opZ5WlHJz0v3Rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mbSkkHZ8pd3qzc8pjpZc3Dku6xjLGdQvXmjxPtw65nHH1CkUnGvVs6oot1KwI/nUW
	 y2XX7Kl8QJCDvQAxrwW+27XENXRokAkjFfUAEHTzwZfW2xOifE8wnFpz1lG70aiMdl
	 d7NT/IRvfw9i7P8/qxZHTKQGHu+rr1vswU8LkBjxDRIL2NntQSv+JSHSnQPDkIYVwv
	 aq+JORGici5TpbU/WQM/36C4tAWvsOq8L1a6SSSpxvmNfyK9mOFCfOYb83b5mTA2oO
	 T0UItb3g4J4LGIaEqHVLl/eNsuOQ2BKE4mnxXK/o+y2OgRIfRA2Lnb+r0tlBAOBWj+
	 mdxIERzIFYRSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 194A0C04DD9;
	Fri, 22 Sep 2023 07:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hamradio: baycom: remove useless link in Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169536722310.5471.3731844839478615297.git-patchwork-notify@kernel.org>
Date: Fri, 22 Sep 2023 07:20:23 +0000
References: <20230919141417.39702-1-peter@n8pjl.ca>
In-Reply-To: <20230919141417.39702-1-peter@n8pjl.ca>
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 14:14:23 +0000 you wrote:
> The Kconfig help text for baycom drivers suggests that more information
> on the hardware can be found at <https://www.baycom.de>. The website now
> includes no information on their ham radio products other than a mention
> that they were once produced by the company, saying:
> "The amateur radio equipment is now no longer part and business of BayCom GmbH"
> 
> As there is no information relavent to the baycom driver on the site,
> remove the link.
> 
> [...]

Here is the summary with links:
  - hamradio: baycom: remove useless link in Kconfig
    https://git.kernel.org/netdev/net-next/c/84c19e655b29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



