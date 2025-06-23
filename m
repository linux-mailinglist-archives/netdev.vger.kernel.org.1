Return-Path: <netdev+bounces-200406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF6AE4DED
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E97189D2C2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58C2D323E;
	Mon, 23 Jun 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq36FxUG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6B1F5617
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709379; cv=none; b=WfMd8bFlGGmfTv8ND8Frgdb2iIP9q4yTFIcKljb5N8GIGQ1bRzXGcM8b8BT322RdoEQO9aOs4Rmta61q7RhPtIyPtXoR/s3oKD9Y+ov3m+j0UDq592Ssf64Z8TIZD45lSZC98/qc+LLRl0ePqo7milsoJttTHfMExZkQHkZaJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709379; c=relaxed/simple;
	bh=zEyyMZDciWvUO0CrNEGW0Qjz4zXfd6pMTrkYiEBveTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JQ3GYo4SbqBPVkkxYZesrEiAde7Q7COdikWvIzj0dEPLehD5H09VJV3PGEMKj8xAAcMwrDig26V+bXtRfoGJRClDdy8xiHc0zGiRThYipkEE0+tRROZNEgZ3RX2lAyTijRfh2LY7QYzdFIg7/iToD1DhzBvEb7jH5ZLrHgYySus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq36FxUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C51C4CEF4;
	Mon, 23 Jun 2025 20:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750709378;
	bh=zEyyMZDciWvUO0CrNEGW0Qjz4zXfd6pMTrkYiEBveTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aq36FxUGieyDUpSOTpFLODoKWnFhAxid5LKv9aph5XaCG2CiincxRMoKX9rCo0boH
	 jEnu/Vr3lIzLefL/fYjcuLBfpm5n2gNzmjtEhNJYDlb1ERmCvMtjSPQoOn0ql6kxH+
	 im+Az8DCebmXJG730qznEIRQNzqM6U99gXIuYVZclRulBPO2GHUw3arisPPPJ6Mkvf
	 giKsfxOYsq4Jl1/t2XPr0sDYhKIZIXJzLon+LHlyDzE88jyRCvsuqnqh1tDv/yL8Y7
	 0xtiJnaCLX48vma/xEbLBjBlU5PbsChakwDVpH7LJtuT9P+pHU73OTpzoEN55DuPK5
	 B36LN0BEJHtXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9638111DD;
	Mon, 23 Jun 2025 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: ethtool: rss: add notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175070940575.3283295.8387504164995699701.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 20:10:05 +0000
References: <20250621171944.2619249-1-kuba@kernel.org>
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, maxime.chevallier@bootlin.com, sdf@fomichev.me,
 jdamato@fastly.com, ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Jun 2025 10:19:35 -0700 you wrote:
> Next step on the path to moving RSS config to Netlink. With the
> refactoring of the driver-facing API for ETHTOOL_GRXFH/ETHTOOL_SRXFH
> out of the way we can move on to more interesting work.
> 
> Add Netlink notifications for changes in RSS configuration.
> 
> As a reminder (part) of rss-get was introduced in previous releases
> when input-xfrm (symmetric hashing) was added. rss-set isn't
> implemented, yet, but we can implement rss-ntf and hook it into
> the changes done via the IOCTL path (same as other ethtool-nl
> notifications do).
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] netlink: specs: add the multicast group name to spec
    (no matching commit)
  - [net-next,2/9] net: ethtool: dynamically allocate full req size req
    (no matching commit)
  - [net-next,3/9] net: ethtool: call .parse_request for SET handlers
    (no matching commit)
  - [net-next,4/9] net: ethtool: remove the data argument from ethtool_notify()
    (no matching commit)
  - [net-next,5/9] net: ethtool: copy req_info from SET to NTF
    (no matching commit)
  - [net-next,6/9] net: ethtool: rss: add notifications
    (no matching commit)
  - [net-next,7/9] doc: ethtool: mark ETHTOOL_GRXFHINDIR as reimplemented
    (no matching commit)
  - [net-next,8/9] selftests: drv-net: import things in lib one by one
    https://git.kernel.org/netdev/net-next/c/bfb4a6c72151
  - [net-next,9/9] selftests: drv-net: test RSS Netlink notifications
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



