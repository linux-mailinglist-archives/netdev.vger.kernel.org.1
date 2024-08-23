Return-Path: <netdev+bounces-121195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8395C1C0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB49B24886
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F14381C6;
	Fri, 23 Aug 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUGfMoqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7D1E4A4
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371234; cv=none; b=mmTrFLwNa+W9AzDvD6/Bh49M1/6HAyc61wxb+WVSJlp2kYHejuRgsgtHbkzBbgSpbEUIm1Xa7F9BmxELfjS7uUpndW2VflElt6e5ngxrjizamNvb1xIO0cnCBOYUoXvLw3d+WQzD9t2Mhhb0qbMk1G3q+GIpmfFtJCDz81NSDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371234; c=relaxed/simple;
	bh=lHHp2ftv/6khzBROom1Ior5u9jGj5WVclYWp1zj38mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YdSdtu5Wpa+3tmBDNVD/5eAG7MhxLQ98SefeQGf3jlYb+veZOsa66OuQqA0MxtxbAPmwBT1/4kW1m+zPFAyme//aCYbfYcWyJ6JLeZVJ+50x63ajuTb6JHifnMgpQeKTdsXESJA/czmc9a7W97nOx8paCFHZWMq9BvUxDSlJ2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUGfMoqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B95C32782;
	Fri, 23 Aug 2024 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371233;
	bh=lHHp2ftv/6khzBROom1Ior5u9jGj5WVclYWp1zj38mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fUGfMoqZ/yYwktCNloUBf7Rwr6tjZKZ8vhtzy1wnMafEeYGcutyJSBPPOfI8Stk2U
	 TV/mH8Y1nrF9KT0SQWXcmPu/w3gH0jfF9YzPlGZz4Y6YKYQmjmzoOSVf8nLesuV2rh
	 cNFD2SkbBIcG/bie/qXNPgxOI/PSK1HtUK50zRLNeNhgYfpt617rAipGqWdvKoS+c2
	 iSVIov4kDYS6svDc1r7sOQQWyQIVtr6XEuZQQjapb8g08P4NzYQMzV8FRnQ8kATZqu
	 LbxNRCW5Nm8oZkMc2oWCI+pZPm/8G+Qd7puWdqcOVTx9luYgGazf0bMvKYFVTkcalI
	 twRZAMtPJrynA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD453809A81;
	Fri, 23 Aug 2024 00:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atlantic: Avoid warning about potential
 string truncation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172437123351.2508974.14515879032118431427.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 00:00:33 +0000
References: <20240821-atlantic-str-v1-1-fa2cfe38ca00@kernel.org>
In-Reply-To: <20240821-atlantic-str-v1-1-fa2cfe38ca00@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Aug 2024 16:58:57 +0100 you wrote:
> W=1 builds with GCC 14.2.0 warn that:
> 
> .../aq_ethtool.c:278:59: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 6 [-Wformat-truncation=]
>   278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
>       |                                                           ^~
> .../aq_ethtool.c:278:56: note: directive argument in the range [-2147483641, 254]
>   278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
>       |                                                        ^~~~~~~
> .../aq_ethtool.c:278:33: note: ‘snprintf’ output between 5 and 15 bytes into a destination of size 8
>   278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] net: atlantic: Avoid warning about potential string truncation
    https://git.kernel.org/netdev/net-next/c/5874e0c9f256

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



