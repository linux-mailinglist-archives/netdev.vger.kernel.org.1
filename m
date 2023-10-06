Return-Path: <netdev+bounces-38699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA497BC2B6
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E551C20956
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275045F56;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfYmjsJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDA405CC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 120BDC433C8;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696633225;
	bh=MI+XKg/LdzdUZV0k2jCaAZ13tSOTPvUQCpOe/gCDRcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LfYmjsJfGP3PP1t6b4RnoeNCs+o3KJh/297MaVZ5S3yQ5HHzps8kILGLG7ZYRLnoB
	 rGDj75ao52iXZQcEWnSgZnY8SSGsBEUPEhJsReGcDxg51PmgiWYtceeoHav/TSJtF+
	 g3i9msA+/g6yMPYlZt5H/XLP3Q0kanZ7lJuz9GyXpFj6bp4xnGrnyL5VmgZ/H71Vxe
	 jNxSqKa7/I9kIup4NVWHDefYCLCnnO2esdyEf3M/h0CZnfWVgaZIm5ESCoyVtbyXrq
	 KaRDt4Yz5Z0z6NQgepN+aVIcRYGMa4y+LVHgZGfFrBPPJ4URSPRQMu7nwJ5rtoUB5t
	 JWbgLFLlZx5IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC89FE632D2;
	Fri,  6 Oct 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] devlink: Hold devlink lock on health reporter dump get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663322496.31337.14047004680576589561.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:00:24 +0000
References: <1696510216-189379-1-git-send-email-moshe@nvidia.com>
In-Reply-To: <1696510216-189379-1-git-send-email-moshe@nvidia.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 jiri@nvidia.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Oct 2023 15:50:16 +0300 you wrote:
> Devlink health dump get callback should take devlink lock as any other
> devlink callback. Otherwise, since devlink_mutex was removed, this
> callback is not protected from a race of the reporter being destroyed
> while handling the callback.
> 
> Add devlink lock to the callback and to any call for
> devlink_health_do_dump(). This should be safe as non of the drivers dump
> callback implementation takes devlink lock.
> 
> [...]

Here is the summary with links:
  - [net,v2] devlink: Hold devlink lock on health reporter dump get
    https://git.kernel.org/netdev/net/c/aba0e909dc20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



