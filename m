Return-Path: <netdev+bounces-151601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28E9F02DB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 04:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25A7284F66
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F313A271;
	Fri, 13 Dec 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA+uXg5y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED527715;
	Fri, 13 Dec 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058814; cv=none; b=COKXj3jgNeXqEEjPhBYqk43pI0r+v/Gd9M5tbJJAZ6jjD6W0psyN1T77DeFXqUsG9cfOnd01WwDQKlQE7JV4ERZXW0pOhc5DkDkeDIw3l5fqo21KQlc7HYShbW5qstrlPQ1Y8XFKhnoOfXUBY03Mn2FZwvHFQ8pMt3SWsM6tnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058814; c=relaxed/simple;
	bh=sUWgms/m2M8cMtkGOkYr4LrmL4/DOIF9JUD9CV216iQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l7hlU6Pq3oFOEP9PbinG7bwbkR+ufOGSD+gfbzfydiqnmVFoG1e9Un3Elh7GbC0cUnknr7TUkfDEQyloIhdKSTg1Z/KDp01cp27B8SujG0a0zYmLnaxT0/xoF+UQiSaMCNrnLWsw8ZICLwoO1XC46uHpFbRljYVO01XjHoPwmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA+uXg5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC66C4CECE;
	Fri, 13 Dec 2024 03:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734058814;
	bh=sUWgms/m2M8cMtkGOkYr4LrmL4/DOIF9JUD9CV216iQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kA+uXg5y3WGv5YF7JDNeGmFQ6H4hlKu5LRJJjgxHdZZB/eXl1QTuMUMwJie0BQzvC
	 OvDVXpH57SVARZ5GbdThREcWahNBZ31gdY9JMh4Ua/DQz+PqIsq1lL70Jcv2hZ9sUs
	 KowwyOTBM2CcxCLcfbQgT2HXwc3SF59rg6LNhYhQiA8YLm/jONO/1+Tg8fco+agCw7
	 DU9iAuorvHxuvB/okBITPsU2Rjbbfdrnvzt0PelL+dBie1BPW+iV5cwEAs3ElBuYyc
	 Wj9EyBEG6EkNmQgF9CQXhSih/QQe+J4Zh2AiDy6BbADVuBBw4NuLWtyZ5/V+Z7ddGa
	 44yF8JsxdQDDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA5380A959;
	Fri, 13 Dec 2024 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/5] devmem TCP fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173405883030.2519119.15952110801173674783.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 03:00:30 +0000
References: <20241211212033.1684197-1-almasrymina@google.com>
In-Reply-To: <20241211212033.1684197-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
 willemb@google.com, kaiyuanz@google.com, skhawaja@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 hawk@kernel.org, ilias.apalodimas@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 21:20:27 +0000 you wrote:
> Couple unrelated devmem TCP fixes bundled in a series for some
> convenience.
> 
> - fix naming and provide page_pool_alloc_netmem for fragged
> netmem.
> 
> - fix issues with dma-buf dma addresses being potentially
> passed to dma_sync_for_* helpers.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/5] net: page_pool: rename page_pool_alloc_netmem to *_netmems
    https://git.kernel.org/netdev/net-next/c/91a152cbb49c
  - [net-next,v4,2/5] net: page_pool: create page_pool_alloc_netmem
    https://git.kernel.org/netdev/net-next/c/8156c310499a
  - [net-next,v4,3/5] page_pool: Set `dma_sync` to false for devmem memory provider
    https://git.kernel.org/netdev/net-next/c/b400f4b87430
  - [net-next,v4,4/5] page_pool: disable sync for cpu for dmabuf memory provider
    https://git.kernel.org/netdev/net-next/c/7dba339faae9
  - [net-next,v4,5/5] net: Document netmem driver support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



