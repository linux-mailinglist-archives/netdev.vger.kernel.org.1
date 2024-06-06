Return-Path: <netdev+bounces-101234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5308FDCE5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439F11C2174A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42471199B9;
	Thu,  6 Jun 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njCbtPeE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82718638
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641633; cv=none; b=RDs9+VvE2VkGEIRaRZ7BFeWtH1sS/ljAvELIEEr0wGa3Q0tiwk30mDc0N2ePcx1h2Wer43X2J/JntuhfMwjo5jY+ovkz+FcknRetzxgrRAVfYU1JtVFwFcIyu7UrA477OUDY0E/8aCSc/d1BMcLoQNEICLYBnF0bZNyNNCZH/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641633; c=relaxed/simple;
	bh=2G8BaVFrqj+ONfuuNC/4IpQHVY1Rgfy8gqj4HFVzF10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BX58i+D+hyAkx2xw1THeIfJ1+FMCD6E0e/lM1VRqKkRoHZuFaWdr6laPcQ7MeuAsgT5RkFsn7lxbvwMMnNT8oDLcE0PYH/6iuZOO+XoJHWA5yNk6MqlEEjPb3PH809UnTVxs7fWbw8hDuoBCC6wldlhEmtprDcng/lf8AbpFeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njCbtPeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74845C4AF0C;
	Thu,  6 Jun 2024 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717641632;
	bh=2G8BaVFrqj+ONfuuNC/4IpQHVY1Rgfy8gqj4HFVzF10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=njCbtPeEl9kDfgjX0lOqcgQ8LyxTHDze3Z9/H+z8umIsYw4hsVuIccl7mysS0cfbg
	 VuvCXr0Qnt3u/2FdPke3B9zDHKRk8QWlgMtrQAuOoUIfOn60qo1a/DRcUY3g+ROP69
	 fePKkM4SwDOvSXVbAPcLSbM90dwsZD7b2b5ZMJWj11Rl6OcyGZF93ipx1JySWa5s94
	 7z65X/JFXHfBv4bO1EZf1u/PiTq7qQ3/e4OksIHNRS0RLj7CBkxb5qHgFWPLgpAuYG
	 8DXNriYuAVugLzApl1OKcN9ogmymdtmceghJo0Fvl/nPOrkAKxBOfUsBU74oUlHftb
	 9X7c8Ty3qVizg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EF5CD3E996;
	Thu,  6 Jun 2024 02:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/6] Intel Wired LAN Driver Updates 2024-05-29 (ice,
 igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171764163238.28437.2661144010302792367.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 02:40:32 +0000
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
In-Reply-To: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 himasekharx.reddy.pucha@intel.com, larysa.zaremba@intel.com,
 horms@kernel.org, chandanx.rout@intel.com, igor.bagnucki@intel.com,
 sasha.neftin@intel.com, dima.ruinskiy@intel.com, naamax.meir@linux.intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 03 Jun 2024 14:42:29 -0700 you wrote:
> This series includes fixes for the ice driver as well as a fix for the igc
> driver.
> 
> Jacob fixes two issues in the ice driver with reading the NVM for providing
> firmware data via devlink info. First, fix an off-by-one error when reading
> the Preserved Fields Area, resolving an infinite loop triggered on some
> NVMs which lack certain data in the NVM. Second, fix the reading of the NVM
> Shadow RAM on newer E830 and E825-C devices which have a variable sized CSS
> header rather than assuming this header is always the same fixed size as in
> the E810 devices.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/6] ice: fix iteration of TLVs in Preserved Fields Area
    https://git.kernel.org/netdev/net/c/03e4a092be8c
  - [net,v2,2/6] ice: fix reads from NVM Shadow RAM on E830 and E825-C devices
    https://git.kernel.org/netdev/net/c/cfa747a66e5d
  - [net,v2,3/6] ice: remove af_xdp_zc_qps bitmap
    https://git.kernel.org/netdev/net/c/adbf5a42341f
  - [net,v2,4/6] ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
    https://git.kernel.org/netdev/net/c/744d197162c2
  - [net,v2,5/6] ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()
    (no matching commit)
  - [net,v2,6/6] igc: Fix Energy Efficient Ethernet support declaration
    https://git.kernel.org/netdev/net/c/7d67d11fbe19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



