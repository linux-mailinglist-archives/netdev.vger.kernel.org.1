Return-Path: <netdev+bounces-248192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE1D04B94
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F1A03075E90
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA6528C035;
	Thu,  8 Jan 2026 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Y5gOc9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594F28B4FD
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891826; cv=none; b=H/mY6PcYcD7ZPOyjY+JdswhSITsKNyR+TVbeLsb25ws9lvZNRr54+J1MqH+AoZPWg/ijx7yeygi47mUqzihUSzWiw7vQXK02wxvbZ1SzkUmZ2IT8oDBrfZP/7gF507abCsNIEg/ZlZN4hadmIQN0NiucDMt4/M7FacsyEUMagxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891826; c=relaxed/simple;
	bh=hXLfr/FkIh1+o5RHbXE2ZwBKPHfSxqrO7ZpYqzQcmzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g2i55eEjeMDMW+XZVSb+LqQznTxzyu4uO2UdEIXvpiN7wuF1chAVEdf+C6+/yga3maT3gVzdO4gNCV599eMEFmaoY/BJ3QsXpvCTRZfI+GMkiOZR/sXrDrdOdjCUl3vkkpGCi//rJSgMOVTn2JdQeS1C85iC1MnCSLbLPfBVJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Y5gOc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C86C116C6;
	Thu,  8 Jan 2026 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891826;
	bh=hXLfr/FkIh1+o5RHbXE2ZwBKPHfSxqrO7ZpYqzQcmzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z/Y5gOc9d3rvWg8o7OqdRZudrH6tvVe+OBjIfG+VKczXC28jor7RqjvaPWXlC9KfU
	 xW2UiL9ZP8Vl7ZzcpJbX3R4qKocbqjTceDGzGKInAviuz5OKq8yoykIz9y0lxp2MvD
	 hEW9PQxWOg5UxgFTcaxrXRgtfmHHxUplByUE2PRc1HkjFxbOYtDC+3SmwMtwP8Vsgt
	 KE6jEYpPk8vBbpcezurBW6/UuAFFS0o1QX9t6eEXuTPdhMDpfhN9Yp9tJOo4mxtapd
	 TfBItXs326NAM8DNfB080VzPAh1Xr0rOiSQo10B4yfN/UrxLunbcRWefDdQIjq41VN
	 2kqsoYdpT8eOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2D893AA940D;
	Thu,  8 Jan 2026 17:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/13][pull request] Intel Wired LAN Driver Updates
 2026-01-06 (idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789162279.3720850.14296320536814121658.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 17:00:22 +0000
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 emil.s.tantilov@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  6 Jan 2026 16:06:32 -0800 you wrote:
> This series contains updates to idpf driver only.
> 
> Emil fixes issues related to resets; among them timeouts, NULL pointer
> dereferences, and memory leaks.
> 
> Sreedevi resolves issues around RSS; mainly involving operations when
> the interface is down and resets. She also addresses some incomplete
> cleanups for ntuple filters and interrupts.
> 
> [...]

Here is the summary with links:
  - [net,01/13] idpf: keep the netdev when a reset fails
    https://git.kernel.org/netdev/net/c/083029bd8b44
  - [net,02/13] idpf: detach and close netdevs while handling a reset
    https://git.kernel.org/netdev/net/c/2e281e1155fc
  - [net,03/13] idpf: fix memory leak in idpf_vport_rel()
    https://git.kernel.org/netdev/net/c/f6242b354605
  - [net,04/13] idpf: fix memory leak in idpf_vc_core_deinit()
    https://git.kernel.org/netdev/net/c/e111cbc4adf9
  - [net,05/13] idpf: fix error handling in the init_task on load
    https://git.kernel.org/netdev/net/c/4d792219fe6f
  - [net,06/13] idpf: fix memory leak of flow steer list on rmmod
    https://git.kernel.org/netdev/net/c/f9841bd28b60
  - [net,07/13] idpf: fix issue with ethtool -n command display
    https://git.kernel.org/netdev/net/c/36aae2ea6bd7
  - [net,08/13] idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
    https://git.kernel.org/netdev/net/c/83f38f210b85
  - [net,09/13] idpf: Fix RSS LUT configuration on down interfaces
    https://git.kernel.org/netdev/net/c/445b49d13787
  - [net,10/13] idpf: Fix RSS LUT NULL ptr issue after soft reset
    https://git.kernel.org/netdev/net/c/ebecca5b0938
  - [net,11/13] idpf: Fix error handling in idpf_vport_open()
    https://git.kernel.org/netdev/net/c/87b8ee64685b
  - [net,12/13] idpf: cap maximum Rx buffer size
    https://git.kernel.org/netdev/net/c/086efe0a1ecc
  - [net,13/13] idpf: fix aux device unplugging when rdma is not supported by vport
    https://git.kernel.org/netdev/net/c/4648fb2f2e72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



