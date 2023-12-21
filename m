Return-Path: <netdev+bounces-59440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD981ADA5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DDC1F22D74
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02E4C8C;
	Thu, 21 Dec 2023 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkEx1DzT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245735247
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D29C433C9;
	Thu, 21 Dec 2023 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703130628;
	bh=qzzFsj/00A2sTHtbWMgsg7kntiIjhAagBGEjxoiBcq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nkEx1DzT+ou54Ae104ZW3JLiRf9hy6ZQWGgVwZi/sFcTTWBESPbmcAsXCGCSZKETw
	 HvGnno7K5cl/NI/gUYos28bXCr/ujzDq0s4sxrz7ABsGyjVvGQl/yZLcJFWwPxrWST
	 pzCwq+3/7DfxPCwMRC5GlzQ7PFVGO64ndxcw9j0Vk10pNDCTN4ST8R+K3sfOB2WYia
	 rvXP/Q0nrI5gpwE86GRaxG9wQzehRn5qFUInOi9FzSbhaVpcfjnv3hAL++mbp2I+Yk
	 WOqHL0StKAPnUkrJqaU0R+kV1YfxIQX7sjTMwnOZgMGc6JV5l5JNGqrkFURhNgXD7A
	 Re6YxikdGCY7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EA3BD8C98B;
	Thu, 21 Dec 2023 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2 PATCH 1/2] man: ip-route.8: Fix typo in rt_protos location
 spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170313062851.21517.16327229074904846696.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 03:50:28 +0000
References: <20231215221923.24582-1-phil@nwl.cc>
In-Reply-To: <20231215221923.24582-1-phil@nwl.cc>
To: Phil Sutter <phil@nwl.cc>
Cc: stephen@networkplumber.org, gioele@svario.it, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 15 Dec 2023 23:19:22 +0100 you wrote:
> RTPROTO description erroneously specified /etc/iproute2/rt_protos twice.
> 
> Fixes: 0a0a8f12fa1b0 ("Read configuration files from /etc and /usr")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  man/man8/ip-route.8.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2,1/2] man: ip-route.8: Fix typo in rt_protos location spec
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=aba8530da699
  - [iproute2,2/2] man: Fix malformatted database file locations
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=33f73690f171

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



