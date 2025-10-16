Return-Path: <netdev+bounces-230239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA45BE5B75
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBB33A41F5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2662E5B0E;
	Thu, 16 Oct 2025 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coLXORVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7392E54DB
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655026; cv=none; b=f6S5DuPNMwdGI+xKQ/UOyDEUimgvvvyxuS90oj85QPZLhrUgyQiAZMzXJL5OOi13YjtiHHiZQ+GvegWeYp1CzGg8zJLjF3LJN0E0PckdANlKKjfSwWz5qWCMDsfwhUwDiDRVujRujzjv5mvFkKH5hrdis66Di8EuT/umkFZH/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655026; c=relaxed/simple;
	bh=+11642LP2dGRK6ozKPGqnFmVFRWQtp6C6xyu+5McRRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ux1ip2MaoGdezjAiiprnDTZn8Z82Nd8hep39IHneZOS1i4IKunGgSyiDPjHoHasj0rsPuy6V1DDKIIFFUmlH8xkXfWuaiCh16qB6wRtjkG07gSnuDvX59InXS1bUBjzjCS+JqBZjqLQOpUOfNIfuCBcLnvUyCQlCAij8rx5DK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coLXORVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D55BC116B1;
	Thu, 16 Oct 2025 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655026;
	bh=+11642LP2dGRK6ozKPGqnFmVFRWQtp6C6xyu+5McRRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=coLXORVFqXG4jcVoOYyaC7yZ3wzcduMq4DSNCnuMvUqhavqFETsaR/4rZYQsB9PEQ
	 wPuV7HQKP41KgAR3HxU0uvvQRS1Ao1avUD3Vj5I8NGYliwMu9E0ikBcKQcZ/r9rzfs
	 HqJK72di9bpCdU5LHCFjTWWfhxD5ZF5yCEDd8WstlgLYJiVLYoptF+hGJgpxSj+vZc
	 OPfWDWcY8TUwlg2aZyrOEB4IuWpzblC20UCR6sih1OibSt/E8yKxUJ0Rnj2Vdul7W/
	 +J0AfNcdKXqS3sdEvz4w2pEa+h+PLRiAXP14KwBaW46rPrLOC2SdSYQW18Aw7+uEgq
	 zq00t5drNqL7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B1A39D0C23;
	Thu, 16 Oct 2025 22:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: gro: clear skb_shinfo(skb)->hwtstamps in
 napi_reuse_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065500999.1934842.14483553395327922301.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:50:09 +0000
References: <20251015063221.4171986-1-edumazet@google.com>
In-Reply-To: <20251015063221.4171986-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 06:32:21 +0000 you wrote:
> Some network drivers assume this field is zero after napi_get_frags().
> 
> We must clear it in napi_reuse_skb() otherwise the following can happen:
> 
> 1) A packet is received, and skb_shinfo(skb)->hwtstamps is populated
>    because a bit in the receive descriptor announced hwtstamp
>    availability for this packet.
> 
> [...]

Here is the summary with links:
  - [net] net: gro: clear skb_shinfo(skb)->hwtstamps in napi_reuse_skb()
    https://git.kernel.org/netdev/net/c/d0d3e9c2867b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



