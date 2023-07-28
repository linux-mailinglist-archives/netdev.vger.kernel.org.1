Return-Path: <netdev+bounces-22464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488497678FB
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44B7281E0D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D23200BF;
	Fri, 28 Jul 2023 23:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A975525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 23:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9497C433C9;
	Fri, 28 Jul 2023 23:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690587020;
	bh=FWGOuJNnxQ8LB9TJesHkFzsgcZFxtmGm/CpqXJd8ZKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jp97ag3wlFuxtpF5a4YX3rzTtqnUPDCRUsde2RyxeYUumvbkNFW1uDl2a7XgvHe+e
	 oL5bYqFQTSirdBl8usT3ZM0kOdZu//BSc5Y1QA8aBAorgFfbkzAyFBxBg3QsH5ziH+
	 LLGq8gtId+lh9KOisRVwk4B5zPoa96QBN3qUQJ/PP6p+Z4V6IfzVTAdnp6v+nt1xup
	 1MHz9wE1CNpfZowr05Q8pciIa5jyBbDPixUV/4XBEdHtA2uwC57mrE0Y8DWHyG9Clh
	 CL96fLSkTgvT67u9gYsljxyXnagAsbIv743S0i3VBIgxFoGoeOActgkMy0SjWsLvky
	 DwuAOG97vYrqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB1BC4166F;
	Fri, 28 Jul 2023 23:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: ethernet: slicoss: remove redundant increment of
 pointer data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169058702071.6177.8877758938708395588.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 23:30:20 +0000
References: <20230726164522.369206-1-colin.i.king@gmail.com>
In-Reply-To: <20230726164522.369206-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: LinoSanfilippo@gmx.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 17:45:22 +0100 you wrote:
> The pointer data is being incremented but this change to the pointer
> is not used afterwards. The increment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/alacritech/slicoss.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [next] net: ethernet: slicoss: remove redundant increment of pointer data
    https://git.kernel.org/netdev/net-next/c/3bdd85e2e350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



