Return-Path: <netdev+bounces-94326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA888BF313
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4675B24E70
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AF1327F9;
	Tue,  7 May 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7SekkNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71885C70
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125230; cv=none; b=JDWtzlujKH0I6JbEuirMElyAlUQVzKQCg4uM/4zKCqMPy+vEi16jix3VYnbXWKVUoulbbcpl/c9UTif8nHVWLAAz/W9QPMzGNi4yEJLEWk+qsncLI4U/AHU1DoXLNu8KhGb8OwzMOztJt+5VUBkhWjVItD2/rxT1hP161xX5HBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125230; c=relaxed/simple;
	bh=anQZsnoLQZx+H9iYdFe9qKQUJ3YMUkXTRd3HlYSQJqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SPrHv3X8E2LBq4HUIToLzLQD0hLWdDq0mQXegJ/OsRFzw8L5L/G7V7njFlraS2KJcisDcxy/aNgzRyECu8phAkZx/g+NEi9E0oj/KzNsijo7wphb5QsI6d839Pj+Ez11dXQhIwmc4AEzIUWEE55hkd6yyVnqmTv24Z5MsLf1KR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7SekkNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17DC2C4DDE0;
	Tue,  7 May 2024 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125230;
	bh=anQZsnoLQZx+H9iYdFe9qKQUJ3YMUkXTRd3HlYSQJqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7SekkNlyLRpC6QLpoo5Fvv1qSsEeXgl2hBCc9uM45V7Wc7+uvvAmrIEhsQiJ1SWD
	 Q9vx5/jw46q85F2706Z9e7U/6NrThVgKumKkPD+Lg84NC+NQJ5FVJxBYDxMHHNO+VH
	 FUKjC6twen3QwvEejpEA3eM3iSASyByEtmX7hXNijZZxpoLIuZLz/wqxZSs44kxYfM
	 gTTuRnBLODUpvI8z1lr8rd/Ect7BG5beMuxlPI1wsrAzDVIESRhlUiwcg7dYFUlFxj
	 o8uJGOhfU4IXwAfXVMyWY126hu7B+ADyyfizOzqvfkIjCVhFGJauKIp2aVAguR7INE
	 zV98a+VZ8Qf7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 012C8C43619;
	Tue,  7 May 2024 23:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: annotate writes on dev->mtu from
 ndo_change_mtu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512522999.22016.3007207524141493167.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 23:40:29 +0000
References: <20240506102812.3025432-1-edumazet@google.com>
In-Reply-To: <20240506102812.3025432-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 May 2024 10:28:12 +0000 you wrote:
> Simon reported that ndo_change_mtu() methods were never
> updated to use WRITE_ONCE(dev->mtu, new_mtu) as hinted
> in commit 501a90c94510 ("inet: protect against too small
> mtu values.")
> 
> We read dev->mtu without holding RTNL in many places,
> with READ_ONCE() annotations.
> 
> [...]

Here is the summary with links:
  - [net-next] net: annotate writes on dev->mtu from ndo_change_mtu()
    https://git.kernel.org/netdev/net-next/c/1eb2cded45b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



