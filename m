Return-Path: <netdev+bounces-153836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E49F9CB4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E2C16BE4C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABF227BB8;
	Fri, 20 Dec 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnVL+l8g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802EE227B94;
	Fri, 20 Dec 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734733217; cv=none; b=RR3ZMVyfp/sPBG1DGp/dSMkl1FFvJYmAcS76XczN74WSrMfcLENP5Zxo4PFw6miIjN6BwcBBqp1g+ppcKatjCEZ3oDd2AqtdXGLnPXWfSswNnjVCa9wezPqb8+ZEVnSZRyg6V0/tLiB3FugLcGW7lQJINg2Fe2BZdyFQ0ZSTtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734733217; c=relaxed/simple;
	bh=7SZ1eF0pxYedrhawWxd0yixMBjGQ+fZtPvYJTM2ques=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mIFB2VcIQYmapvicDMwZfxVhCCe2YYkuKD4340od2zNh7LbPrsaqAX1FCwFpdNMbbi10aOnNHGa6iMkW6c1lSGFuhCLUxTaWKSQgLZhkBbjONyUGCc9njKDy4pUI7bXJzx5e3RbgzZZvpBEa0RUxZc15LkZHop0tpiVUXF6IYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnVL+l8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59634C4CECD;
	Fri, 20 Dec 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734733217;
	bh=7SZ1eF0pxYedrhawWxd0yixMBjGQ+fZtPvYJTM2ques=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pnVL+l8gEHpALSt4qG44/FPswpHrZ3PgQHfK6GcSnIkyv8xkCVdFskkAR+oUKsq3F
	 74MJoo9cDolLfrmHcPFBk50+V51V+E8vvotf3XrarqjwFwVJNUJP83nhUMVkAC23dM
	 daRpdNHRZSpCYWw2L9LHkXvj0rjSrv8+syjBiiV+gbEf5/p2FYKo/aZPOQLyc8CVcn
	 b9Ym3rJXiWmTuiYTbcoIEOBrvIpd4fIFKjizYkXrBErfdHSeqoL7sIUnAiyBtVA7nk
	 DUqw6i1ST1E6c/Wk+eKtdJOFj5CnBd/lJhyIqao4f4kCzkxjMy8PbqgVn+CPCXN79y
	 azId46gJzZPWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7741C3806656;
	Fri, 20 Dec 2024 22:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch bpf v3 0/4] bpf: a bug fix and test cases for
 bpf_skb_change_tail()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473323519.3037384.12810053109977507523.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 22:20:35 +0000
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, cong.wang@bytedance.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 12 Dec 2024 19:40:53 -0800 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> This patchset fixes a bug in bpf_skb_change_tail() helper and adds test
> cases for it, as requested by Daniel and John.
> 
> ---
> v3: switched to TCX prog attaching API
>     switched to UDP from TCP for TC test
>     cleaned up TC test code
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/4] bpf: Check negative offsets in __bpf_skb_min_len()
    https://git.kernel.org/bpf/bpf/c/9ecc4d858b92
  - [bpf,v3,2/4] selftests/bpf: Add a BPF selftest for bpf_skb_change_tail()
    https://git.kernel.org/bpf/bpf/c/9ee0c7b86543
  - [bpf,v3,3/4] selftests/bpf: Introduce socket_helpers.h for TC tests
    https://git.kernel.org/bpf/bpf/c/472759c9f537
  - [bpf,v3,4/4] selftests/bpf: Test bpf_skb_change_tail() in TC ingress
    https://git.kernel.org/bpf/bpf/c/4a58963d10fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



