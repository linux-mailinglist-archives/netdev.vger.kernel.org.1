Return-Path: <netdev+bounces-37316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC67B4B5F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 123C81C203D6
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A9EDF;
	Mon,  2 Oct 2023 06:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8BA53
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3096C433C9;
	Mon,  2 Oct 2023 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696227625;
	bh=wXzmAfRshjqAnDdD5iHtUmmoeWAJ02bWuV6zzoV/B0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TH4iD6OOE0tOITdK4gCSwJ7EgpBJ7StewarDgDmFfEXYpWaDvwlctIZEbA0fnu7jO
	 WvIaaY+4MGz4FSNRTp8O+Ylr55jODK/6lAjy0UNcRF+u/zb1WcM+184yRdBJ+KurjR
	 sF2a2Mr0+vcYTnpyi1xzAhFJJIWa8iJAje1q6PFQl731l2YcdR6/UYvc5fSHtM5E83
	 /KHExxHBjHE6pKzwfxGSgSv8LKzNMeWSeSBAzktPVGaU/4zhCMbb3mnbOBUeXRuXJw
	 TGeqdlhkLVLHlRH17A3RrDYQwkcR5gWjVrwCBZQwzvStvfdq75tLbd+oPsYS0i35TX
	 3fiUFUniJLqow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBF47E632CD;
	Mon,  2 Oct 2023 06:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: ocp: Fix error handling in ptp_ocp_device_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169622762489.27578.3892409434532929889.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 06:20:24 +0000
References: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Sep 2023 17:40:44 +0800 you wrote:
> When device_add() fails, ptp_ocp_dev_release() will be called
> after put_device(). Therefore, it seems that the
> ptp_ocp_dev_release() before put_device() is redundant.
> 
> Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> 
> [...]

Here is the summary with links:
  - ptp: ocp: Fix error handling in ptp_ocp_device_init
    https://git.kernel.org/netdev/net/c/caa0578c1d48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



