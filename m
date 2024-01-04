Return-Path: <netdev+bounces-61439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0F823AEC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 04:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FF02880F8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765BC4C9B;
	Thu,  4 Jan 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9wqIaM2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F318C31
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 03:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCC1BC433C7;
	Thu,  4 Jan 2024 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704337226;
	bh=bjz6EH1Kbr6qaXLlBS8t6r8Qt32XQTVaueZRtyrCYsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m9wqIaM2KhbnbZ2b6Ix3glK3QmZndnWFAQ0R8xzbv+wLBGhHwmwf697ij9MIuarlZ
	 J7qQsOOcgbUWZOqgyIch27W8HAyNBCzKn1luXt2tNkcxD8tavW3gnHWNeDThJUrFFM
	 FGo1fjY6isP0i3PQ9SoDHHxI2jzP0nroHn6+JpeZ3ed1K11sEZthmGBbgtByY5fNKZ
	 WEyNYYuUgs5FNGKHGTKzDJw+y/CMLBgcAcI+EtEGjuLJL7d5ErzoI6QFelY9XyJBKP
	 N0ZnHC9wdO/lOLlaXKM9cfqRREpIcfixsx9XchsWCMHLO7eDwk8AV1HBC9QdeRjBHa
	 IhSOeOZYvewLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2920C395C5;
	Thu,  4 Jan 2024 03:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: introduce ACT_P_BOUND return code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433722679.32402.3817084374119869620.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 03:00:26 +0000
References: <20231229132642.1489088-1-pctammela@mojatatu.com>
In-Reply-To: <20231229132642.1489088-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Dec 2023 10:26:41 -0300 you wrote:
> Bound actions always return '0' and as of today we rely on '0'
> being returned in order to properly skip bound actions in
> tcf_idr_insert_many. In order to further improve maintainability,
> introduce the ACT_P_BOUND return code.
> 
> Actions are updated to return 'ACT_P_BOUND' instead of plain '0'.
> tcf_idr_insert_many is then updated to check for 'ACT_P_BOUND'.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: introduce ACT_P_BOUND return code
    https://git.kernel.org/netdev/net-next/c/c2a67de9bb54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



