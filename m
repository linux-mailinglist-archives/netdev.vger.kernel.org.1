Return-Path: <netdev+bounces-38158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206697B994C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 63A92281ABB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8337EB;
	Thu,  5 Oct 2023 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atbOEoAX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526AC36B
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA42CC433D9;
	Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696466427;
	bh=1/Us9HGzzokeMRRp/ZJIfxuzIgehXZMPqhsa/gG69GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=atbOEoAXr7BZSZni49FNM5HKySE202zlI+OjqsXI+BUg0rKjD+g+D5IStaY1HtbJv
	 CwthWKVp5HZUjj2iPIDxN3rekFAfcAD/2HskA5GA7tQccalLq04mmu5Yup297CbRT0
	 UTDEooDUk9Tx5dcupk6FZsMnBmiscfryxVIhbXwMHhnmVlvAsZR8LrCNGUUX1ZTzz3
	 hE6CswiowOYzws2yn2cVHm6jQaKm2AJDneKjfp/1IaDCZIX8emuCSEf7OGvO3w0Quq
	 HjJg31ikJ86MUM8EIln0nLoT5wbzm5qeJEWSlIN0aTSReYLVjp2Pt9eEUVdjd6HwPj
	 ssUbFdsmR3mlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD6E8E268B2;
	Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: update transport state when processing a dupcook
 packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169646642777.7507.18371535328786220058.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 00:40:27 +0000
References: <fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com>
In-Reply-To: <fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Oct 2023 10:58:45 -0400 you wrote:
> During the 4-way handshake, the transport's state is set to ACTIVE in
> sctp_process_init() when processing INIT_ACK chunk on client or
> COOKIE_ECHO chunk on server.
> 
> In the collision scenario below:
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]
> 
> [...]

Here is the summary with links:
  - [net] sctp: update transport state when processing a dupcook packet
    https://git.kernel.org/netdev/net/c/2222a78075f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



