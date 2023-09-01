Return-Path: <netdev+bounces-31691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956678F907
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 09:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DC81C20B85
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F28BE8;
	Fri,  1 Sep 2023 07:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2823C3B
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FA9CC433C9;
	Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693552826;
	bh=pQJufM2gfsTvjtgulQq2rIq0spW0AEUvlhqXCYjOrKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qq0PBa6/A3K+z0YiaPcRmGqSdBTUUZawpsQ57xRPZ0HVhYKmJU3WyMfZH+7niwn+k
	 NVC0V4+icVMw1UqqLjoELYwjKtbSF2eJSeIW5LTQS5SN93M/aYlzrld9zHQLCz7s1h
	 LQcgx5EcKEieV9bek6Hwz1tjxvcBOVgK4XUDz9ysBTrc1foRkOk4XEmWx+RaD13GSq
	 ACTQbx3+JA8hSOnuoWXvVNRORzE3Ub+B9wfaDFBTnF5RK+fspMhbd1JKDos0DQJYRe
	 YD3G/DNY0CXnAYGkpX2hE3pwtqbIIiLYefckZYhuqQW4FfDJWZd7tgwA072FBckG0T
	 Mp0r8urxq1AdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DC74C595D2;
	Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: check for zero length in EF10 RX prefix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169355282650.26042.12939448647833622026.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 07:20:26 +0000
References: <20230831165811.18061-1-edward.cree@amd.com>
In-Reply-To: <20230831165811.18061-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 17:58:11 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> When EF10 RXDP firmware is operating in cut-through mode, packet length
>  is not known at the time the RX prefix is generated, so it is left as
>  zero and RX event merging is inhibited to ensure that the length is
>  available in the RX event.  However, it has been found that in certain
>  circumstances the RX events for these packets still get merged,
>  meaning the driver cannot read the length from the RX event, and tries
>  to use the length from the prefix.
> The resulting zero-length SKBs cause crashes in GRO since commit
>  1d11fa696733 ("net-gro: remove GRO_DROP"), so add a check to the driver
>  to detect these zero-length RX events and discard the packet.
> 
> [...]

Here is the summary with links:
  - [net] sfc: check for zero length in EF10 RX prefix
    https://git.kernel.org/netdev/net/c/ae074e2b2fd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



