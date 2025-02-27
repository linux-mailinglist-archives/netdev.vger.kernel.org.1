Return-Path: <netdev+bounces-170089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17DA473F4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A239616DC52
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104961922D4;
	Thu, 27 Feb 2025 04:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqCaDBSD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6247186E2E
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629401; cv=none; b=AipBLwdINa+faeCpkEuOKMktDuW9qethzKXT32peqwuzpKxs4wj6uikSFnnGCkiJl017e8coHh/q+rViro0TgpmW13dEYaCm4NTJuyQWK65Ahggh3SwN+bmCgVUJmEKEckl8ARmqxdjjFi3i8RqjT4wqEmk8muE7yz1pu2gQtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629401; c=relaxed/simple;
	bh=WAdmwBZ0V6ZdykWz+pq5qA+k3XZ6teOjGJ+kJy5JSuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UMmY0ZVfjcdKImj7NHWOB+MbOdZ9MO0itnOqZp60z9MMmnem6x62PHeKV/JxutwFtmFRlnsGMwwAzXUCBvJ1fnBXcOsE+XnUmjxcnIge8k56YAt3Zgy9rOQe+vnUxc+skPrJAi+ni5r+CN3uxpDsQ9G1Lu6UgkC94YsMRRlYknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqCaDBSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48107C4CEDD;
	Thu, 27 Feb 2025 04:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740629400;
	bh=WAdmwBZ0V6ZdykWz+pq5qA+k3XZ6teOjGJ+kJy5JSuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hqCaDBSDPq9AeYQs062IXcOC364kvX8rT/TPPPVSYCNR/8uSojUHYxhosbU5K83oz
	 kROeKFKeWeslOdi5MDODdYsDOxKAu8voP1nX08Ob3He3cOBrmMLurOLFcihQpL42h0
	 kU/1+3345EfGkPwyAejHOYeVCXQ0ETEJ1PSCvO65mFWRokWqtW0BPG061PwClUGJOG
	 pUrgdBV00dmFUMbAWVdTx6asJNzX1Y/29wbxQvTu11228L29MB2Abg5zb7ISVyOnJM
	 Ml2r/mX4lU6rKChcNU1h+cjbfWZWfUnMgkl3Hc3Qsf8/zX6r9Rw+3pir70EdYZkrzs
	 FDkjMKhhj1NjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711AE380CFE6;
	Thu, 27 Feb 2025 04:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/6] net: napi: add CPU affinity to napi->config 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062943228.962704.4253431175547388927.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 04:10:32 +0000
References: <20250224232228.990783-1-ahmed.zaki@intel.com>
In-Reply-To: <20250224232228.990783-1-ahmed.zaki@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 michael.chan@broadcom.com, tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 16:22:21 -0700 you wrote:
> Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
> after reset. However, since there can be only one IRQ affinity notifier
> for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
> management in the core (which also registers separate IRQ affinity
> notifiers).
> 
> Move the IRQ affinity management to the napi struct. This way we can have
> a unified IRQ notifier to re-apply the user-set affinity and also manage
> the ARFS rmaps.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/6] net: move aRFS rmap management and CPU affinity to core
    https://git.kernel.org/netdev/net-next/c/bd7c00605ee0
  - [net-next,v9,2/6] net: ena: use napi's aRFS rmap notifers
    https://git.kernel.org/netdev/net-next/c/de340d8206bf
  - [net-next,v9,3/6] ice: clear NAPI's IRQ numbers in ice_vsi_clear_napi_queues()
    https://git.kernel.org/netdev/net-next/c/30b78ba3d4fe
  - [net-next,v9,4/6] ice: use napi's irq affinity and rmap IRQ notifiers
    https://git.kernel.org/netdev/net-next/c/4063af296762
  - [net-next,v9,5/6] idpf: use napi's irq affinity
    https://git.kernel.org/netdev/net-next/c/deab38f8f011
  - [net-next,v9,6/6] selftests: drv-net: add tests for napi IRQ affinity notifiers
    https://git.kernel.org/netdev/net-next/c/185646a8a0a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



