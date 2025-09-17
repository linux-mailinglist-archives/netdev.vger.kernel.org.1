Return-Path: <netdev+bounces-224213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53381B82408
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8C02A7503
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AC131159B;
	Wed, 17 Sep 2025 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSSfVSIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229A31158F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151217; cv=none; b=LOR7TGQ8W4qHu/oMz+RLIiwfwbtEg1X8LxWnFUXrlOT8MxaaIPpXE0LZbvQHH2s4R2DX8P+oiHtj+/weg5qvCMm6jVuoPtcahDYRXB3vxzYtl/sw4tnVpFah9DGvZeogf8eyiEYJJpct+BtCJw53xX5G1+hhiVxiv9w9+JeXoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151217; c=relaxed/simple;
	bh=Vs/DnZgJptmNCxWNvDc6vOtwhOi4Q9QbEw5fFdZXQ58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mlXOj46EAnmxY65fKjDoE/9wElhWVWc/DugFN51sxuIyggyTa/Unqw4vyeHQWsnOV0DoZHM7khUfbwpYn5cXDmqUZWVKAX2mGKW/QBcoX47jPKeKo4/1D6SddOM4Kml6ycd1copSnwbwUrzMqcNztPDsKkgFna0TMdLY64ZRExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSSfVSIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E31C4CEF5;
	Wed, 17 Sep 2025 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758151217;
	bh=Vs/DnZgJptmNCxWNvDc6vOtwhOi4Q9QbEw5fFdZXQ58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CSSfVSIYmBJYMnDoFCgHw3e4iNiRJC25R4qzk1Gn1Nn4uXWFqZcNjH0aTqx8/0QoJ
	 CVWP7bg/mas2WYPcoB60BDgcq02EDw6cjkcdeD/CdxLtzdMlKGpndKYrHB3HQF9QcJ
	 I4+zEPh7M2AfHHubE1Nh4cKKLwdb1MC4DdZfQUuFohwO6N44Iow/AaDscRQ639SKxs
	 KBfday3ZokbS6EY/GT+XRk6ktZ6vIFOd3DGxdWEBERcnMMJ1DinJqDISFwmdbcDgRE
	 iqJk5fwaAGecFGDfwDm9ALrqjMZu88vl8rSS3CR2a7S8fl1N61+Gb7HWjBH4RVPyTh
	 aloY0baV8fu9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB139D0C28;
	Wed, 17 Sep 2025 23:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2025-09-16 (ice, i40e, ixgbe, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175815121723.2184180.13322022585138233446.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 23:20:17 +0000
References: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 16 Sep 2025 14:27:55 -0700 you wrote:
> For ice:
> Jake resolves leaking pages with multi-buffer frames when a 0-sized
> descriptor is encountered.
> 
> For i40e:
> Maciej removes a redundant, and incorrect, memory barrier.
> 
> [...]

Here is the summary with links:
  - [net,1/5] ice: fix Rx page leak on multi-buffer frames
    https://git.kernel.org/netdev/net/c/84bf1ac85af8
  - [net,2/5] i40e: remove redundant memory barrier when cleaning Tx descs
    https://git.kernel.org/netdev/net/c/e37084a26070
  - [net,3/5] ixgbe: initialize aci.lock before it's used
    https://git.kernel.org/netdev/net/c/b85936e95a4b
  - [net,4/5] ixgbe: destroy aci.lock later within ixgbe_remove path
    https://git.kernel.org/netdev/net/c/316ba68175b0
  - [net,5/5] igc: don't fail igc_probe() on LED setup error
    https://git.kernel.org/netdev/net/c/528eb4e19ec0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



