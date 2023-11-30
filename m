Return-Path: <netdev+bounces-52377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C07FE83C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D0A1F20ED2
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F9168DD;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgny+WTf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6B1641F;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8D51C433C9;
	Thu, 30 Nov 2023 04:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701318034;
	bh=s5khtu7LDfx8Kc1hS9gJ6am7MTLlXPnlFHZ4L8nETB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sgny+WTfK00A9lIauSt/JqV6zIEYMyH8BVg9/sh87s/xleTmpqMuPqOBlLkER0rCE
	 UuFJUJ7nTfuep3r5jGJtg+KCgXG1Jrk66A1oLyXod9v7DpYd9Po+39oHjidVf0TfZY
	 ZWG2rl/MH847u4E71vXYOUEj6EaGX+aMaBNjZg9A7eCe/NMeeXg5x+lHYRSaDctQaS
	 /C8D1mMJLHv/QLLVB+MhJbsmvkcHoXBRw71yAl2plA7U65uhB/+41Ene9rNHlnCEzf
	 CwWzLvoudgQONUDMh3vq46Bsk/dD+8MnDZZ8BNkIaIcoEqNK5BhpQUJf1C4IY0+0kD
	 nWUITxMykN3VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D68DAE00090;
	Thu, 30 Nov 2023 04:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/15] mptcp: More selftest coverage and code
 cleanup for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131803386.31156.11737105854609497588.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:20:33 +0000
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: matttbe@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, geliang.tang@suse.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 15:18:44 -0800 you wrote:
> Patches 1-5 and 7-8 add selftest coverage (and an associated subflow
> counter in the kernel) to validate the recently-updated handling of
> subflows with ID 0.
> 
> Patch 6 renames a label in the userspace path manager for clarity.
> 
> Patches 9-11 and 13-15 factor out common selftest code by moving certain
> functions to mptcp_lib.sh
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/15] mptcp: add mptcpi_subflows_total counter
    https://git.kernel.org/netdev/net-next/c/6ebf6f90ab4a
  - [net-next,v4,02/15] selftests: mptcp: add evts_get_info helper
    https://git.kernel.org/netdev/net-next/c/06848c0f341e
  - [net-next,v4,03/15] selftests: mptcp: add chk_subflows_total helper
    https://git.kernel.org/netdev/net-next/c/80775412882e
  - [net-next,v4,04/15] selftests: mptcp: update userspace pm test helpers
    https://git.kernel.org/netdev/net-next/c/757c828ce949
  - [net-next,v4,05/15] selftests: mptcp: userspace pm create id 0 subflow
    https://git.kernel.org/netdev/net-next/c/b2e2248f365a
  - [net-next,v4,06/15] mptcp: userspace pm rename remove_err to out
    https://git.kernel.org/netdev/net-next/c/b3ac570aae6b
  - [net-next,v4,07/15] selftests: mptcp: userspace pm remove initial subflow
    https://git.kernel.org/netdev/net-next/c/e3b47e460b4b
  - [net-next,v4,08/15] selftests: mptcp: userspace pm send RM_ADDR for ID 0
    https://git.kernel.org/netdev/net-next/c/b9fb176081fb
  - [net-next,v4,09/15] selftests: mptcp: add mptcp_lib_kill_wait
    https://git.kernel.org/netdev/net-next/c/bdbef0a6ff10
  - [net-next,v4,10/15] selftests: mptcp: add mptcp_lib_is_v6
    https://git.kernel.org/netdev/net-next/c/b850f2c7dd85
  - [net-next,v4,11/15] selftests: mptcp: add mptcp_lib_get_counter
    https://git.kernel.org/netdev/net-next/c/61c131f5d4d2
  - [net-next,v4,12/15] selftests: mptcp: add missing oflag=append
    https://git.kernel.org/netdev/net-next/c/119931cc88ce
  - [net-next,v4,13/15] selftests: mptcp: add mptcp_lib_make_file
    https://git.kernel.org/netdev/net-next/c/3a96dea9f887
  - [net-next,v4,14/15] selftests: mptcp: add mptcp_lib_check_transfer
    https://git.kernel.org/netdev/net-next/c/9d9095bbc24d
  - [net-next,v4,15/15] selftests: mptcp: add mptcp_lib_wait_local_port_listen
    https://git.kernel.org/netdev/net-next/c/9369777c2939

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



