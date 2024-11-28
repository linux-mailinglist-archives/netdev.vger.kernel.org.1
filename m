Return-Path: <netdev+bounces-147708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9A39DB4CB
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28153B21F79
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36475B216;
	Thu, 28 Nov 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv9b7Tvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A561FDF
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786219; cv=none; b=beunVi9r2YMLA/2vmpHhSS66MvmF39dFfAisciLDSL9LQFOBV5mNQQRun5tr9GHrfLdlK8F4oQfh3wjxHiGBGlqDT0e6Eq06wtH716Nr9QhtGIPXffgzpqyJ8sBLl12BnwBIY9cA/otu2L/GNrohkTZ7mNie6b4pYL8lHyuu1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786219; c=relaxed/simple;
	bh=mkOOukbrhXHbiP6Ma3W+5lgrQTSHBbWF0A/2+CG+9tM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7I0QtfF+dKojRd785IGAgxlffIwAxhebJ1dRCbB791uRlnXEqj+RKgH2GAncloTKd6k483qvSjmh9DHFNyYHNGIb+bWKdMB+9dFdNQSu07dAwEVfGqcj6j3qmLJGSTVg3V35gtyFa+9gyqHpHlkqqTLIo2bKRaeERy5zx71t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv9b7Tvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149A4C4CECE;
	Thu, 28 Nov 2024 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732786218;
	bh=mkOOukbrhXHbiP6Ma3W+5lgrQTSHBbWF0A/2+CG+9tM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dv9b7TvlF2gFNixlEYQKV4dq7tkJ60xGQKseD3cadanU5CwNTyqmIyz0I0pYcYX9B
	 5f0x08DOlhVP92fhOhlb0ppNpwzKJ1T37W0YcfDqsQaHcYV4OZM0dIqwnPrgecuQto
	 0X7UljA8IEc2NVzZi5oASNrCuuIvW9YCiDfD7Lo1Dk4p5gXgvMFahKoT9IVN0myCxa
	 Vsw3JLk0hzb+SMXTHUsu09KMkAOEpmWRrz2XlQ/n3A8/L9OdTGlCzLz7qeqq3RRjg+
	 bt/1xCu/9lcOCeeI5u0KwhR6rFsnFfSM8hREh0IIFyhvpdWk0/moMbXOhXx2MR4IIH
	 zDnjIIaAQNTLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71F18380A944;
	Thu, 28 Nov 2024 09:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] net: fix mcast RCU splats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173278623126.1676038.10017365544015703549.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 09:30:31 +0000
References: <cover.1732289799.git.pabeni@redhat.com>
In-Reply-To: <cover.1732289799.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, stefan.wiehler@nokia.com,
 dsahern@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Nov 2024 16:40:55 +0100 you wrote:
> This series addresses the RCU splat triggered by the forwarding
> mroute tests.
> 
> The first patch does not address any specific issue, but makes the
> following ones more clear. Patch 2 and 3 address the issue for ipv6 and
> ipv4 respectively.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] ipmr: add debug check for mr table cleanup
    https://git.kernel.org/netdev/net/c/11b6e701bce9
  - [v2,net,2/3] ip6mr: fix tables suspicious RCU usage
    https://git.kernel.org/netdev/net/c/f1553c9894b4
  - [v2,net,3/3] ipmr: fix tables suspicious RCU usage
    https://git.kernel.org/netdev/net/c/fc9c273d6daa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



