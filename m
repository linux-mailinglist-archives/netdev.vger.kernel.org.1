Return-Path: <netdev+bounces-168370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90DA3EAAA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D384B19C586B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C01E0B9C;
	Fri, 21 Feb 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6nhWCDq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD61E00B4
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104217; cv=none; b=WvKX5WJecsOrMotbOrHHNwc10uf5pNmEHKUjGEFAXDa6nG3Wd/eQMTWxmHlq8vNGN/K6bLdc1RMUNNhUnd88E42vNcMHmz3jT/kHbAIMMKDNqFL1v+E32cKuXeCWu7ZAAOkf5A3WdWaNzxW7w4LDLEm2p70iWnCDCcrnrUZx8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104217; c=relaxed/simple;
	bh=qG4z/sEVHYAaX5+ql1RKVj/+K5ivFYD/aoIuLnBWBOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJSyOz8q45NSY9kHQ9m1a9a1OePDYbwWJeRnjpXaM/w+SHg+KQl/LPUDVNOyaF2BYR6CSUX+9HRhPoZFUjhe+cCa1RUgiSsAkiZilGJ+yiSXpSlu3mjxFdOfEXYQjN5BJRB4KYp+iYs6ItXKn9noizB0jpngFapD1jZEC/PE8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6nhWCDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1020C4CEE6;
	Fri, 21 Feb 2025 02:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104215;
	bh=qG4z/sEVHYAaX5+ql1RKVj/+K5ivFYD/aoIuLnBWBOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6nhWCDqNMRezg1hmjaZuiXXbj3/gkBIm/htkGLHV+YGAdxFlbp24Asq4YMF2oKuE
	 xfx0e7LZlq8jxmXBbqyIylVBjCN7wGMgBu5qafCXZhcGzR7dIL3PoLB3nkDnPcsR+Z
	 bLxbGPVl3WRE1LUVVusx4+bhdk2YcPfhnEfBd7knfeIM9ZKuQTGYZMeKSwkyCDS1oV
	 /ciw6g1alk64cOxTSXzpYvWfNv1YJhoaXQCPfvZLRvLcM1Fw1m3c0td2WCixVKHkul
	 00X6srFnmUuTnutCysPGgZ8M4RVlEACVVY2QS3onvpeN+L1diqIIzRUouY2bkjDG0/
	 HTbmRjfLax7XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB9E3806641;
	Fri, 21 Feb 2025 02:17:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] selftests: drv-net: improve the queue test
 for XSK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010424624.1545236.6424547889006511403.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:17:26 +0000
References: <20250219234956.520599-1-kuba@kernel.org>
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jdamato@fastly.com, stfomichev@gmail.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 15:49:49 -0800 you wrote:
> We see some flakes in the the XSK test:
> 
>    Exception| Traceback (most recent call last):
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/ksft.py", line 218, in ksft_run
>    Exception|     case(*args)
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./queues.py", line 53, in check_xdp
>    Exception|     ksft_eq(q['xsk'], {})
>    Exception| KeyError: 'xsk'
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] selftests: drv-net: add a warning for bkg + shell + terminate
    https://git.kernel.org/netdev/net-next/c/846742f7e32f
  - [net-next,v2,2/7] selftests: drv-net: use cfg.rpath() in netlink xsk attr test
    https://git.kernel.org/netdev/net-next/c/dabd31baa3b5
  - [net-next,v2,3/7] selftests: drv-net: add missing new line in xdp_helper
    https://git.kernel.org/netdev/net-next/c/bab59dcf71fb
  - [net-next,v2,4/7] selftests: drv-net: probe for AF_XDP sockets more explicitly
    (no matching commit)
  - [net-next,v2,5/7] selftests: drv-net: add a way to wait for a local process
    (no matching commit)
  - [net-next,v2,6/7] selftests: drv-net: improve the use of ksft helpers in XSK queue test
    https://git.kernel.org/netdev/net-next/c/4fde8398462f
  - [net-next,v2,7/7] selftests: drv-net: rename queues check_xdp to check_xsk
    https://git.kernel.org/netdev/net-next/c/932a9249f71f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



