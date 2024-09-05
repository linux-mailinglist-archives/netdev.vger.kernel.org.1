Return-Path: <netdev+bounces-125306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7896CB83
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E0E281F37
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF727735;
	Thu,  5 Sep 2024 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA6bIPLX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B71DFD8
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494442; cv=none; b=W0iGGxe83Fb3ldnouXynh/VsRQhSUScJ9EpS9hTGRz1/rOB0NrH+q2BeqcGmWLeq55UhpX2Imj7tS8L5Nywyg9oz2wWNzfzpow1CSAUDcdW1w5a3Y1KxIXQsFylO0aRgpF/7X+Q0zi27Ld7nk27q0lcxUr3RKDLyVrwqIlpquAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494442; c=relaxed/simple;
	bh=viL/wCZRUGidZoDbcQrT4vSq+P7nRgHYSyNQ0ZuM1Ck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QOn0QcTkcw3a3dOmZdp1rHgMqhPkMN5XBWUeDz56v91N56g+8hwt+pmGRFtMY/Wf0kqewrz15/NjfjAflzQ0iofzKewaeZv9I6QgUpEpCgPhYe9+blPP9lZcWqqekVPF/ePfTPi0LLrlDZc+02j9n2t6eaO7XpP48EywNu3dPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA6bIPLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBDFC4AF0B;
	Thu,  5 Sep 2024 00:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725494442;
	bh=viL/wCZRUGidZoDbcQrT4vSq+P7nRgHYSyNQ0ZuM1Ck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UA6bIPLXPLbxyUbIUpD3o0OdWAV1sd9JVK7yQDTlLnIIepfAn9XCRC/pyvEXfOvHf
	 TiFvwr/7vL43ODK4zrcE8kBVAcu+Q2+GV6dyYOfXy84FETP2lkS5BmGlnTuSEctwm2
	 4POZZLoLiNjQavFgwN1Pj5KYnXF6MebSMRUrbPmYWiuWkQ2S8Cuue9VTMnhRw5MIAk
	 bIlKOpaDj7XDEW2b6zImvztPyWbOTpFr4aXp9hyNPGYjy4Aym1B0AEbJKbshFMlJ19
	 Iqaj3H70K98xglzuortZuvp9iu2EBNVpnQ3+bBQom/g25wkfRZ3nYNJ+RsaJG0+jb3
	 hwbDJdMa+4TDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCCE3822D30;
	Thu,  5 Sep 2024 00:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: Fix user space build failure due to header
 change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549444349.1204284.10048717463562007415.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:00:43 +0000
References: <20240903133554.2807343-1-idosch@nvidia.com>
In-Reply-To: <20240903133554.2807343-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, gnault@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Sep 2024 16:35:54 +0300 you wrote:
> RT_TOS() from include/uapi/linux/in_route.h is defined using
> IPTOS_TOS_MASK from include/uapi/linux/ip.h. This is problematic for
> files such as include/net/ip_fib.h that want to use RT_TOS() as without
> including both header files kernel compilation fails:
> 
> In file included from ./include/net/ip_fib.h:25,
>                  from ./include/net/route.h:27,
>                  from ./include/net/lwtunnel.h:9,
>                  from net/core/dst.c:24:
> ./include/net/ip_fib.h: In function ‘fib_dscp_masked_match’:
> ./include/uapi/linux/in_route.h:31:32: error: ‘IPTOS_TOS_MASK’ undeclared (first use in this function)
>    31 | #define RT_TOS(tos)     ((tos)&IPTOS_TOS_MASK)
>       |                                ^~~~~~~~~~~~~~
> ./include/net/ip_fib.h:440:45: note: in expansion of macro ‘RT_TOS’
>   440 |         return dscp == inet_dsfield_to_dscp(RT_TOS(fl4->flowi4_tos));
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: Fix user space build failure due to header change
    https://git.kernel.org/netdev/net-next/c/1083d733eb26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



