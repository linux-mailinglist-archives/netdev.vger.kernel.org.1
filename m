Return-Path: <netdev+bounces-44333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787357D7910
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C87B281D74
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CA3196;
	Thu, 26 Oct 2023 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdU3tOQw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED627163
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64E30C433C9;
	Thu, 26 Oct 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698279024;
	bh=JS8i/2sc2zs+UZXDO+CAHE2mWcERQZZtKZyVDDf9uo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kdU3tOQw/EbJhidwrAQDQwEE8D7HBwIeV/63MtCsL0/L4aSxvS1sKmsxdHZIpqmTA
	 FC3fIIJAziPkRO50mHOGR3ocrzjtllhRVi26nETDFbyvvYjnU6g8gpFwpQ7RzhMkPs
	 q5Va9z9ITR1noN0OXWq8ZcgB3Eh0jaEF+ZHs+8PM2H+1xjMmZOEWpISGf676fDk0wR
	 7nqlPlfPTb4ulyZSSYdUolNGe3SV/GHyw3Fx3yLS83vMerzdoMQMxmNvU8NremWTLw
	 vRUtQ3Mr+zoJuZVe3BBeoY6D+rGxkbXZ7TGd1GgAHAL+SGRffME8x2LaE17jKZM2kw
	 CugWPH/xYluTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4777BE4CC0F;
	Thu, 26 Oct 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 iproute2-next 0/3] Add support to set privileged qkey
 parameter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169827902428.6163.13738163996032599729.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 00:10:24 +0000
References: <20231025123102.27784-1-phaddad@nvidia.com>
In-Reply-To: <20231025123102.27784-1-phaddad@nvidia.com>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: jgg@ziepe.ca, leon@kernel.org, dsahern@gmail.com,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, huangjunxian6@hisilicon.com,
 michaelgur@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 25 Oct 2023 15:30:59 +0300 you wrote:
> This patchset adds support to enable or disable privileged QKEY.
> When enabled, non-privileged users will be allowed to specify a controlled QKEY.
> The corresponding kernel commit is 36ce80759f8c
> ("RDMA/core: Add support to set privileged qkey parameter")
> 
> All the information regarding the added parameter and its usage are included
> in the commits below and the edited man page.
> 
> [...]

Here is the summary with links:
  - [v3,iproute2-next,1/3] rdma: update uapi headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=bbcebb2ea76b
  - [v3,iproute2-next,2/3] rdma: Add an option to set privileged QKEY parameter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=21180a7ac40a
  - [v3,iproute2-next,3/3] rdma: Adjust man page for rdma system set privileged-qkey command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ecea0c2a7bba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



