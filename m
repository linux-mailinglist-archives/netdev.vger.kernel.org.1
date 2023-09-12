Return-Path: <netdev+bounces-33126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA93479CC68
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68CC1C20D52
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0C168D2;
	Tue, 12 Sep 2023 09:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16017750
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16D5CC433CB;
	Tue, 12 Sep 2023 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694512225;
	bh=D9mg9tN91cP+3ujmuL/n0zALr66PJnRVQlzNbK+lkyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D2+MpvVMLRtSLwwO5CRff/zFb6Hvq93kf9NVn7NYSOer4r7aK/7Y+IgicU7QozKcc
	 xCReTiN2+l/GmjiQTcz5BD0KUOqo4tg/1SFKmiu86wfg3sqxbVJNsMyIMm/4/BTPJl
	 QiaXWPH8ULSJ58TRVZ0Z6a6IqJzX17ExaN4O5iKYS5MwTXfCZYx8WKkH2Ud33s2h43
	 l26C0jPB+wC9Bo/L1iWKEHVlbfgpxIDGBGCEXmHFGWRmCIeKSjVFwI8z8anwNOSrwn
	 PC8qnUQCOBf/+0DH+KHiU0bUD4+xU86X3qlaL7498O9TLUbObiJeEOhCWyjJxKgrFk
	 2STZEOaxGzsCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE54EE1C282;
	Tue, 12 Sep 2023 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dst: remove unnecessary input parameter in
 dst_alloc and dst_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169451222497.933.13229305373386995484.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 09:50:24 +0000
References: <20230911125045.346390-1-shaozhengchao@huawei.com>
In-Reply-To: <20230911125045.346390-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 pshelar@ovn.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 jmaxwell37@gmail.com, tglx@linutronix.de, mbizon@freebox.fr,
 joel@joelfernandes.org, eyal.birger@gmail.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 20:50:45 +0800 you wrote:
> Since commit 1202cdd66531("Remove DECnet support from kernel") has been
> merged, all callers pass in the initial_ref value of 1 when they call
> dst_alloc(). Therefore, remove initial_ref when the dst_alloc() is
> declared and replace initial_ref with 1 in dst_alloc().
> Also when all callers call dst_init(), the value of initial_ref is 1.
> Therefore, remove the input parameter initial_ref of the dst_init() and
> replace initial_ref with the value 1 in dst_init.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dst: remove unnecessary input parameter in dst_alloc and dst_init
    https://git.kernel.org/netdev/net-next/c/762c8dc7f269

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



