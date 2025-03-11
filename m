Return-Path: <netdev+bounces-173812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C203DA5BD0E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8CA3AD38C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9322F392;
	Tue, 11 Mar 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCwCyOdU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87C22E415;
	Tue, 11 Mar 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687201; cv=none; b=vCUgDklwsjVOgb/LJTWbqYcJ1+7rPi6xkkPhEDqsvEnGufgOaYahDYH5afKLeSV69QnS+49iVgoeB3Qzaz6AS0s9oOqMMf535VVDpAas+3WP1dBiF3aS6G70BLpp1zW06L7DxcnTtxea/G18F903vHn6xWTBbwhlVXt81nAt1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687201; c=relaxed/simple;
	bh=mNkiJQyHI9PkhhTXrV2YZZ3/e7ilPqw+IG6VppDiAwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C5HlkWXEJEDes3e79qSbSl3QVLr5WABXTlApQNrpi6MJq024DNK5ruoEOrDkr0lI+PBpF11yZQGJ5tUvamOXpLrZq7FjRqAF5Y3wviZw4j+ZTsrFvl1qFiQ8D4Zr9KFKVsdpSZ6Z80GF14ffhvtc0T7J5Y4XkfEoH2CzCwOrQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCwCyOdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13A1C4CEE9;
	Tue, 11 Mar 2025 10:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687200;
	bh=mNkiJQyHI9PkhhTXrV2YZZ3/e7ilPqw+IG6VppDiAwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YCwCyOdURnYhgggvGC6WjfEbMzA7kTZ8mIhLrLlDclZnx4Lld/03tEfexM6NEdMrQ
	 5CGkAjBkVu5hughtn9OHZHwJo5kwjRhmcj9BdoT+AIc1l69JZWj8xr5VOtwXcfK5Os
	 OgkYSq4BJAWJsWidc2qGNeTqDlkXo5UgSioz9e3lb+4JE90vG5g6E1XyuZ8mjaTbbz
	 bChoRSMXB1XngPn1PalEi0avBDemgD4NqASC9mJSJYqvzAjaB00+zgGsm18naxSfI2
	 4b48AaVyEdK85caa+6XgRVWW45XYSDHyI7M+HIVx4wewk7TlVw4+FEryzTMHjyBGwt
	 zgXKudbCA9J3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348C7380AAD1;
	Tue, 11 Mar 2025 10:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] enic:enable 32, 64 byte cqes and get max
 rx/tx ring size from hw
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174168723504.3879094.16367848143121507790.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 10:00:35 +0000
References: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
In-Reply-To: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
To: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Cc: benve@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, satishkh@cisco.com,
 neescoba@cisco.com, johndale@cisco.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 04 Mar 2025 19:56:36 -0500 you wrote:
> This series enables using the max rx and tx ring sizes read from hw.
> For newer hw that can be up to 16k entries. This requires bigger
> completion entries for rx queues. This series enables the use of the
> 32 and 64 byte completion queues entries for enic rx queues on
> supported hw versions. This is in addition to the exiting (default)
> 16 byte rx cqes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] enic: Move function from header file to c file
    https://git.kernel.org/netdev/net-next/c/025cf9318083
  - [net-next,v2,2/8] enic: enic rq code reorg
    https://git.kernel.org/netdev/net-next/c/eaa23db8686f
  - [net-next,v2,3/8] enic: enic rq extended cq defines
    https://git.kernel.org/netdev/net-next/c/2be2eb764343
  - [net-next,v2,4/8] enic: enable rq extended cq support
    https://git.kernel.org/netdev/net-next/c/bcb725c79cfa
  - [net-next,v2,5/8] enic : remove unused function cq_enet_wq_desc_dec
    https://git.kernel.org/netdev/net-next/c/6dca618c9467
  - [net-next,v2,6/8] enic : added enic_wq.c and enic_wq.h
    https://git.kernel.org/netdev/net-next/c/e5f1bcd93d96
  - [net-next,v2,7/8] enic : cleanup of enic wq request completion path
    https://git.kernel.org/netdev/net-next/c/26b2c5f6ff47
  - [net-next,v2,8/8] enic : get max rq & wq entries supported by hw, 16K queues
    https://git.kernel.org/netdev/net-next/c/df9fd2a3ce01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



