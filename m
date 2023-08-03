Return-Path: <netdev+bounces-24231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31B76F611
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9AE2823AD
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC5426B09;
	Thu,  3 Aug 2023 23:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A7EA0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 23:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8CB8C433C9;
	Thu,  3 Aug 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691104821;
	bh=lGOviMOnGCbOLFMwLj2QTD4VI5atSdNRHgS5cNjPLbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PgGMKPueftX+Zkf1m5yDoR3oI5D0izSmKkIfYW5SOmgZ6WGUeNdUVut5ReIl1mnjh
	 a6l1oRMiOpnwj2O+PyZcyi+Qtu1PQO3jVrKXBOULLtjmkD0LtgD5O16CpdV9EIBUaF
	 ng+oUNM8mkHitH8dRxEcbKsz454uPsodohh/f9Rhm4GThbppoH7l48e91CXadP8EJK
	 hGTlkulfhrp97yDBRysOBB8v7nClgu7ilMs8inHwMOdVwmqLtIC3Zth2AJ2LheRUPr
	 geDbOgqb/B0kmMg8yLtlmraFt02ByXfugz6aLC3ulN/NUR86OJHFEjndskG5baD3SP
	 VuSJvKXDV1pRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DB4CC595C1;
	Thu,  3 Aug 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: dpaa: add missing net/xdp.h include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169110482151.27975.10599231239550934312.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 23:20:21 +0000
References: <20230803230008.362214-1-kuba@kernel.org>
In-Reply-To: <20230803230008.362214-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, lkp@intel.com, madalin.bucur@nxp.com,
 martin.lau@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 16:00:07 -0700 you wrote:
> Add missing include for DPAA (fix aarch64 build).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308040620.ty8oYNOP-lkp@intel.com/
> Fixes: 680ee0456a57 ("net: invert the netdevice.h vs xdp.h dependency")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: dpaa: add missing net/xdp.h include
    https://git.kernel.org/netdev/net-next/c/6f9bad6b2d7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



