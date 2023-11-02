Return-Path: <netdev+bounces-45644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52057DEC23
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710992819C8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B41FAD;
	Thu,  2 Nov 2023 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ745KI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6F1FA1
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 882F3C433C7;
	Thu,  2 Nov 2023 05:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698901824;
	bh=btXv2XdXDHf07gHDWV1UosurRtwPYUU9Op7QCwjxfMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sQ745KI646diJYp58MSHsqNyi15Hmkaj5csrM0jK80xh3u9wo5ly6tX0k5DzuaQBX
	 tVj6nn3ge3iRhoV+s8W8hq+ZX9fxKCAz00Pgn0Eg2UUzS1oiwCNNsT8ByWiF6EuX0E
	 nfL+dRRJXxU2KRT/Un9pw0JQGVDlZPYaupIDp/GWs7loDMj/OlNjHZGKDOEjWrOnHX
	 yfwztFN648ugiIKAZPE4jKBN+YQ+15BifXef41cNDVtAyc7BAc3/bziQLrL63agmVk
	 Lkog/vtxbWMQMHf9zxKSKmcrfuGZXqKoIsVS76ykLUSO9TIz2MbmGKpJ3UOCQurNnO
	 qn04+F3TRnerw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69947E00091;
	Thu,  2 Nov 2023 05:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: sched: Fill in missing MODULE_DESCRIPTIONs
 for net/sched
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890182442.20479.8661620012508684775.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:10:24 +0000
References: <20231027155045.46291-1-victor@mojatatu.com>
In-Reply-To: <20231027155045.46291-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, vinicius.gomes@intel.com, stephen@networkplumber.org,
 netdev@vger.kernel.org, kernel@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 08:50:42 -0700 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> 
> Fill in the missing MODULE_DESCRIPTIONs for net/sched
> 
> Victor Nogueira (3):
>   net: sched: Fill in MODULE_DESCRIPTION for act_gate
>   net: sched: Fill in missing MODULE_DESCRIPTION for classifiers
>   net: sched: Fill in missing MODULE_DESCRIPTION for qdiscs
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: sched: Fill in MODULE_DESCRIPTION for act_gate
    https://git.kernel.org/netdev/net/c/49b02a19c23a
  - [net-next,2/3] net: sched: Fill in missing MODULE_DESCRIPTION for classifiers
    https://git.kernel.org/netdev/net/c/a9c92771fa23
  - [net-next,3/3] net: sched: Fill in missing MODULE_DESCRIPTION for qdiscs
    https://git.kernel.org/netdev/net/c/f96118c5d86f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



