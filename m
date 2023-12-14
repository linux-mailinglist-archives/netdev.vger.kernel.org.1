Return-Path: <netdev+bounces-57205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7708125AB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9591C2171C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F3ECF;
	Thu, 14 Dec 2023 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmcMbWq3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79F1EA3
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ECD8C43391;
	Thu, 14 Dec 2023 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702522826;
	bh=WRvV7jkhaywOs74s6oO3swC05Is7QmZ7CySN42KTgbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fmcMbWq3FZgYVT08vlZrAxg31V3IfWZA8JT/vTZWUCF15Km9eS2hI/zPkYfIwXMuN
	 6vkz9uPYqiVJQC7+LGHErBguUbOsMjtAdzYFcqF35TOqhP99J/t0xvZiQHQmonR8cE
	 979RE75UnaDt1AxW47Ftp+XQBuedDWAZlRTMsm+Pk1XkEQcG0nuioThFGQr53jsbyr
	 PSBXHdAzbbeXOigoBAWVt9knJe8Ph8r0BBDan0LgendnUp66x7OsmopxNwFWK05STc
	 S8Z4xG0bFtBplJUt2V195VXzQXSmuAnrvBTwe0KDOfJEUUNJcY4aH0LDBoLb0mr526
	 JmJ4q2oOkayyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A211DD4EFE;
	Thu, 14 Dec 2023 03:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/4] skbuff: Optimize SKB coalescing for page pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252282616.11535.4456947354721331080.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 03:00:26 +0000
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
In-Reply-To: <20231212044614.42733-1-liangchen.linux@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org,
 jasowang@redhat.com, almasrymina@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 12:46:10 +0800 you wrote:
> The combination of the following condition was excluded from skb coalescing:
> 
> from->pp_recycle = 1
> from->cloned = 1
> to->pp_recycle = 1
> 
> With page pool in use, this combination can be quite common(ex.
> NetworkMananger may lead to the additional packet_type being registered,
> thus the cloning). In scenarios with a higher number of small packets, it
> can significantly affect the success rate of coalescing.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/4] page_pool: transition to reference count management after page draining
    https://git.kernel.org/netdev/net-next/c/0a149ab78ee2
  - [net-next,v9,2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment
    (no matching commit)
  - [net-next,v9,3/4] skbuff: Add a function to check if a page belongs to page_pool
    (no matching commit)
  - [net-next,v9,4/4] skbuff: Optimization of SKB coalescing for page pool
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



