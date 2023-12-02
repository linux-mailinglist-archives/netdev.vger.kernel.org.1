Return-Path: <netdev+bounces-53295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95B801F02
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923291C2083C
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1BBA40;
	Sat,  2 Dec 2023 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcSIkpTH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1F224CE
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 22:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 319DFC433C9;
	Sat,  2 Dec 2023 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701556224;
	bh=6hnIyDCFcY3aaJ2RiD3v6SpEevAHBty3WRK2OFR983U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZcSIkpTHo+AYkg9FyCrDcQbwqx9Lh/EtJvu7+4EkOf7HxzHSSdLS4Eat3M/DHZCeD
	 F1aKgy/+l5R/2VEOh/Mchh1WCSvrGUc2S3P23jeNDbsFAasLzzPge99ve83LRSCMXE
	 l5EzWDjbV6TzhtMQ1QFqYqtihkmu9JfKL1QJYMUk0EzxYt41gs7S9vTIK7BhgjlIAR
	 O6vN8DzakazJPBgTDKWqmIWglny/ygA4JtHbaUVCgEQBfgXUQoMcBPo3RIUR5B+k0X
	 kDgCRCAr/1C0ZhM7mMUFQzev8bvWW6LqJfCX5xm9QxKUFLzibRrhGwIuwwdtSAAILT
	 +J+UF0gYwR70A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 157F1DFAA94;
	Sat,  2 Dec 2023 22:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170155622408.27182.16031150060782175153.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 22:30:24 +0000
References: <20231129072756.3684495-1-lixiaoyan@google.com>
In-Reply-To: <20231129072756.3684495-1-lixiaoyan@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: kuba@kernel.org, edumazet@google.com, ncardwell@google.com,
 mubashirq@google.com, pabeni@redhat.com, andrew@lunn.ch, corbet@lwn.net,
 dsahern@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 wwchao@google.com, weiwan@google.com, pnemavat@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 29 Nov 2023 07:27:51 +0000 you wrote:
> Currently, variable-heavy structs in the networking stack is organized
> chronologically, logically and sometimes by cacheline access.
> 
> This patch series attempts to reorganize the core networking stack
> variables to minimize cacheline consumption during the phase of data
> transfer. Specifically, we looked at the TCP/IP stack and the fast
> path definition in TCP.
> 
> [...]

Here is the summary with links:
  - [v8,net-next,1/5] Documentations: Analyze heavily used Networking related structs
    https://git.kernel.org/netdev/net-next/c/14006f1d8fa2
  - [v8,net-next,2/5] cache: enforce cache groups
    https://git.kernel.org/netdev/net-next/c/aeb9ce058d7c
  - [v8,net-next,3/5] netns-ipv4: reorganize netns_ipv4 fast path variables
    https://git.kernel.org/netdev/net-next/c/18fd64d25422
  - [v8,net-next,4/5] net-device: reorganize net_device fast path variables
    (no matching commit)
  - [v8,net-next,5/5] tcp: reorganize tcp_sock fast path variables
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



