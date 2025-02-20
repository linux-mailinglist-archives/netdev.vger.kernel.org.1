Return-Path: <netdev+bounces-167978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1AA3CFDF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391B917D933
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411361DED4A;
	Thu, 20 Feb 2025 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWvSTt0N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25B1DE891
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021003; cv=none; b=kRcBsBSmIZOH7vy9q0uaqhjZs4FVLRqwGB66eVQVR3UMUIPjBjCQv/wzHxxA2DQGtnnZ4mjT9/1Uzd/XMCgijIVQcQmi6TE2mLtg2cp7D/D2pvlQdTaq1EDRNz58rRQduBlhlpc5M6kc07vZEznz4eKRmr8HzoCryteaw/07WWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021003; c=relaxed/simple;
	bh=Q5HxMeHjajrUU/0rDSbY5U+8UP3I2AW3ewygtoghq/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ms+HscDpc1HBOck3q7epT7xQ86aouNSbfBUpcB6q3fJCjCu2B9hofrQLdqcAaciuVn9wdVVJkkx8unblb884TrOWFkzwVFeOR3hnb1r6JmbdzD2cNkmj89rWcYDtf3I0F+BpPHUvBKkNwdJmdUlGgHHyTxqDpgUxAbL+HKpDqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWvSTt0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B75C4CEE2;
	Thu, 20 Feb 2025 03:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740021002;
	bh=Q5HxMeHjajrUU/0rDSbY5U+8UP3I2AW3ewygtoghq/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RWvSTt0NT75eLzjMQV/gQrUdAtAJz091sF1uBc0MuxytJAg1bSe6ArlX/y9qNE6xz
	 MR5XQrkVz/g4Eor4RfCWGwJKJKvr9/fNZmc3xi908piQ5rFxaWA604Hp9daiW0zHo3
	 kV9YQTomViC7LnVcb9jfZaTUxjEGJ84vbHTXnzfRPavR+hvu3sfBii0Trwss2m24ds
	 J7lscS8vdVaRimoYC22WkKXCQB0VPhlj0ViBbDDFMmAt0Q6zSSkPARMo0PgcSyF0TM
	 5ufyCOeBxKQsAg7L2dhMsU6oxwT/lNdFrayuxhVQjs+5rAatvJ59b2MdPPWg9WbaP4
	 6jfL/nZUVjETg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BCC380AAEC;
	Thu, 20 Feb 2025 03:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net 0/4] flow_dissector: Fix handling of mixed port and
 port-range keys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002103325.825980.8220700199091428268.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:10:33 +0000
References: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 20:32:06 -0800 you wrote:
> This patchset contains two fixes for flow_dissector handling of mixed
> port and port-range keys, for both tc-flower case and bpf case. Each
> of them also comes with a selftest.
> 
> ---
> Cong Wang (4):
>   flow_dissector: Fix handling of mixed port and port-range keys
>   selftests/net/forwarding: Add a test case for tc-flower of mixed port
>     and port-range
>   flow_dissector: Fix port range key handling in BPF conversion
>   selftests/bpf: Add a specific dst port matching
> 
> [...]

Here is the summary with links:
  - [net,1/4] flow_dissector: Fix handling of mixed port and port-range keys
    https://git.kernel.org/netdev/net/c/3e5796862c69
  - [net,2/4] selftests/net/forwarding: Add a test case for tc-flower of mixed port and port-range
    https://git.kernel.org/netdev/net/c/dfc1580f960b
  - [net,3/4] flow_dissector: Fix port range key handling in BPF conversion
    https://git.kernel.org/netdev/net/c/69ab34f705fb
  - [net,4/4] selftests/bpf: Add a specific dst port matching
    https://git.kernel.org/netdev/net/c/15de6ba95dbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



