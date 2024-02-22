Return-Path: <netdev+bounces-73992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31485F90F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2174B1F266A6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190D12E1D6;
	Thu, 22 Feb 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frX56mCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61B3D54D
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606830; cv=none; b=tXi2KGe6cEU7mZskPzBuikPaNuXG2neB3f/G48ZQJVcBTdCdVC+YHNLq0AiBYu6krmXgoD0oz9pflnf1KN1NJUcQnNcxosKk+FBCWQtNo/5wTBvDHf8p8EmVctypRhWvpanMEJ60Y9Ip/HggFYHR7fPpiq/uVLIwJs2yo+/f1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606830; c=relaxed/simple;
	bh=E13gKrc+fiQeijV1YdvOne7wvP0pgHDo/wk3dR/ZpGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fylUVdq3Z1BT2IMDSuBVgCZnGut092+Vfw7mjunOst3lcoPLcDPJpHoMISynddjUfrRRQrm1f66NE4PHsALL+WhJO/xpPhu5Aa4wybCd3ugmOyV+2QdVIvJ9f9Nl9YHw1TcLB1drrALhNHTBMOvHlZEIULPuwjnfrU/Em0QT9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frX56mCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B29EC433C7;
	Thu, 22 Feb 2024 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708606830;
	bh=E13gKrc+fiQeijV1YdvOne7wvP0pgHDo/wk3dR/ZpGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=frX56mCmywjx9TXq1gxzuGvYfQYvYJPgYpLk8zOATCGqDHI/rtT9eqh8tPzfVhujM
	 GVUbH0C7mo5Ln+PQmxEEv7H1nQNb3/F+5yXoYcdFABLCDaxXWI4N08BWVFejMgSJqT
	 FelkXgUD4ki4yPvQaXUrv0wn04kstDHNtTNFbjv5sOakBZuOvoAwK4zmJDo0YN3mhb
	 IP4cN98g03z8tBRW794n5oAapjk7VhcCoWqhDFbrl4CqFQ6AeMKWj0l116RnRskP9C
	 Qf6jsEr6PCOcxF+m8US2sHrha+L20CzpfPxcvXaH1FqGbqu9ZIF67LyBOeTwKQarKo
	 fEGIlqjd2Qeiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B012C59A4C;
	Thu, 22 Feb 2024 13:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] MCTP core protocol updates,
 minor fixes & tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170860683010.12924.11166470847067651109.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 13:00:30 +0000
References: <cover.1708335994.git.jk@codeconstruct.com.au>
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dhowells@redhat.com, aleksander.lobakin@intel.com, liangchen.linux@gmail.com,
 johannes.berg@intel.com, dan.carpenter@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 19 Feb 2024 17:51:45 +0800 you wrote:
> This series implements some procotol improvements for AF_MCTP,
> particularly for systems with multiple MCTP networks defined. For those,
> we need to add the network ID to the tag lookups, which then suggests an
> updated version of the tag allocate / drop ioctl to allow the net ID to
> be specified there too.
> 
> The ioctl change affects uabi, so might warrant some extra attention.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: mctp: avoid confusion over local/peer dest/source addresses
    https://git.kernel.org/netdev/net-next/c/ee076b73e576
  - [net-next,v2,02/11] net: mctp: Add some detail on the key allocation implementation
    https://git.kernel.org/netdev/net-next/c/aee6479a458e
  - [net-next,v2,03/11] net: mctp: make key lookups match the ANY address on either local or peer
    https://git.kernel.org/netdev/net-next/c/fc944ecc4f1a
  - [net-next,v2,04/11] net: mctp: tests: create test skbs with the correct net and device
    https://git.kernel.org/netdev/net-next/c/a1f4cf5791e7
  - [net-next,v2,05/11] net: mctp: separate key correlation across nets
    https://git.kernel.org/netdev/net-next/c/43e6795574f5
  - [net-next,v2,06/11] net: mctp: provide a more specific tag allocation ioctl
    https://git.kernel.org/netdev/net-next/c/c16d2380e8fd
  - [net-next,v2,07/11] net: mctp: tests: Add netid argument to __mctp_route_test_init
    https://git.kernel.org/netdev/net-next/c/61b50531dc66
  - [net-next,v2,08/11] net: mctp: tests: Add MCTP net isolation tests
    https://git.kernel.org/netdev/net-next/c/9acdc089c088
  - [net-next,v2,09/11] net: mctp: copy skb ext data when fragmenting
    https://git.kernel.org/netdev/net-next/c/1394c1dec1c6
  - [net-next,v2,10/11] net: mctp: tests: Test that outgoing skbs have flow data populated
    https://git.kernel.org/netdev/net-next/c/109a5331143d
  - [net-next,v2,11/11] net: mctp: tests: Add a test for proper tag creation on local output
    https://git.kernel.org/netdev/net-next/c/d192eaf57f00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



