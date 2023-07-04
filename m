Return-Path: <netdev+bounces-15357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECDF7471B9
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 14:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A2E1C209A0
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4E53B6;
	Tue,  4 Jul 2023 12:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDA4417
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 12:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9738C433C9;
	Tue,  4 Jul 2023 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688475020;
	bh=M5l1e+Gqp35087fipcXy2n+cT+F6ew/WIwjSXCd/zJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XI0/oFqkn/lXQdfqVv89WkTgVeHC8ISMFy7xNO+so9pEmGo53i7YUzwiUUT/mAPzu
	 IEWW7xwTFGWi/2eDNAR+9eXK4f4az0Siq1vuQk9ctHW3IrvcbnegSxtzGxjUepslVK
	 GxCMbCCa6j8L5c24m2YfCpgIbdG9CtyeZCXjQbYiExCiGDnRmG2BgY/ncDINaFySi6
	 36w7/7At3+fxpkoRHYsqzEFLe5OqP/5i1dr0hrTAqGun//NXwiEq7nqJ3TesxSVsjp
	 qE65JqGje2kpMyiL43uzG2fMeAoFUO+RrVKriUVNuA5JRLDBxUWeW54ulI46EGSXSi
	 7NjI80gq/ME5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE122C40C5E;
	Tue,  4 Jul 2023 12:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net/sched: act_pedit: Add size check for
 TCA_PEDIT_PARMS_EX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168847502077.18022.18312978796935285573.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jul 2023 12:50:20 +0000
References: <20230703110842.590282-1-linma@zju.edu.cn>
In-Reply-To: <20230703110842.590282-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  3 Jul 2023 19:08:42 +0800 you wrote:
> The attribute TCA_PEDIT_PARMS_EX is not be included in pedit_policy and
> one malicious user could fake a TCA_PEDIT_PARMS_EX whose length is
> smaller than the intended sizeof(struct tc_pedit). Hence, the
> dereference in tcf_pedit_init() could access dirty heap data.
> 
> static int tcf_pedit_init(...)
> {
>   // ...
>   pattr = tb[TCA_PEDIT_PARMS]; // TCA_PEDIT_PARMS is included
>   if (!pattr)
>     pattr = tb[TCA_PEDIT_PARMS_EX]; // but this is not
> 
> [...]

Here is the summary with links:
  - [v1] net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX
    https://git.kernel.org/netdev/net/c/30c45b5361d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



