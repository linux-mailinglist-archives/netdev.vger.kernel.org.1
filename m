Return-Path: <netdev+bounces-66373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D083EB2E
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 06:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232681F24787
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9213FFB;
	Sat, 27 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrCJkq1P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3613FE0
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332230; cv=none; b=KbWg0xyjyq3dXmk8qohsuOQiolRpyWCJ7P0aU7DxleNErgFsQaQkQh8acn7ExTiMZSzD5gMxUnkelbl2kXURNSFltrD+WdWPG/y3b41yc0xpfy953cO6Z2/LlEoiVxo5kwQX8LlO0kJxokFzbOAilq23/yMsedRWPtcxGsUhtaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332230; c=relaxed/simple;
	bh=RJT2Y0WdnmAYahzEiiAmr4lFTMx13C/vt5K2KmEPb/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FIhqaNq3cH2Mf0rDrdW6nI/QceJuK4yiiLIXZROFBVYSQkcvdjaSzk1MY+Wi6vaAzE2fqA6Mwo34HLu4bl4aBCg3Vqke/F6fckbXzjeLhpJ1EGXgsiaciUZe0VNuHwZgoNy3r07mpN58GH5ffqvysbje43brI4rXToSxjVNyDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrCJkq1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D638C433F1;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706332229;
	bh=RJT2Y0WdnmAYahzEiiAmr4lFTMx13C/vt5K2KmEPb/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WrCJkq1P/aX7XpVz4uweH2ocShWWdcu9SzTngLBRtfuZnECuoezS9KiMa1t48AGqh
	 ya05+CKSt4Jt/MEiXQaQl1mnJAu+wYR9AbTftQSMH/pq3rAYlhADQvO2uxOoXL6tol
	 ernEdahh0GozHPT52YM+IA2aubx2+oOKS3qHbN8oxod9asYTQkfPIw59v7i53eD6wY
	 +61B760uMg8Kroeto5XDFofiXS73S2SGTr6Y0eY2In88loU7F9kEfkH0ANCd1THkbc
	 o4trVHTvHLEFzRJc7bgW1SNi35OZhxWH/APZHSh2IQFu8/ZBhnfLWNCW1H8Dzff/Lm
	 h/a/oYMJdZXlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EAA8DFF760;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/5] af_unix: Random improvements for GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633222951.22327.8113682508825854536.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 05:10:29 +0000
References: <20240123170856.41348-1-kuniyu@amazon.com>
In-Reply-To: <20240123170856.41348-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ivan@cloudflare.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jan 2024 09:08:51 -0800 you wrote:
> If more than 16000 inflight AF_UNIX sockets exist on a host, each
> sendmsg() will be forced to wait for unix_gc() even if a process
> is not sending any FD.
> 
> This series tries not to impose such a penalty on sane users who
> do not send AF_UNIX FDs or do not have inflight sockets more than
> SCM_MAX_FD * 8.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/5] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
    https://git.kernel.org/netdev/net-next/c/31e03207119a
  - [v5,net-next,2/5] af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
    https://git.kernel.org/netdev/net-next/c/97af84a6bba2
  - [v5,net-next,3/5] af_unix: Return struct unix_sock from unix_get_socket().
    https://git.kernel.org/netdev/net-next/c/5b17307bd078
  - [v5,net-next,4/5] af_unix: Run GC on only one CPU.
    https://git.kernel.org/netdev/net-next/c/8b90a9f819dc
  - [v5,net-next,5/5] af_unix: Try to run GC async.
    https://git.kernel.org/netdev/net-next/c/d9f21b361333

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



