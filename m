Return-Path: <netdev+bounces-34468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC697A44F0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75497281C7F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137D14AA7;
	Mon, 18 Sep 2023 08:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AA63B6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D7D1C433C9;
	Mon, 18 Sep 2023 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695026423;
	bh=hkysuzXXpyTo4YJfpCQrt/6IvGPkJL0RINYK9UEJwXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lMK3Sc/iweRWJUj2obq3/xmL1iFgykk25FPppE+TxUipCMTsPHWi7NXxBqu+2TLXn
	 0CiJkh5yduhs1pvHcrFF0v3ugBv/jQhh0yAvRQubKceU5eiHj+PfGiInZpyR9fTgss
	 1E1KoxMWwgMJrHo65rZ1L2BnY/6GA3Hg+83gVyWvu2Altus5kNr1blSwuTti4ct+sg
	 uMa2fue8sfD1VNfGw5aAwu8QeQj7cXXRDgCnd9a2IVKddN9pSKyGtq+CKE34Zc/Q29
	 E8HFaMJnxXieRZDimG4Het9ko9dBcKXp7y6LW4EvAXWAIj26Hrpsp4YP3RFfVH1Qyo
	 7SEskvSZPDwTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1566FE11F41;
	Mon, 18 Sep 2023 08:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] tls: Use size_add() in call to struct_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169502642308.5792.6048998714250953891.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 08:40:23 +0000
References: <ZQSspmE8Ww8/UNkH@work>
In-Reply-To: <ZQSspmE8Ww8/UNkH@work>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 13:12:38 -0600 you wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: b89fec54fd61 ("tls: rx: wrap decrypt params in a struct")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> [...]

Here is the summary with links:
  - [next] tls: Use size_add() in call to struct_size()
    https://git.kernel.org/netdev/net-next/c/a2713257ee2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



