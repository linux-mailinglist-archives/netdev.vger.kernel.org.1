Return-Path: <netdev+bounces-61987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE0E8257C7
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC40B22CF0
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9542E844;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMQqlVPo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B582E824
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5695BC433CC;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704471027;
	bh=gqe9X0mxbX4L6qyyQo6ETQVGikIdxmIHsOV5d/MWTrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kMQqlVPof/ftB18UFhECMtBHSx8el+Xn4cdtT/zQyV5Z9SnVFFrvTCMqKa2emLjkm
	 gV2nuvlV3K2P4RDoWnTCm5gyc3rReX3WiKFQCb48m1TfjsYizrvvmsz+S23iVl3nDb
	 3xSa2uaBKD3A3ZQrezJ2tkZWBhPOaKn7u0Pqm5JivcUmJ+i83Au3K3s9ICWwL+HBOT
	 e3FxbfC8hV+bVVDt27AiaKro+gDJ7KppqEE684O03CRogIIxLnrNJORrQPuefO5raz
	 8avZFNzeQvtOYy09wojaBTQ0Qxx89Uaqo7Xjoi1akEQXE/w1iGls0Uh8NhbxWsrhIY
	 pb1laArg0HPrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BB18DCB6F9;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fill in MODULE_DESCRIPTION()s for ATM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170447102724.8824.4452172269888054496.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 16:10:27 +0000
References: <20240104143737.1317945-1-kuba@kernel.org>
In-Reply-To: <20240104143737.1317945-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, 3chas3@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 06:37:37 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to all the ATM modules and drivers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: 3chas3@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next] net: fill in MODULE_DESCRIPTION()s for ATM
    https://git.kernel.org/netdev/net-next/c/fc0caed81bca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



