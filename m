Return-Path: <netdev+bounces-227264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30ABAAEB4
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC941673A4
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0419CC3E;
	Tue, 30 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZNWeGhE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972635949
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197038; cv=none; b=jvgN7MQ1nqbq/w28X1XL0JR/aUwOeUl2J6T9RlItvobB0DUAJKvqEU5xGy2QBdiDwQJIG7HHK5mvPJvoTLsGBr8O/RGa4H0QYnnBJmvjwcojiI7hU+BrT2/3ZCZ4BK3i1laBY1XAdvuk2jRbp31n++owem+yo9tDsEVNE70bDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197038; c=relaxed/simple;
	bh=yyHyRW1TYtscft/Y3yN6AwLyn+NQ5fphh+5gcFdZeUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gB2B/1qtXkl8FzzGIpxcpkEtc8RtuWt+opW5JDgEufkaix6Xcz03V11ATBvRfqf/mCF7Atj80M2Vxslce04MW1GX442POB5A1kP/G49IysHLbl0LzPaLM9dXMDOpgvhgrpwGj4if0ndtun0+hVBDQHJ7Ztnd+juDsIL9wMu480U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZNWeGhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2281C4CEF4;
	Tue, 30 Sep 2025 01:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197037;
	bh=yyHyRW1TYtscft/Y3yN6AwLyn+NQ5fphh+5gcFdZeUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kZNWeGhEypmMPiZXxzoYBpBKWZ+G9spPhW2QHt1uWj6LA9Arnvi9huZ5ukwOZejWU
	 uz3y2ezfeDd08oYAMJ2kpezTAsj05tq8V9KnJZhPYLk266Uhb88itgmGzkXxD78r2R
	 pgS0e0UKH4Mov7BzYQRILSBbYOtZrifFwM29njeXBsG/iu0njVJtHkp3BGmuVKPAB1
	 yuwPRqcFnodVP4/I9k6isLsVG83FHZkqO/QrSeBy33xCvR8fX4GzWE+PZt59gNtHTq
	 kHLz/nKwa74G9rYFa0oerZ4awrwDqD+MZQab1oR/CwXslKIqs0poXdpMqY3QdbZl6+
	 qHJzccV9tan/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7F39D0C1A;
	Tue, 30 Sep 2025 01:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/13] selftest: packetdrill: Import TFO
 server
 tests.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919703123.1783832.14323963190924552293.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:50:31 +0000
References: <20250927213022.1850048-1-kuniyu@google.com>
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 21:29:38 +0000 you wrote:
> The series imports 15 TFO server tests from google/packetdrill and
> adds 2 more tests.
> 
> The repository has two versions of tests for most scenarios; one uses
> the non-experimental option (34), and the other uses the experimental
> option (255) with 0xF989.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/13] selftest: packetdrill: Set ktap_set_plan properly for single protocol test.
    https://git.kernel.org/netdev/net-next/c/70dd4775db7f
  - [v2,net-next,02/13] selftest: packetdrill: Require explicit setsockopt(TCP_FASTOPEN).
    https://git.kernel.org/netdev/net-next/c/261cb8b12376
  - [v2,net-next,03/13] selftest: packetdrill: Define common TCP Fast Open cookie.
    https://git.kernel.org/netdev/net-next/c/97b3b8306f78
  - [v2,net-next,04/13] selftest: packetdrill: Import TFO server basic tests.
    https://git.kernel.org/netdev/net-next/c/0b8f164eb264
  - [v2,net-next,05/13] selftest: packetdrill: Add test for TFO_SERVER_WO_SOCKOPT1.
    https://git.kernel.org/netdev/net-next/c/399e0a7ed930
  - [v2,net-next,06/13] selftest: packetdrill: Add test for experimental option.
    https://git.kernel.org/netdev/net-next/c/e57b3933abce
  - [v2,net-next,07/13] selftest: packetdrill: Import opt34/fin-close-socket.pkt.
    https://git.kernel.org/netdev/net-next/c/5ed080f85a33
  - [v2,net-next,08/13] selftest: packetdrill: Import opt34/icmp-before-accept.pkt.
    https://git.kernel.org/netdev/net-next/c/a8b1750e68f5
  - [v2,net-next,09/13] selftest: packetdrill: Import opt34/reset-* tests.
    https://git.kernel.org/netdev/net-next/c/5920f154e144
  - [v2,net-next,10/13] selftest: packetdrill: Import opt34/*-trigger-rst.pkt.
    https://git.kernel.org/netdev/net-next/c/21f7fb31aef8
  - [v2,net-next,11/13] selftest: packetdrill: Refine tcp_fastopen_server_reset-after-disconnect.pkt.
    https://git.kernel.org/netdev/net-next/c/be90c7b3d5c8
  - [v2,net-next,12/13] selftest: packetdrill: Import sockopt-fastopen-key.pkt
    https://git.kernel.org/netdev/net-next/c/05b9f505fbe7
  - [v2,net-next,13/13] selftest: packetdrill: Import client-ack-dropped-then-recovery-ms-timestamps.pkt
    https://git.kernel.org/netdev/net-next/c/9b62d53cc8b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



