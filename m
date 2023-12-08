Return-Path: <netdev+bounces-55279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8F80A172
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324861F212E3
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7B13FFC;
	Fri,  8 Dec 2023 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgXy+4W2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578816FD6
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E47A8C433C8;
	Fri,  8 Dec 2023 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702032624;
	bh=PsJCU0e+IRY7MMQRJtEVcbl8uhICg3EauJ7+G+jqR3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lgXy+4W22g9njMtDjP7kZaacdy7zFPJeJzAb7Di4Y1dml7d8A78NKtreYW8CCdz2V
	 OQao9vxBoyf3xYx19jFdfsXlyJJIL56dcMNvpUavpCCegSCDAhqRwfZrUQQGUiXSnk
	 0E/xXB/soIdtUZ8CE98BGuzOQ9Y2ORe9n2iQtCEltQxpjFFJqv0tpdYXCTlj9KNgFk
	 UVlF6SeumtKCZA9sXSbc1v8fUmuJe4NvxaDA7asYdzsNj+KGUfM0gVHyb8///BPcjO
	 talTzi89L352BNTe6CFGY28JYJdGART3R9vouKLmDOjCODF7kVohJUPVy7ENGHzmld
	 3r1VD1t1UMD9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE622DD4F1E;
	Fri,  8 Dec 2023 10:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170203262384.21119.8524021464394465634.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 10:50:23 +0000
References: <20231206173612.79902-1-maze@google.com>
In-Reply-To: <20231206173612.79902-1-maze@google.com>
To: =?utf-8?q?Maciej_=C5=BBenczykowski_=3Cmaze=40google=2Ecom=3E?=@codeaurora.org
Cc: zenczykowski@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 lorenzo@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Dec 2023 09:36:12 -0800 you wrote:
> Lorenzo points out that we effectively clear all unknown
> flags from PIO when copying them to userspace in the netlink
> RTM_NEWPREFIX notification.
> 
> We could fix this one at a time as new flags are defined,
> or in one fell swoop - I choose the latter.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX
    https://git.kernel.org/netdev/net/c/bd4a816752ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



