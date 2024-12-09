Return-Path: <netdev+bounces-150399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63819EA1A2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DCB1883738
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5C19DF77;
	Mon,  9 Dec 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTlWFKK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311D19D89B;
	Mon,  9 Dec 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782221; cv=none; b=f9lkFSyMyJZEBfjuCo0X3fGa0K0FZIk9gXXo4mx82AbXT5Ew0nzgFy0QJsUL0iUEVWFWTKiIjElWaxrsBso9WAYwDw/cPbXriJfubD8lkoyZ00rnvFOyUjTXsRs9SMb9EVrrkJVsGAWgJp2cYuHKBCOahwzOdhbONAviBwaTlUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782221; c=relaxed/simple;
	bh=9mn9FY8m5rfNfrs4A2wmviNGznoH2kQKyuRe+pYzJuY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kb9vNcbcfmQuqE1hwmwE0F4sCVn1V8WW+QUNvA1/AbnBNeOOHthfBlTSx9P66ufV1zXKV96vAHizSSFMrNu2iPuKE2D/vN+tDoflh1iJJb4Pi6rTLU33fpDNJoMZ+uHqYiR/rlFHblf4veVM8+6TZATkwBBGZE+By0bCuDdOwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTlWFKK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CABC4CED1;
	Mon,  9 Dec 2024 22:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733782220;
	bh=9mn9FY8m5rfNfrs4A2wmviNGznoH2kQKyuRe+pYzJuY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTlWFKK5ydDYNMdL/AQWfIcjVf1cF2/Ud2WMwZULUF6F1NXDw8IMJfWM9WWN6rDNL
	 OauYn8tRB9ghJkhWa7WgicGLc/jYrXNZMXb9FmwQNoYgvpic1xIo31EX42WB+dTP0L
	 f01CX2pnPTLjkCRLl/Q+Mbqmrw822EXalKV4q3fE3pY8HSxXrwMZAolJPLmz+Sq7G6
	 9bdEnz28Tw2dFoJh6+mvZttxjmrjRhZKL1xHh4RujiRYoKc9zWwpYUnnMih/5vJZEM
	 XyX2DnKmhqSkU+CG/pzBKZ9pVK5/m44XpMDTq5L4s6o75/0jrzlYRb9bvb7ZIARY0i
	 8rBN2sHxb1lvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71082380A95E;
	Mon,  9 Dec 2024 22:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/39] rxrpc: Implement jumbo DATA transmission
 and RACK-TLP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173378223626.256970.7645441720961286203.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 22:10:36 +0000
