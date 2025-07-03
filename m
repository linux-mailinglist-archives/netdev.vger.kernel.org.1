Return-Path: <netdev+bounces-203830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAD4AF7620
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5321BC8730
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9734528E59C;
	Thu,  3 Jul 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opJR6ktU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E1288AD;
	Thu,  3 Jul 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550586; cv=none; b=c32UCLpBRlhnBzPLGcusbkDhby1+Jl9PooFjAJM4GhXLvUJDZ3dAMrz09sUKWRU46h4PQMn+znEF7OtIgZPs5gxG3cMZNfuTLLBNa5ao9vwW0jZgQD5PyNOA/vyqv0NoZ6lrULG0DhQMIcYxRK3TDHnc8IQFM7Nw70E/DoVRdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550586; c=relaxed/simple;
	bh=kPAjLXyowLhtCtDh0aOXOQEKznzaWQHyEqIjjgS/dww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pUBHBEm2bmycI1bL8ieY4ux9lPz+ruPKzznhjzrkzlIZGrK0Lrs5u5Yqo9Z0BKNDW4KmEdjMLZNLJpjIbj7ifMadOckB4C5ZBbt+8Zh3j3oQKwVWnTVZRJp6QEi5SUsEqC8cLvDc5AdK4x2acXs8laewLOGe9iVOnrIJZMjeMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opJR6ktU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF7C4CEE3;
	Thu,  3 Jul 2025 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751550586;
	bh=kPAjLXyowLhtCtDh0aOXOQEKznzaWQHyEqIjjgS/dww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=opJR6ktUH2uajNPLTTbVI4mbMVydU2aU+HlA0tMHaJ9D0SnBofdALLEUZaQQnMpJa
	 e2LT5/fs/wJSY09LYEOZkuUWEK+9dA6s3l1DTdUJ09VQSpelB9Kh50XtjsUfzovYbH
	 Mx3ZwVFwythLraYOYIfZzJeKwrjNIrcyJHnviSAW3cW+i+X34evQ5ReNrwMtPHVS5L
	 Ahcb4iq2l+7FA7o0utYrJnhMwVwBBgxwzBObmS2GiHtyyWWkh4cApPpUinRlqZVZzq
	 p+vHPIXrM/Mp4KFFr8WUEhQjwvFiT9Oqkha3pMmnQFyJVukl5NKYwwNErx3mEz4zDg
	 7tEew9DXx9oYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF1383B273;
	Thu,  3 Jul 2025 13:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch V2 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175155061051.1488621.18100322509615749135.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 13:50:10 +0000
References: <20250701130923.579834908@linutronix.de>
In-Reply-To: <20250701130923.579834908@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, christopher.s.hall@intel.com, jstultz@google.com,
 frederic@kernel.org, anna-maria@linutronix.de, mlichvar@redhat.com,
 werner.abt@meinberg-usa.com, dwmw2@infradead.org, sboyd@kernel.org,
 thomas.weissschuh@linutronix.de, kurt@linutronix.de, namcao@linutronix.de,
 atenart@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Jul 2025 15:26:56 +0200 (CEST) you wrote:
> This is a follow up to the V1 series, which can be found here:
> 
>      https://lore.kernel.org/all/20250626124327.667087805@linutronix.de
> 
> to address the merge logistics problem, which I created myself.
> 
> Changes vs. V1:
> 
> [...]

Here is the summary with links:
  - [V2,1/3] timekeeping: Provide ktime_get_clock_ts64()
    https://git.kernel.org/netdev/net-next/c/5b605dbee07d
  - [V2,2/3] ptp: Use ktime_get_clock_ts64() for timestamping
    https://git.kernel.org/netdev/net-next/c/4c09a4cebd03
  - [V2,3/3] ptp: Enable auxiliary clocks for PTP_SYS_OFFSET_EXTENDED
    https://git.kernel.org/netdev/net-next/c/17c395bba1a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



