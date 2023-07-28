Return-Path: <netdev+bounces-22138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAE766272
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5C21C2179D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B881FDF;
	Fri, 28 Jul 2023 03:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB8210C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71A24C433C7;
	Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515023;
	bh=fOupbUfWIq1GHSvRkIH0Sw2V71Ryf2NHF4M/570Qf9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TRVGbxh6kq9P1QRY+pYFsUgXYOdhVoEsGiS2IgKCSjb+9loLpyl/iVSylI1xHroFF
	 W4vrO7+QmLcALxvBz/p7Ce70fpd+sYFWfhpEZILlKelPDTshxJAdouV0e0aV3iruWM
	 udCKlLaXAPSavVIXkIf/0PJ8DnBKtDJvVrdOu+gEbrQtgcK00vFM8CJSmN1ZUuxx4i
	 VcKkaBjezbUbToQ3PJBPef6PD8FwAmR9flsfE/7+VID4TpAqpMkQZwctUvY3yEPbqx
	 mm4ghBskGkUGHRZ4Ux48nH8Q2t6V+AqTabBD+Ow4LGKYC6JUCEoghcx3oxEpQSqml8
	 8JIUd8pY8GThQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EDA0C691D7;
	Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: flower: fix stack-out-of-bounds in
 fl_set_key_cfm()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051502331.18144.11048467979263137230.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:30:23 +0000
References: <20230726145815.943910-1-edumazet@google.com>
In-Reply-To: <20230726145815.943910-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com, zdoychev@maxlinear.com,
 simon.horman@corigine.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 14:58:15 +0000 you wrote:
> Typical misuse of
> 
> 	nla_parse_nested(array, XXX_MAX, ...);
> 
> array must be declared as
> 
> 	struct nlattr *array[XXX_MAX + 1];
> 
> [...]

Here is the summary with links:
  - [v2,net] net: flower: fix stack-out-of-bounds in fl_set_key_cfm()
    https://git.kernel.org/netdev/net/c/4d50e50045aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



