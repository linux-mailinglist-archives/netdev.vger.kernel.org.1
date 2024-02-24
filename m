Return-Path: <netdev+bounces-74658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0948862237
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F5F1C21386
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32362DF6C;
	Sat, 24 Feb 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsAWgHMx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC21DF5A
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740630; cv=none; b=SnbLocKwvHVLo+malQfDCEPVNXeGMrjeNJWInUw/szbmTRWYjOZqym2t/GqK+i2kPzYDKfkmsCrpQS70MR0YeQzF+0ReLPJveDKgzT9ETh0/uiEAzs4xYGcNlQWq93UOjVlhuhzQ8AoMcBYWBmF2oi1smBIL1j8Vtwt8c0dZq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740630; c=relaxed/simple;
	bh=mNd6LiJc+gWKzbkETPpDWP7u+nyxQA6O2vnjJxwqMug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=snew+NJrZr1LkjiENE0nrihLMhTUPbKOk51y3WP+/uq2xuwfHFL+vHaFOsBBTyrhs79a9lbLs+T8hTZQj2YevEQ6BwHNMYiTDRZ7qF3g1w2hm8YTp1Qs6n6FXu98WexRoym3CrKUOzgScmNJrQOWGUc3udClGKFa5fqGf2u7ysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsAWgHMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E589C433F1;
	Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708740629;
	bh=mNd6LiJc+gWKzbkETPpDWP7u+nyxQA6O2vnjJxwqMug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qsAWgHMxxTKDU12hvIYREgxlitAuSq1yDzklrhHCpEXm6WMBG6JC3RE1N6B/4tydy
	 vyTzocVjrL3ezIRa0XT8iM9uiJxVIaJYWLFu5Oq4XLMi7ox5kb/uYyKy6at+ez4TKf
	 fHSrMojcvthrQaUaK8aIP50gqOgZKW5WLbmrA7MzOpbSpYOBgWNn/penvrKLJFPFht
	 tOD8DduJhAv1WvN8CZtJKR0Q4xJeL1978E7stIP68AVx9yDun9Lc5nOy5qQ6LYAqMb
	 dtpR+3KTqEix6nFb/BtMHU8jqlok1bkPl4RXJsE371hv0C6pygi6ugRPLFAks5YDXm
	 3JraAxYcQBiVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A7C0C39563;
	Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mpls: error out if inner headers are not set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170874062935.5601.1311290697565705511.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 02:10:29 +0000
References: <20240222140321.14080-1-fw@strlen.de>
In-Reply-To: <20240222140321.14080-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Feb 2024 15:03:10 +0100 you wrote:
> mpls_gso_segment() assumes skb_inner_network_header() returns
> a valid result:
> 
>   mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
>   if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
>         goto out;
>   if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mpls: error out if inner headers are not set
    https://git.kernel.org/netdev/net-next/c/025f8ad20f2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



