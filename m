Return-Path: <netdev+bounces-87345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F88A2CDF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 12:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA2B1F231B7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD342069;
	Fri, 12 Apr 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swj0jPyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7830673
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919031; cv=none; b=jZWA+qMCpI5FZeVIxx+yv11BBZ9Y4/3zyD8v8Gom3zrXFinoBOElfjBBDhllsyGFacd+82jfaXi9gGGAqczKs0sRkAzsodMlfasKX+tQZrxkfczP/t51753eP5U8yYmou5xDumC+hPpzwKiFVtwEzR5qcYNIpTK/6iNzFGFSe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919031; c=relaxed/simple;
	bh=iOkEOC4bd/9HgFj965hLOhgi11Zf6Duh0WtkUtlIll8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GngFphtYA/UNsCMlnTAmn1rcmLkS7tG5XCBQV5oJHofkQi9pcztu4D2QsSXOi/Hgn0UFoxQFVhJpP3pw6haM7EczlNfLHQ3rVfpW4FQ5qv2uTCOCUikxNsW4Y/hHVRdpUzi6Zb3atSBGwlomBQLsz9qi2jy+qaDJiogNcezVb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swj0jPyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49E53C113CD;
	Fri, 12 Apr 2024 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712919030;
	bh=iOkEOC4bd/9HgFj965hLOhgi11Zf6Duh0WtkUtlIll8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Swj0jPyr2LCeF8h1IYOJhCw19izSIBLca/INN6ZiUz7p2BoYrNqHd9/QUbCbKGuO9
	 XcCqXRex62iZ7J/Gmn5IYVwULHjPfXAMqtMWOZpnfM02kW/KB/mL6KvRd1WVPAKxBM
	 Yba7SHuB6afCZehZudCwHtgJSpP4BanlqJjJvihiNjAHrw+G8Xek3DXvyg0r+hH28M
	 yyeSJzAsfHjn94RWSB/oCQq7QWA1gwHIKZkHh3456QqQCfkWe3vdkPShZPCCZDosu5
	 JQJrHOEZSAdmMIvH4agO9+1ZoMqh2MiPzSBYQzJNDSDNu2+7Nn6APBcvFxQ007JYjW
	 BzK+3eZoqizPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 365D6DF7856;
	Fri, 12 Apr 2024 10:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2]  nfp: series of minor driver improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171291903021.14580.4622607080457516471.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 10:50:30 +0000
References: <20240410112636.18905-1-louis.peens@corigine.com>
In-Reply-To: <20240410112636.18905-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 fei.qin@corigine.com, netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 10 Apr 2024 13:26:34 +0200 you wrote:
> This short series bundles now only includes a small update to add a
> board part number to devlink. Previously some dim patches also formed
> part of this series, these were dropped in v5.
> 
> Patch1: Add new define for devlink string "board.part_number"
> Patch2: Make use of this field in the nfp driver
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] devlink: add a new info version tag
    https://git.kernel.org/netdev/net-next/c/3bb946c9d323
  - [net-next,v5,2/2] nfp: update devlink device info output
    https://git.kernel.org/netdev/net-next/c/8910f93b9570

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



