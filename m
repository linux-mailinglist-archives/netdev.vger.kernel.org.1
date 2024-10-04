Return-Path: <netdev+bounces-132204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF35C990F8A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B7D1C20AC8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5761FB3C0;
	Fri,  4 Oct 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBrAXMps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB71F891F
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069031; cv=none; b=M/UqQh3wOy8ZcMgQXBTQqLxqEPUbGbBv8ZP2+2O2xqh53WZLjHwyszAoFOzWXVtWaSUcUUXg9TqPUL8+FmR3SmQPpowz9b6LvKTfBcldPXgAgIbljKhDzv9RyDvij2ocxhlY5ZelsFxk0J0foo+dRrgvFfsMTccx6f+JGjDNJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069031; c=relaxed/simple;
	bh=AHYc2Hj4Z5WWj24HgcIGA2REpPMq1/XBTP3pc2FZ/EY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S91eK9tVVcfPgxfopgREzEvg8FuUTgzJ4dNXWKMuG8iI0b6YRlJ2eZxo+/xwlC2g2SOg/ywotEr+Tb0qf5yGJLoU5c05+e3r3q/ZwpDJ1gPMUceipPHtJ51TVRXE38gIkREbkGdY2w+jFjJ0jxbFYYNm1ef6I/Yij+lQJVEgjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBrAXMps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A4FC4CEC6;
	Fri,  4 Oct 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069031;
	bh=AHYc2Hj4Z5WWj24HgcIGA2REpPMq1/XBTP3pc2FZ/EY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kBrAXMpsnhSsbFKXn9nfO4TkvzO0c2uaWxv985llI51G6mFUafCvVYb+hE1rhbp0D
	 8ut/bpivC/xjK1wE1sPA7rptf3EAdoPW7ZWOn1LrG/hV8oqqP+k0Ity6HqEfQ9CGJl
	 S9pQavNoyxE0SRvC1dP0gpUotXAITc6HMZSANWkghVnZvTmIk7HY7vUBB2qiBOP/dn
	 suzZwoLFOn3mcHptfOtMnCXFo+Y0QV3W05i3kJ560L3eh/3ICUMOUvZN1a5SGKaTdr
	 By6Uk8YNc0Q0WsUxyM9w+NsFpyEqE4r644kUyqarse/nP0a0WVaPKLHHErLQvj+iQ0
	 V4K865mIOKkgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE039F76FF;
	Fri,  4 Oct 2024 19:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] netfilter: br_netfilter: fix panic with metadata_dst
 skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806903489.2708740.1274785740623551771.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 19:10:34 +0000
References: <20241001154400.22787-1-aroulin@nvidia.com>
In-Reply-To: <20241001154400.22787-1-aroulin@nvidia.com>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 idosch@nvidia.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Oct 2024 08:43:58 -0700 you wrote:
> There's a kernel panic possible in the br_netfilter module when sending
> untagged traffic via a VxLAN device. Traceback is included below.
> This happens during the check for fragmentation in br_nf_dev_queue_xmit
> if the MTU on the VxLAN device is not big enough.
> 
> It is dependent on:
> 1) the br_netfilter module being loaded;
> 2) net.bridge.bridge-nf-call-iptables set to 1;
> 3) a bridge with a VxLAN (single-vxlan-device) netdevice as a bridge port;
> 4) untagged frames with size higher than the VxLAN MTU forwarded/flooded
> 
> [...]

Here is the summary with links:
  - [net,1/2] netfilter: br_netfilter: fix panic with metadata_dst skb
    https://git.kernel.org/netdev/net/c/f9ff7665cd12
  - [net,2/2] selftests: add regression test for br_netfilter panic
    https://git.kernel.org/netdev/net/c/bc4d22b72a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



