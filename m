Return-Path: <netdev+bounces-69109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EBF849A96
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F5728197C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F01C6BB;
	Mon,  5 Feb 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niwUh8fS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89241C6A1
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136830; cv=none; b=ReQqTgq5TgKYbYaTudsXQSCeNnAceM/nbjzoZ8YKwN0nj1+R8fI1csq3jU1gYjzLwG//U4krkJoP42uZw7f8CTFxQ+FlSvjBW871Q5RoluK83Vlx0nPJR5d/RPWlvYjnu8fejEIYdZtDOtzgd90JJ+I3uCLPv3cgebzA4Sk4DFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136830; c=relaxed/simple;
	bh=2XJfc4CHFGcfxniY/WYEhLsiPHmep03l6eTFo0vtgdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TH1wBjrLTriSB6qwb7lEvcO4rUJf9arg8W8I7Pv2drb7AhlPFxpwRZcZQw8qD3MDdDUdfnYnESIIsc4yD8Q+FfqcpwkVOw8Aj4z5qJ30e2/xTNpjaR9ZAm5xgmcOfyFcO0ES5OcDqzHIKGqYpMhZp6EvPcOBAQzkrg/Zf8XQnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niwUh8fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56395C433F1;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136830;
	bh=2XJfc4CHFGcfxniY/WYEhLsiPHmep03l6eTFo0vtgdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=niwUh8fSH5qONKgdgtaQdENL0z4/M54LQgQdTNM1w0TsD9msOQQTJWiktkzYc4dEl
	 vkvNQjs5s40nbyfor9SshLF4tQOpXJdbaN6yqBWmCf78eX0OIwE4UuzWRMmaXNo4q2
	 vvUSvNjunwJDTGXK4l1k5//MDmu92fapq2Yoj4iebWrQhw5JBAP6YdyVwlmz8SdHPz
	 zlKFi97fO/+gW8LffIuxE+Mejews3x5IWGR4mrfoMXK4O6SulJ2jw3MYir7xcoh9MK
	 l2E1OKexZj/rOYItmxaHVmdRaVWnZt97UckH/R8n3Tr9dd4kzkfuM3NHPLPIJR4DO9
	 a7/uiUa3MsN7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3517BE2F2F9;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Fixups for qca8k ds->user_mii_bus cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713683021.8022.6745560385177796412.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 12:40:30 +0000
References: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 alsi@bang-olufsen.dk, ansuelsmth@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 18:36:24 +0200 you wrote:
> The series "ds->user_mii_bus cleanup (part 1)" from the last development
> cycle:
> https://patchwork.kernel.org/project/netdevbpf/cover/20240104140037.374166-1-vladimir.oltean@nxp.com/
> 
> had some review comments I didn't have the time to address at the time.
> One from Alvin and one from Luiz. They can reasonably be treated as
> improvements for v6.9.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: qca8k: put MDIO controller OF node if unavailable
    https://git.kernel.org/netdev/net-next/c/08932323ccf7
  - [net-next,2/2] net: dsa: qca8k: consistently use "ret" rather than "err" for error codes
    https://git.kernel.org/netdev/net-next/c/709776ea8562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



