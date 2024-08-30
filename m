Return-Path: <netdev+bounces-123796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5BE9668D0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9229D1C21F69
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98391BBBF7;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIQIFIcz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D241BB6B9;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042028; cv=none; b=rGq3sbA3GvXKnenIEEXE0nrdQDRR2qkRemnhtRLfNMg+SWvFjFFycm+z+0AW7wpk0h9x+rttoWr8v1DesTvVy19FfTmT4PxTGNWhKsHHJjMjzH5FIE2HVH8JIEhcFHrayXSuJJ290HEYD6arCio5piXjdXp76k99BkNA/iNPCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042028; c=relaxed/simple;
	bh=S4LhiCjxkTqDlJJT4aBKOZgqogADuYYzlY2ieWc9NxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gDANFWMIE46iKofeQg+4yr0KTYrHwQOv14by5ypsJ//UA9Ku5r+nYFMx1laI0iz02071LVKuJp1XDaQImfz3nA1EaWOvGPGd8XOb79i6JDfECG1NOBEnTr5em+wQGim67PJeKW/xybppx4Gw6r4fmMPskWjyNVGlRWPfsMa/pYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIQIFIcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270FEC4CEC4;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042028;
	bh=S4LhiCjxkTqDlJJT4aBKOZgqogADuYYzlY2ieWc9NxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hIQIFIczRy28YS2NnkAS7CLHqYpYLZ8NYUe5rMb3f1KHtEvUUtzOBBQakyhyFihzP
	 4Nm137rlfseaf/Al1fFbP2GzSmOF5eMuRYtcrDiVIpqjev+3TnPpziJlpaIM2CA6HN
	 l9+qlzN/KDFCxvP2xvxQc8NtVOd0ha9BeSlY5f4+XbmvlY2xXbX+uuNdYzqRvBQeDv
	 THCgiPwrBukpjcnJ1+p0szqLFvHWbRz1bqyjXLgnDi1UktQtim3kfhT/scI0raMbbs
	 vcPcYcOrZO/k0Pu/PF0qbRoAf7hXAjbyYsFaQy//L03m0xuc+oCgPkisS95eBzsBep
	 zFWnERoLyb5Ww==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA86E3809A82;
	Fri, 30 Aug 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: openvswitch: Use ERR_CAST() to return
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172504202975.2677701.2567446210822369558.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 18:20:29 +0000
References: <20240829095509.3151987-1-yanzhen@vivo.com>
In-Reply-To: <20240829095509.3151987-1-yanzhen@vivo.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: edumazet@google.com, pshelar@ovn.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Aug 2024 17:55:09 +0800 you wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  net/openvswitch/flow_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1,net-next] net: openvswitch: Use ERR_CAST() to return
    https://git.kernel.org/netdev/net-next/c/b26b64493343

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



