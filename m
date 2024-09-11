Return-Path: <netdev+bounces-127189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B09974834
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3751F27091
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9717273FC;
	Wed, 11 Sep 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQwCLONx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604210A0E
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726021229; cv=none; b=fuTO0Rc9+ydbDXMhVt5nRaswjIvd0U1OiCd5O/stUkIDYWCZwvhdJu7tdP0+3vPhDaFcWBSsgUk9B2le4l1DYabVNIBdAFPZqsysrXjjIpxX48JDGI83pIZ/IhvjbMDA5acmE/cNTEzO9f1ticudLL2yOyrhULhO3Tfa/uMBYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726021229; c=relaxed/simple;
	bh=YA6AuGzBJh/ENoqLPEl5IGir+OSsSwx0BQZByne0H3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sEQAdWiyO7ToI364ZvLCG8iS6cuHzPo4MRMbDWvkv9lch+O9TUScWvxt4naYLYU4X5dkMVpe7o5TsykAO0n+calqqA5skHOv3bVCm+EAoB1pKzgLAJ/huj7B6mw2RHE8JIcPZ5wUg2+ye4FS7Ytj8bRx9Xo0Hrxepd/N5Tfuo2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQwCLONx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2D9C4CEC3;
	Wed, 11 Sep 2024 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726021229;
	bh=YA6AuGzBJh/ENoqLPEl5IGir+OSsSwx0BQZByne0H3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cQwCLONxYVIruEFNe6UZaAT9MtKajp4r9YKlc4A5rHf1tOkZYyqQyeF54847Xp1jJ
	 jIFSw0NMRAfyHYL7eV4EUi85urY8Ea4yqKV61Jpvic8wJ+UBrkNNhgUnftwyv9oi8Y
	 8GeDu9SlcrskMRM5acuJWDTb/UPAxNoUHNdryJKPPrYVJfFExJX70gkkL5/ESema97
	 pqXlJbW3GdT+PLcFwt052bAFMoPdZBvWoEWQIq03zZ+Kn1551v/KoR8EWb3Co2ASlY
	 eZLM0x8RwWcIsIGZ5ORPK/NK1UbnqGtau8L3+akcAZzpN2qzD9ywJSZT1StJDElpz4
	 LRR6Tb9IqZ9XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E523822FA4;
	Wed, 11 Sep 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/13] xfrm: Remove documentation WARN_ON to limit return
 values for offloaded SA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602123027.463549.4444581460245758467.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 02:20:30 +0000
References: <20240910065507.2436394-2-steffen.klassert@secunet.com>
In-Reply-To: <20240910065507.2436394-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 10 Sep 2024 08:54:55 +0200 you wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> The original idea to put WARN_ON() on return value from driver code was
> to make sure that packet offload doesn't have silent fallback to
> SW implementation, like crypto offload has.
> 
> In reality, this is not needed as all *swan implementations followed
> this request and used explicit configuration style to make sure that
> "users will get what they ask".
> So instead of forcing drivers to make sure that even their internal flows
> don't return -EOPNOTSUPP, let's remove this WARN_ON.
> 
> [...]

Here is the summary with links:
  - [01/13] xfrm: Remove documentation WARN_ON to limit return values for offloaded SA
    https://git.kernel.org/netdev/net-next/c/9b49f55838b1
  - [02/13] net: add copy from skb_seq_state to buffer function
    https://git.kernel.org/netdev/net-next/c/6ad8bc92a477
  - [03/13] xfrm: Correct spelling in xfrm.h
    https://git.kernel.org/netdev/net-next/c/54f2f78d6b9f
  - [04/13] selftests: add xfrm policy insertion speed test script
    https://git.kernel.org/netdev/net-next/c/9c5b6d4e33dd
  - [05/13] xfrm: policy: don't iterate inexact policies twice at insert time
    https://git.kernel.org/netdev/net-next/c/33f611cf7d52
  - [06/13] xfrm: switch migrate to xfrm_policy_lookup_bytype
    https://git.kernel.org/netdev/net-next/c/563d5ca93e88
  - [07/13] xfrm: policy: remove remaining use of inexact list
    https://git.kernel.org/netdev/net-next/c/a54ad727f745
  - [08/13] xfrm: add SA information to the offloaded packet
    https://git.kernel.org/netdev/net-next/c/e7cd191f83fd
  - [09/13] xfrm: policy: use recently added helper in more places
    https://git.kernel.org/netdev/net-next/c/08c2182cf0b4
  - [10/13] xfrm: minor update to sdb and xfrm_policy comments
    https://git.kernel.org/netdev/net-next/c/17163f23678c
  - [11/13] Revert "xfrm: add SA information to the offloaded packet"
    https://git.kernel.org/netdev/net-next/c/69716a3babe1
  - [12/13] xfrm: policy: fix null dereference
    https://git.kernel.org/netdev/net-next/c/6a13f5afd39d
  - [13/13] xfrm: policy: Restore dir assignments in xfrm_hash_rebuild()
    https://git.kernel.org/netdev/net-next/c/e62d39332d4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



