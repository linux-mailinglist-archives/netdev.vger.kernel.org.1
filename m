Return-Path: <netdev+bounces-93034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242F68B9C30
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343B5B21376
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9777313C69B;
	Thu,  2 May 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diBVwjFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE883A1D
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659634; cv=none; b=Ho3EYQ4O3ej428rQA9i/HN5uojCAoUx4BmKQsr5ncW6HxmIrjyopSKZlcj2IaSlpn6CNXgshIX+AoO/ah7ncCBkZB6yud2Ufkv/ZTusN4IvjedmA6Y1tINEW2xpkQPP5h8G86guPf1D5jkOyitCz+5hMRYMTFSPPtn8O/P4hwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659634; c=relaxed/simple;
	bh=afdzYhJwFXxyFnhITq3oNSXbTqa5JUfcwN3OYlF6iW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WlcgD2QLd+y0ZyzYsAFUr1lNdQq9p5T/cP+Pv2NfUa/V0+m/JAvZmBuRgJ/2dy4RsypYs8KlKud4spBn47wH5aeUh/K2bshlrvPRbEjZ3Bf48EhksHCpmrnWFDHICVA2HOBVMSfEeSCoR2JCh61/9r8inTNy2AuBIJS4obl2dsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diBVwjFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ACE9C32789;
	Thu,  2 May 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659634;
	bh=afdzYhJwFXxyFnhITq3oNSXbTqa5JUfcwN3OYlF6iW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=diBVwjFVBe4ly/B2BQViMloE/+bnAuoAIE+MDa1+aWJ7geeM0a7CxJxWdrwaNRcx9
	 Rzyco3xJ5Z8isX7LI66Xj7+T5qH3tIPZHZ14JBaFDXi3/afwc35+ZGo8HKwyMiSr57
	 aTRZdKSI0xtbLdajydmFV22KDGrnYh1/8iS6yRMGtiyiklbP2gvxUbqc6rQCqwJHtJ
	 z5GJHnOfTNmqkPhNXgV18DhGO/9oHWs1OztrhvcVYEshA3bZea3AQctIFlKKQxBMI8
	 Fu7ch4ZyquylZCPouIYAtnXI+9K4NMcS7Lnk6dpqKjvdrqEoPac0t/grNizia6mwqQ
	 PngmAnRTuNXnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00ABBC4333B;
	Thu,  2 May 2024 14:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171465963399.28830.8599915114515835353.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 14:20:33 +0000
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
In-Reply-To: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naresh.kamboju@linaro.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 19:11:13 +0200 you wrote:
> Naresh and Eric report several errors (corrupted elements in the dynamic
> key hash list), when running tdc.py or syzbot. The error path of
> qdisc_alloc() and qdisc_create() frees the qdisc memory, but it forgets
> to unregister the lockdep key, thus causing use-after-free like the
> following one:
> 
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in lockdep_register_key+0x5f2/0x700
>  Read of size 8 at addr ffff88811236f2a8 by task ip/7925
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc error path
    https://git.kernel.org/netdev/net-next/c/86735b57c905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



