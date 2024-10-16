Return-Path: <netdev+bounces-135944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6D99FDAD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD7DB255DD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38031187FE2;
	Wed, 16 Oct 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMWKxhFE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F15187872
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040430; cv=none; b=bTN4X52m5JIJ51Xw92fynZ5JPb4Wod1397i2Tm0VWH9kYCSxcbmau4VHak4NPU1qFCywlCd0BoCr91HY2ET9L7rYkaN5rYEH9AxOFP5fkZJ6kKQczBK71knUlTn5LWeTcoGVA1BUf2bEcu9GfPOmFgl3NprpPa2GLpHFYGPhohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040430; c=relaxed/simple;
	bh=9rS5BYKx0KHHmhvoTu3P1PQZfutq6jKrKNWs91WI/tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKhmASPXryX/zltpmSvsLyshizymwjWajHTq6ckJGGdPKDeD9U1UUODL4vVETB5rMeTbp+uGrUbGenPZ6Srq+tGHVemMFmerchfUG7EBmk+ZnfNKGqgiUY5HkMpf6dYw/Rhk+fQ04rzVVzg6Q6tRlWngCTn024LoXA9YVpmk+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMWKxhFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F0AC4CEC6;
	Wed, 16 Oct 2024 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040429;
	bh=9rS5BYKx0KHHmhvoTu3P1PQZfutq6jKrKNWs91WI/tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HMWKxhFE4YQtw8vh5gy67brripGBfHtgP93flxPNlsltk3+sZ0ZIPodgS5XLfNWKo
	 kGJ3btE9xSv2tiRLWDy9TKVQ1F5FwodandOMjS+7mQjimWBOL4ps2O6W4mt8xZggVa
	 1LHxsTKLQ1YTOJ34OiKg1zThoPBHAtsR3S0m/dtNMexaQZRHqEbBcP3fWQw2Dq2csp
	 CVoQ+WNlX1Ssa25cM5RfXbrxa06Otqa9ZrlIzRU2xeVFx77CDOcTWvzOa2KqVxgCS+
	 53rI0b4Fxp12Y+eOHc5vEzXgM0M2MHWvtXHY79ZMUXMnBZEBLU/0TqYpDVvicA0TUm
	 WV0mHc50Nbb2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5733809A8A;
	Wed, 16 Oct 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] neighbour: Remove NEIGH_DN_TABLE.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904043448.1343417.5380255499659363908.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:00:34 +0000
References: <20241014235216.10785-1-kuniyu@amazon.com>
In-Reply-To: <20241014235216.10785-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 16:52:16 -0700 you wrote:
> Since commit 1202cdd66531 ("Remove DECnet support from kernel"),
> NEIGH_DN_TABLE is no longer used.
> 
> MPLS has implicit dependency on it in nla_put_via(), but nla_get_via()
> does not support DECnet.
> 
> Let's remove NEIGH_DN_TABLE.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] neighbour: Remove NEIGH_DN_TABLE.
    https://git.kernel.org/netdev/net-next/c/95b3120a485f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



