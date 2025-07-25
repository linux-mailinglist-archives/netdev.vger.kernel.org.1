Return-Path: <netdev+bounces-210182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74124B1242F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941CA1CC29CA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DB2472AB;
	Fri, 25 Jul 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMa+0sD/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65B2417DE;
	Fri, 25 Jul 2025 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468795; cv=none; b=aFgPp7a7/cDO0QHkka7MXkjab/g3lweKP8Fdwy2+s0FhdSN1rvoIfNCkJ1xYqhk+4nphxttj8bkX+UX2IsuqxOWGbVEdheC7iXTzuL7Q6Kyaz7AEq/JOZVbDJ6kKFfDoFf1FKesi2jCEly9akAbjFJtR137RLt7zlNraJ7NI3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468795; c=relaxed/simple;
	bh=edIATgke8NGOyIpM94wZwgosXYqSaSxcFFOIOzilcck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f+eMsolk1QXx21vhG2hCQO3rR4/ZaT9i2oEut7oAz7HXnJ489KxXup/OFHh7Iv9bInmdDvP3DFoVAbn3FRy/WTM2PDNP268rbrvvfwPocqcptT0wWxIGt9/0X+6QHaZexx8JJ20nLJiQFkQ0lM7jv2CwFtaM/bVEwJjJpfTpq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMa+0sD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57D8C4CEE7;
	Fri, 25 Jul 2025 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753468794;
	bh=edIATgke8NGOyIpM94wZwgosXYqSaSxcFFOIOzilcck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rMa+0sD/aCuywy2NNQyUHVhLdVxJPPGgood/OKrrIkFq8aZpBgD96k+9O4IDn0e5e
	 j6pQXIx4RPxyxlrptoTTIsHtblq8ZKaYFbaTa1WN1RqJSdzm5H6XlOeJWbUlVA6Ooa
	 zfRp8YfpZwny2u0Vrd2T955NqpySKJCSyKj8aJps3mDmjuxNA8O68NADoU7fAE+fuz
	 IOaGqDzWMCYKnYiUcF/1fnKg2+gi8PSYNSgF7f7D2+x03Zin0WA+vye2eFEGNSy/HJ
	 RX6DKh4/+a9OZzOB23Jo16o8kgimHLKJzx+1CTmnI9O34g89Bh5CctHYcjg8NVlZSK
	 Zi7hsmKFGp9NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB9383BF5B;
	Fri, 25 Jul 2025 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mptcp: track more fallback cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346881226.3231025.5908283026020682892.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:40:12 +0000
References: 
 <20250723-net-next-mptcp-track-fallbacks-v1-0-a83cce08f2d5@kernel.org>
In-Reply-To: 
 <20250723-net-next-mptcp-track-fallbacks-v1-0-a83cce08f2d5@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 16:32:22 +0200 you wrote:
> This series has two patches linked to fallback to TCP:
> 
> - Patch 1: additional MIB counters for remaining error code paths around
>   fallback
> 
> - Patch 2: remove dedicated pr_debug() linked to fallback now that
>   everything should be covered by dedicated MIB counters.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] mptcp: track fallbacks accurately via mibs
    https://git.kernel.org/netdev/net-next/c/c65c2e3bae69
  - [net-next,2/2] mptcp: remove pr_fallback()
    https://git.kernel.org/netdev/net-next/c/829fec0244b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



