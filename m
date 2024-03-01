Return-Path: <netdev+bounces-76512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D886DF9B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6881E1C20C2E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8246A8D4;
	Fri,  1 Mar 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8EcMWQz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEB69E0B
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290228; cv=none; b=FAdQMJLiZdk7GnUt7RNgVF0iomaecnZ5NupKCFVe+tGqw2gwMvKVJFsvxrR7h2Mnexb7krJ3onARiv20p5Bwk2/04TCUxM8lwtOPggcqI52XYfjHYkL41KoujepQzCTSVTAzqKv9NI3gWE6aTxe7gW9wkOv1nvTdmp6HdcRzbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290228; c=relaxed/simple;
	bh=lbw76u/KGztqhf0Az8PVkf3TeIzv6sT2oR7maztF+FI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tclwN+CtcJiZZB/UHuiCInkuFp5XKxYMwgw0mIljKTDUsa8y8Ti/RiolGLMkGY7BaSkcKoO7jG5Nw+BmR/zm8GL2hYrisKGAVW8jjChu6bnO4X5+U3isrYGoy+Ed9Po+ruwlQUnDtZQtBcsYqTinLOiXhmirhSZ5itwyaymhPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8EcMWQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20080C43390;
	Fri,  1 Mar 2024 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709290228;
	bh=lbw76u/KGztqhf0Az8PVkf3TeIzv6sT2oR7maztF+FI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o8EcMWQzrM7M/8sxUvmk1vvxgT/SBehEjJKAmZhlY0U4m+TfwXH/OHrFjAVjmCbkX
	 L8q6pQZXdSlMCFHjYntbeFBB6QLCydjV2/16UJ4SpOURH88pSaLHDWuTsZKdUqf1QP
	 IVGJEeZBhrOi0R26umtsOjdIgdZTUg4VqIdvmrv95zSU5wGbEArKWhNb0tqQ9Vydc/
	 dRtVjIKiIU8ZvRBYbuxYCu9FkQXvFVBkhoeWnOEqCAI5w+Pp4tvAd9d8nSb5SdrcmX
	 I9Np3WHP7Av6ACPt8JZK+4hnqgjDsHPgqvZ6SYk+UTKCjsHhfaKnSa1+CeRRnmNsNv
	 VCefZ66Lgh2pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F4224C595C4;
	Fri,  1 Mar 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v14 0/5] netdevsim: link and forward skbs between ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170929022799.7574.1862024190631622134.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 10:50:27 +0000
References: <20240228232253.2875900-1-dw@davidwei.uk>
In-Reply-To: <20240228232253.2875900-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: kuba@kernel.org, jiri@resnulli.us, sd@queasysnail.net,
 maciek@machnikowski.net, horms@kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 15:22:48 -0800 you wrote:
> This patchset adds the ability to link two netdevsim ports together and
> forward skbs between them, similar to veth. The goal is to use netdevsim
> for testing features e.g. zero copy Rx using io_uring.
> 
> This feature was tested locally on QEMU, and a selftest is included.
> 
> I ran netdev selftests CI style and all tests but the following passed:
> - gro.sh
> - l2tp.sh
> - ip_local_port_range.sh
> 
> [...]

Here is the summary with links:
  - [v14,1/5] netdevsim: allow two netdevsim ports to be connected
    https://git.kernel.org/netdev/net-next/c/f532957d76de
  - [v14,2/5] netdevsim: forward skbs from one connected port to another
    https://git.kernel.org/netdev/net-next/c/9eb95228a741
  - [v14,3/5] netdevsim: add ndo_get_iflink() implementation
    https://git.kernel.org/netdev/net-next/c/8debcf5832c3
  - [v14,4/5] netdevsim: add selftest for forwarding skb between connected ports
    https://git.kernel.org/netdev/net-next/c/dfb429ea4f2d
  - [v14,5/5] netdevsim: fix rtnetlink.sh selftest
    https://git.kernel.org/netdev/net-next/c/8ee60f9c41fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



