Return-Path: <netdev+bounces-55156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC98099FD
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15059281075
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D91FC2;
	Fri,  8 Dec 2023 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP4VkZqv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4D1FC1
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 03:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB684C433C9;
	Fri,  8 Dec 2023 03:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702004449;
	bh=TJ2CBU8BasgAfoWTOvHLiPNUxVDsz+vrhY2LHK/XAYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hP4VkZqvMbRiuOHnxQIFYVkXX9DIAp24FO37PLKQv4ckCdwtNiFkVrjKis486WKe7
	 LtrDMbl/xEyy6exl+/AlXUD/xt1K6y+Wm1piMrCTJ/gyDY0fPuYrfZWX5cSZaPuUv7
	 HDqARAQutrzb33zc41ews2tW3nFmmc3E2qSW4S9pFQkgxcOCq9ZoCqGIyKlHZBlEFH
	 cMtiogjw5avB1Wiw86BEaA+PL96MdoJyTl3YEIbhYAPay8jbLty3YYv9K6ywrtr2iV
	 DVJZ2H1bDb4IXEv0PAFUEla6vLGTbH9iKkvSMYW0RKNfznKtYVXZrjitwfHIM5OsPy
	 6nERFhIX41M3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A88BDD4F1D;
	Fri,  8 Dec 2023 03:00:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] nfp: add ext_ack messages to supported callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170200444962.7884.9274290453308069207.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 03:00:49 +0000
References: <20231206151209.20296-1-louis.peens@corigine.com>
In-Reply-To: <20231206151209.20296-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ryno.swart@corigine.com, netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 17:12:07 +0200 you wrote:
> This is a mostly cosmetic series to add error messages to devlink and
> ethtool callbacks which supports them but did not have them added in the
> nfp driver yet.
> 
> Ryno Swart (2):
>   nfp: ethtool: add extended ack report messages
>   nfp: devlink: add extended ack report messages
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] nfp: ethtool: add extended ack report messages
    https://git.kernel.org/netdev/net-next/c/b0318e285493
  - [net-next,2/2] nfp: devlink: add extended ack report messages
    https://git.kernel.org/netdev/net-next/c/2f076ea86674

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



