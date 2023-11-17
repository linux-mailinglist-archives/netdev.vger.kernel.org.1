Return-Path: <netdev+bounces-48535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE87EEB47
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 04:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84701F2263D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2FF4A0F;
	Fri, 17 Nov 2023 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="symgOHiC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB9469E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 03:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2638C433C9;
	Fri, 17 Nov 2023 03:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700190023;
	bh=GMFEh6GoMGIDGmPKoeCx161zAh4UulGGvZfaLHv+L2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=symgOHiCuBfaQKZEuP9DlVtGX8ULTJHV7hJLB+29BIl1+SRgEZor0W9xhD4CkgfwP
	 E+L3/AQCSH8jLo3hOvzpD6QxWthw/96qC9l1KHTcwdAYJ0ipC6BUT6kqMrxtIoWntJ
	 kmHzqWbanoXrIcHl8uICiyn7T3/cDcBqgU8S6lrSzaU3R6bdwklYZExyWyraMpprhh
	 lLrJP3et7wU67qKE2VT8tdlBfvIf7u9fNDVcVfVOiy2jwJcaHcu7YxjgePalwBHeM4
	 pi852Hl6g6ujrJd6AOmD0Mmn/8Nf4RMuuye8mHy+D/JfurrdBOaV+USgV/cJUhvluS
	 YqqNKKQU9b70A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83D9EE1F65A;
	Fri, 17 Nov 2023 03:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] rxrpc: ACK handling fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170019002353.1895.8952802465707802348.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 03:00:23 +0000
References: <20231116131259.103513-1-dhowells@redhat.com>
In-Reply-To: <20231116131259.103513-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Nov 2023 13:12:57 +0000 you wrote:
> Here are a couple of patches to fix ACK handling in AF_RXRPC:
> 
>  (1) Allow RTT determination to use an ACK of any type as the response from
>      which to calculate RTT, provided ack.serial matches the serial number
>      of the outgoing packet.
> 
>  (2) Defer the response to a PING ACK packet (or any ACK with the
>      REQUEST_ACK flag set) until after we've parsed the packet so that we
>      carry up to date information if the Tx or Rx rings are advanced.
> 
> [...]

Here is the summary with links:
  - [net,1/2] rxrpc: Fix RTT determination to use any ACK as a source
    https://git.kernel.org/netdev/net/c/3798680f2fbb
  - [net,2/2] rxrpc: Defer the response to a PING ACK until we've parsed it
    https://git.kernel.org/netdev/net/c/1a01319feef7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



