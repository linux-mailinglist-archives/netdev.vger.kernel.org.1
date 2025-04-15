Return-Path: <netdev+bounces-182550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04134A890E3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D97217C2B7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF513AA53;
	Tue, 15 Apr 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb0Xae5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB136FC5;
	Tue, 15 Apr 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744678202; cv=none; b=mz9BDS2BToUrq47ddmfcQwLZxRQ5gcfic39ibmdGwYbpxJ0KPwg1lrJtqSmF/3MuPYeAngeYtpk2u0unZyRUr5m/jTglFWhwWZa1785+vMq+nCFJmHpvHs8oV/FWdGHbh0ug0mX/ilpwhBEyT+7u1XEgl3l0g8K7XvHt8rNiXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744678202; c=relaxed/simple;
	bh=r/W/tyUA4SIffvZwjzA7RNTAzNJ3bqHs4/X+NSWYwx8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ixj5ir2G2+3I7lFmwOZU/0FSZMM1J1olXLT+xjK83HGgh9TFTB/XXWNQHaEeTrjBA4UWW7NnRWvuLOJCdUoWnIw22jWEYdW/P8MVs8reoVBCXQ3wVoSWf7HVpiaZrqHaaY5qFpHNGqWtJ6crGQSoZ3e43uMaf60HOElASSJwpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb0Xae5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE72C4CEE2;
	Tue, 15 Apr 2025 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744678201;
	bh=r/W/tyUA4SIffvZwjzA7RNTAzNJ3bqHs4/X+NSWYwx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wb0Xae5RLAJ9fz055t1A+y5GE9mnj+by8FmRoXcUv5/4A2HZ6UUfbgbaDogcw7fCQ
	 vT/R9RLxI5tdB4bVfMJLrR8w9q4+h8uGz+u4WmzrCxcqTMngPH3by+8DsUnlsxVRE2
	 MExdz3ZV0bBlSa1R0SVcC7OhUHugxlqTjD9AAoeFLaeFs9IV3UHOpTNTV9ycPBHr0W
	 Cf+DLa03LipDQA2A6cSGiTP/glUeFiHkGXOrZyv5E4yohE6+Eex4yS13r/qvEG9oZS
	 nbBWY2rkz7OjITBnpxWR86+3TpmzkiH35jnFW3KRxDzVYrUIp1sL6XAv5qs/clJR8H
	 MJNuW/bYqTKAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADED3822D1A;
	Tue, 15 Apr 2025 00:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/14] rxrpc,
 afs: Add AFS GSSAPI security class to AF_RXRPC and kafs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467823949.2089736.14930552033478134698.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 00:50:39 +0000
References: <20250411095303.2316168-1-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, brauner@kernel.org, chuck.lever@oracle.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Apr 2025 10:52:45 +0100 you wrote:
> Here's a set of patches to add basic support for the AFS GSSAPI security
> class to AF_RXRPC and kafs.  It provides transport security for keys that
> match the security index 6 (YFS) for connections to the AFS fileserver and
> VL server.
> 
> Note that security index 4 (OpenAFS) can also be supported using this, but
> it needs more work as it's slightly different.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/14] rxrpc: kdoc: Update function descriptions and add link from rxrpc.rst
    https://git.kernel.org/netdev/net-next/c/28a79fc9b03e
  - [net-next,v3,02/14] rxrpc: Pull out certain app callback funcs into an ops table
    https://git.kernel.org/netdev/net-next/c/23738cc80483
  - [net-next,v3,03/14] rxrpc: Remove some socket lock acquire/release annotations
    https://git.kernel.org/netdev/net-next/c/019c8433eb29
  - [net-next,v3,04/14] rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE
    https://git.kernel.org/netdev/net-next/c/5800b1cf3fd8
  - [net-next,v3,05/14] rxrpc: Add the security index for yfs-rxgk
    https://git.kernel.org/netdev/net-next/c/01af64269751
  - [net-next,v3,06/14] rxrpc: Add YFS RxGK (GSSAPI) security class
    https://git.kernel.org/netdev/net-next/c/0ca100ff4df6
  - [net-next,v3,07/14] rxrpc: rxgk: Provide infrastructure and key derivation
    https://git.kernel.org/netdev/net-next/c/c86f9b963dc6
  - [net-next,v3,08/14] rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
    https://git.kernel.org/netdev/net-next/c/9d1d2b59341f
  - [net-next,v3,09/14] rxrpc: rxgk: Implement connection rekeying
    https://git.kernel.org/netdev/net-next/c/7a7513a3081c
  - [net-next,v3,10/14] rxrpc: Allow the app to store private data on peer structs
    https://git.kernel.org/netdev/net-next/c/b794dc17cdd0
  - [net-next,v3,11/14] rxrpc: Display security params in the afs_cb_call tracepoint
    https://git.kernel.org/netdev/net-next/c/d03539d5c2de
  - [net-next,v3,12/14] afs: Use rxgk RESPONSE to pass token for callback channel
    https://git.kernel.org/netdev/net-next/c/d98c317fd9aa
  - [net-next,v3,13/14] rxrpc: Add more CHALLENGE/RESPONSE packet tracing
    https://git.kernel.org/netdev/net-next/c/fba6995798c6
  - [net-next,v3,14/14] rxrpc: rxperf: Add test RxGK server keys
    https://git.kernel.org/netdev/net-next/c/aa2199088a39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



