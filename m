Return-Path: <netdev+bounces-197263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D15AD7FBE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A7B18879EC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA68F66;
	Fri, 13 Jun 2025 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeiyCRat"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA52AE97
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775811; cv=none; b=ZTQZX3MGVLw9X7VWxkL/Vfg8ZO0UzgjpjXVItJKmjDvQax+Xo2LHA+GLku+lUJ7y+huFL3SQ/QoCRCldkrzHBXVz0ZqjFcSUGwXdZAgPrNOVEsNSxJoaGWIMjnI5vtELmzTLTwpShZWag6ibiBWk+m+PDexjOpOBAHmt3+x1DvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775811; c=relaxed/simple;
	bh=ef4smiOC47x5NuXH+olcR5+Mps0Y7hrqd7rV4VLIZ2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I+gU+ENjxJJMBfqaCY6OtfGbhlGfodtWVyFRiji2uaV7IewXaTI2wslhzwyxXr7R6aewLNj835Bqogfny4UC7PPJpAMycR51rhBxsRmSWKI4TfeZ8u1F0aW9bKy78sxuycuCSJbqe2qs3SRM3i64pkavjaSMEHly+kPM26gAJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeiyCRat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEF5C4CEEA;
	Fri, 13 Jun 2025 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749775810;
	bh=ef4smiOC47x5NuXH+olcR5+Mps0Y7hrqd7rV4VLIZ2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AeiyCRatGgZrHFNYfWL9XwMYOTfD2WvrmErGtOMqF9XnTd6lwYn6WrpqpjqxLOuM+
	 gG3RVmwmociw4+DjM/QOfsyCwHf0Y16n1SQgH0bng18IPntXAWcsDSGWuw53RSFCwE
	 7lDkiT9MvA12gE0nAt9ERl8swRyiS4hWDt8nqQPoQck7sIi4BLjGSBvOqnQt6gPxqz
	 Vw8++ZCBl2Cmo02CFRLHlCHpDm6WLuP0izrQQMYQHrKRkjLLOw3yPYCHSzT9g3CexC
	 Og71lWbvF9E1y82K01xkAb2Vd9n+M3xqtrkm10JMpJ50jld6znqn9cR1qKPgLiaRjh
	 UhogEVrhVBZVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D3439EFFCF;
	Fri, 13 Jun 2025 00:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: ethtool: add dedicated RXFH driver
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977584001.169232.17739613101853165487.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 00:50:40 +0000
References: <20250611145949.2674086-1-kuba@kernel.org>
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 07:59:40 -0700 you wrote:
> Andrew asked me to plumb the RXFH header fields configuration
> thru to netlink. Before we do that we need to clean up the driver
> facing API a little bit. Right now RXFH configuration shares the
> callbacks with n-tuple filters. The future of n-tuple filters
> is uncertain within netlink. Separate the two for clarity both
> of the core code and the driver facing API.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: ethtool: copy the rxfh flow handling
    https://git.kernel.org/netdev/net-next/c/f4f126535546
  - [net-next,2/9] net: ethtool: remove the duplicated handling from rxfh and rxnfc
    https://git.kernel.org/netdev/net-next/c/2a644c5cecc0
  - [net-next,3/9] net: ethtool: require drivers to opt into the per-RSS ctx RXFH
    https://git.kernel.org/netdev/net-next/c/fac4b41741b5
  - [net-next,4/9] net: ethtool: add dedicated callbacks for getting and setting rxfh fields
    https://git.kernel.org/netdev/net-next/c/9bb00786fc61
  - [net-next,5/9] eth: remove empty RXFH handling from drivers
    https://git.kernel.org/netdev/net-next/c/86b2315e7041
  - [net-next,6/9] eth: fbnic: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/2a34007ba977
  - [net-next,7/9] net: drv: vmxnet3: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/2f14765d6397
  - [net-next,8/9] net: drv: virtio: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/63d474cfb596
  - [net-next,9/9] net: drv: hyperv: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/6867fbe3a9f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



