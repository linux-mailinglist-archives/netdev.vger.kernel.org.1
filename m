Return-Path: <netdev+bounces-42472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA827CED32
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06CD1C20920
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296F393;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giArGqum"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2038C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B527C433CA;
	Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697677822;
	bh=JlzEZ8v1B5wtj1cXH96hQZchr39dACa3ccg4t8nFGuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=giArGqumx6JmGXDpul1DLTtmlMWSesYf95zX5LYrZFVR1EWuZ5N6peDOi9hlQACf3
	 iwgBbn+P02Yk61CAPKvG/WOEyvl6lulwhckV3Oq3KO2lLmIr+LfMjugbLZ5GQACdBQ
	 tjya3ZgStXFmq00Wy8eLE3Lgc/rqi2Gk5PjKsb7ItIMslRtheXal5E0Dhz/4414HSe
	 Lm4DcXqZUhknbcHQ9gLGXlIgOrIgKLKNUq1B/TPJynf1dBeXNClrnOQlrXDPK3UX11
	 S0Sed5RtU1HjfDoB5vFYojAZohbSYsLzC4PBMQnCM2WKbaBsrR/rhO3uvlBUPMNxZS
	 hpAcX0KXwGn7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 531C5E00080;
	Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: tsq: relax tcp_small_queue_check() when rtx queue
 contains a single skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767782233.12246.268144306723324978.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:10:22 +0000
References: <20231017124526.4060202-1-edumazet@google.com>
In-Reply-To: <20231017124526.4060202-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, wahrenst@gmx.net,
 ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 12:45:26 +0000 you wrote:
> In commit 75eefc6c59fd ("tcp: tsq: add a shortcut in tcp_small_queue_check()")
> we allowed to send an skb regardless of TSQ limits being hit if rtx queue
> was empty or had a single skb, in order to better fill the pipe
> when/if TX completions were slow.
> 
> Then later, commit 75c119afe14f ("tcp: implement rb-tree based
> retransmit queue") accidentally removed the special case for
> one skb in rtx queue.
> 
> [...]

Here is the summary with links:
  - [net] tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb
    https://git.kernel.org/netdev/net/c/f921a4a5bffa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



