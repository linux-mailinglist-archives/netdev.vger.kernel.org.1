Return-Path: <netdev+bounces-12866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC598739370
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD261C21008
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80689DDAB;
	Thu, 22 Jun 2023 00:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DC2CA6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 652D6C433CB;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687392021;
	bh=WiZVeloMcs/+JOHqbX05hM3ZHPzrGrw8JH39DpSMMvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q3OWDtV8fw9ec6/Y+K54ko4tza46/AVwMqjJD5/9iO+ScEMY6zStf817uL+/M/VPA
	 OcRapSLq4/xH5EU2/1Hc34F3XwcalxKFxfWG3v9om0tKUZ+G1Aghv5HPawPqHNG2N7
	 lPUgN1r+yIGR5XHDzziKT91JUCJ5i51WAZl0ubuzHTHZXhN4slpdDjCfgz47MCNWhW
	 SVoF4qybf7o1XRzgxc86kj8g/rgFH1Pq8LXNKiLuxmHQ+X8HIasu/eMajcwOSI9TFq
	 uiBo58czkKvU0QqhpYdvENw7PGH1zQObqEKlZfxL0voAsAbXcjauDwDfg0ZH59dSRg
	 YWWqvnrTYHJ2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F748E4F14A;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: tc-testing: add one test for flushing
 explicitly created chain
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168739202125.22621.9173578727280562724.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 00:00:21 +0000
References: <20230620014939.2034054-1-renmingshuai@huawei.com>
In-Reply-To: <20230620014939.2034054-1-renmingshuai@huawei.com>
To: renmingshuai <renmingshuai@huawei.com>
Cc: pctammela@mojatatu.com, vladbu@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, liaichun@huawei.com, caowangbao@huawei.com,
 yanan@huawei.com, liubo335@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 09:49:39 +0800 you wrote:
> Add the test for additional reference to chains that are explicitly created
>  by RTM_NEWCHAIN message.
> The test result:
> 1..1
> ok 1 c2b4 - soft lockup alarm will be not generated after delete the prio 0
>  filter of the chain
> 
> [...]

Here is the summary with links:
  - [v2] selftests: tc-testing: add one test for flushing explicitly created chain
    https://git.kernel.org/netdev/net-next/c/ca4fa8743537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



