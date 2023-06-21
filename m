Return-Path: <netdev+bounces-12723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33596738AD6
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49F12815D8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C30719912;
	Wed, 21 Jun 2023 16:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070E18C2E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08D76C433CA;
	Wed, 21 Jun 2023 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687364421;
	bh=oZ0oNzvVsf/37jZ0vZKYhCVITqnV+lWslHRudbcFSBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ojMKjI7a7vx54gCETG1IG0R/8TwI9p4AZ7XxeIh8fdR/GBNDq2I38tzzFojmhezPd
	 TzF/Dk3w1etylZygm7+9/dtVw0VWlPF5c0R3qvU7bA8rTlv6S+8/TIH5LLp+t/d8dV
	 Xm8VuRyBNSzskgAfB1Mlm73OHdoz6Vy5hiPodcg4O8qo2DfLC97aD1xmVvYVfwMbYR
	 R4LI5o9kk1uVTsdELyI1mikJGRuPYTv/6JdG0C2skcbeGx/4810b72IuEZ5vtmwoMX
	 r3PRqLfCpTrRfjqxRierklf6uH16T5k4fTK1aKvWYZhwlbbbaWQRqMxGhNx3KrvwNi
	 fTcmGSKbwnPfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0A71C4316B;
	Wed, 21 Jun 2023 16:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] iplink: filter stats using
 RTEXT_FILTER_SKIP_STATS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168736442091.20476.17277549128925283453.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 16:20:20 +0000
References: <20230611105738.122706-1-gal@nvidia.com>
In-Reply-To: <20230611105738.122706-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, dsahern@gmail.com,
 stephen@networkplumber.org, mkubecek@suse.cz, netdev@vger.kernel.org,
 edwin.peer@broadcom.com, espeer@gmail.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 11 Jun 2023 13:57:38 +0300 you wrote:
> From: Edwin Peer <edwin.peer@broadcom.com>
> 
> Don't request statistics we do not intend to render. This avoids the
> possibility of a truncated IFLA_VFINFO_LIST when statistics are not
> requested as well as the fetching of unnecessary data.
> 
> Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
> Cc: Edwin Peer <espeer@gmail.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] iplink: filter stats using RTEXT_FILTER_SKIP_STATS
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=bbb1238123a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



