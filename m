Return-Path: <netdev+bounces-61986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E828257C3
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71F1284714
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73CC2E833;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITdxeccH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A82E823
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40AFBC433CA;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704471027;
	bh=Dm5M+dsJYQNq8D0lpCX+Bup+J3yVmYb/5268CVZ8w/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ITdxeccHz7weJM1DAJy1qVrVTsXCwHxbOvHGMYiJrCjWDuN/0ZxeJ0o0jm9Cp5qYs
	 XYHEZ38goR/TEfOVYpkUVl0YCRh7r56oyjlaDw4SHaeqPlsdYQCPyx8wC8BGEA8twV
	 IXXFiBYHsv23VMr5iVVWjC/Ulp4RGNXBkf2Wv0XH1/1YWXR7qX9Z22FzjYIbaiIHcp
	 W3BnSSiEXP5WC2rzC/Tl0y0sGoBWCBGozyDpwVgm/CZozW08hYMaGt3QIs3nAleZnL
	 TBprVTr+krWge2uK/3XsesbS1d1cVoBMjF4EPtossEsfDrw4DSExmVvZSqZtrn88QE
	 F/UwGFlBW/7FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26A00C4167E;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next 0/3] dpll: expose fractional frequency offset value
 to user
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170447102715.8824.5095352127275403572.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 16:10:27 +0000
References: <20240103132838.1501801-1-jiri@resnulli.us>
In-Reply-To: <20240103132838.1501801-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 michal.michalik@intel.com, rrameshbabu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jan 2024 14:28:35 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow to expose pin fractional frequency offset value over new DPLL
> generic netlink attribute. Add an op to get the value from the driver.
> Implement this new op in mlx5 driver.
> 
> Jiri Pirko (3):
>   dpll: expose fractional frequency offset value to user
>   net/mlx5: DPLL, Use struct to get values from
>     mlx5_dpll_synce_status_get()
>   net/mlx5: DPLL, Implement fractional frequency offset get pin op
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] dpll: expose fractional frequency offset value to user
    https://git.kernel.org/netdev/net-next/c/8a6286c1804e
  - [net-next,2/3] net/mlx5: DPLL, Use struct to get values from mlx5_dpll_synce_status_get()
    https://git.kernel.org/netdev/net-next/c/e6d86938a40a
  - [net-next,3/3] net/mlx5: DPLL, Implement fractional frequency offset get pin op
    https://git.kernel.org/netdev/net-next/c/f035dca34ede

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



