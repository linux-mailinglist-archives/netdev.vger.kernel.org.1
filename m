Return-Path: <netdev+bounces-149881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40B9E7E09
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 03:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA9616A922
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984217753;
	Sat,  7 Dec 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kypP3phP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227D101EE
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733538016; cv=none; b=rS9A8dPyBgfrgQfXkGOKwFMlDKkA9e41+drOluN8BfmQrGhYMZTT1cZpe1EeiPKOlnsBnm9XMOI9pIcfYMVUc3RTdH5YCX0pZetuIcQRNTGEcsVExrKYHS5CwxETmstVMoxhVRwJ/HWo1eUhVzOWBIA35ywLkUOm4gJeoFrWWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733538016; c=relaxed/simple;
	bh=DjtmJGYDJFNTMpg42Qq6eAptsHJ6FurWX4tdW7y9K9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jlDU5gJRocBA10RaL8/17GLIlIVBd7IEy06UnlGJ04NksousQZG8U5BQUqwmfil0eOWTIym4uwLYiUPgkuocboMe03ncACMkPwE2PeOzVvpc4ouJVnmc7m1tgAzQa8OluVCB+x+iojSFHl7PzDt94q31PYS9E7KBiKeAyLf0k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kypP3phP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD21C4CEDC;
	Sat,  7 Dec 2024 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733538016;
	bh=DjtmJGYDJFNTMpg42Qq6eAptsHJ6FurWX4tdW7y9K9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kypP3phPMV0bAkpkix2zOMuqZKh4GqoxXi4C7p29Oz7A4HF4Q30u5J1hmE/jysix6
	 76s1j20eEDOLWScfWvbumB/DDwZp3a6pu3ZoyrYfOBeA68kWJtJMoH6oktYS6BcNKh
	 GQzKKSGD3HWqg5NOlkTCP42i7dwa/jdkHzfKS3VwMnLu/skw4MCrprYbYHkzEFj/Gq
	 5gpWZuiNhdWgIqstxPBkrFbGC+RiJ0abW2PNZ+Agfc5IjNojir0oqN/BY6fDrolGUc
	 4Mxrpa1Q7ataZJNTzphN46+biG1P8nqF153xb/+4JpNYRv6NKdnyOgq7TvxTt+l3Ku
	 gldQaKbp8pVLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3445B380A95C;
	Sat,  7 Dec 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: Convert some UDP tunnel drivers to
 NETDEV_PCPU_STAT_DSTATS.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353803101.2875914.1295458332531014429.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 02:20:31 +0000
References: <cover.1733313925.git.gnault@redhat.com>
In-Reply-To: <cover.1733313925.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, andrew+netdev@lunn.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Dec 2024 13:11:13 +0100 you wrote:
> VXLAN, Geneve and Bareudp use various device counters for managing
> RX and TX statistics:
> 
>   * VXLAN uses the device core_stats for RX and TX drops, tstats for
>     regular RX/TX counters and DEV_STATS_INC() for various types of
>     RX/TX errors.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] vrf: Make pcpu_dstats update functions available to other modules.
    https://git.kernel.org/netdev/net-next/c/18eabadd73ae
  - [net-next,v2,2/4] vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
    https://git.kernel.org/netdev/net-next/c/be226352e8dc
  - [net-next,v2,3/4] geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.
    https://git.kernel.org/netdev/net-next/c/6fa6de302246
  - [net-next,v2,4/4] bareudp: Handle stats using NETDEV_PCPU_STAT_DSTATS.
    https://git.kernel.org/netdev/net-next/c/c77200c07491

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



