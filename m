Return-Path: <netdev+bounces-21143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 021E576291D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C1B1C21000
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17E1FDC;
	Wed, 26 Jul 2023 03:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989915C9
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A203CC43395;
	Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341020;
	bh=ksJDVNmZpZ1DYcJEyESEXFZ9bmStt9xJuis/PkFSI6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y36Njv8Jno0xDR+Fdsr+tPJPyCDUYAzQNeqGwgQdVeNRmK4VCNQwNMQfJ+02NC44e
	 G8W5vywiQPSGLnr9+RNSiaww+nP6/QJ67xKU4Adm+LUxqfsnMmlmwHrbpuFg6Ryd5u
	 cd5DwnRHjrdhloklfyVRwi7WKU60+KdPYEPAskxldG+i3zzLWNPYBE2jniC/EZwQes
	 /hlc2CFHzAV8iG9olNHfpwKxu4a7Fn7BtrAuMp0SctuJRUWH1Otzie1L4BukN8Inoi
	 fMkaRhEJALvHIiLi3s74BmlKhjK0mF2GgDDvDFwnbHglsIsIymE1XdrWpa1hoSVLnS
	 SiBuQQlnq2BEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 833F7C595D0;
	Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove redundant NULL check in
 remove_xps_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169034102053.18310.10029873167601541391.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 03:10:20 +0000
References: <20230724023735.2751602-1-shaozhengchao@huawei.com>
In-Reply-To: <20230724023735.2751602-1-shaozhengchao@huawei.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, simon.horman@corigine.com,
 kuniyu@amazon.com, liuhangbin@gmail.com, jiri@resnulli.us,
 hkallweit1@gmail.com, andy.ren@getcruise.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 10:37:35 +0800 you wrote:
> There are currently two paths that call remove_xps_queue():
> 1. __netif_set_xps_queue -> remove_xps_queue
> 2. clean_xps_maps -> remove_xps_queue_cpu -> remove_xps_queue
> There is no need to check dev_maps in remove_xps_queue() because
> dev_maps has been checked on these two paths.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove redundant NULL check in remove_xps_queue()
    https://git.kernel.org/netdev/net-next/c/f080864a9d90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