References: <20241204074710.990092-1-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, linyunsheng@huawei.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 07:46:28 +0000 you wrote:
> Here's a series of patches to implement two main features:
> 
>  (1) The transmission of jumbo data packets whereby several DATA packets of
>      a particular size can be glued together into a single UDP packet,
>      allowing us to make use of larger MTU sizes.  The basic jumbo
>      subpacket capacity is 1412 bytes (RXRPC_JUMBO_DATALEN) and, say, an
>      MTU of 8192 allows five of them to be transmitted as one.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/39] ktime: Add us_to_ktime()
    https://git.kernel.org/netdev/net-next/c/d1fd97291423
  - [net-next,v2,02/39] rxrpc: Fix handling of received connection abort
    https://git.kernel.org/netdev/net-next/c/0e56ebde245e
  - [net-next,v2,03/39] rxrpc: Use umin() and umax() rather than min_t()/max_t() where possible
    https://git.kernel.org/netdev/net-next/c/29e03ec75729
  - [net-next,v2,04/39] rxrpc: Clean up Tx header flags generation handling
    https://git.kernel.org/netdev/net-next/c/efa95c32352b
  - [net-next,v2,05/39] rxrpc: Don't set the MORE-PACKETS rxrpc wire header flag
    https://git.kernel.org/netdev/net-next/c/cbe0d89095c3
  - [net-next,v2,06/39] rxrpc: Show stats counter for received reason-0 ACKs
    https://git.kernel.org/netdev/net-next/c/ff992adbc470
  - [net-next,v2,07/39] rxrpc: Request an ACK on impending Tx stall
    https://git.kernel.org/netdev/net-next/c/8b5823ea4376
  - [net-next,v2,08/39] rxrpc: Use a large kvec[] in rxrpc_local rather than every rxrpc_txbuf
    https://git.kernel.org/netdev/net-next/c/420f8af50287
  - [net-next,v2,09/39] rxrpc: Implement path-MTU probing using padded PING ACKs (RFC8899)
    https://git.kernel.org/netdev/net-next/c/eeaedc5449d9
  - [net-next,v2,10/39] rxrpc: Separate the packet length from the data length in rxrpc_txbuf
    https://git.kernel.org/netdev/net-next/c/3d2bdf73cea5
  - [net-next,v2,11/39] rxrpc: Prepare to be able to send jumbo DATA packets
    https://git.kernel.org/netdev/net-next/c/b7313009c2e5
  - [net-next,v2,12/39] rxrpc: Add a tracepoint to show variables pertinent to jumbo packet size
    https://git.kernel.org/netdev/net-next/c/149d002bee70
  - [net-next,v2,13/39] rxrpc: Fix CPU time starvation in I/O thread
    https://git.kernel.org/netdev/net-next/c/9e3cccd176b5
  - [net-next,v2,14/39] rxrpc: Fix injection of packet loss
    https://git.kernel.org/netdev/net-next/c/cd69a07b6d18
  - [net-next,v2,15/39] rxrpc: Only set DF=1 on initial DATA transmission
    https://git.kernel.org/netdev/net-next/c/81e7761be58a
  - [net-next,v2,16/39] rxrpc: Timestamp DATA packets before transmitting them
    https://git.kernel.org/netdev/net-next/c/976b0ca5aae7
  - [net-next,v2,17/39] rxrpc: Don't need barrier for ->tx_bottom and ->acks_hard_ack
    https://git.kernel.org/netdev/net-next/c/6396b48ac0a7
  - [net-next,v2,18/39] rxrpc: Implement progressive transmission queue struct
    https://git.kernel.org/netdev/net-next/c/b341a0263b1b
  - [net-next,v2,19/39] rxrpc: call->acks_hard_ack is now the same call->tx_bottom, so remove it
    https://git.kernel.org/netdev/net-next/c/692c4caa074c
  - [net-next,v2,20/39] rxrpc: Replace call->acks_first_seq with tracking of the hard ACK point
    https://git.kernel.org/netdev/net-next/c/203457e11b59
  - [net-next,v2,21/39] rxrpc: Display stats about jumbo packets transmitted and received
    https://git.kernel.org/netdev/net-next/c/f003e4038f0e
  - [net-next,v2,22/39] rxrpc: Adjust names and types of congestion-related fields
    https://git.kernel.org/netdev/net-next/c/f7dd0dc96513
  - [net-next,v2,23/39] rxrpc: Use the new rxrpc_tx_queue struct to more efficiently process ACKs
    https://git.kernel.org/netdev/net-next/c/9b052c6b92f9
  - [net-next,v2,24/39] rxrpc: Store the DATA serial in the txqueue and use this in RTT calc
    https://git.kernel.org/netdev/net-next/c/dcdff0d8e3b6
  - [net-next,v2,25/39] rxrpc: Don't use received skbuff timestamps
    https://git.kernel.org/netdev/net-next/c/7903d4438b3f
  - [net-next,v2,26/39] rxrpc: Generate rtt_min
    https://git.kernel.org/netdev/net-next/c/c637bd066841
  - [net-next,v2,27/39] rxrpc: Adjust the rxrpc_rtt_rx tracepoint
    https://git.kernel.org/netdev/net-next/c/93dfca65a1df
  - [net-next,v2,28/39] rxrpc: Display userStatus in rxrpc_rx_ack trace
    https://git.kernel.org/netdev/net-next/c/a3d7f46d983f
  - [net-next,v2,29/39] rxrpc: Fix the calculation and use of RTO
    https://git.kernel.org/netdev/net-next/c/5c0ceba23bb4
  - [net-next,v2,30/39] rxrpc: Fix initial resend timeout
    https://git.kernel.org/netdev/net-next/c/0130eff911b1
  - [net-next,v2,31/39] rxrpc: Send jumbo DATA packets
    https://git.kernel.org/netdev/net-next/c/fe24a5494390
  - [net-next,v2,32/39] rxrpc: Don't allocate a txbuf for an ACK transmission
    https://git.kernel.org/netdev/net-next/c/08d55d7cf3f3
  - [net-next,v2,33/39] rxrpc: Use irq-disabling spinlocks between app and I/O thread
    https://git.kernel.org/netdev/net-next/c/a2ea9a907260
  - [net-next,v2,34/39] rxrpc: Tidy up the ACK parsing a bit
    https://git.kernel.org/netdev/net-next/c/547a9acd4c5e
  - [net-next,v2,35/39] rxrpc: Add a reason indicator to the tx_data tracepoint
    https://git.kernel.org/netdev/net-next/c/372d12d191cb
  - [net-next,v2,36/39] rxrpc: Add a reason indicator to the tx_ack tracepoint
    https://git.kernel.org/netdev/net-next/c/b509934094fd
  - [net-next,v2,37/39] rxrpc: Manage RTT per-call rather than per-peer
    https://git.kernel.org/netdev/net-next/c/b40ef2b85a7d
  - [net-next,v2,38/39] rxrpc: Fix request for an ACK when cwnd is minimum
    https://git.kernel.org/netdev/net-next/c/4ee4c2f82b81
  - [net-next,v2,39/39] rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]
    https://git.kernel.org/netdev/net-next/c/7c482665931b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



