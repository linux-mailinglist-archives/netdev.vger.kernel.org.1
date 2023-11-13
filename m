Return-Path: <netdev+bounces-47399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE17EA15E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2491C2096F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA549219FD;
	Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k78HAHeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AE21361
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DAF9C433C9;
	Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699893623;
	bh=8PLIztKthzv9eJO4wjuonksSJun6tpJM7tm02hB8c30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k78HAHeYWgr5/DoiFz5pGOvYGLUztd0RSTTWbNJz3j/JAq47JGnafvKKontoDJ4QA
	 t8VwIxRXj72PpN9Qm0X6kKzPohxHInbXciZZyiTS1mLIZtRKVxI5J6NhCvGeIx2j4M
	 jUFPGWKpui7YskvP3yRPBTCqBYxHbucmCTs1W4BfyS3N8hZk8Ex5oH0CmqF6Wq2Fi/
	 HEDTZSBDjgULHU7ZCztNaVy0fUy728et5NJn6qv2pX30hYgWLO/RuAL2Cotc7spsbS
	 7Yc9Nxsr9159aBXc7y4lhIHflzH6laMMOBRIxDF0Zi7Pxkd/1l2vxlt+oU+H5swyn4
	 tKEkkpVvUeJAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 240C2C4166E;
	Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] libnetlink: validate nlmsg header length first
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169989362314.31764.4756372396049231316.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 16:40:23 +0000
References: <20231107012147.668074-1-maxdev@posteo.de>
In-Reply-To: <20231107012147.668074-1-maxdev@posteo.de>
To: Max Kunzelmann <maxdev@posteo.de>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 BenBE@geshi.org, github@crpykng.de

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  7 Nov 2023 01:20:55 +0000 you wrote:
> Validate the nlmsg header length before accessing the nlmsg payload
> length.
> 
> Fixes: 892a25e286fb ("libnetlink: break up dump function")
> 
> Signed-off-by: Max Kunzelmann <maxdev@posteo.de>
> Reviewed-by: Benny Baumann <BenBE@geshi.org>
> Reviewed-by: Robert Geislinger <github@crpykng.de>
> 
> [...]

Here is the summary with links:
  - [iproute2] libnetlink: validate nlmsg header length first
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=78eebdbc7d2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



