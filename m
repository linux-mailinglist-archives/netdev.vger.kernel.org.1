Return-Path: <netdev+bounces-231059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B13BF4484
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743A53A8732
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EFF1D88D0;
	Tue, 21 Oct 2025 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFa+gFHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35D15D1;
	Tue, 21 Oct 2025 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010832; cv=none; b=t6lQ0++Gh44pmodjzgTf0TkS13ALt4GHiCPt9spZWm5MzVcjq1nXgkUMiSG2+34bcQAPZG/+//TCDENB4YYFgjZh+sGZjbt23Wfrx2WcJtDS1RQu61KpaSLmS+gN6q3yGauLk8gIHlBF38blxV6reLcQCDr1vnb5VMZhEmIr5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010832; c=relaxed/simple;
	bh=vqmbLX8f4urGDiGVZm9x6Y4bYkeTPTxluKAPymbVGCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7u1cPEXrFWfXGeXkr7wJPgHV5AXESwiagKpklXw4nM+uxgiLZ3pbBJtiWY5J51eHd0x/jduvryMphXLuNtR2iCmHqf58s2y4+lgL2xtmP8TbtbilBETYc93qSurfTTTC8inr+QwrLDVcUTlq24eVf2O2XRzla7mbipE+P8Tabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFa+gFHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C2FC4CEFB;
	Tue, 21 Oct 2025 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761010831;
	bh=vqmbLX8f4urGDiGVZm9x6Y4bYkeTPTxluKAPymbVGCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iFa+gFHV0eB273Xl9sBzr9kqfdGe7VUQQ1gPD48SsTkl9NOqou7m+q5tVzBI9zNww
	 QRtocp/CVACO5MNHXf+NCpwWqcifenf0MTaFfryNQc5JjkBFyjA1T5S0EVMUd5Pnez
	 92MVtfKa7nJuOrik+P/AzapyCO+rquH+kIwldDg0tniFBxHG7Zc4TsyIiIZoz6a1DR
	 A611RHtjZ4altHYA4eK+4Gc4Lz//FVNd3iQ6z9FHxC1m+mnFqGlQTMox4Myw1g0Zpk
	 sTxqhIFBlrManLu3cgX15jCYItpjBJL20WkEjHtOEYiRyPpg6ohbmvGGR7fR/wvwSb
	 frAUZk9Zdej5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAB3A4102D;
	Tue, 21 Oct 2025 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/14] Intel Wired LAN Driver Updates
 2025-10-15 (ice, iavf, ixgbe, i40e, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176101081325.484471.16736237984983898429.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 01:40:13 +0000
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mheib@redhat.com,
 aleksandr.loktionov@intel.com, rafal.romanowski@intel.com,
 dan.nowlin@intel.com, junfeng.guo@intel.com, ting.xu@intel.com,
 jie1x.wang@intel.com, qi.z.zhang@intel.com, jedrzej.jagielski@intel.com,
 rrameshbabu@nvidia.com, pmenzel@molgen.mpg.de, marcin.szycik@linux.intel.com,
 sx.rinitha@intel.com, hkelam@marvell.com, enjuk@amazon.com,
 vitaly.lifshits@intel.com, timo.teras@iki.fi, dima.ruinskiy@intel.com,
 Avrahamx.koren@intel.com, jbrandeburg@cloudflare.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 23:08:29 -0700 you wrote:
> Mohammad Heib introduces a new devlink parameter, max_mac_per_vf, for
> controlling the maximum number of MAC address filters allowed by a VF. This
> allows administrators to control the VF behavior in a more nuanced manner.
> 
> Aleksandr and Przemek add support for Receive Side Scaling of GTP to iAVF
> for VFs running on E800 series ice hardware. This improves performance and
> scalability for virtualized network functions in 5G and LTE deployments.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/14] devlink: Add new "max_mac_per_vf" generic device param
    (no matching commit)
  - [net-next,v2,02/14] i40e: support generic devlink param "max_mac_per_vf"
    (no matching commit)
  - [net-next,v2,03/14] ice: add flow parsing for GTP and new protocol field support
    (no matching commit)
  - [net-next,v2,04/14] ice: add virtchnl and VF context support for GTP RSS
    (no matching commit)
  - [net-next,v2,05/14] ice: improve TCAM priority handling for RSS profiles
    (no matching commit)
  - [net-next,v2,06/14] ice: Extend PTYPE bitmap coverage for GTP encapsulated flows
    (no matching commit)
  - [net-next,v2,07/14] iavf: add RSS support for GTP protocol via ethtool
    (no matching commit)
  - [net-next,v2,08/14] net: docs: add missing features that can have stats
    https://git.kernel.org/netdev/net-next/c/98c2f0b42eea
  - [net-next,v2,09/14] ice: implement ethtool standard stats
    https://git.kernel.org/netdev/net-next/c/20ae87514ad5
  - [net-next,v2,10/14] ice: add tracking of good transmit timestamps
    https://git.kernel.org/netdev/net-next/c/4368d5fe02f6
  - [net-next,v2,11/14] ice: implement transmit hardware timestamp statistics
    https://git.kernel.org/netdev/net-next/c/71462475d002
  - [net-next,v2,12/14] ice: refactor to use helpers
    https://git.kernel.org/netdev/net-next/c/a308ea972112
  - [net-next,v2,13/14] ixgbe: preserve RSS indirection table across admin down/up
    (no matching commit)
  - [net-next,v2,14/14] e1000e: Introduce private flag to disable K1
    https://git.kernel.org/netdev/net-next/c/3c7bf5af2196

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



