Return-Path: <netdev+bounces-28577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65177FE41
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6820E282086
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367661802F;
	Thu, 17 Aug 2023 19:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8152168D6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45EC8C433C9;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692298825;
	bh=mf5bz0gtEmfzPFEWOMDioIUkg8vDsLALXriCNEeq0C8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVZiqbCl++0E1n3JejIJm75F7giI4OVJCM60mKaZrHJ7+jvU6h+W9YQ+YMdDFYC0N
	 xaiILo/keCC2rqEqnaa4vCMtxEYVwZBS3/T8g1VQeaiINJWZs8uMNVttPVjLgU39m1
	 fUuIVFLIMqKJjB5Pvwix0+JRm4S12xD31IJM9+BD1jTqgYckO3Co60iIxB2AbEYjFY
	 nq6SaS3MKK2Fc5ElXnD+itNgvs7pN60MWOI8W3k4RKWx1cN3cQ7JX+f7M0sgSvX9bS
	 CPW6kpv1WhjNTuZsg8H/zZKnF3u+imSX4cHEtmBQdar//sC9uJy3jiUnBpy6siGlay
	 IL5r+fnQ5mR7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B484E26D39;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Block switchdev mode when ADQ is active and vice
 versa
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169229882517.13479.1670902307032767991.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 19:00:25 +0000
References: <20230816193405.1307580-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230816193405.1307580-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, marcin.szycik@linux.intel.com,
 leon@kernel.org, jiri@resnulli.us, przemyslaw.kitszel@intel.com,
 sujai.buvaneswaran@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 12:34:05 -0700 you wrote:
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> ADQ and switchdev are not supported simultaneously. Enabling both at the
> same time can result in nullptr dereference.
> 
> To prevent this, check if ADQ is active when changing devlink mode to
> switchdev mode, and check if switchdev is active when enabling ADQ.
> 
> [...]

Here is the summary with links:
  - [net] ice: Block switchdev mode when ADQ is active and vice versa
    https://git.kernel.org/netdev/net/c/43d00e102d9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



