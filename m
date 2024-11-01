Return-Path: <netdev+bounces-140910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A259B8963
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BC5B21B57
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82B13D248;
	Fri,  1 Nov 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skCmTBHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338B137775;
	Fri,  1 Nov 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428824; cv=none; b=Dtv3+98AYzQV+A2U5Ed5HvG4MnSHTYtm4DR5/gmRyRMzR3pQfAPxIgTYUotyGh/GCo9CghdiFDCngo9n7WlA1E+L2xEZbPmD5zJcDW9n9TaimNXwDQpi3li3gldI26VS9DNKrTxBGGNRK3AMBACtbkX+9QWinhE1z1D2ELiz22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428824; c=relaxed/simple;
	bh=hPom6XFQ8qBzLHhYj0bj1tSoFVlQuFqEEm6gsee2TWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Puhcw3P2+3ZWy9TUPtUZnUknC6B9kQ9TbpHCJZbBg29kTnCPm3Hjn9vmccZ2L2atTuVgQ/DyTibrySOK9OL3H6bqfEQ4fuV1KalZDMzsPokaXyib45GoGeaq4Ztwl5GN6gCPIbF4FdrjjFzRMzT+zG5+p5mE/7bPDAszTrZkRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skCmTBHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD96C4CED0;
	Fri,  1 Nov 2024 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428824;
	bh=hPom6XFQ8qBzLHhYj0bj1tSoFVlQuFqEEm6gsee2TWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=skCmTBHqRx/7k+TGgQq248pTzZQ3YBKKgqkhZB4Av8EbKG1UI2B+noqChRS3zXMPt
	 /IS5/2UfAavsUHrZqbF6tVuPjnGMEG7DwT2AqxV+YfAuwXnMNUOEK6bvWFUM2YScnF
	 Lp2jJtwi8HYtXA3H9gYE3Kh6+00ibxxOBXcn5K1PrWDktkul1eorLNec59jQ/aQLxr
	 JR2CN+h2ELS/XAb5QGHH6xi8cHZ4P6sdWEgF5b53AAa1hVINQlKKK27e7BUYO/xtr9
	 BkD2RBUJrnT+mQGQozjAOZatRkWrzVO0QITevRJUsfKWrTExxt5KI5466hduvvdqiV
	 OPDdaxALC1AsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE77380AC02;
	Fri,  1 Nov 2024 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dpaa_eth: print FD status in CPU endianness in
 dpaa_eth_fd tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042883250.2159382.982406472849657183.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:40:32 +0000
References: <20241029163105.44135-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241029163105.44135-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, radu-andrei.bulie@nxp.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leitao@debian.org,
 madalin.bucur@nxp.com, ioana.ciornei@nxp.com, christophe.leroy@csgroup.eu,
 sean.anderson@linux.dev, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 18:31:05 +0200 you wrote:
> Sparse warns:
> 
> note: in included file (through ../include/trace/trace_events.h,
> ../include/trace/define_trace.h,
> ../drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h):
> warning: incorrect type in assignment (different base types)
>    expected unsigned int [usertype] fd_status
>    got restricted __be32 const [usertype] status
> 
> [...]

Here is the summary with links:
  - [net] net: dpaa_eth: print FD status in CPU endianness in dpaa_eth_fd tracepoint
    https://git.kernel.org/netdev/net/c/0144c06c5890

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



