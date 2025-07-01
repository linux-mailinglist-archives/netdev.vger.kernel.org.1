Return-Path: <netdev+bounces-202726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D060AEEC28
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD85D3E116A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9BF1A3155;
	Tue,  1 Jul 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMNZRNmU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E211A2389
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751334002; cv=none; b=cUvcT0KoEjXRHYkng3B4imaarwBiiX1Qh73Y9YE7kB8Nu78IiwIcX3oec4fQUb6XjvtvXJ8Q9zvkGAFhmTBcXVRgOo8HdlAH5yEzULff3pKrJpGgnVlYIdVjN/nzlrvakNSQfzgpEWB2XHeHRJycg1ZBer+1WMmV0m++JRgD0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751334002; c=relaxed/simple;
	bh=cup/FE692gDjPwqwFNXaaiKyJksdGk1lGs+M5I2KF10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GP7lszXN7HRp0vp1v6INGMYR++0KvCqJNKODgix/E1CHz7FaKC3U30flQE7C6PGx1d96f0Xk1EIrNv2UXGCz+bsmxTniGDS73m74E4Jijq71KHvZDZ5heqEb4Sl7kvOfCluzR+qMQvlJyR86U56UrajYVEwoSi0OPGqjYg+VZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMNZRNmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B86C4CEF2;
	Tue,  1 Jul 2025 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751334001;
	bh=cup/FE692gDjPwqwFNXaaiKyJksdGk1lGs+M5I2KF10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fMNZRNmU97Kp5Nxut9PW0vvJ5Kmg4EY5oY5CrazvxcV+TImybbHaHnU7j635TB0gx
	 pHk6Hmd5yms2vZH0575nwGiQWm8zCkcD2K+BsfglX3CyZCHboTW9UJF//TP2+bt+re
	 /AdbIGrP1leftrJGZj7TBc1I0a+nNCmSFeqO7tDJ5cp1RZviM1CrGT3WmqVtC4LP4f
	 qD4KW8rfSqyN8qZJ1JtNePT3Bd8LQ3CUghtXovjAhrykbSsrXmGvcgH0TUWut2rPA4
	 NHpkcjxSluZFcxwi1u7fck7AAa/xV3TzHEEv2D3x9ljvvY8Fsl/4EvKj0FYS9pGusS
	 Jd2oW9DmjMo9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD0F38111CE;
	Tue,  1 Jul 2025 01:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Add support for externally validated
 neighbor
 entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133402624.3632945.10968028668719175301.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 01:40:26 +0000
References: <20250626073111.244534-1-idosch@nvidia.com>
In-Reply-To: <20250626073111.244534-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 donald.hunter@gmail.com, petrm@nvidia.com, razor@blackwall.org,
 daniel@iogearbox.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 10:31:09 +0300 you wrote:
> Patch #1 adds a new neighbor flag ("extern_valid") that prevents the
> kernel from invalidating or removing a neighbor entry, while allowing
> the kernel to notify user space when the entry becomes reachable. See
> motivation and implementation details in the commit message.
> 
> Patch #2 adds a selftest.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] neighbor: Add NTF_EXT_VALIDATED flag for externally validated entries
    https://git.kernel.org/netdev/net-next/c/03dc03fa0432
  - [net-next,v2,2/2] selftests: net: Add a selftest for externally validated neighbor entries
    https://git.kernel.org/netdev/net-next/c/171f2ee31a42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



