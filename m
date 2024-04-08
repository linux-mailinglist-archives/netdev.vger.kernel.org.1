Return-Path: <netdev+bounces-85664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918A89BCB5
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBCCB2341C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AAE535BA;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz7n3wqP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539C53387
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571027; cv=none; b=IW1PancDI7FjiAvKUBFgdwKgJ8zXBNDDFg9wCgIxgE/kSv0vF+vB32j1UES/LtAWzjv8/mGCN9Qnu4qJUUwKxl+rSAPYIBy1dWYGNUOJBPrrOoQ1tvz76d3n0+aI//7FlBS2LYdC0HW7E+GJZypEjyZWf6FY8spJRqPkyuZZOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571027; c=relaxed/simple;
	bh=OBAV48Hga6wqvdLaMXHGE9uDRLhU7sEd1WXxcf9VSZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MUqGQhPJyq6F0p1SuSJ7uuduFgxEM/FqKzsiKi67w0ZoGhab7UWTyXy9Eett+HsX6uUJz5XGQh0C1k3Vt8c9pObOjN8s6jI3Z4chEO6TESQYKXB86fI5DgERzY74/FzNb6PNN8pkMbEvhCG9vfK0ynUILLNQhrrA6TvV2QIzevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz7n3wqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16B82C433B2;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571027;
	bh=OBAV48Hga6wqvdLaMXHGE9uDRLhU7sEd1WXxcf9VSZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bz7n3wqPdHFNnWnsCAPqYwfHcpVV/1sIaH3hWAtUB52eK6hCBHLkJ6UaUV9MstSEc
	 rHWqHpeibQSxH3nq1n/X3OFMmeUkr6ljIo8K1/5v+XA9LFZu9TnA5CwTI49XTKqyPR
	 gxRVJ8KmTkagkxdXrtwQJpJbk3awVhz3NBdYrGDFcusiuUixzmlt9+ZaoSEqmLyk8G
	 rSw1J5jhkOaChtQGIOfZ3lhXETGnkSBgSPwj/3sOba/xR3ZNjbM8lwzpisr+qefK6x
	 GILt1Ri792i1mRRAfXt7LgofpPyt2Rb1s7ly00P76JW/q+foCggVnmnxohZ7o8wrVs
	 uoENwbvuYlSdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BCE6C54BD3;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dqs: use sysfs_emit() in favor of sprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257102704.30740.3719601035253246147.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:10:27 +0000
References: <20240404164604.3055832-1-edumazet@google.com>
In-Reply-To: <20240404164604.3055832-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, leitao@debian.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 16:46:04 +0000 you wrote:
> Commit 6025b9135f7a ("net: dqs: add NIC stall detector based on BQL")
> added three sysfs files.
> 
> Use the recommended sysfs_emit() helper.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dqs: use sysfs_emit() in favor of sprintf()
    https://git.kernel.org/netdev/net-next/c/db77cdc69684

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



