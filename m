Return-Path: <netdev+bounces-138139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4AB9AC1EA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6A21C250AC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5636715855E;
	Wed, 23 Oct 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIpIuWNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119017F7
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672821; cv=none; b=pPbZXMqf4R5hABJAWJNXG+e0N0mLwmfYnJhBrGZWaPfsEh0l2PIoc312+qj5zGOq/w6iX4kfh2QwjSsOhyZhaJEUNxtUCvD6AyypMafrRpf1mvbTTJzAh0zcRYoj/xuaN/zFyAY1w0xlnE8Zg1elTzraF7W37WR7B57eH2wx5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672821; c=relaxed/simple;
	bh=tC8oTU6tva4WayMaKs0VjRiIiZRH8xYI3u2B02wp3rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nzXjdZtXHrbTh1K5fZghKsHNNMxUVN7rnUpbdOF/8nYGGZuVgYRZxhB7oU7Pl2cQU45zAwXFGk9oGoHRNXMQPJj/CffW1L+antB3AvJ6AGc/hewh9x/AheezTTN8/tegEEb9gD4A+dAEfmdj1pf2rQFYLfEIIdzy93sLSaN27rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIpIuWNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC06C4CEC6;
	Wed, 23 Oct 2024 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729672820;
	bh=tC8oTU6tva4WayMaKs0VjRiIiZRH8xYI3u2B02wp3rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIpIuWNN5vL86g+tTAE3dOeGY+fY+qyb4Y7EGM5IdRcs2wwCaZacrCBcM5YZ84uQo
	 XttN4+iKvIZZX12BSMS3NfUKiD2PEeNmGojixMkk5YxnRTrUSYzjBGgFXvBHELrX6c
	 9X3lVrJXPF+y+DkOoU0nr5Meip0VIrz//FaZpn35mu0hEO1npJIlbwUnCXUtfOzSbH
	 dmVzqEP5rQ6u+neibURQnSKtXY0MN8H6hnGba8QbYP5wwvELN6S8XV3MUYhYRE50tb
	 isPoAdhGvs9IrculKPo8DJ93MwKw2Ab+Tqli1pdGXV2cEzMgTlfdRTWlHH2DoRZYqH
	 zA1ZCawjgLiqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1B3809A8A;
	Wed, 23 Oct 2024 08:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: sysctl: allow dump_cpumask to handle higher
 numbers of CPUs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172967282700.1521755.2112468833461772529.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 08:40:27 +0000
References: <20241017152422.487406-1-atenart@kernel.org>
In-Reply-To: <20241017152422.487406-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 17:24:16 +0200 you wrote:
> Hello,
> 
> The main goal of this series is to allow dump_cpumask to handle higher
> numbers of CPUs (patch 3). While doing so I had the opportunity to make
> the function a bit simpler, which is done in patches 1-2.
> 
> None of those is net material IMO.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: sysctl: remove always-true condition
    https://git.kernel.org/netdev/net-next/c/d631094e4d20
  - [net-next,2/3] net: sysctl: do not reserve an extra char in dump_cpumask temporary buffer
    https://git.kernel.org/netdev/net-next/c/a8cc8fa14541
  - [net-next,3/3] net: sysctl: allow dump_cpumask to handle higher numbers of CPUs
    https://git.kernel.org/netdev/net-next/c/124afe773b1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



