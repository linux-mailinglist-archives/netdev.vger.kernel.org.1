Return-Path: <netdev+bounces-42471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A47CED0E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70572B20E1A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A6391;
	Thu, 19 Oct 2023 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISG5FG5l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F538C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B2EC433C7;
	Thu, 19 Oct 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697677223;
	bh=jhqylZ1kbUblqylLlif48g5pTl+ZU53wYTDMSwgJjhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ISG5FG5lO9n/A9rh8MO4aQPQ4xTuvW8DQPBvMvReqXaCCM9IIymOQzsVH8DP/n+oD
	 lGjbk2Zyc7+wnKA/10mwhjbuW9dlqIxVrJccdpbNQcwwF1zh75/A2f1S8XQreBDycN
	 G7lnqfZB/PkVSySwTHtH5Y1oPBNpiHg+ARfZBnx8kj9Xgs3C35U4HGgKPfWuZ3j7y8
	 bjfZkAORrfT8MTY3LO4be4I3be8hirsXLVVqZNcjinWeySD2GKC3ge5N8rRen4Suv1
	 LtQcgzEXQ0TlxgVIufANX4PgZbr12PY7mzcZ+srRbK3CwwV+pQhbrfX/EiulsNODi2
	 5ZjQcqCjVlqwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAF8BE00080;
	Thu, 19 Oct 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers: net: wwan: iosm: Fixed multiple typos in multiple
 files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767722376.5576.467230838370578760.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:00:23 +0000
References: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: m.chetan.kumar@intel.com, linuxwwan@intel.com, loic.poulain@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Oct 2023 17:14:07 +0500 you wrote:
> iosm_ipc_chnl_cfg.h: Fixed typo
> iosm_ipc_imem_ops.h: Fixed typo
> iosm_ipc_mux.h: Fixed typo
> iosm_ipc_pm.h: Fixed typo
> iosm_ipc_port.h: Fixed typo
> iosm_ipc_trace.h: Fixed typo
> 
> [...]

Here is the summary with links:
  - drivers: net: wwan: iosm: Fixed multiple typos in multiple files
    https://git.kernel.org/netdev/net-next/c/2c6370a13f0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



