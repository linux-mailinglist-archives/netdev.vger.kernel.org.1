Return-Path: <netdev+bounces-184588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F4A9648D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20574165571
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5A1F4E3B;
	Tue, 22 Apr 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU69J1LF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904D1F150B
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314666; cv=none; b=kCtaEFtcNICqBFvQD2lvn8nSmpOzsVH3zDv71Ucle8aJ1zLz9tkE0CJDnr/bAX7Dw2E3D086z4DiRgrJCVEK9VboCwnjx8cKe3w78ikiPxpYw+KKkRCVbym9wT5wlyLE/aIQ5tTDt/Fh34cznfayaosrsbUlcVVThNRUP284oB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314666; c=relaxed/simple;
	bh=HSRWaP4zTX6Rq4PMG2RbcwkKzu8VjK764uv6dHcqp+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l/vOrH34ba9xphZe01029IOebE0ArUJ+WJFbpc/zy1pdGJqHY2ivO3CvVIjaSUcd8aw5wNwhucSZBq6t0CRut+e3FWjWTNLOOFAfLfNSvwQLYydehxL2CRx2AVbFFJtg/8dUQfKOJZgfeFoydbsctk4ptvGIJrOzvIexN+MHb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pU69J1LF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D559C4CEE9;
	Tue, 22 Apr 2025 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745314665;
	bh=HSRWaP4zTX6Rq4PMG2RbcwkKzu8VjK764uv6dHcqp+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pU69J1LFWanwbnh2iTIPkx68hpaVfoMZIh6hyYdzc4iFkHl9UZ5GgdRYwfu5InulW
	 3jhvh1GxdgBoqaNwEYOhhoBsqweetPu2Og+2/ZAe1U9QxTdLltIzieyITy+r1/oDfQ
	 u2X7Cp3Bgfr4vzRW11iT+d/fcH3hD3O3V0pRrbeFrmGBleWqgXR1PVtycPp88vL0cl
	 samQdtWA/01IIWOfo1hWKvxdubJSPrxgbC7RpJtepnkFtrE9rBe6BbHjnYK7sEkc0F
	 aJ20LaRiqJigjAFCBCtOQeT95CpdIh/aRaVnlxdwet+04cpY5ZcoSq1EM6I2oR3nL0
	 63IdPlOuV1bhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8639D6546;
	Tue, 22 Apr 2025 09:38:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] vxlan: Convert FDB table to rhashtable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531470400.1495352.5589563462825751298.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:38:24 +0000
References: <20250415121143.345227-1-idosch@nvidia.com>
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, razor@blackwall.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Apr 2025 15:11:28 +0300 you wrote:
> The VXLAN driver currently stores FDB entries in a hash table with a
> fixed number of buckets (256), resulting in reduced performance as the
> number of entries grows. This patchset solves the issue by converting
> the driver to use rhashtable which maintains a more or less constant
> performance regardless of the number of entries.
> 
> Measured transmitted packets per second using a single pktgen thread
> with varying number of entries when the transmitted packet always hits
> the default entry (worst case):
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] vxlan: Add RCU read-side critical sections in the Tx path
    https://git.kernel.org/netdev/net-next/c/804b09be09f8
  - [net-next,02/15] vxlan: Simplify creation of default FDB entry
    https://git.kernel.org/netdev/net-next/c/884dd448f1ac
  - [net-next,03/15] vxlan: Insert FDB into hash table in vxlan_fdb_create()
    https://git.kernel.org/netdev/net-next/c/69281e0fe18a
  - [net-next,04/15] vxlan: Unsplit default FDB entry creation and notification
    https://git.kernel.org/netdev/net-next/c/ccc203b9a846
  - [net-next,05/15] vxlan: Relocate assignment of default remote device
    https://git.kernel.org/netdev/net-next/c/6ba480cca25f
  - [net-next,06/15] vxlan: Use a single lock to protect the FDB table
    https://git.kernel.org/netdev/net-next/c/094adad91310
  - [net-next,07/15] vxlan: Add a linked list of FDB entries
    https://git.kernel.org/netdev/net-next/c/8d45673d2d2e
  - [net-next,08/15] vxlan: Use linked list to traverse FDB entries
    https://git.kernel.org/netdev/net-next/c/7aa0dc750d4b
  - [net-next,09/15] vxlan: Convert FDB garbage collection to RCU
    https://git.kernel.org/netdev/net-next/c/a6d04f8937e3
  - [net-next,10/15] vxlan: Convert FDB flushing to RCU
    https://git.kernel.org/netdev/net-next/c/54f45187b635
  - [net-next,11/15] vxlan: Rename FDB Tx lookup function
    https://git.kernel.org/netdev/net-next/c/5cde39ea3881
  - [net-next,12/15] vxlan: Create wrappers for FDB lookup
    https://git.kernel.org/netdev/net-next/c/ebe642067455
  - [net-next,13/15] vxlan: Do not treat dst cache initialization errors as fatal
    https://git.kernel.org/netdev/net-next/c/20c76dadc783
  - [net-next,14/15] vxlan: Introduce FDB key structure
    https://git.kernel.org/netdev/net-next/c/f13f3b4157dd
  - [net-next,15/15] vxlan: Convert FDB table to rhashtable
    https://git.kernel.org/netdev/net-next/c/1f763fa808e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



