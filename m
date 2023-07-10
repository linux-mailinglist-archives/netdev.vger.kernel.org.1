Return-Path: <netdev+bounces-16370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C8774CEAF
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B82280FCE
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC966A933;
	Mon, 10 Jul 2023 07:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848A33EE
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DF4BC433C7;
	Mon, 10 Jul 2023 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688974820;
	bh=0Bwp15/bzkiAYeCdxpZMgJoJAC0QpOauLx6M6z+j8P8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GV2uscGdECdSg5ZV/ZSjB4wuqvxfVbmmZfFR8kQp0oGxZ9kxU9xI49kRc3MZZKEgQ
	 xPj29aj3TDMZotMNEX8VNCUg1yGxUgxFPLp8ZGSAj77DfFWnV3bwe4lgQdhvjlOCkD
	 PFAH3KDCl1DNUQaYazCzjv58foujCyP577WSIGfcINfF9nvBlgYKtRf7rbwUBkjnkp
	 fIrxA52QJUe9Ex1Ojufe2ITph+3HhSKWimJTYvmkd5wR9zqkhBbsVKH//BHW3X3UgU
	 fY8l8NU37ys0dve3Zj+fUtNWVSq8+Up02IDVFTH9z2Ho+2lA0bmJ3IBMRhfBN7mLkD
	 0TboTStaVYzIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50619C395F8;
	Mon, 10 Jul 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gve: unify driver name usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168897482032.8087.6653671878287859036.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jul 2023 07:40:20 +0000
References: <20230708031451.461738-1-junfeng.guo@intel.com>
In-Reply-To: <20230708031451.461738-1-junfeng.guo@intel.com>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, haiyue.wang@intel.com, kuba@kernel.org,
 awogbemila@google.com, davem@davemloft.net, pabeni@redhat.com,
 yangchun@google.com, edumazet@google.com, sagis@google.com,
 willemb@google.com, lrizzo@google.com, michal.kubiak@intel.com,
 csully@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  8 Jul 2023 11:14:51 +0800 you wrote:
> Current codebase contained the usage of two different names for this
> driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> to use, especially when trying to bind or unbind the driver manually.
> The corresponding kernel module is registered with the name of `gve`.
> It's more reasonable to align the name of the driver with the module.
> 
> Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
> Cc: csully@google.com
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] gve: unify driver name usage
    https://git.kernel.org/netdev/net/c/9d0aba98316d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



