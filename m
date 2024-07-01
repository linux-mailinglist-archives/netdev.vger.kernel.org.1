Return-Path: <netdev+bounces-108133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2391DEF2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E038B20B45
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EFF14291E;
	Mon,  1 Jul 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK/sLNq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210B535D4
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836430; cv=none; b=tQW8TvEJzyONaqOY3ZR+Jjd02G4alsHUHL3eCXIp0pmpSilfnVF/5S8JGav3VYW9AKZbLOFpgYgvEcY05dqsCljCfqvB2useBtCwHsHbFnFYpYmKvyyFO7VgUwzIB6V5hBlTVYblMj/Qw40B5Fwzyglnb1Xkk0Z9lqhz9y/TjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836430; c=relaxed/simple;
	bh=7wapyQPeWbKDUjBCG13ucpZh98O71BeKiA1T4Hu8WPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NPI7dVMj2syy6UFO0wjJSkw8DFp1Cfnp+vSZL2HunmoIofY/wIzG+J9c2P/PVWA1MYPg9SvHIxp+3Yjoi2077cndeSSAznLWOMxAowcGqDwzm5vld3J5J5PXMKtQPSI5cs8G1LCOxpj6XdN1N07y0t+wLkPMDrrVPkLlwlT9Hcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK/sLNq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF95C32786;
	Mon,  1 Jul 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836430;
	bh=7wapyQPeWbKDUjBCG13ucpZh98O71BeKiA1T4Hu8WPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OK/sLNq8X23GPlJ63OOyDQ9vZsGFp4B8jCNmA6XGDosJo9zK2dLRuPg/C3xhpWzs7
	 et7zyB6WRuSvXTHqrsFEA1nDyBA5J2jcdfCSTw0RZrqACuTicPCfDyn4PbOm1/1Toq
	 EVDrKABzi/5DZbVaDLfuTlUzbi9U7DAN2Xyhh/qFtBMZqQ8+Dr02sbDNHqGq+iKdAq
	 R2p9XR3plL8ec4l1xrRvzzOAXy6Ck6TdaAYzfokoNILsowW7f6w890e3zzvX2qSFub
	 c5J+38LKuQSb+c6P7pd5SI4bZwIDDQr89PoHDDHFOj9hSnNytq4bUgHKAX5Rc69lOB
	 BPjlxCyA6Ti3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F7D7C43331;
	Mon,  1 Jul 2024 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates
 2024-06-28 (MAINTAINERS, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171983643019.16070.4159107412791580808.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 12:20:30 +0000
References: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 28 Jun 2024 13:13:18 -0700 you wrote:
> This series contains updates to MAINTAINERS file and ice driver.
> 
> Jesse replaces himself with Przemek in the maintainers file.
> 
> Karthik Sundaravel adds support for VF get/set MAC address via devlink.
> 
> Eric checks for errors from ice_vsi_rebuild() during queue
> reconfiguration.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] MAINTAINERS: update Intel Ethernet maintainers
    https://git.kernel.org/netdev/net-next/c/28cf7829a77f
  - [net-next,2/6] ice: Add get/set hw address for VFs using devlink commands
    https://git.kernel.org/netdev/net-next/c/4dbb4f9b8fc6
  - [net-next,3/6] ice: Check all ice_vsi_rebuild() errors in function
    https://git.kernel.org/netdev/net-next/c/d47bf9a495cf
  - [net-next,4/6] ice: Allow different FW API versions based on MAC type
    https://git.kernel.org/netdev/net-next/c/7dfefd0b9048
  - [net-next,5/6] ice: Distinguish driver reset and removal for AQ shutdown
    https://git.kernel.org/netdev/net-next/c/fdd288e9b764
  - [net-next,6/6] ice: do not init struct ice_adapter more times than needed
    https://git.kernel.org/netdev/net-next/c/0f0023c649c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



