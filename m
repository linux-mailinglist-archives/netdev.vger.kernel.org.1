Return-Path: <netdev+bounces-110768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B63792E399
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA716283573
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C517156C78;
	Thu, 11 Jul 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br90p5AJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A613AA35
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690831; cv=none; b=O6oTDKG+q/IkRJnb49H5m4nTLHEg+kYvwXW3wZAgdo1nTf7rrhpy9/Fe+2z9IzcEqFa080ZCgeWpu0Z01BqkWBuDAw+t7yW2HLK/ntfrV94Xtw/Oxo0XifHbaBnmbtkN47xu3sn3MgR7+a8y2rBhGpw1hLeAjvc8gEIAL4lw7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690831; c=relaxed/simple;
	bh=W2568hclen+GOavVHJmTykZ8f++EWk/s13b3rkwUfOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f31ZVUksOIr/TTVaBM3Fg5NV235RaWIxBf6xVJbPEYrDXMZxW+tSY+Xmwet8UURDAd87tnsCTou0az6v0n1GtuLCUa5N1mQcfEmALPMBt1DrCEDzn2ZF9g6ikqdd9D/KD5Lg7nGRCOIuEUHLjglcV3IVnl/dNzkoJYqLTABfm2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br90p5AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1889FC32786;
	Thu, 11 Jul 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720690831;
	bh=W2568hclen+GOavVHJmTykZ8f++EWk/s13b3rkwUfOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Br90p5AJgWcIHGbME9fL1NeXhmKeP/bksy6duuchbmgxew8OvitSvlEYtoMbhpml4
	 LLvzYn/CSDVkXTFdsV4L2hjijAMGeiWWPSk3sVzv1CoUgjBV7Fpl5YpkkdxdSrKe4H
	 wmR41fgCFRwLlgGJFQ+TZBa3W2iBgb16voqFBaoxpnYGohBglGysN8vElJXn+a3e7x
	 OW3l/yBmVU7f/eLy7MOmuRwdlxGy65zHKqc115iBSkbPxvULShUwY4Jzc3IgWBNE3t
	 jEA3HW8IXK9iWDLXRlBnuqc6JxZSsBstPj8TSp2KNZ7qZqqun3qQE39+B2PLlpC7TC
	 IQujQj3nnj6uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0402DDAE95C;
	Thu, 11 Jul 2024 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172069083101.19088.6448598444769939054.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 09:40:31 +0000
References: <20240709191356.24010-1-kuniyu@amazon.com>
In-Reply-To: <20240709191356.24010-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 joe@wand.net.nz, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 9 Jul 2024 12:13:56 -0700 you wrote:
> syzkaller triggered the warning [0] in udp_v4_early_demux().
> 
> In udp_v[46]_early_demux() and sk_lookup(), we do not touch the refcount
> of the looked-up sk and use sock_pfree() as skb->destructor, so we check
> SOCK_RCU_FREE to ensure that the sk is safe to access during the RCU grace
> period.
> 
> [...]

Here is the summary with links:
  - [v2,net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
    https://git.kernel.org/netdev/net/c/5c0b485a8c61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



