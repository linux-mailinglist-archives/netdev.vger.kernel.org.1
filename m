Return-Path: <netdev+bounces-246142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC440CDFF18
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D1923002152
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD0313293;
	Sat, 27 Dec 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trYhIOB6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9921B4244
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766852653; cv=none; b=bPf8eM0oowA73mhcJ9v7rz7tKHCmhrogHcji/eiUPQQakDXr5ZV+1JwZuuyH+mF93NasC3eNcaydYw0rRBKcKuCAZ9j4mUoJz2/Igzvk0Q7FkZdFPNtkOiOlN5knzKpxoZ48kQvJgvlvH2miIMXzdkav/rLXaK/yRrnqcpYc5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766852653; c=relaxed/simple;
	bh=5veDri74shuy5XCFIAlCdbGNbBDt8RRTucBBSU4IFSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=foaHlbwtDMexF7/oftawQY32HT4HgE9/BdVdeqq5i4OxcrvLYFtwp5YmIKiXF6RH/2m56hrIjgYFqbFpxVgvKpYMkr/e7/9/uyckLynH6IcZsHDsNNv7AWSZgctOrJ0q/rIa1b437Ny+5eF81TB2MVMB06eeB6EE/cXaKFYicek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trYhIOB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0B9C4CEF1;
	Sat, 27 Dec 2025 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766852653;
	bh=5veDri74shuy5XCFIAlCdbGNbBDt8RRTucBBSU4IFSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=trYhIOB6lo+KgZyOwpaC6HVA9UYkd6rkYqYH5Q6VGDkUNjZzQm3u8xZo4+bf782eq
	 IrnTDpIFntWsU+P47b3XF7xQ/2exivkANO6cI2hebRSnzO9l0ZNp5tlPw9oJXuWF+o
	 IAZglENFoF4GfE0mDO80Ude6BshCCSKMhilkz9gdZMYSJHRTkn2bosOES+qvH7V8wc
	 pWU3aBgyPtc0KTwSPbbve0ioq7fcBaDh04AlWvHHMou3GbRT2xUZJ/ptyO8eZCTnyK
	 9B6vtwG17ylcqRTXZhVylhmA5dIPIrW1VbpYv57aQoR3cldCpaltZCVpWtkoRNZac6
	 thB1V/bKMWlgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7B23AAA77C;
	Sat, 27 Dec 2025 16:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2025-12-17 (i40e, iavf, idpf, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176685245705.2172831.10962001399413974589.git-patchwork-notify@kernel.org>
Date: Sat, 27 Dec 2025 16:20:57 +0000
References: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 17 Dec 2025 11:49:39 -0800 you wrote:
> For i40e:
> Przemyslaw immediately schedules service task following changes to
> filters to ensure timely setup for PTP.
> 
> Gregory Herrero adjusts VF descriptor size checks to be device specific.
> 
> For iavf:
> Kohei Enju corrects a couple of condition checks which caused off-by-one
> issues.
> 
> [...]

Here is the summary with links:
  - [net,1/6] i40e: fix scheduling in set_rx_mode
    https://git.kernel.org/netdev/net/c/be43abc55141
  - [net,2/6] i40e: validate ring_len parameter against hardware-specific values
    https://git.kernel.org/netdev/net/c/699428342153
  - [net,3/6] iavf: fix off-by-one issues in iavf_config_rss_reg()
    https://git.kernel.org/netdev/net/c/6daa2893f323
  - [net,4/6] idpf: fix LAN memory regions command on some NVMs
    https://git.kernel.org/netdev/net/c/4af1f9a47291
  - [net,5/6] idpf: reduce mbx_task schedule delay to 300us
    https://git.kernel.org/netdev/net/c/b3d6bbae1d6d
  - [net,6/6] e1000: fix OOB in e1000_tbi_should_accept()
    https://git.kernel.org/netdev/net/c/9c72a5182ed9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



