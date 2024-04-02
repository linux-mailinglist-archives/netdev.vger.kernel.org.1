Return-Path: <netdev+bounces-83867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D535F894A5E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B28B1F22DD6
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E695179AB;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2xwB7vJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D31426F;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031627; cv=none; b=SVlaNjThMVVBkfV3NLrCB8t6QPCvuKSVgqBcW3NreAz54pnM0TkbJZcjpisDT9+CUq95A20UwEu5VzHYAQSIKmXzV0DhY8Au15k/X3E37ReUX1InUTJbaY8TIVzcWQ+abRdpB3MIqCbSBQynIBSix+3oJSwbKoK0XDdSo+lnS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031627; c=relaxed/simple;
	bh=vaCsj7gbd2rPFxIynoOdojDVOPNrn8BX8eepAklV8N8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KDewrQ57nCG8N30qvjNjSC1hVX5YBK7DfEPmd1Z6yBezem8DxJ4iBaHn+3PItTVzBH87DzN6JhL1uQi1lb+H3+fKyPV3XdOYZ9HQwZstXSt5CSc5hrfb8AuqxSyXtsqkPAPEqhUWL76uduFFYkS/VHmEC8aoz1b31tyn53DgUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2xwB7vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DC6DC43394;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031627;
	bh=vaCsj7gbd2rPFxIynoOdojDVOPNrn8BX8eepAklV8N8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y2xwB7vJpgTI2JEOa13r3a3JNeskiCGDc2u3ZTio50LSRG2vm9wWUFklIY8E8Pd1V
	 WT3wiMOs9KIWxD9gNklNWtgcyjTfWa5DVCxbz/BORHEPpXQ0jZpWW2tZfxBE5H1VWl
	 vBqR0L42MrK1+zfhmVFSM7xDs7hC0zGIY+DN/GwdXnGuBg1Ysk4aQxP2qImEoC1VI0
	 TL36qpaDf8OnmUpxk2cfQJ4of4WFA1JqFV/e0BbUAJ/Sr/rsMQTPd+aRZYEJR/VgkL
	 YX8YByJ/guTbdJaaAVedr21ustNYRNcV+zp00pu/Xdjc2jmULeV1ydGpnHKR1DFdZo
	 TpvrEWD81s+oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C8E9D8BD16;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: prevent BPF accessing lowat from a subflow socket.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203162704.30104.6455806082804107632.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:20:27 +0000
References: <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
In-Reply-To: <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, mptcp@lists.linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 19:50:36 +0100 you wrote:
> Alexei reported the following splat:
> 
>  WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430 subflow_data_ready+0x147/0x1c0
>  Modules linked in: dummy bpf_testmod(O) [last unloaded: bpf_test_no_cfi(O)]
>  CPU: 32 PID: 3276 Comm: test_progs Tainted: GO       6.8.0-12873-g2c43c33bfd23
>  Call Trace:
>   <TASK>
>   mptcp_set_rcvlowat+0x79/0x1d0
>   sk_setsockopt+0x6c0/0x1540
>   __bpf_setsockopt+0x6f/0x90
>   bpf_sock_ops_setsockopt+0x3c/0x90
>   bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
>   bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0x132
>   bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
>   __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
>   tcp_connect+0x879/0x1160
>   tcp_v6_connect+0x50c/0x870
>   mptcp_connect+0x129/0x280
>   __inet_stream_connect+0xce/0x370
>   inet_stream_connect+0x36/0x50
>   bpf_trampoline_6442491565+0x49/0xef
>   inet_stream_connect+0x5/0x50
>   __sys_connect+0x63/0x90
>   __x64_sys_connect+0x14/0x20
> 
> [...]

Here is the summary with links:
  - [net] mptcp: prevent BPF accessing lowat from a subflow socket.
    https://git.kernel.org/netdev/net/c/fcf4692fa39e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



