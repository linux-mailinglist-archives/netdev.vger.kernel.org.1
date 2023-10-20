Return-Path: <netdev+bounces-43053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41397D1322
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF22824E2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC381E513;
	Fri, 20 Oct 2023 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFEm0R84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5981E504
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 15:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A803C433C9;
	Fri, 20 Oct 2023 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697817024;
	bh=O16tKOksOYhwz2iCs8FMA+gtPatW42L2qp8ugBM2iUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fFEm0R84NzF9ui9n8wi0T8LBZLyRG9IWI4g0gVzlOLtkfwCJLjwx1o9NHdCX0iEJB
	 pIPSkgq/EQ8ifgRvOhtQUWesbiUYIMvL7ZcO/P1nQ7NWwfEZt81Uym7+MuCPcipopJ
	 QJcI/pwhd1/ot8P5NqxhwxFK1ffAN8/b7SHnzE4jg++S7JqtjDzUJ0WJ9i01KSddyd
	 LmnjpAcF9B8hwq80Ah2PbZrYyMo/FhnXtfiKSmekUBSij54twUw57uYTK2HWgQVxvn
	 lU9W9dKDlSUkbgfV1hUiwHq6OUWT8wH1/OvkIvIwJNpPazA91QL/UdRdSi6IX3FKvX
	 aLcLESmOuvE9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15FCEC595CB;
	Fri, 20 Oct 2023 15:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/8] Extend flush command to support VXLAN
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169781702408.13692.10637906256677459210.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 15:50:24 +0000
References: <20231017105532.3563683-1-amcohen@nvidia.com>
In-Reply-To: <20231017105532.3563683-1-amcohen@nvidia.com>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 razor@blackwall.org, mlxsw@nvidia.com, roopa@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 17 Oct 2023 13:55:24 +0300 you wrote:
> The merge commit f84e3f8cced9 ("Merge branch 'bridge-fdb-flush' into next")
> added support for fdb flushing.
> 
> The kernel was extended to support flush for VXLAN device, so the
> "bridge fdb flush" command should support new attributes.
> 
> Add support for flushing FDB entries based on the following:
> * Source VNI
> * Nexthop ID
> * Destination VNI
> * Destination Port
> * Destination IP
> * 'router' flag
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/8] bridge: fdb: rename some variables to contain 'brport'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c1904631bb84
  - [iproute2-next,v2,2/8] bridge: fdb: support match on source VNI in flush command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=69b0310e82c6
  - [iproute2-next,v2,3/8] bridge: fdb: support match on nexthop ID in flush command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=f3c34db4be1d
  - [iproute2-next,v2,4/8] bridge: fdb: support match on destination VNI in flush command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=9107073a78e4
  - [iproute2-next,v2,5/8] bridge: fdb: support match on destination port in flush command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1b429388aaa3
  - [iproute2-next,v2,6/8] bridge: fdb: support match on destination IP in flush command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=994bf05ee265
  - [iproute2-next,v2,7/8] bridge: fdb: support match on [no]router flag in flush command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=958eecd2d05a
  - [iproute2-next,v2,8/8] man: bridge: add a note about using 'master' and 'self' with flush
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=734a82a15e1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



