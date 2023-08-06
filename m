Return-Path: <netdev+bounces-24714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201F7715F7
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E2C1C2096C
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B17567E;
	Sun,  6 Aug 2023 15:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EE53B3
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7324EC433C7;
	Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691337021;
	bh=wrBdZugugv5+bjCZftrtdQCrAT3kcIxzWUP4AzgC/oI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ImQVlEIdiGuUO0HPpBdXeOPV6GfNmfDyGqrYhewdECbUJ7MqUv71oY7LSN99A2I/5
	 qgOnDIOvmwMh492MraYCxrnrQgW/sHAcUM4BwoZ1bNHUW5o7cIoZ6P1Rp9Qz2PB993
	 DyyM4KG17eE947gaHwmL5llgpr1HSFA2Hl0fYkx02yNpyEx/iIgjr4K2a+jVithg9D
	 SGZhnnqUP7H/6gPU0XJe2KsU2Lbvqar5kcLhU928/JF7zqVzV3YERC1wLhJV9z0U/1
	 Kdu0mqpO+H1Lvacv3pmta55oejgAfFPWDIdsXEJMliG76xrZLYX8lsC2QtCdyf3gmn
	 mI/cYv9JOkK7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DF70C6445B;
	Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] drivers: vxlan: vnifilter: free percpu vni stats on
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169133702131.8913.17543544061792703834.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 15:50:21 +0000
References: <20230804155337.18135-1-pchelkin@ispras.ru>
In-Reply-To: <20230804155337.18135-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: idosch@idosch.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org, roopa@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, khoroshilov@ispras.ru,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 18:53:36 +0300 you wrote:
> In case rhashtable_lookup_insert_fast() fails inside vxlan_vni_add(), the
> allocated percpu vni stats are not freed on the error path.
> 
> Introduce vxlan_vni_free() which would work as a nice wrapper to free
> vxlan_vni_node resources properly.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> [...]

Here is the summary with links:
  - [net,v2] drivers: vxlan: vnifilter: free percpu vni stats on error path
    https://git.kernel.org/netdev/net/c/b1c936e9af5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



