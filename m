Return-Path: <netdev+bounces-161953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239BA24C69
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD36B163424
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BA3C3C;
	Sun,  2 Feb 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9bJBS28"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F6380;
	Sun,  2 Feb 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738459212; cv=none; b=hClb+St9S2sQ6BZVsVxfDE3EC4p9cFKrZRbJ8O5RH7p+UP2NHyuoBt55+jvEu78w88eJyM2p7rifUxLDRkfdHZP9bJbRwj85KdV7Ake9cP/JO0nQFWQ2N1jA+l234NvL0f5qRKkwqi0Al3N1x2P2wFg+ax3xy1J5J/V92qvfSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738459212; c=relaxed/simple;
	bh=GbcQEQpjuXezmd6s4Xjo3yFPd81uZdTBhnNerQvz48Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D2DVFXo3bYiSvEzybSFQi65PJlJ4fmUlfU28W/4UCEaYnY6ulQwMtIgNfOxE0DuDF8jZfvNtyAHW8/1Xy5TrTViaYevBJEtrihqSK90+dgqeLnu4jJ2GODosUkHcOjErvJz+ybNOtXaAvBkSDnaj0Oehgo//U5UyEXCnq8DRSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9bJBS28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEEFC4CED3;
	Sun,  2 Feb 2025 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738459211;
	bh=GbcQEQpjuXezmd6s4Xjo3yFPd81uZdTBhnNerQvz48Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q9bJBS28WSd7V59JcFvaUX6ewy+nlyTzOqnjYBsemLu9etJMvQJRyKwk4whYKvMBm
	 qOAB12WdTlU3+8myRS0EEg8L3+xNGjjjM4XQbsadsbI224Fo+d0uU7dm1VJGa1qGpE
	 5iq9lTUBw0hTfI+1rrPf5Enh35b1sNYStyrm7ADPzmsUDGLeHbL9EB3OMzIXyUenHr
	 vyeJ/Dil9bw+93l9wGs37zYzXcX+egHWNMAPE4Io2B12rVTM4crY2d2sdzHFSNGGMq
	 tpfOTJmpjFynCzfBN7Pua4HNHmsNTs2mpHtuKCKS1TbXQxO3lxd/8TElvv2YM6K48V
	 6qVVzTG1M+2KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 722F9380AA68;
	Sun,  2 Feb 2025 01:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ice: Add check for devm_kzalloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173845923827.2030588.8008436658888569180.git-patchwork-notify@kernel.org>
Date: Sun, 02 Feb 2025 01:20:38 +0000
References: <20250131013832.24805-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20250131013832.24805-1-jiashengjiangcool@gmail.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.swiatkowski@linux.intel.com,
 horms@kernel.org, wojciech.drewek@intel.com, piotr.raczynski@intel.com,
 mateusz.polchlopek@intel.com, pawel.kaminski@intel.com,
 michal.wilczynski@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jan 2025 01:38:32 +0000 you wrote:
> Add check for the return value of devm_kzalloc() to guarantee the success
> of allocation.
> 
> Fixes: 42c2eb6b1f43 ("ice: Implement devlink-rate API")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - ice: Add check for devm_kzalloc()
    https://git.kernel.org/netdev/net/c/a8aa6a6ddce9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



