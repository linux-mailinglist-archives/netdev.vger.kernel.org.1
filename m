Return-Path: <netdev+bounces-226832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95599BA579D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B246E2A0794
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA2214A64;
	Sat, 27 Sep 2025 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwwBwgch"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAEF2139CE
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935427; cv=none; b=BdtKTabvsGzodIkc/mqqtjlZkjjU+LPqcuYVgImmYumZdTtmEV4WT/fhWO1W+zEml1kxSDJRKbPHZc+IWqxzzza4PnYkK9tigZvOMp2xWvCGxXmIxg+zE5yUjqSwVvu/bcfTgNJPGVTfo77zzWkk4ihxic03mVfIcMYS3d4/xJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935427; c=relaxed/simple;
	bh=PHULwKgMAgRXUU7T79SVcN/vmBwfsHQaZaraM1WPTSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZaIjpr+tPE5tO7F6+LFFhYP/qWGUxue+CFpnGMzFPzCyenekr9/33fCOK1ylrxZjUWEjpkNR9vACP2CgFkL30PzrOBANqam0gVNuobhOzu7ikQ0hSbe1vcw5Q80wGUDiBEneNSRiTKVfMYUAmiaqNN5807p6iVgMjBuw5C+Wei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwwBwgch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D4C4CEF8;
	Sat, 27 Sep 2025 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758935426;
	bh=PHULwKgMAgRXUU7T79SVcN/vmBwfsHQaZaraM1WPTSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AwwBwgch6bConZOoEl5nCdgQ3utQpMT9mmV2U2tDHtkZV6DafKntiju6PGcSI0yBn
	 dyaboTLJypsRStMvzOObsqViBgDb+z/sakntbmBDeLfBrJJWacoHNqkhMEVassyZ4S
	 weafsIV9Jku77ngb/yqaxN+MR/Ke7yrFXM7OsrsCFcbBxAo5weRCk00dDq3sEKEfXO
	 v9z7EYwUhYa36sOgtE5Irirpis3XGhHIO6RGhdVG0R+wmF5LFGiG4dFax70bUTm4eu
	 BZ1zQU1UIz5cj5tW4ltfrJwBLy8WyCSIJCJxV7ocVkeLLSrUuQ7pLn/Spb+LSH0rSM
	 4KYD1Jje0rgww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB04039D0C3F;
	Sat, 27 Sep 2025 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: Add support to read lane count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893542174.113130.7691074286270953919.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:10:21 +0000
References: <20250924184445.2293325-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250924184445.2293325-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com,
 vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 11:44:45 -0700 you wrote:
> We are reporting the lane count in the link settings but the flag is not
> set to indicate that the driver supports lanes. Set the flag to report
> lane count.
> 
>  ~]# ethtool eth0 | grep Lanes
> 	Lanes: 2
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: Add support to read lane count
    https://git.kernel.org/netdev/net-next/c/20a2e46f9e4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



