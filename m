Return-Path: <netdev+bounces-25605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76E774E71
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3EB2819BE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07072154B6;
	Tue,  8 Aug 2023 22:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FC15496
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47D6AC433CB;
	Tue,  8 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691534422;
	bh=mJG5rpnaod2qIsDUv4+1eWd5VxYuF2zZBjEDf6ZWRbw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EdOiOQeay6hxzk8+2LdvXnESSsYM3tpL224doupU/hg1gYF03WYrrBOWSt2yPf/sl
	 q8UIoLMroC2aQ4uKbO3sfRd9UmiFBVvYuUQNm7fr6yll2yE0rNPO6WV0uPTIAxChby
	 DjmvswUZ7IbxuRNRbPRYxA3se1gEIt/Drl6wQvTXDCvAcZdIgnbly9+EuT6ZN+UYZZ
	 wlunJORpuy9/YXRbbxqzKO6hHFToh2zwYNrDPK/5tHEon8ONkOnyZkhkNiXAYkw7gT
	 5Lr1K6trXmud9GjNe1ggyYUhw2QhkXSWzaYGPeCx+Ab9IAl+mvxDhxp/eb2iBgjNUU
	 lsFGAIdNzR71g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C1A9E270C1;
	Tue,  8 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] rtnetlink: remove redundant checks for nlattr
 IFLA_BRIDGE_MODE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153442210.29360.11186424124562731879.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:40:22 +0000
References: <20230807091347.3804523-1-linma@zju.edu.cn>
In-Reply-To: <20230807091347.3804523-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, saeedm@nvidia.com,
 leon@kernel.org, simon.horman@corigine.com, louis.peens@corigine.com,
 yinjun.zhang@corigine.com, huanhuan.wang@corigine.com, tglx@linutronix.de,
 na.wang@corigine.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 17:13:47 +0800 you wrote:
> The commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length") added the nla_len check in rtnl_bridge_setlink,
> which is the only caller for ndo_bridge_setlink handlers defined in
> low-level driver codes. Hence, this patch cleanups the redundant checks in
> each ndo_bridge_setlink handler function.
> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rtnetlink: remove redundant checks for nlattr IFLA_BRIDGE_MODE
    https://git.kernel.org/netdev/net-next/c/f1d152eb66a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



