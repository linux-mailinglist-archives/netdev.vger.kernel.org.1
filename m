Return-Path: <netdev+bounces-134034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A85997B1C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45E41C21D75
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE6188CB5;
	Thu, 10 Oct 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPV8fYz9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFA188A08
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529829; cv=none; b=UpwTCSHllU063ByAkfsQKye8+OSxshOG7lMmp3G+LiVZDMJeWXiXufFvlh7mkdW5s6B1J0r0F55beL+0/o+WMCNhnb7yQjNwhbQVnURV94bMM9gK2d8vEE5cRQJ0vz6F/jhYqmvMQhLCCQCCFjoYlf+yBQNW5sLz+pWKA6Ned9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529829; c=relaxed/simple;
	bh=PAyOCw107pP+peacZexfB1zMvrqBPsCowZSAfEa+38A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=putQwEGnXTRJ1dnq0g0CDvy5GOJhpdmoO3oDala6UBkik41Mo/iLJDW9ewNMxTJ4DjP04NN6g/+AMe5W+rvGIwC7SKPEfdPGBc28MEchWTL3ctvkx5FeWeUWbKJZmOQ5RR6E2yc2Z3Y+tt6qZywjd6z4v3vgahOzcyzSJMB1aP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPV8fYz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EF6C4CECE;
	Thu, 10 Oct 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529828;
	bh=PAyOCw107pP+peacZexfB1zMvrqBPsCowZSAfEa+38A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pPV8fYz9U67x/NuQMsxeY8Z8Y49+0eYPCAppEbpoZ9KUZWAN1mMruFq4Rq1OJDNeK
	 2inKjXOMxBpd6aMt+cjHKGw9NmkP2SvGkkoVj0aIYYQL4iCZHdQBTgHYQ0bT/BJ2YB
	 6yVv62m0WUakK6sK7h54g7PE1g8k7wf6BISpzVoKuUn2sJJA719qyG63s1GOg8MskD
	 d95m7gwUuZDVncAEFaFq9XCOm767xkyN/U06Ngt1yTho6huDKz1hbmFa3/zBKsaXdf
	 1FcgwmyWdRtSWSxpj4VXtUwqt4ePa4GtWBHo4cL+/X+1Gn9x9ozl0f1aDvl2cClRQY
	 9dnPzj12T1SOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2263806644;
	Thu, 10 Oct 2024 03:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7][pull request] Intel Wired LAN Driver Updates
 2024-10-08 (ice, i40e, igb, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852983276.1551072.12952034396804784358.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 03:10:32 +0000
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  8 Oct 2024 16:00:38 -0700 you wrote:
> This series contains updates to ice, i40e, igb, and e1000e drivers.
> 
> For ice:
> 
> Marcin allows driver to load, into safe mode, when DDP package is
> missing or corrupted and adjusts the netif_is_ice() check to
> account for when the device is in safe mode. He also fixes an
> out-of-bounds issue when MSI-X are increased for VFs.
> 
> [...]

Here is the summary with links:
  - [net,1/7] ice: Fix entering Safe Mode
    https://git.kernel.org/netdev/net/c/b972060a4778
  - [net,2/7] ice: Fix netif_is_ice() in Safe Mode
    https://git.kernel.org/netdev/net/c/8e60dbcbaaa1
  - [net,3/7] ice: Flush FDB entries before reset
    https://git.kernel.org/netdev/net/c/fbcb968a98ac
  - [net,4/7] ice: Fix increasing MSI-X on VF
    https://git.kernel.org/netdev/net/c/bce9af1b030b
  - [net,5/7] i40e: Fix macvlan leak by synchronizing access to mac_filter_hash
    https://git.kernel.org/netdev/net/c/dac6c7b3d337
  - [net,6/7] igb: Do not bring the device up after non-fatal error
    https://git.kernel.org/netdev/net/c/330a699ecbfc
  - [net,7/7] e1000e: change I219 (19) devices to ADP
    https://git.kernel.org/netdev/net/c/9d9e5347b035

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



