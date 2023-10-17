Return-Path: <netdev+bounces-41908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB037CC224
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DDD1C208D0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E46A41E31;
	Tue, 17 Oct 2023 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyR13NqG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385F1946A
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66026C433C7;
	Tue, 17 Oct 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697544023;
	bh=r6Rm3djNaBJSAPvsANZ7x4Pe/zaEWxkEXZRLiYOaOeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DyR13NqG35Y4Un5VydQdm4Iz4olyaBSVM8W83Lei2ZJ/yyYBZx8c3uG69rKcunNuP
	 lMJLD4Z1JCmY1vOH9F2Oz0esJr8rFJEqDav+uKnUbMXXBTDNhKJYKaPWEbbKvgyj9Z
	 aet93E8pXpz/ulT71Xdmt1KR7NLMX9Dzz2O7EaimcEnDanWuJBnFXgzB5+7XcOhLS7
	 6znjqBiMuZFVsxTusZ8NLbAqxweH2O4vw/ZN5HhKI0JKwkMeTwiI8z7SoUknIMYeDx
	 RBQzcCAMm20q13primuuQ3mknpIXuCtjCjhE3kfxXn0+ctLzHfC01GJ3RfYsFGvp8P
	 J72I5gQo9JHBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51F07C04E24;
	Tue, 17 Oct 2023 12:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: Do not fully free QPL pages on prefill errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169754402333.24227.4640309007559494474.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 12:00:23 +0000
References: <20231014014121.2843922-1-shailend@google.com>
In-Reply-To: <20231014014121.2843922-1-shailend@google.com>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 14 Oct 2023 01:41:21 +0000 you wrote:
> The prefill function should have only removed the page count bias it
> added. Fully freeing the page will cause gve_free_queue_page_list to
> free a page the driver no longer owns.
> 
> Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
> Signed-off-by: Shailend Chand <shailend@google.com>
> 
> [...]

Here is the summary with links:
  - [net] gve: Do not fully free QPL pages on prefill errors
    https://git.kernel.org/netdev/net/c/95535e37e895

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



