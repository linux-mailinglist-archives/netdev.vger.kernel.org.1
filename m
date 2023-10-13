Return-Path: <netdev+bounces-40637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE87C818B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B12BB20A3E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BBA10A0A;
	Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGSsAv07"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E010A00
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCE53C433C9;
	Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697188230;
	bh=2NHXUmHMA0x62KWzVmj7kY/JH5/7szO6PdBuXZNYv9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AGSsAv07SjmBKbXWRZv8jwZ9gUciGtaHAnyHzD1bshJwDJEwlBgkWTi3ruGVvaWzp
	 gFeFgR9C5+IZ9b6A7qpQCo9klwVBCm2wBssIcCvFkGnibKn47QiIfZ+Z04Di2whMfd
	 7t966Z+Xx+SP+gMe+rl+i3wxoJzMHiXS1joLttues5F67DA4ojOqeF9kJZbsUrH3ic
	 iJviiaQXAo5lmJAXXFB1Ii9/2gkOiJ6uILqNejK3rfSsj8fuARbDUpAvV7smRHBc/9
	 gUB0YbEhareEzHV02HvWtxJWBbTSBtHkHHRPL2XFkIrOcQ5ub/8AP0Ou9F0OcPUaTu
	 zuvuctSsp+wjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B84FDC691EF;
	Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] Extend VXLAN driver to support FDB flushing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718823071.32613.13896691864191241955.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:10:30 +0000
References: <20231009100618.2911374-1-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, mlxsw@nvidia.com, idosch@nvidia.com,
 kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, shuah@kernel.org, pabeni@redhat.com,
 bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 9 Oct 2023 13:06:07 +0300 you wrote:
> The merge commit 92716869375b ("Merge branch 'br-flush-filtering'") added
> support for FDB flushing in bridge driver. Extend VXLAN driver to support
> FDB flushing also. Add support for filtering by fields which are relevant
> for VXLAN FDBs:
> * Source VNI
> * Nexthop ID
> * 'router' flag
> * Destination VNI
> * Destination Port
> * Destination IP
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: Handle bulk delete policy in bridge driver
    https://git.kernel.org/netdev/net-next/c/38985e8c278b
  - [net-next,02/11] vxlan: vxlan_core: Make vxlan_flush() more generic for future use
    https://git.kernel.org/netdev/net-next/c/bfe36bf7811c
  - [net-next,03/11] vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by default
    https://git.kernel.org/netdev/net-next/c/77b613efcc81
  - [net-next,04/11] vxlan: vxlan_core: Add support for FDB flush
    https://git.kernel.org/netdev/net-next/c/d324eb9cec84
  - [net-next,05/11] vxlan: vxlan_core: Support FDB flushing by source VNI
    https://git.kernel.org/netdev/net-next/c/a0f89d5e68b6
  - [net-next,06/11] vxlan: vxlan_core: Support FDB flushing by nexthop ID
    https://git.kernel.org/netdev/net-next/c/36c111233b56
  - [net-next,07/11] vxlan: vxlan_core: Support FDB flushing by destination VNI
    https://git.kernel.org/netdev/net-next/c/c499fccb71cb
  - [net-next,08/11] vxlan: vxlan_core: Support FDB flushing by destination port
    https://git.kernel.org/netdev/net-next/c/ac0db4ddd0cb
  - [net-next,09/11] vxlan: vxlan_core: Support FDB flushing by destination IP
    https://git.kernel.org/netdev/net-next/c/2dcd22023cab
  - [net-next,10/11] selftests: Add test cases for FDB flush with VXLAN device
    https://git.kernel.org/netdev/net-next/c/96eece693330
  - [net-next,11/11] selftests: fdb_flush: Add test cases for FDB flush with bridge device
    https://git.kernel.org/netdev/net-next/c/f826f2a2ee1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



