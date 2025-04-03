Return-Path: <netdev+bounces-179209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3BA7B221
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D765189B86B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFAC1C84AB;
	Thu,  3 Apr 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmJoPO28"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD02E62BA
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743720599; cv=none; b=NR2dTRaxYl6zb5NXyY2HrMnvx9QZpDlz2j1DfXbwZQZ16yZ5QDu6tLKbuq+igX37HoZsNkRZ3DRAbyLp63WYMsEgy46w0ukFuJqXdBoR3pY/nbJIuGtftXe3mygtAOUwDP9v2PMR3/M17nyf/Cmrj9Y1UBS03hkTx6FCmu1NV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743720599; c=relaxed/simple;
	bh=8Kg/t2RqkZte6lOZ5o3u94WA0oTskjj8aJjrgnHYWv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j5ZW5rEpqQpRoaKtYV+6qFs56USIuPvDMsfg+zoMoJkoHUcLqWZaFqtjwaEhHT5pc9lFBJFxmsmKzydKJHP/E/4HRmoG6yj/R/ylEWoi1Z+ty9Whkn5OsEmPsIC7my4QYaOlOHA7UDUzYHJSGhdBb/tLHnzdguKcC83fe1HIufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmJoPO28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD26C4CEE8;
	Thu,  3 Apr 2025 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743720597;
	bh=8Kg/t2RqkZte6lOZ5o3u94WA0oTskjj8aJjrgnHYWv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YmJoPO28sntJNdov6hfpPioOgUIChFYyaNcVAq5XQ1Ea/Qt2bDEShy6y4VWAXObcx
	 1zb2T1wNHVMALD/WjoNyfIn0mxJ4nENsdncxzdFJgshnDefBscSqRPQqgwamy+4toW
	 nvsS3QHInywPZcMR3PX2q1BdB5ocWlgLxz/tM5Q2pBJCPe8BsSyZ/TizQKpnXwK+y4
	 wtijEf1pqC6K5D/LgTd2I4mM9n8GM6OBWhtH1wKauYmuPJw4MWvlJ2x5Vs2WUV+B8a
	 gkKNCMo6r1NJWxea4Amgv3ZggxvTwkTJsAOJ7DlDpRTaYI6oyBqiHCZc3KKu2xJfM/
	 1658t8SJrAFYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0455380664C;
	Thu,  3 Apr 2025 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174372063424.2709734.9248725253121002171.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:50:34 +0000
References: <20250401-airoha-validate-egress-gdm-port-v4-1-c7315d33ce10@kernel.org>
In-Reply-To: <20250401-airoha-validate-egress-gdm-port-v4-1-c7315d33ce10@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Apr 2025 11:42:30 +0200 you wrote:
> Dev pointer in airoha_ppe_foe_entry_prepare routine is not strictly
> a device allocated by airoha_eth driver since it is an egress device
> and the flowtable can contain even wlan, pppoe or vlan devices. E.g:
> 
> flowtable ft {
>         hook ingress priority filter
>         devices = { eth1, lan1, lan2, lan3, lan4, wlan0 }
>         flags offload                               ^
>                                                     |
>                      "not allocated by airoha_eth" --
> }
> 
> [...]

Here is the summary with links:
  - [net,v4] net: airoha: Validate egress gdm port in airoha_ppe_foe_entry_prepare()
    https://git.kernel.org/netdev/net/c/09bccf56db36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



