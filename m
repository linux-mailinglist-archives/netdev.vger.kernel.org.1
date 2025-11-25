Return-Path: <netdev+bounces-241386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD22C8348F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB44E4731
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854871A8F84;
	Tue, 25 Nov 2025 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvG4FSRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6E39FD9;
	Tue, 25 Nov 2025 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043244; cv=none; b=LVFBJvB4umKc8f4uPkdu+T6a/K55mTsOwMRaYW9z0qPQhSBbBpFesDs80R8wzSiO876T6alfUtlWzSlQO98PkexR0XCr3ZglRkFqDXdX1f2XT3LFsCI4j3ObZp+wmNwydULwnZVxSLvPjNV2Wlu8mf7RPlb3iAua29KAC3aOeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043244; c=relaxed/simple;
	bh=wW40DeYPI08euhu6hMkmthD56BMfvMvbUuoigRl/LU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mgTqEtNtTuhjihDNk4YLOvqwmET/rnavdIDHDHVgfcuIwRg3HURHjnm3zRYy6KGWHi0T4hcTNXY8YJc5SHyTIn7tNZ7PHApabM8qE48IUcnNnzDNGASVHj6OqSZvgV4FMsMq6fiwrgLVxiXPoR0vv5sURM0iu/ALDovAbs6auT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvG4FSRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B834FC4CEF1;
	Tue, 25 Nov 2025 04:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764043243;
	bh=wW40DeYPI08euhu6hMkmthD56BMfvMvbUuoigRl/LU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BvG4FSRDAmVQdlRlDiV7zpL8uOI+W009GzJD0MR/4kAri+snuSltfA8slrU7BpOC6
	 G1FPEPuz4DnzjhVU1hdpMIwWr568oDalc+EO2Nnr512pj5eTGVe8mJOn7musRErVQ9
	 LPMSIrOs6lHwC92sJ/dfqMkudKrkq8T9t6pDuw260wBPmcBtCl6xcXCj/IJWaGfcux
	 Ygouere+IjDk0y3LnxlMGnCgs8dDqH2RD/qkrW1QgD4dZjMJgodlA1c02bIANlUe6N
	 ubSxa294HtcRVZ/twc4O0FtADKZUokUiNJzzuXgxMTgjHFykxPUzMqFxlADvLVECJQ
	 oev7IOgvpcvrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE03A8A3CC;
	Tue, 25 Nov 2025 04:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] ipvlan: fix sparse warning about __be32 ->
 u32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404320651.181232.1752669675998121765.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 04:00:06 +0000
References: <20251121155112.4182007-1-skorodumov.dmitry@huawei.com>
In-Reply-To: <20251121155112.4182007-1-skorodumov.dmitry@huawei.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 julian@outer-limits.org, gnault@redhat.com, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 18:51:08 +0300 you wrote:
> Fixed a sparse warning:
> 
> ipvlan_core.c:56: warning: incorrect type in argument 1
> (different base types) expected unsigned int [usertype] a
> got restricted __be32 const [usertype] s_addr
> 
> Force cast the s_addr to u32
> 
> [...]

Here is the summary with links:
  - [v3,net-next] ipvlan: fix sparse warning about __be32 -> u32
    https://git.kernel.org/netdev/net-next/c/f296b73d17a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



