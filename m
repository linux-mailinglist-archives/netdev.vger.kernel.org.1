Return-Path: <netdev+bounces-249189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F8D155E6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D464304A965
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D73612F8;
	Mon, 12 Jan 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHErctuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C03612F6
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251669; cv=none; b=ZiuXARWIK8hGIjy04TQano0DQHxxiXFkbM9e68V3F0GqOyC3YQbXlgT8dLLgAXsl+GBSyQ/QO7THDc4P6V2CWXkMi4a5q4orlaaSB9K3U/TrqiX2AAJuFWI5bw8Zln60fxdKi/yKeIwa+w2Iu2sExHtG1l6/S1+At+7qFVGrLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251669; c=relaxed/simple;
	bh=l0YqGpKRtuf9wKo7n0VcSOq7OIPA5yKJiuDuHTrTN5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=no1MizgYBFJEPY6VNIRQ217f2HsI+r9EP2b/HPV7VqVHF06x1Zjvl6/Ir+B2qp+VFUH0ASqn1kV0BW2rtVbeP7T4EoQ6K3G+p/bFyL1mRPq2g3pgrFaS1TMIpth5LSPStLPCFU/RpGJfnbZExdkB4zQCmcbYQDbjLLMroEa7k/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHErctuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19108C116D0;
	Mon, 12 Jan 2026 21:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251669;
	bh=l0YqGpKRtuf9wKo7n0VcSOq7OIPA5yKJiuDuHTrTN5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KHErctuQzgvzdkZQzTvSIKL8frQ+9TsgbqpvKu2Bn7NzQ7O6/7X25k/3HebzNyfgd
	 trjWwLaJYwI0QFVJ6d2qUDww5bT/hGd5hZNDQ76ScXVW3BhZqMHIpH4QbuSpn6fJer
	 qw77nfIN+uCS19FPMbd+wqx+Q7egWLFFTLIxFd9CLX+9yeGp5DYsEemaLOn7hC5X2z
	 EIHd496+8C0+E2sPMVsfx2rYhSPqLHjmV7OVxMS9ugrCHfU1YutaUpBIaZf1RDjKBH
	 QaPS0hdOMwynpfvJliA53J2YOOeOlRVNbdgOPA/ABmz0FLPrKyZ4iypMhiYayLkacl
	 ecPwKHS+Ltl9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA22380CFD5;
	Mon, 12 Jan 2026 20:57:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] bnxt_en: Updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825146303.1092878.12676174704649444710.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:43 +0000
References: <20260108183521.215610-1-michael.chan@broadcom.com>
In-Reply-To: <20260108183521.215610-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 10:35:15 -0800 you wrote:
> This patchset updates the driver with a FW interface update to support
> FEC stats histogram and NVRAM defragmentation.  Patch #2 adds PTP
> cross timestamps [1].  Patch #3 adds FEC histogram stats.  Patch #4 adds
> NVRAM defragmentation support that prevents FW update failure when NVRAM
> is fragmented.  Patch #5 improves RSS distribution accuracy when certain
> number of rings is in use.  The last patch adds ethtool
> .get_link_ext_state() support.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] bnxt_en: Update FW interface to 1.10.3.151
    https://git.kernel.org/netdev/net-next/c/fdb573d675e3
  - [net-next,v2,2/6] bnxt_en: Add PTP .getcrosststamp() interface to get device/host times
    https://git.kernel.org/netdev/net-next/c/c470195b989f
  - [net-next,v2,3/6] bnxt_en: Add support for FEC bin histograms
    https://git.kernel.org/netdev/net-next/c/e1c9c8928b5b
  - [net-next,v2,4/6] bnxt_en: Defrag the NVRAM region when resizing UPDATE region fails
    https://git.kernel.org/netdev/net-next/c/743e683596fa
  - [net-next,v2,5/6] bnxt_en: Use a larger RSS indirection table on P5_PLUS chips
    https://git.kernel.org/netdev/net-next/c/51b9d3f948b8
  - [net-next,v2,6/6] bnxt_en: Implement ethtool_ops -> get_link_ext_state()
    https://git.kernel.org/netdev/net-next/c/bc87b14594e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



