Return-Path: <netdev+bounces-50813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CBA7F73A4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C26B214C6
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9624A06;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQYCf04c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97124214
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FD64C433CA;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700828430;
	bh=nhW0XLHwkT4zYDPg0hKKpnPSiom39xmsOL6MXhz6RLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQYCf04cVEPC3Do5F3KYMxvtWiB8NFm6p5T45DMaVhbxfBFnKnYjXPjYhv1XoWMls
	 3wfLrf6kjaSo27ceoAp/qGpzj7eGmRK08yFP9l7lsiFuRaXyBIQ89ot3chVBVPV+kt
	 lQxenbTOmZeDmuy6YprU7XEk1oQJYXJch+h6ZPADmUpVWgRm+nolZFsvedpYUqpRAX
	 dm2pOY87yEM6C5lVQFXX2pwzPqnQRI7gVyeBNfm1d2ZKAiGZwfl3PKPb1g2UWQPVnt
	 LjHXlM5deSTKefVEEnHSLDH6oJQXDjapYuCYb5qGOLbP8m3tpscCYuUYIP5O/fLSq/
	 uhrKQaCzODQZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 053C1E2A02B;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Get max rx packet length and solve
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170082843001.28500.952047846301067356.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 12:20:30 +0000
References: <20231122183435.2510656-1-srasheed@marvell.com>
In-Reply-To: <20231122183435.2510656-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, konguyen@redhat.com, jesse.brandeburg@intel.com,
 sumang@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 10:34:33 -0800 you wrote:
> Patchsets which resolve observed style issues in control net
> source files, and also implements get mtu control net api
> to fetch max mtu value from firmware
> 
> Changes:
> V2:
>   - Introduced a patch to resolve style issues as mentioned in V1
>   - Removed OCTEP_MAX_MTU macro, as it is redundant.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeon_ep: Solve style issues in control net files
    https://git.kernel.org/netdev/net-next/c/e40f4c4e50fc
  - [net-next,v2,2/2] octeon_ep: get max rx packet length from firmware
    https://git.kernel.org/netdev/net-next/c/0a5f8534e398

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



