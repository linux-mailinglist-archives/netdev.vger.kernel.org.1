Return-Path: <netdev+bounces-67546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CBA843F8D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AE92833E0
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8DB79938;
	Wed, 31 Jan 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiU/+/l3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C94F5F9
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704827; cv=none; b=Kw62D7KzMkGmr73Hj5JoG9xyzsTBF+yesqgmVBP2X6lbjvAG2aEy6m3O6DKnNiCNtG88/nAs1mrdKOjXzKw7n1A7sR4AodUlecQShBjgPw+OsnU8JnfpctYHfCFZwQdvIVdtGTYbmWlnEiy3DgJOnu54RkIK351FBhqPKQFnFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704827; c=relaxed/simple;
	bh=gdIBQPIl9WYJ1By4iZeKGhVgPnsxLwwbFAYBQmodP2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=onh8yka9NOUOWOFqdlJLIJpu6OSHdIBhfraa2b4KG+WNoZW1gVzxquf7/kvErvWdINJEPjyPSb1rMfe5LGfvthvxXtRhjw7LBl6xhaeah2WUtT2OR56574sGQA/pilDwEw/9cxJVVylhZFPTiH+bPsdsM9DUfeH4oH5+3wRnTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiU/+/l3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FBD3C43394;
	Wed, 31 Jan 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706704826;
	bh=gdIBQPIl9WYJ1By4iZeKGhVgPnsxLwwbFAYBQmodP2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fiU/+/l3pRjurIhzTpv6c0utgVk8s+znxNaEoUaOf/dLH+tSS13gdRdOZ8VvESeRH
	 vPQVV2OdfwaKIzxyBxzU3ATZI33GycPoUX9Qrj2jUEHW3xRMbTcOfHVUgh7N0xDlV7
	 xVOGLoiyHOLj3LqLdhqiB+M4B++mozkORBMXk59zGf+vjVICVFQpjdDDgan29y8vyP
	 8cw/sr3zHbI4Lkv02hBooq2sV8ZmCiIsHS6o+0TmJpW/3yjojwGOW+7HDaQBysRGiF
	 XTLlnZNIrv/g23iLo6dtUhewGRwnC8haiUN1qyCB5oHx9sjUXukDFQfuty13jPhp2z
	 hzSS3mPWQgv9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 556C0E3237F;
	Wed, 31 Jan 2024 12:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] ethtool: switch EEE netlink interface to use
 EEE linkmode bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170670482634.28228.8010946543841872656.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 12:40:26 +0000
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
In-Reply-To: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 27 Jan 2024 14:24:05 +0100 you wrote:
> So far only 32bit legacy bitmaps are passed to userspace. This makes
> it impossible to manage EEE linkmodes beyond bit 32, e.g. manage EEE
> for 2500BaseT and 5000BaseT. This series adds support for passing
> full linkmode bitmaps between kernel and userspace.
> 
> Fortunately the netlink-based part of ethtool is quite smart and no
> changes are needed in ethtool. However this applies to the netlink
> interface only, the ioctl interface for now remains restricted to
> legacy bitmaps.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] ethtool: replace struct ethtool_eee with a new struct ethtool_keee on kernel side
    https://git.kernel.org/netdev/net-next/c/d80a52335374
  - [net-next,v4,2/6] ethtool: switch back from ethtool_keee to ethtool_eee for ioctl
    https://git.kernel.org/netdev/net-next/c/0b3100bc8fa7
  - [net-next,v4,3/6] ethtool: adjust struct ethtool_keee to kernel needs
    https://git.kernel.org/netdev/net-next/c/285cc15cc555
  - [net-next,v4,4/6] ethtool: add suffix _u32 to legacy bitmap members of struct ethtool_keee
    https://git.kernel.org/netdev/net-next/c/1d756ff13da6
  - [net-next,v4,5/6] ethtool: add linkmode bitmap support to struct ethtool_keee
    https://git.kernel.org/netdev/net-next/c/1f069de63602
  - [net-next,v4,6/6] net: phy: c45: change genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps
    https://git.kernel.org/netdev/net-next/c/2bb052612959

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



