Return-Path: <netdev+bounces-112753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC2193B047
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600B61C20E25
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C386156C6C;
	Wed, 24 Jul 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY4fediI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315FD22EF2;
	Wed, 24 Jul 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820031; cv=none; b=J2tHvHeUHLQxF7xvNimh2qaYlZHWuFv/T9Wp/7LADBcjs/bmYDuFXAsAWwMaJMsEP5WBWejqudoUqkxIAP1uTHjeJmA0SqiBtghznVlsGWq/+s1LCOQ9dHuBu4UiweCVU11pdQsBSLdH9qjdD1b4hWkEh4ePMW4vmpbOoYQzAeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820031; c=relaxed/simple;
	bh=LRh0DHRniu5cJw6hEo5aqtxNitGqTiRY2CMNNF+JwyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qO/fXXgWuMsDptd6XxiqeRUzOxBv1e5dFhQ7RNk6LUee9QP+7xvB/qJrXyFOalcHcQulTL7zfSnQkAg3N4U5xVXDmAskzzJKLviKJZlgM04AK6yi3ShRL5TexiTavVEE2RlMlDsVLGiWxp0V8vHTJaSM0WuM2MLYVvn1XOJay8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY4fediI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A837DC4AF0E;
	Wed, 24 Jul 2024 11:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721820030;
	bh=LRh0DHRniu5cJw6hEo5aqtxNitGqTiRY2CMNNF+JwyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eY4fediIbsRHooFUpzNQs8SVIDeThG2XNgyb0ldTSUlAP2TFGMoKWqc5Bdg4GYY/q
	 gB6dyzoDip0M3tT1sgxtFPjX/XCy01CGwWLNQY6dK8vUZHGAKZ4jGIpvPJgRzb4S9E
	 DZnMhsLnKJhNRG0TdoWqPHHWH5A+Uv/cVrduP0FpZJzOzPQc3KVk5JXk0F1S3dZ5Hc
	 aEIjS66am1LwFdSFi6LYr5PHcBSPvK3l2Dh/JGNQJVKHikUi6S/zDTWDB7H4MKP9ll
	 cs5D0Srh5S3FBl5/N0GIv+bbbISbYevLJwhS00cRHZod+o8OAf3gOj2KEIj3RoNL/d
	 zOdgGRMVU2t3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 950ACC43445;
	Wed, 24 Jul 2024 11:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str() on
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172182003060.2467.7477839388953777484.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 11:20:30 +0000
References: <20240716020905.291388-1-syoshida@redhat.com>
In-Reply-To: <20240716020905.291388-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 16 Jul 2024 11:09:05 +0900 you wrote:
> tipc_udp_addr2str() should return non-zero value if the UDP media
> address is invalid. Otherwise, a buffer overflow access can occur in
> tipc_media_addr_printf(). Fix this by returning 1 on an invalid UDP
> media address.
> 
> Fixes: d0f91938bede ("tipc: add ip/udp media type")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] tipc: Return non-zero value from tipc_udp_addr2str() on error
    https://git.kernel.org/netdev/net/c/fa96c6baef1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



