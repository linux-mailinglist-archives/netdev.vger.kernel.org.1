Return-Path: <netdev+bounces-207059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28808B057A4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB19168DA5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB842D6402;
	Tue, 15 Jul 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNlPbPE/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39589275873
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574795; cv=none; b=bGhllLtqGFgdVtQhRjBEHWV7wpzmO7RKZrRPeg5lpC7oTjwxJhgTU8KR150koOFE5I4rfy37uhJUoq89K6+CKZLrN8YRJEWzawIaDNTngjjOE0HvMKThc05Ian56zHjzj58U2asMDkN1VaWTAiErdEPlKxrkYNDIvHs+rbeivMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574795; c=relaxed/simple;
	bh=BNKxjY/W7+prDJejNl+rrxKqZXwSei0aj4Vkuz4lVsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oBM4++t9JAOh86E7vzVh4LMMcPZwGMa5qW6j5sBgTi4n4mLkv+/1p+5wfoF+EBGy8ibz0KVQdQgqV35dySG4nRCn6IZxvtOb035XKl/0Qt8YM2B+GvVqO7oA9y9glfDd3kUnqByP+m906zAFWETuu6ebrX6LMvIq7kcVFQbaVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNlPbPE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453AC4CEF1;
	Tue, 15 Jul 2025 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752574794;
	bh=BNKxjY/W7+prDJejNl+rrxKqZXwSei0aj4Vkuz4lVsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eNlPbPE/30tp0HMf5oT3DhoOlLPxXPsH+FGI38E1ln9h+pdpWo1l/kxC7EZXKRIHP
	 QWjBGM2IrSRgaU2WqJZ8cF1XRXO+lxl5/nfDmmbzPl8Jg4MYSuYLeNvEcMQ7nkc1wT
	 +DKFk1UCjvQxRj3oVhEuDKCvGTT2xMDU6B2SQh7ktZiGq4Nf+RNEWjQe1qJxxIAre4
	 O2Ez35ZRQ8aiGV2a3aprszbapU2exPGTWAH6MVf667voyWtXXhdJgYKE8Ib+6bf53D
	 +FRQR5pwLPmVJwVqJBPrsZHQNuG7EG5vO+QU21F7tcIbC1FvR6eeL0Xla5a3/l9zIf
	 wlQQQIEbHujKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0E383BA08;
	Tue, 15 Jul 2025 10:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/8] net: mctp: Improved bind handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175257481551.2793.9987057213083962280.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 10:20:15 +0000
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Jul 2025 16:55:53 +0800 you wrote:
> This series improves a couple of aspects of MCTP bind() handling.
> 
> MCTP wasn't checking whether the same MCTP type was bound by multiple
> sockets. That would result in messages being received by an arbitrary
> socket, which isn't useful behaviour. Instead it makes more sense to
> have the duplicate binds fail, the same as other network protocols.
> An exception is made for more-specific binds to particular MCTP
> addresses.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] net: mctp: mctp_test_route_extaddr_input cleanup
    https://git.kernel.org/netdev/net-next/c/3558ab79a2f2
  - [net-next,v4,2/8] net: mctp: Prevent duplicate binds
    https://git.kernel.org/netdev/net-next/c/3954502377ec
  - [net-next,v4,3/8] net: mctp: Treat MCTP_NET_ANY specially in bind()
    https://git.kernel.org/netdev/net-next/c/5000268c2982
  - [net-next,v4,4/8] net: mctp: Add test for conflicting bind()s
    https://git.kernel.org/netdev/net-next/c/4ec4b7fc04a7
  - [net-next,v4,5/8] net: mctp: Use hashtable for binds
    https://git.kernel.org/netdev/net-next/c/1aeed732f4f8
  - [net-next,v4,6/8] net: mctp: Allow limiting binds to a peer address
    https://git.kernel.org/netdev/net-next/c/3549eb08e550
  - [net-next,v4,7/8] net: mctp: Test conflicts of connect() with bind()
    https://git.kernel.org/netdev/net-next/c/b7e28129b667
  - [net-next,v4,8/8] net: mctp: Add bind lookup test
    https://git.kernel.org/netdev/net-next/c/e6d8e7dbc5a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



