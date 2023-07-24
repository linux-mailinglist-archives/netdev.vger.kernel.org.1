Return-Path: <netdev+bounces-20594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2777602F8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027F61C20C7F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A2C12B6D;
	Mon, 24 Jul 2023 23:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AC10973
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5331FC433C7;
	Mon, 24 Jul 2023 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690240219;
	bh=U+Sxd732MQgoeQI9aiUg1vjpXzmzR3gnU0oMDi4PYfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ewAKoj8lCImBbUSwXANcOWK7eGgJoEYjjcNT+XGa3BgOn7vToTu+NeWQYExhCkJCX
	 ErmH5/KH3jBs83PuGODmZ84nXJcN6DAwX3b9CIQt9u7hIUS8qJFpu/wW6Dz0o9Ykxk
	 XULlMw6nY26Pu2gBREehV6lxoSdSYTxVjzuHfUuNb2YfLwdJr6cHSMjX06t/UBYBLW
	 eC8cPqDbZMU/4KC7hWYDQc5CM5s56ocs1pu43WoKWMOhPlz/EwMFalsojEq//5gVol
	 WHcnsj5PrlhEv+nujSVKBsaN3tKXwCJL8KzcqaxxEG6K5412v6JwQWpuaJ4hh8Tc7s
	 vNKI7BWGBl1bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C8B2E1F65A;
	Mon, 24 Jul 2023 23:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add missing net_device::xdp_zc_max_segs
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024021923.15281.11165696593620187685.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 23:10:19 +0000
References: <20230721145808.596298-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20230721145808.596298-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, magnus.karlsson@intel.com,
 davem@davemloft.net, sfr@canb.auug.org.au

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Jul 2023 16:58:08 +0200 you wrote:
> Cited commit under 'Fixes' tag introduced new member to struct
> net_device without providing description of it - fix it.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20230720141613.61488b9e@canb.auug.org.au/
> Fixes: 13ce2daa259a ("xsk: add new netlink attribute dedicated for ZC max frags")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: add missing net_device::xdp_zc_max_segs description
    https://git.kernel.org/netdev/net-next/c/a097627dcadd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



