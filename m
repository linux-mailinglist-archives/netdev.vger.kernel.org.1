Return-Path: <netdev+bounces-31880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ACC791133
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 07:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2014280F74
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398380D;
	Mon,  4 Sep 2023 05:58:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE747FE
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B8A4C433C8;
	Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693807094;
	bh=V76n9XJ19s+dtaK9k/RjhknJ/aY1RHos0fNal93rZwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OTG2KU9sJx3rQ5oaobyKu5ifW440yH+xHiUZBDIG2JmfZV52C/adApJm1AV23xKkk
	 7kPcSWMlN3LdsaL2rdJgSwHQ3YVeoBeOqEb1DYDUlGH0LE2GLF4xfZfhY+25GtySHE
	 1BBfr7NyKpuK0aCaJlXxDVre/jxXN+/tvEvdIx9hOOcZ+nndTiPgOI0N3/b+1QqQyN
	 qHTFYNeJrIpfDn2EL6NISEpxnxQZLLAjDNskNW82lgaHayX1N9vN6vSgS3BIBGNZ+p
	 fUFUO4xpIu77oIAuaqEKLelxH3XmSmM8iy9EuNijOzICFXtXcqgg/o4JYDCFpdEQor
	 X5SiAyUrMjbuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BCD7C04E27;
	Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: fix frag_list chaining
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169380709437.30982.14085880052125469347.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 05:58:14 +0000
References: <20230831213812.3042540-1-edumazet@google.com>
In-Reply-To: <20230831213812.3042540-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, bcf@google.com,
 willemb@google.com, csully@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 21:38:12 +0000 you wrote:
> gve_rx_append_frags() is able to build skbs chained with frag_list,
> like GRO engine.
> 
> Problem is that shinfo->frag_list should only be used
> for the head of the chain.
> 
> All other links should use skb->next pointer.
> 
> [...]

Here is the summary with links:
  - [net] gve: fix frag_list chaining
    https://git.kernel.org/netdev/net/c/817c7cd2043a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



