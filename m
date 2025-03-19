Return-Path: <netdev+bounces-176238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3F6A696D5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2D17AF07
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3271E231D;
	Wed, 19 Mar 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyEJmQ2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3A257D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406597; cv=none; b=K1DCTcA2wzHOex73wRc0nGgGvYCRAnV2Itlre+2QMBBLo9xBW0N/uXMaY4ASEDZrGKu4TyeRQuSfTlRezXGIX0Ej7zllPi80zvJdZlZnROn26MonXFx8z6vhVUhalQ1ngXo3MiEWJksR7yZK2chjrT2bA57sU8tqR5lbzXdpUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406597; c=relaxed/simple;
	bh=LpG/0A6xfWSe+pb2vhZqgn4K+174BPcnefWwVhZMduE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VupvPgx2MLZRqvfj9yRNXoECny/5Wf1Z9spQqSXnT/BqS3Mv7M8xo+p8O4zpi7yKzPXU7rNHO+GeCaGwx7u5NpE2VMGOf/nl7+PkX29p3ykJibVLVVYVEAQB/Km4aeJYjpaBBTlgXkg5tcMu9p5zAkiR1Ml8yT9VaCm6MU3SUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyEJmQ2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF196C4CEE4;
	Wed, 19 Mar 2025 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742406596;
	bh=LpG/0A6xfWSe+pb2vhZqgn4K+174BPcnefWwVhZMduE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MyEJmQ2MMwnjOnYCPNCwkbRTejBXdNMZwcvqyAcO0Rp3ItY63zjLhULxgI1NxDfFL
	 cwCz4Jm3dj+0LwcjXwLWwb0XGJgBeGn8AED1Jr8bPjZuRRHPUApHYISFvR6JaBMsT1
	 NZl2Sso44ECA8RpgJrdeZkYkvY8w7LjTFnufEsKhlT4DyTXVXhv2tZ7gP19/cwgHgd
	 8EQm+oZnQHujkrOQuhU3yPjSnzETYzhpXy4fejWMVEM1nKN3niExrBdaG1b2zDDpcq
	 xIY0D6AEyMjx0HdNpW+4JMp6IFRitshep8ONIZE4YyFWyGHR7HiLy2nCNPDhaE7CVm
	 68x60Rt9exMpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF0F2380CFFE;
	Wed, 19 Mar 2025 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240663251.1133400.924075648290102706.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 17:50:32 +0000
References: <20250312174804.313107-1-jonathan.lennox@8x8.com>
In-Reply-To: <20250312174804.313107-1-jonathan.lennox@8x8.com>
To: Jonathan Lennox <jonathan.lennox42@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, jonathan.lennox@8x8.com,
 dsahern@kernel.org, netdev@vger.kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 17:48:04 +0000 you wrote:
> Before tc's recent change to fix rounding errors, several tests which
> specified a burst size of "1m" would translate back to being 1048574
> bytes (2b less than 1Mb).  sprint_size prints this as "1024Kb".
> 
> With the tc fix, the burst size is instead correctly reported as
> 1048576 bytes (precisely 1Mb), which sprint_size prints as "1Mb".
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tc-tests: Update tc police action tests for tc buffer size rounding fixes.
    https://git.kernel.org/netdev/net-next/c/756f88ff9c6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



