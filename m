Return-Path: <netdev+bounces-53882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDE8050BD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325A3281A45
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A12D046;
	Tue,  5 Dec 2023 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixwq/6KX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D056470
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02C9CC433C9;
	Tue,  5 Dec 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701772825;
	bh=2wMRhD7nG9fhMWKgzrcjxHaeicY4ghS7mf5qyNJvwEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ixwq/6KX+vVmQre0v6RqeQldazu8mFNaYKQ8RVC95yUQEORqYk8C5xlD1QigrqPrU
	 XSCvqyzSfwdsZQBrnE+rmTDoR5VTZN/2CgpAYv+ZozDIJqBUoHNp966rIprGlreYtV
	 dpK0GM2BdzoaWcd/AdAEiCgtwB3BIzS1nXd8NdEhbRsdXGycgcYYcoJb/mi7+wXAfe
	 gM+xLU4Usv09hpxsUzQwqA1uprmiLFRcM2mfTpKQTf3mIXIlKp+1m92DZ1ad7SPHhV
	 mhJGfZvlAPZ7P4PGAXmBRnA1aCzL1SIlmjj6JyNenqkD0bs2RQI5Va7LtLwJKBDxNX
	 I3oyRxI6ksc+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC0B4C43170;
	Tue,  5 Dec 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net/sched: act_api: contiguous action arrays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170177282489.23603.56753076130768480.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 10:40:24 +0000
References: <20231201175015.214214-1-pctammela@mojatatu.com>
In-Reply-To: <20231201175015.214214-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, mleitner@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Dec 2023 14:50:11 -0300 you wrote:
> When dealing with action arrays in act_api it's natural to ask if they
> are always contiguous (no NULL pointers in between). Yes, they are in
> all cases so far, so make use of the already present tcf_act_for_each_action
> macro to explicitly document this assumption.
> 
> There was an instance where it was not, but it was refactorable (patch 2)
> to make the array contiguous.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net/sched: act_api: use tcf_act_for_each_action
    https://git.kernel.org/netdev/net-next/c/3872347e0a16
  - [net-next,v2,2/4] net/sched: act_api: avoid non-contiguous action array
    https://git.kernel.org/netdev/net-next/c/a0e947c9ccff
  - [net-next,v2,3/4] net/sched: act_api: stop loop over ops array on NULL in tcf_action_init
    https://git.kernel.org/netdev/net-next/c/e09ac779f736
  - [net-next,v2,4/4] net/sched: act_api: use tcf_act_for_each_action in tcf_idr_insert_many
    https://git.kernel.org/netdev/net-next/c/f9bfc8eb1342

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



