Return-Path: <netdev+bounces-225457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0434B93C59
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2EB1898692
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748681E7660;
	Tue, 23 Sep 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8fGaOKy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3B1E25E3;
	Tue, 23 Sep 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589227; cv=none; b=WFPQksLa15Ceq4gyIqUVbIiKPmQ2AvfBVTEfV6/MNcbqwD3mzaY5VhDv7QlSjWZhQBGs6bjwnixf5IfmVNDAvaZzrqgnaZzr3NF3XHNl7ECh3Q/pU9giQwIWntLMyIK3hZ8N3HrBWnMo6t0BOpC9tAKFgDhIjhKmHzL0vTM4QDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589227; c=relaxed/simple;
	bh=8rN070MJrlpqBoc1QUeIZW7HLgDt5sjcpkpsZ7LyeMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=llblBb+zt5YpR6oVLwLUK34VBvMzo1NLE791W7ijdngQCVab/2SpHTOvCUTLfudF2xexO4Si6rb+rCik2DDsaAZ/jzEbvsReaAxVtDxzg4x9lZGcpy6EOAz/l2aacUNCz7Ggf52QcJIlA97JrH/i5HZfAUqOQXfIz6uSsvflVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8fGaOKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C5C4CEF0;
	Tue, 23 Sep 2025 01:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758589226;
	bh=8rN070MJrlpqBoc1QUeIZW7HLgDt5sjcpkpsZ7LyeMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T8fGaOKyWqKkC3AxhH78+VPOWDYNeB8HsEZEc/NazY49NNZ+v6FWKzpqS0Jg4Hj2g
	 ir1oIc4A3c98KvcvB8xABM/tIAN2r3BdXlkVeSdnxbwE0jOwHy8/IysKQP04IGamHq
	 DMfKSpV5vpEVS3OUiCXUmNTJv6QzU3q4cAfle/a0kJ5Zfv3WHxJkeex4uViKx6Kzo8
	 vL1AuKmlRgZcbx267SYBUWnsbFlvIjKOpgbVqV+Ab/PmSqOXlcaRx9RPi/wwO2gtYg
	 SVsnkrEKcZ0RDJIkknYqB/Po5Y43t4uXKQv/zes/C+4Ex3UKK94rl+ukAdYd1D8DFx
	 oe/i6ktuR+M9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5439D0C20;
	Tue, 23 Sep 2025 01:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: replace wq users and add WQ_PERCPU
 to
 alloc_workqueue() users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858922424.1212827.17329891946197083398.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 01:00:24 +0000
References: <20250918142427.309519-1-marco.crivellari@suse.com>
In-Reply-To: <20250918142427.309519-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 16:24:24 +0200 you wrote:
> Hi!
> 
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: replace use of system_unbound_wq with system_dfl_wq
    https://git.kernel.org/netdev/net-next/c/9870d350e45a
  - [net-next,v2,2/3] net: replace use of system_wq with system_percpu_wq
    https://git.kernel.org/netdev/net-next/c/5fd8bb982e10
  - [net-next,v2,3/3] net: WQ_PERCPU added to alloc_workqueue users
    https://git.kernel.org/netdev/net-next/c/27ce71e1ce81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



