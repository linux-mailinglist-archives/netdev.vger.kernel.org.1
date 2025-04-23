Return-Path: <netdev+bounces-185312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0AA99BED
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606FB463793
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6B20C001;
	Wed, 23 Apr 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVcL7cT3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C719F137
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450404; cv=none; b=muw2Dx78nYNUSjpFmJz7ZUKBuEz9JafKVpwPSyDO3w+7dPbbR4qxODx1WLwbZYFiqOBOaK0xpB8mtfYTI5317qNocKcgPnzqnfqKoRtUuxB2t1TVbD6SsNXHE/P403T+5U1vTn5Q2HBSHHCTjc7jlQk13Rd280chxsK0U1hzGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450404; c=relaxed/simple;
	bh=ljVFDKb7V/Tx7yR/DAxxtHn2i2Ek4xxrq61yUT0yfj8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ss/ESpAcRKOVwG6rUZSBYfJRHapkGSe/+9qgWIduvMLNW4mXPiGLuq8Ug/W+rDUDzHHoxQdy9Yykv1eUnYoQTUYL5NQhhuBFY54z/pONijCClTuBrV7xGOvi08UCVy5LksZTzOMJ9kIw6yHnsy1v/TM11E+upb883zPZUOsim2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVcL7cT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B377C4CEE2;
	Wed, 23 Apr 2025 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745450403;
	bh=ljVFDKb7V/Tx7yR/DAxxtHn2i2Ek4xxrq61yUT0yfj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gVcL7cT35iUgOOn8gIiujAkPMy1SXBAyymbYBqmkcG+JY4Sai/sHmC1fs49GLkyml
	 27RyFrtIwzURN9eoir20yCoE7fH8Nw3oO0XgH0Uc7njVIMzrCvpx4tYB9GwLKCy20l
	 mKMrZb8tgUju5+saqML+vgReQBgsYcb0SH2O0En2Wk05j4dC1IeCNort3JDxKADAw8
	 vXHc8FdncSGOJWD8Fzc4qcAmemY2gfo9YK/6p3Zx/SKQfi58TYv5zYoskLJQQz9Mnl
	 dVWbd/am2iuDhzWXdm1TsLQYwIQpmEHxwR4brMTCetL9ahBox7VZhffTMc+ylkDp3e
	 XjCCJBr3onOKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7A380CED9;
	Wed, 23 Apr 2025 23:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] netlink: specs: rtnetlink: adjust specs for C
 codegen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545044200.2798114.10515051458035383073.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 23:20:42 +0000
References: <20250418021706.1967583-1-kuba@kernel.org>
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 19:16:54 -0700 you wrote:
> The first patch brings a schema extension allowing specifying
> "header" (as in .h file) properties in attribute sets.
> This is used for rare cases where we carry attributes from
> another family in a nest - we need to include the extra
> headers. If we were to generate kernel code we'd also
> need to skip it in the uAPI output.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] netlink: specs: allow header properties for attribute sets
    https://git.kernel.org/netdev/net-next/c/7965facefaed
  - [net-next,02/12] netlink: specs: rt-link: remove the fixed members from attrs
    https://git.kernel.org/netdev/net-next/c/43b606d98482
  - [net-next,03/12] netlink: specs: rt-link: remove if-netnsid from attr list
    https://git.kernel.org/netdev/net-next/c/ed43ce6ab222
  - [net-next,04/12] netlink: specs: rt-link: remove duplicated group in attr list
    https://git.kernel.org/netdev/net-next/c/c703d258f626
  - [net-next,05/12] netlink: specs: rt-link: add C naming info
    https://git.kernel.org/netdev/net-next/c/b12b0f41819a
  - [net-next,06/12] netlink: specs: rt-link: adjust AF_ nest for C codegen
    https://git.kernel.org/netdev/net-next/c/e6e1f53f0283
  - [net-next,07/12] netlink: specs: rt-link: make bond's ipv6 address attribute fixed size
    https://git.kernel.org/netdev/net-next/c/1c224f19ff06
  - [net-next,08/12] netlink: specs: rt-link: add notification for newlink
    https://git.kernel.org/netdev/net-next/c/622d7050cfd4
  - [net-next,09/12] netlink: specs: rt-neigh: add C naming info
    https://git.kernel.org/netdev/net-next/c/cd879795c3ee
  - [net-next,10/12] netlink: specs: rt-neigh: make sure getneigh is consistent
    https://git.kernel.org/netdev/net-next/c/eee94a89c55a
  - [net-next,11/12] netlink: specs: rtnetlink: correct notify properties
    https://git.kernel.org/netdev/net-next/c/e3d199d30909
  - [net-next,12/12] netlink: specs: rt-rule: add C naming info
    https://git.kernel.org/netdev/net-next/c/620b38232f43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



