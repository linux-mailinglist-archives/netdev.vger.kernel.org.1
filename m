Return-Path: <netdev+bounces-131831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A0098FAB2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B91C21B94
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF301D095B;
	Thu,  3 Oct 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrqKnl84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7121D094C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998834; cv=none; b=dqdHHp5k/h4HstL2sa6D5lmBRyNF/hLVuhJtUbUGoNnDH6w89jyvqBjFLkAmwuXgknx8286yIySC3mMSn4tt2PMG0M2Dlq8zaYlPFJVepUV3Tm+GIjUXMLNk82jKFit7LPrtYX3w2NBx3cW7runMH2efcLMug0xSOQk1o5BU4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998834; c=relaxed/simple;
	bh=yP0YKiEuXiQkpmqXZnAt61c5ubE4B4tOk3mGBo/o6QU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DVDEh4ifcifTSVfxE3kyjXDuDJV7wl0uqsALS1Q5CJsvCloCMQ47ACxMvJrGXJQY5AiX+s6XGYrn0jIDU9OXZ/7cyJcbsVjizyJxd+DauK1jTJ57PEh/vwwp6GaoYGz6FhiJwzOmD6LFYUSYkW5wuHEDpCOEngHqdJ+7nKUOBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrqKnl84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02923C4CEC5;
	Thu,  3 Oct 2024 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727998834;
	bh=yP0YKiEuXiQkpmqXZnAt61c5ubE4B4tOk3mGBo/o6QU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qrqKnl84/IA2xFDrVAuPmY0q5E67+KMbEBGp390OjW2w2DsP7W6gWGFG4heghs6wR
	 Jsw8Th6n0qpcF0DMXraq8j5hMMp/TZl/rah9v+196Ibiglu6a/g8JNw57P7mBWOg3S
	 TFsU1KHFOxIB4puFqgxqMSIAw6rNOeTNDN+LTU3WS0GZJtZJfYl48qumdo4xpnrZXK
	 etROy8fq+U0L97O9yMxmeKY5OvVGxhr3cupScqwN0Gof8wsgrg+b2Yu7OUEmQ+pKPA
	 gf0B+/KeKkOrZmg8qBcee/RX84+Gr6WFRdKxILjVOCj+skDSsMtKQ9Nta0FStsQdgO
	 bBgULbQxmVd7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE083803263;
	Thu,  3 Oct 2024 23:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] ipv4: Convert ip_route_input_slow() and its
 callers to dscp_t.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799883723.2030473.10817559036506157791.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:40:37 +0000
References: <cover.1727807926.git.gnault@redhat.com>
In-Reply-To: <cover.1727807926.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Oct 2024 21:28:30 +0200 you wrote:
> Prepare ip_route_input_slow() and its call chain to future conversion
> of ->flowi4_tos.
> 
> The ->flowi4_tos field of "struct flowi4" is used in many different
> places, which makes it hard to convert it from __u8 to dscp_t.
> 
> In order to avoid a big patch updating all its users at once, this
> patch series gradually converts some users to dscp_t. Those users now
> set ->flowi4_tos from a dscp_t variable that is converted to __u8 using
> inet_dscp_to_dsfield().
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ipv4: Convert icmp_route_lookup() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/913c83a610bb
  - [net-next,2/5] ipv4: Convert ip_route_input() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/7e863e5db618
  - [net-next,3/5] ipv4: Convert ip_route_input_noref() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/66fb6386d358
  - [net-next,4/5] ipv4: Convert ip_route_input_rcu() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/be612f5e99e1
  - [net-next,5/5] ipv4: Convert ip_route_input_slow() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/783946aa0358

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



