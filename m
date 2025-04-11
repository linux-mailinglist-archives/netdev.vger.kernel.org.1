Return-Path: <netdev+bounces-181483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FAA85208
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406058C3F97
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180427CB01;
	Fri, 11 Apr 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leQue0dp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FA27C87B
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342200; cv=none; b=NavPuaQsw09LE6hRuKpMEg/PZxmHwiseNWUYQmBv97UJOZnGs4a+wSGJe5pu6uEmkeVmrRluKSUIUmsKFPDQio3pnX74hDyuYd2eoXQYUHjmNslTPiogresb4QtWRghqznB/O2pencck88rGS9KTLaKvslavuSlAGBBY8WLdQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342200; c=relaxed/simple;
	bh=mUL2z/EIZiZq8JKPIuXjz9JurKt+uudGsHYKwpnvE4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJz0ik1HdMmvLggSjEbx0kDIvkWpyyQcGQdsTPAmZB3zNWqFtg1JIZKUqzqmUwwTUPgR5L3jZkhz3KiKK1F9IF5/f0941h0AgYNPa4XSFh1W/aUVdLMNlbTh79MY9PeuOxjwlvbAXQCk9pD1U1E06jY7XH71r6DsVqhHrRxgCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leQue0dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62019C4CEE5;
	Fri, 11 Apr 2025 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744342199;
	bh=mUL2z/EIZiZq8JKPIuXjz9JurKt+uudGsHYKwpnvE4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=leQue0dpBjoaL+5MaWRmaAShuNkkk1QSHsKwcCzpdA+kuMmC62AQUT9l4iyaMGOuM
	 +StM8982nXMNGB3G8gkJUmLxfDn4T2EJiYtjUbtLRGjOnW21NlCRCDgdvadmO065qU
	 42IEuTeq2ZSkRX/yhxFAUYZOnPc0ffrQqyLifCxEvI6okdq7ILzgPyo5SUpB7GvVTL
	 A2nABpSwBpsmhNIqzwLQojsfz7WWrCYYoW/5KP8olQ/FNUi9X/ph9vLmaLSlrOMWbI
	 jmSt+7hRFtn2OqBQCCPGgbB6OnRTBuiTDjbiwJUmzzRqvABU+N/bMaPjcgsXi1xndB
	 0jP6LEafu1Ghg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B86380CEF4;
	Fri, 11 Apr 2025 03:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: remove unnecessary judgment in
 ip_route_output_key_hash_rcu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174434223675.3945310.4555224487531250688.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 03:30:36 +0000
References: <20250409033321.108244-1-shaozhengchao@163.com>
In-Reply-To: <20250409033321.108244-1-shaozhengchao@163.com>
To: shaozhengchao <shaozhengchao@163.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 11:33:21 +0800 you wrote:
> From: Zhengchao Shao <shaozhengchao@163.com>
> 
> In the ip_route_output_key_cash_rcu function, the input fl4 member saddr is
> first checked to be non-zero before entering multicast, broadcast and
> arbitrary IP address checks. However, the fact that the IP address is not
> 0 has already ruled out the possibility of any address, so remove
> unnecessary judgment.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: remove unnecessary judgment in ip_route_output_key_hash_rcu
    https://git.kernel.org/netdev/net-next/c/3b4f78f9ad29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



