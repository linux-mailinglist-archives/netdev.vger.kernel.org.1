Return-Path: <netdev+bounces-13630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A9573C4ED
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 01:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723FE281E2E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947486FD3;
	Fri, 23 Jun 2023 23:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08A6FD0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 23:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E376EC433C0;
	Fri, 23 Jun 2023 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687564219;
	bh=Y3bxkp5SbGztYo+DA97inEbwJ5wiO6xnII5XqYNbLA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z6ZY3cLgoeFWol9ToU5WqrssIX5nNJRCvONVYP0A9ynn6l1YhO9T8kp9zjMy5CqYd
	 S/zyY/P6VZth74TmN2uVsFxRslP9irbL8WyRbp1chc2F3WRWLKcw2sWcCXg7sOlNB9
	 pSdUYzoIoADNrN012MckCKtC/7w7kQBYIWU4UPeK8sXtl4tXeoXVrfxJxTDXb3Jf72
	 u/0igCmI+TiIURrqlZ8SGMjV4AO+Ulbdc6Cl6aPImdpcX8xR5iNF+J7RSFRkgxF8DS
	 hLn7HM2x3b+E8B9oh/BqXoC+v+vttBGrUYQPHT0aKOgXNnmzpv6OX9v8V+QYx3K7Ap
	 cMI7rRJlGo70g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC3D4C395D9;
	Fri, 23 Jun 2023 23:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3] f_flower: add cfm support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168756421976.20790.10672968376612738306.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 23:50:19 +0000
References: <20230621205545.63760-1-zahari.doychev@linux.com>
In-Reply-To: <20230621205545.63760-1-zahari.doychev@linux.com>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 hmehrtens@maxlinear.com, aleksander.lobakin@intel.com,
 simon.horman@corigine.com, idosch@idosch.org, zdoychev@maxlinear.com,
 idosch@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 21 Jun 2023 22:55:45 +0200 you wrote:
> From: Zahari Doychev <zdoychev@maxlinear.com>
> 
> Add support for matching on CFM Maintenance Domain level and opcode.
> 
>   # tc filter add dev ens6 ingress pref 1 proto cfm \
>        flower cfm op 1 mdl 5 action ok
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] f_flower: add cfm support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=5295b8f38e31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



