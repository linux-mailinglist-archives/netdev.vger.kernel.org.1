Return-Path: <netdev+bounces-199544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED242AE0AB1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ADB3B21DF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C566236424;
	Thu, 19 Jun 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB5uwoMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E4235068;
	Thu, 19 Jun 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347587; cv=none; b=bhDzi4QgVnFrkUf74aHg8UZ6znvA0WKPqa7AgUDdphVmx9NHfijAMNcNQUvp9Am2EIbEe6mu2BHBV4QVblFFYJF0AuU9vKCmx1/tBWKwJQGxX6aVRMaXSsy5iqBvMjAz9+S6Fakkcx/XocgdmWi014kifj2yZigC5LhEbjX8/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347587; c=relaxed/simple;
	bh=YFrTYQvHmRey+7MTAD25fVmEpZBODFYNpOvJ8at6t5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RCyJWTMnTi5i3vZ+VPnXufKjmB5CDviV6VUNbm/2phV18QE3vCWQUhA+wIiNWTfvlBP+KCEZItxW2UZbrk0fUw9SbRDzOU9vTEbPTg3XYNuKkADg0GiELDz/meN8XY6h7yQIixHablzztVBxJVSc6jv2gzwS8h4xQ7cF6hzGDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB5uwoMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E217EC4CEEA;
	Thu, 19 Jun 2025 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347586;
	bh=YFrTYQvHmRey+7MTAD25fVmEpZBODFYNpOvJ8at6t5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qB5uwoMq/oyDAD/AkkFcIIkwltz3k0qRA0L9dOHcjOruNJZOuWwlVJXirHikivoAP
	 DkD6gg0MCpE3YDWaEp1ELn/4FScFWe5Gr6t1XWp2XcqLvxyTozbG/XaY43AjByXSdC
	 X+SNR0CoeD8tDudsvahM1INJ6TAZ+Ke1svDWzPvAIEH4OcPxbep10Htt0/WNUDwhdQ
	 puAyd5DzqTFcXZ0iEZquk5a1J4nHyvF5/wpQauePlVGK69QR1UT7UPD+PTDO+xpfF9
	 S9lQwlddO4IPhoMrla3mynDgp7HxWN6vF57Oo5sD+KFZPNjr/8uGc+d6/r4KC4QE3T
	 hHhqduaXM3g/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6538111DD;
	Thu, 19 Jun 2025 15:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] calipso: Fix null-ptr-deref in
 calipso_req_{set,del}attr().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034761500.906129.12509994894624107217.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:40:15 +0000
References: <20250617224125.17299-1-kuni1840@gmail.com>
In-Reply-To: <20250617224125.17299-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: paul@paul-moore.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 huw@codeweavers.com, kuniyu@google.com, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, syzkaller@googlegroups.com,
 john.cs.hey@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 15:40:42 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> syzkaller reported a null-ptr-deref in sock_omalloc() while allocating
> a CALIPSO option.  [0]
> 
> The NULL is of struct sock, which was fetched by sk_to_full_sk() in
> calipso_req_setattr().
> 
> [...]

Here is the summary with links:
  - [v2,net] calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
    https://git.kernel.org/netdev/net/c/10876da918fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



