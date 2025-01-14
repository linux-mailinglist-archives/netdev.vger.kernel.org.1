Return-Path: <netdev+bounces-157967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EADA0FF40
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49DF1886726
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7A234981;
	Tue, 14 Jan 2025 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOPx17qL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5D22BAA0
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825428; cv=none; b=eMkPLYOpm3kZJalNyu3RgY1c/cd2qxRfz54ePYNUSysTASVlgzAi4P3Bomy6kXfArON0L0OyJtgLT2BcCc9is3XneYRBWGVrX/1qg7AA5Eb7jhSsBtNhes3i2Rk8+AlM6ioa2fYcbdHLUpFXO5RlOnm97jTJdWhrBRAEAa+iqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825428; c=relaxed/simple;
	bh=cwc3dcffJGInXONOar1Kuy9lN0C96GLk31pK+e98ju4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oURnrOkNG/22huLqDlo3Wzj5KVGYCwhgK6dA1gRM4oNCQpwfWgIWygm9bqIYJ12H6DzD5GmcDLC6+UEsHcFELHJixn41eIqqFaYhjJsGIqIw5da+60dpPcYIcUiipZkfFliuIJhayS7RB7sm0w6a+gtokmIzU5FOpeuVVWdCWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOPx17qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25206C4CEE5;
	Tue, 14 Jan 2025 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825426;
	bh=cwc3dcffJGInXONOar1Kuy9lN0C96GLk31pK+e98ju4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOPx17qLeoua4ly2UDQxX829SQKnjZgCl1lchHbdtNSGWCfBa8Z0nAJKa+pVrTaH6
	 n7oiwytBcrB2jRWjvk/d+Kp8+rfhDaMdxflxIbbYmYhE7TvU2v15T6/PIaj1CeLdem
	 84SvRlrOZU5PLPt0JULCa9EgCpexWDGTEbOGBtKC9IpOSC8531C8j1+aGAShYTxECb
	 glqUDNHrx60wQk6LnVTbLZCr+S1Z2p2JYKNBsUFO8XDJLhH5co+vP+Epj4Cl8OILLw
	 T0zkciXYFPpE4ZPB3oY8uFkmAd7diKxPLv7D7DrUXEL3Lx6QwUATgTEMnt2B+95pp1
	 5PyqWHDLy5zGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE85380AA5F;
	Tue, 14 Jan 2025 03:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] tools/net/ynl: add support for --family and
 --list-families
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682544851.3721274.8403975394235475360.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:30:48 +0000
References: <20250111154803.7496-1-donald.hunter@gmail.com>
In-Reply-To: <20250111154803.7496-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 jstancek@redhat.com, jiri@resnulli.us, donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Jan 2025 15:48:02 +0000 you wrote:
> Add a --family option to ynl to specify the spec by family name instead
> of file path, with support for searching in-tree and system install
> location and a --list-families option to show the available families.
> 
> ./tools/net/ynl/pyynl/cli.py --family rt_addr --dump getaddr
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tools/net/ynl: add support for --family and --list-families
    https://git.kernel.org/netdev/net-next/c/2ff80cefb77b
  - [net-next,v2,2/2] tools/net/ynl: ethtool: support spec load from install location
    https://git.kernel.org/netdev/net-next/c/b1b62d6d332e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



