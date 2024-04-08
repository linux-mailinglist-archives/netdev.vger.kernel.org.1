Return-Path: <netdev+bounces-85735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8A89BEE1
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AF51F227B1
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB906BB21;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW004YPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AA6A348
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578902; cv=none; b=CrqcSqzqO3wLU/Fbn579Ltrtsi6EVghSCp/MDxurhWDWDfGKqqEZIj/E3BMyDGdyQ7llCmNDx8Mb3PzYtQrPGQpMfYrVuH1KsN48/xIoVKDJzNzrU0S5hNg6ljnwI0PanAz8VQ77iDUHOooY8KXELJOWE+lbgzocnJ18fKjNd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578902; c=relaxed/simple;
	bh=C3ygxPUC9J4P3fmbn1uT28RhnGVm1BMxIRDmyNlJO/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=stjyib8SeUp/ApSjaeRSZkU4hGJD54Ta6p39L4bOBed5H1sEeYARLQktSIDAsMmC+vfdKWMT3DmAGT5KmG7lWonhjMOVd7wkFzrlCebLrrhle8eO9wU4wta6+Of7Zj09M+/72bdV6ZuZE1sYXs4qFzs4woxrlfTegMuivrr1wJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW004YPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69025C43390;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712578902;
	bh=C3ygxPUC9J4P3fmbn1uT28RhnGVm1BMxIRDmyNlJO/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dW004YPRmgBWDlLJCt3q6+onBVmINvTBCvp16k4O5+RlOB6okPdx5u9h80Mwe5jG3
	 VRX4MXjw1y2Vv+KS26SZRMdE/zGuFZNStYAL/JD5TZzXDzm1m8Gr1PY9sVzDBeM7d4
	 ADPdCsh50zt5/1XLeYzYVBoZtihw023/yxQJIvQiXtcqdMiApoOQogFEyvqxVIwlSr
	 qQ5WfaigX0wcZ3nxq25/aZ3WV2biFVr0vPRZDELu7tUtlj8/vgCgJRT9UEhd7m1tpi
	 qSrcq0+978w8+YHeiKznWTrwVPiUz9y/F/Q5zb+UjjG8+Lv2RdLvC7bBOtKiOWKbfM
	 JBCSxKEsV5Knw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57247C54BD6;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: Set scope explicitly in ip_route_output().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257890235.8472.12307217868929913978.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 12:21:42 +0000
References: <1f3c874fb825cdc030f729d2e48e6f45f3e3527f.1712347466.git.gnault@redhat.com>
In-Reply-To: <1f3c874fb825cdc030f729d2e48e6f45f3e3527f.1712347466.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, mustafa.ismail@intel.com,
 shiraz.saleem@intel.com, jgg@ziepe.ca, leon@kernel.org,
 mkalderon@marvell.com, aelior@marvell.com, j.vosburgh@gmail.com,
 andy@greyhouse.net, dsahern@kernel.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 5 Apr 2024 22:05:00 +0200 you wrote:
> Add a "scope" parameter to ip_route_output() so that callers don't have
> to override the tos parameter with the RTO_ONLINK flag if they want a
> local scope.
> 
> This will allow converting flowi4_tos to dscp_t in the future, thus
> allowing static analysers to flag invalid interactions between
> "tos" (the DSCP bits) and ECN.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: Set scope explicitly in ip_route_output().
    https://git.kernel.org/netdev/net-next/c/ec20b2830093

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



