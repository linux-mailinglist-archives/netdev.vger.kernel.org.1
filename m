Return-Path: <netdev+bounces-216168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 222F7B32548
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31321CE0C6E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19F2356B9;
	Fri, 22 Aug 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0hK5izL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35921ADCB
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904206; cv=none; b=JPY+q1kywJKBqBho/H9oovu1TQKaYQ7qPmCuoAVs7g6ncvc+HHCoHjrvEOCRbStLyyG89+ObkfnhCn9/2nqJCdUxwpSXJa5dtM9aF+qlNv1NYoMptE5MTKPHYZffywVhGDZyl4eq1QGuGMbJnA1quHUHeOmEPWpTby2YYhmO8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904206; c=relaxed/simple;
	bh=KAbTwsbwifWPQiuhX/oZwNbgamfakq/p2zRDBuiPKSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=akAtFH3fUaUlwI47goW1RQddngEeXodciIOVtmpQDNUVc6sQowJousWhAuS1QhCjF7rB0yJlbcjFJ7LLhjD2lqIEqTQmq6djqreKHJeEzIb1/u6LaMORJZ4IAYmoTwbZl7Q/2DxIHT5VG9NsPDfyh9bDrcn3Qbrf8Ye7xGFOTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0hK5izL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5462C4CEED;
	Fri, 22 Aug 2025 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755904206;
	bh=KAbTwsbwifWPQiuhX/oZwNbgamfakq/p2zRDBuiPKSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V0hK5izLucvikGpsmOEbiGjOfhRtrXIn4t94T4lO/FCnBBnYu7nPnwq0L/zwduS2k
	 FP5PuN6WpCydWH7EHpuAKVOJui1uzbQg/o44ZKiAkMRit7e2nD2dBHUKHmh7y+sa6H
	 zge2fomjtbQMoKISz4EIxCk9hMcsoXeMX1m3XdWntG9/ytlHWK3/VHHoPYbmRw4r52
	 EirNoYViYaVYbSe9M5erBllsekC+mRqwGN6LAwetl6RdpPkXoYmshra9AqqgWQhvCl
	 x2qD7zkDERTpKdmHpIfF8v3VKDXBb32IWQKI6jGeO2ZhGBKfRMJakgTWof5dskeaWz
	 5ObLW1qcblLiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF7383BF69;
	Fri, 22 Aug 2025 23:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] idpf: replace Tx flow scheduling
 buffer
 ring with buffer pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590421475.2026950.7842739741428486992.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 23:10:14 +0000
References: <20250821180100.401955-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250821180100.401955-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 joshua.a.hay@intel.com, lrizzo@google.com, brianvv@google.com,
 aleksander.lobakin@intel.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 21 Aug 2025 11:00:53 -0700 you wrote:
> Joshua Hay says:
> 
> This series fixes a stability issue in the flow scheduling Tx send/clean
> path that results in a Tx timeout.
> 
> The existing guardrails in the Tx path were not sufficient to prevent
> the driver from reusing completion tags that were still in flight (held
> by the HW).  This collision would cause the driver to erroneously clean
> the wrong packet thus leaving the descriptor ring in a bad state.
> 
> [...]

Here is the summary with links:
  - [net,1/6] idpf: add support for Tx refillqs in flow scheduling mode
    https://git.kernel.org/netdev/net/c/cb83b559bea3
  - [net,2/6] idpf: improve when to set RE bit logic
    https://git.kernel.org/netdev/net/c/f2d18e16479c
  - [net,3/6] idpf: simplify and fix splitq Tx packet rollback error path
    https://git.kernel.org/netdev/net/c/b61dfa9bc443
  - [net,4/6] idpf: replace flow scheduling buffer ring with buffer pool
    https://git.kernel.org/netdev/net/c/5f417d551324
  - [net,5/6] idpf: stop Tx if there are insufficient buffer resources
    https://git.kernel.org/netdev/net/c/0c3f135e840d
  - [net,6/6] idpf: remove obsolete stashing code
    https://git.kernel.org/netdev/net/c/6c4e68480238

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



