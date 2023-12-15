Return-Path: <netdev+bounces-57852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF3814530
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A061C22C92
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD818C1D;
	Fri, 15 Dec 2023 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTgOE2mm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F020199DE
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78EA3C433C8;
	Fri, 15 Dec 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702635024;
	bh=QzgSxH2X9WVTDh6yhJ33k5BOreN3WvcxV62hSoelwZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GTgOE2mmnB3K3wyNaZhnNYqysqjTElj0U8Ew9evVjeXHLyH1jtowYG7+vvwfUZhPB
	 fv3521uKxVTyWqersDQTcUETKAqshCmto2DCv1VJ6Ib6FYANPh2bYtFvUE7/Qc7Dci
	 7l4gkIz9HgqboDvR9ve3a0D9uw31pe0oh9dg3C/liqY0YDh3yiGvZzfksZa5s/JrKH
	 s0ANYZadrRl5A4b5r3MfyEeQXN2ZRUoWthTwG2ha5FYhKE+hISS6Hh5Mrvc7qNUrvU
	 h/owpvTr61sSfyl0MdfzZOwsYQDpnru1sJowEZILEBtsy1Bo1Bhv3dNQK63TZZM3iG
	 HcMx1Hg6guq0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FFACDD4EF5;
	Fri, 15 Dec 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: libwx: fix memory leak on free page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263502438.19532.13512821235149291973.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 10:10:24 +0000
References: <20231214023337.15392-1-duanqiangwen@net-swift.com>
In-Reply-To: <20231214023337.15392-1-duanqiangwen@net-swift.com>
To: duanqiangwen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, pabeni@redhat.com,
 yang.lee@linux.alibaba.com, shaozhengchao@huawei.com, horms@kernel.org,
 stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 10:33:37 +0800 you wrote:
> ifconfig ethx up, will set page->refcount larger than 1,
> and then ifconfig ethx down, calling __page_frag_cache_drain()
> to free pages, it is not compatible with page pool.
> So deleting codes which changing page->refcount.
> 
> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
> Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: libwx: fix memory leak on free page
    https://git.kernel.org/netdev/net/c/738b54b9b623

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



