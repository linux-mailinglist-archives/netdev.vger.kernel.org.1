Return-Path: <netdev+bounces-234212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 554FBC1DE3E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB2F14E4C51
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A561D88D7;
	Thu, 30 Oct 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYm9ecyu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782421D6193;
	Thu, 30 Oct 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783629; cv=none; b=MTI5Mu4gpLdSJralxyyUpBJUVDY5ehVSwmpYGzu1I9jAvrz5UM7ceZaoZLORnpO39ttYidlIBer2D5EinsW0x+mTaYhqVk1I8WENIYlu8a5ulTCWs5FnBuH5sZs7PsbNivRouKYRl/SOVD42QK6P8PXUI6p2xF7kjUDAaTbJmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783629; c=relaxed/simple;
	bh=YA1yfnRZ2liXKqTDZAOmA5Hts9femG+bdpmh9Kr9slg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgMlMnJkpG3qzWO9BXSFJgypOM1JnYv+bntoyfiyYb6sLFwZvnqUWq7v+s9Ve7Wpl55ScZKbywO39S874+JDgq030oh2eBb+8EcBdX93D7q/tJ7Z585ZZVM73N/I18EP/b0ZWPyiVi+Jc2MAVkhE/JujgPD//uq6yKBjrapOoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYm9ecyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EEDC4CEF7;
	Thu, 30 Oct 2025 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761783629;
	bh=YA1yfnRZ2liXKqTDZAOmA5Hts9femG+bdpmh9Kr9slg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYm9ecyuJjBZeWy4Vf0gDyme7aEhCI5k2chRXpPL6rdxc/u+GtbhwO7OdIHoFnhv7
	 9ZyJSx6y7bcz3VeopCpqRbeKQYIaOcUqMtgcQKYAzU1IuZgjK4Mc0BOliPu0P5aaUt
	 NsrWEdMva2J3QeDDmSpexQgNvDGKrDWxzeLUtLdWo/KsYotafShyAvRxJUr++eJz2/
	 AjtmIxvTgzo//yysBRhyNWws5OVMphfrWQ1qjwDhXIq8oY17wkDwtQZEKj93QzgTv9
	 y2KDSeCX9TaRspnszfjWY6m1S4D0VOLhwI+Jk5MBceH+Q8ZteOipaMB5Rini9P9vmV
	 RpQvA2660RrvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DCA3A55EC7;
	Thu, 30 Oct 2025 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ipv4: Remove extern
 udp_v4_early_demux()/tcp_v4_early_demux() in .c files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178360601.3260110.840499294229416804.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:20:06 +0000
References: <20251025092637.1020960-1-wangliang74@huawei.com>
In-Reply-To: <20251025092637.1020960-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 25 Oct 2025 17:26:37 +0800 you wrote:
> Function udp_v4_early_demux() was already declared in 'include/net/udp.h',
> no need to keep the extern in 'ip_input.c', which may produce the
> following checkpatch warning:
> 
>   WARNING: externs should be avoided in .c files
>   #45: FILE: net/ipv4/ip_input.c:322:
>   +enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb);
> 
> [...]

Here is the summary with links:
  - [net-next] net: ipv4: Remove extern udp_v4_early_demux()/tcp_v4_early_demux() in .c files
    https://git.kernel.org/netdev/net-next/c/f58abec23da5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



