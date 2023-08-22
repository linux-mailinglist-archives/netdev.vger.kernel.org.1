Return-Path: <netdev+bounces-29631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBA7841A3
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B90D1C20B02
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA11C9E4;
	Tue, 22 Aug 2023 13:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1D7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9B24C433C7;
	Tue, 22 Aug 2023 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692709821;
	bh=jPtoZS7VxPE422iDKCiuqsVhp0tZqesmPCKiQY7aXBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pcy/0HvKO0fo5TyBP3fj1inFtN1uAP6imn6kgPvvhcUbbdAHMJyzcDnOCwNTcZMAR
	 DzxntLTk6APfbf5OZMOoCHBGyJ19JR0kQUwaG1MBmxpVWN7g/PR3bC+SS+VSqSb/JA
	 wmpMxBFaWI2JbKKirezlKYVsbAKzrrw2ecuMYdKSGJCe3YuUszJQRMR0bSZtqlLM1P
	 j0liulWNlDbHWVi0PL+eUgKFrcOEbmXf0x+839ku5cY7I51vAKyaRfvg1gH0nrvjU7
	 W+WJZoNDB+7m4FvaDAQF82MSQ6/mBbkD3xZj5xReXiTI+5fuJ4yh0538EyvDSs/hdH
	 i9nNpt6SzW+SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5C9FE21ED3;
	Tue, 22 Aug 2023 13:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove unnecessary input parameter 'how' in
 ifdown function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169270982167.21836.17828309561672723275.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 13:10:21 +0000
References: <20230821084104.3812233-1-shaozhengchao@huawei.com>
In-Reply-To: <20230821084104.3812233-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org, eyal.birger@gmail.com,
 paulmck@kernel.org, joel@joelfernandes.org, tglx@linutronix.de,
 mbizon@freebox.fr, jmaxwell37@gmail.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Aug 2023 16:41:04 +0800 you wrote:
> When the ifdown function in the dst_ops structure is referenced, the input
> parameter 'how' is always true. In the current implementation of the
> ifdown interface, ip6_dst_ifdown does not use the input parameter 'how',
> xfrm6_dst_ifdown and xfrm4_dst_ifdown functions use the input parameter
> 'unregister'. But false judgment on 'unregister' in xfrm6_dst_ifdown and
> xfrm4_dst_ifdown is false, so remove the input parameter 'how' in ifdown
> function.
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove unnecessary input parameter 'how' in ifdown function
    https://git.kernel.org/netdev/net-next/c/43c2817225fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



