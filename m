Return-Path: <netdev+bounces-65289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41348839E68
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 02:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63641F2A464
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 01:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D679415A8;
	Wed, 24 Jan 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/GJQGKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248C1FAE
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061026; cv=none; b=qQ20s+Xcq2hpKfLC+KfbS9dttO2EeL6SOxChorxvgiiaP4eT/nLDeL80I8opYkJ0pH0fGWDBpbIwAS3Qi3YTYtyO0nx0toRxOqHEHp7+fjeFRHLyOIN/kn8aGz6YxXkfKqjjMdHMX3RZ7OYL65tSW5mdapnSylXLUrPb0r0qSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061026; c=relaxed/simple;
	bh=vmUUbE/W7P7ZRzzTVauCSOSH2jMHLMngDqXGwBopfeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OOVzR/iLqiI2Ywvf3+v2L2WV75D13O+fPkyPfr2bqgyCGmULamDbqQD989B1lgvMuIWMlPcnSvtxg8c4CSSJZh/tayagBNMcbqUcFgjfN6mxy7RhVY/WINpUbIHEuCRW4gy6P2LRRtjBLQAUsLMAFXqmeC1pgVG2ctv21Z8joI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/GJQGKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A4D1C433C7;
	Wed, 24 Jan 2024 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706061026;
	bh=vmUUbE/W7P7ZRzzTVauCSOSH2jMHLMngDqXGwBopfeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/GJQGKvK3eMb80zAM4gdNTMICUul2v4e6tROQQcX7Y9kx7rYMhUd/HjjVdOQkgsd
	 4qtHuIXrUXHIjPD1Hns1ykUtMlruVQcKeOoocyVSulpjkxGU1kUtRr/CMJ5SnSJTa9
	 wdxv9I7tyxvcT0xHaRfMGhCL6GxepsShWiCXfpRPm1SgP8wK5oCVhAeaE5DhEiW/SC
	 f8M1wna6F/erJa3vwpRfGASAybk+sjp7kGQnLRgVkfU62KoYCYRs/iHB7hfbw4dimN
	 dDD/XZDtyakLhmSZ84885D7WaTGqxroNFFXbXYS9ErOFhLm1JgnseJ1gWQCbxuqQ/6
	 8MpmbdNeJJODQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1106DDFF767;
	Wed, 24 Jan 2024 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] gve: Alloc before freeing when changing config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170606102606.25797.6019199168197277313.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 01:50:26 +0000
References: <20240122182632.1102721-1-shailend@google.com>
In-Reply-To: <20240122182632.1102721-1-shailend@google.com>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 18:26:26 +0000 you wrote:
> Functions allocating resources did so directly into priv thus far. The
> assumption doing that was that priv was not already holding references
> to live resources.
> 
> When ring configuration is changed in any way from userspace, thus far
> we relied on calling the ndo_stop and ndo_open callbacks in succession.
> This meant that we teardown existing resources and rob the OS of
> networking before we have successfully allocated resources for the new
> config.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] gve: Define config structs for queue allocation
    https://git.kernel.org/netdev/net-next/c/7cea48b9a4b2
  - [net-next,2/6] gve: Refactor napi add and remove functions
    https://git.kernel.org/netdev/net-next/c/1dfc2e46117e
  - [net-next,3/6] gve: Switch to config-aware queue allocation
    https://git.kernel.org/netdev/net-next/c/f13697cc7a19
  - [net-next,4/6] gve: Refactor gve_open and gve_close
    https://git.kernel.org/netdev/net-next/c/92a6d7a4010c
  - [net-next,5/6] gve: Alloc before freeing when adjusting queues
    https://git.kernel.org/netdev/net-next/c/5f08cd3d6423
  - [net-next,6/6] gve: Alloc before freeing when changing features
    https://git.kernel.org/netdev/net-next/c/f3753771e7cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



