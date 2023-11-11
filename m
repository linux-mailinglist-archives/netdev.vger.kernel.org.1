Return-Path: <netdev+bounces-47200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27C7E8C5D
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3BBB20A30
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33ED1D523;
	Sat, 11 Nov 2023 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc3w/pDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D441CF90
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 19:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 043A8C433CB;
	Sat, 11 Nov 2023 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699732318;
	bh=kMgwL6cTB03XK32KetgmN3BkF483jEjd+jRzvnJeMmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dc3w/pDkeygruWNLWcZ3r6ddONQVkasoj4IVP2cvBKKYgRf2XvlS7Fr5/HqpY51jj
	 l8X2sUc9Sm8sAB5U6x3nOzy1A8K8W2wvmbBYpRSBM3AKWUzJDpSjLHHNOapJr8cMs5
	 13glumUVEUFEBvcoaIr9Na+3IOVIYCBSk3J7352P1/rxebI3QsvVG3zXPePxlCy1UH
	 WMmyclBxsLAdSY7+RmcTskirvndDQ4dYrv9xoXmFnxRQHQE0O4KuWJCimjfHDB/iW1
	 geiA+r+9Pp3UbXGcVViay3XeA0Np02wJfRfEv9auaEDLZtRKW6cIjJfyWwiMhzgptU
	 XTZF9wxPAv06Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE315E00083;
	Sat, 11 Nov 2023 19:51:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169973231790.11806.9879405241139030767.git-patchwork-notify@kernel.org>
Date: Sat, 11 Nov 2023 19:51:57 +0000
References: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
In-Reply-To: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, danishanwar@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, diogo.ivo@siemens.com, nm@ti.com,
 baocheng.su@siemens.com, wojciech.drewek@intel.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 17:13:02 +0100 you wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: ti: icssg-prueth: Add missing icss_iep_put to error path
    https://git.kernel.org/netdev/net/c/e409d7346648

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



