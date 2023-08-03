Return-Path: <netdev+bounces-24210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D776F3DB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2EC28233E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3A263AF;
	Thu,  3 Aug 2023 20:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672163BC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13882C433C8;
	Thu,  3 Aug 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691093422;
	bh=bDldoG/6MjDkYObLfg7WyaFzWIKE8gp5FFP0sQH0Zok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTw84EQFIE0GueeX1ngrUfP92vLXsem726NfUXgQb5mXNQxWcZN7v/rl74gV1TRQD
	 W38g3zK/iufPiNTcbW9saYvkEBGBPJA+39zfMG6LVh303TBIG7BOHTaJI6QTW1jv5G
	 syv4YqWLEbDXzIpJS7YnRO8QZXXUH3FvRxrwuthLXdHIMqe9D1K8HLFPIpv2zLbOCt
	 LNWNhc4Al0qp845HSh9GqYnN8kLeWtIt64dqh1d9Y1qLFQ9yckgYC0sAwCRrclVwX3
	 oOx8K0Uazra5IsvQUCGUy7/j+90qntiES8A6GNPlAatPuW2UeDV2h74KCCeOdpi4tZ
	 GLJXSW3dLZuKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2FD6C595C1;
	Thu,  3 Aug 2023 20:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2-next] seg6: man: ip-link.8: add description of NEXT-C-SID
 flavor for SRv6 End.X behavior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169109342192.26506.5964486855240151933.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 20:10:21 +0000
References: <20230731183616.3551-1-paolo.lungaroni@uniroma2.it>
In-Reply-To: <20230731183616.3551-1-paolo.lungaroni@uniroma2.it>
To: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 stephen@networkplumber.org, stefano.salsano@uniroma2.it,
 ahabdels.dev@gmail.com, andrea.mayer@uniroma2.it, liuhangbin@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 31 Jul 2023 20:36:16 +0200 you wrote:
> This patch extends the manpage by providing the description of NEXT-C-SID
> support for the SRv6 End.X behavior as defined in RFC 8986 [1].
> 
> The code/logic required to handle the "flavors" framework has already been
> merged into iproute2 by commit:
>     04a6b456bf74 ("seg6: add support for flavors in SRv6 End* behaviors").
> 
> [...]

Here is the summary with links:
  - [iproute2-next] seg6: man: ip-link.8: add description of NEXT-C-SID flavor for SRv6 End.X behavior
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=64e8c4b6744e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



