Return-Path: <netdev+bounces-197019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A9AD760D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF5A3B051F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6D2DCC08;
	Thu, 12 Jun 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzDUH7J5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF12DCC04
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741620; cv=none; b=bUm0LfZ1ppAfa8TtNmdMhcgGTXyLKt6+GJirSzCmG+qab8S8QgZO8ocmpvpEHwZwHkgnrdyaSu95vFy54h5nxDnhvSprSLSG8WhNXzhI1tggcmDLmEJTtocyjBQ7iNdYGS2fdRNvHOPp7xG3Y5nptbZl5SnYoInN1jozb7X7gC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741620; c=relaxed/simple;
	bh=JcYMGJZDpp8EP5QbvvNYj5/u4QTJivgxJeuE9QB0Ls0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NaHeIUV6mLQ42e0pxAn3+KvLp8TB17tc9+iRzZExGpShGFr5JaltcUcHmc1smK61AM/0TG4wazQEFacRbutMSIzb5JSUttP1DEJ7DaIEkkj/1foxgBjAChCxvbAzX8AS+T8oICeOIMZRJ4fNFPGCfj+lvFveSsqHd5UX11xL3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzDUH7J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C040BC4CEEB;
	Thu, 12 Jun 2025 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741619;
	bh=JcYMGJZDpp8EP5QbvvNYj5/u4QTJivgxJeuE9QB0Ls0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dzDUH7J5z6Q5TJE7i0lCklP6ndwNre7XkIhpfG12nipXhHBJpL38KcQg1UVUPvc9D
	 xLbwhLyNiHJPNarK2kXdEAq9SolZ79p7vnsEh8M1UfgTIwQa6iAQi6Z8R6SbmMM0Oo
	 rlNjS4P38tsVboOlgjdrBINyyyPJYke9WwlG26Gt0QUqot/HJh0j9MLslLHdJWc7p8
	 9EcAzUhGLGG4oc5eQWZl6Rurg14u0nUoJ+v+xX4shxnH1phrvNmDp169AeNUP4ZayM
	 fUdBO2t0gIf4QIxZyVMwbhOPSdXajaoOG8tFH3jvgPHnepGFHSLEDZalL8eif09K2J
	 ceiRMd4TwPTYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9A39EFFCF;
	Thu, 12 Jun 2025 15:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Move fib6_config_validate() to
 ip6_route_add().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974164949.4177214.14871483094576808515.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:20:49 +0000
References: <20250611193551.2999991-1-kuni1840@gmail.com>
In-Reply-To: <20250611193551.2999991-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, syzbot+4c2358694722d304c44e@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 12:35:02 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> syzkaller created an IPv6 route from a malformed packet, which has
> a prefix len > 128, triggering the splat below. [0]
> 
> This is a similar issue fixed by commit 586ceac9acb7 ("ipv6: Restore
> fib6_config validation for SIOCADDRT.").
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Move fib6_config_validate() to ip6_route_add().
    https://git.kernel.org/netdev/net/c/b3979e3d2fc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



