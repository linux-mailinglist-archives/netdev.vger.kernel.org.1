Return-Path: <netdev+bounces-32863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F579A9F9
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EB2281419
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8C125C9;
	Mon, 11 Sep 2023 15:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E05F51E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7270C433C7;
	Mon, 11 Sep 2023 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694447410;
	bh=RZzm4E4YvE2bOozyX9wws+URswMnykw6R3Mwj4h8OyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tEtIhdn1Q/Pcu0sw8n1pn+swYc6Kdg7vIEqE8UWnugihaAYgpVIADiSSGKuQIpcdr
	 Kzw5zDE8k5qWEk/quH6Pf2yqt/4jLTQVsaILSlLBhKHptAbW3mu2kRY6DNVYtAQJXb
	 mYfxshMyiVwSEZAbzizUknKAxCD1cK+oT95OuTa1Y8TTA+/tG/tnuD+LBoQH70mMVi
	 5+VuQvNm5oXIE+T5cCfZMUq0l38uJNtoZbSj6N2DHx3xFfuGtjtER9/C/dXbiqKjnI
	 bmr3r2Dmppq2xbfXGzBAed6ahElbKLXJHwnL79EHXN8n98pNPJcw8eC2XAOsNn/Xqd
	 wPLG7kHT7fDmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7C50C00446;
	Mon, 11 Sep 2023 15:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch iproute2-next v2 0/6] devlink: implement dump selector for
 devlink objects show commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169444741081.23759.6950166979935469469.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 15:50:10 +0000
References: <20230906111113.690815-1-jiri@resnulli.us>
In-Reply-To: <20230906111113.690815-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed,  6 Sep 2023 13:11:07 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> First 5 patches are preparations for the last one.
> 
> Motivation:
> 
> For SFs, one devlink instance per SF is created. There might be
> thousands of these on a single host. When a user needs to know port
> handle for specific SF, he needs to dump all devlink ports on the host
> which does not scale good.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/6] devlink: move DL_OPT_SB into required options
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=158215c53677
  - [iproute2-next,v2,2/6] devlink: make parsing of handle non-destructive to argv
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=5d9f42124ccd
  - [iproute2-next,v2,3/6] devlink: implement command line args dry parsing
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8eb894eda67d
  - [iproute2-next,v2,4/6] devlink: return -ENOENT if argument is missing
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fd1c2af8cbaa
  - [iproute2-next,v2,5/6] mnl_utils: introduce a helper to check if dump policy exists for command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=20b299a3ec35
  - [iproute2-next,v2,6/6] devlink: implement dump selector for devlink objects show commands
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=70faecdca8f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



