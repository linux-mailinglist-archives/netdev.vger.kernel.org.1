Return-Path: <netdev+bounces-242147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA52C8CBD3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D09A3B5D32
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD222C11FA;
	Thu, 27 Nov 2025 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWQyd4vp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DA2BEC4E
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213450; cv=none; b=lYyKu8udq0iSp5xuCh00/xhmlW86Nql8M54VBwUiGo8NFN8fXP3os/1/4KV+OqJ8VMI3LuAB2Piu6wE1AJHUAebjMWeBxWPbqwkifhzzdt5sFThJtjnBQAoerYFLSpxIJ/+CKQuEh6JwTjh3ooM+UQT8vtSUHGP95z7//92rrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213450; c=relaxed/simple;
	bh=7pVp8wc7EPlFbr7yYf7Rxzaf8CNFAjzrtJiEomZf8aU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nka1W4MP/B6RqGtRrgmad2pUrFH9GoYRagVe3+uYRsrvub2ADzVcWlOwqUk8NVgEi817gcs7XniBDHJF1NbMNe6299B0ZbUl2UubYTyc1begcnwFW01tLGxa/J3yz6dstnWV25J9X3P1WCKzpbQ6jr1OgIDRpOxZRj6KQT18guA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWQyd4vp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192A4C4CEF7;
	Thu, 27 Nov 2025 03:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213450;
	bh=7pVp8wc7EPlFbr7yYf7Rxzaf8CNFAjzrtJiEomZf8aU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dWQyd4vp8IzWlAnistxR/6GJvCd3bfcxT/c/rGMnO3Cdg+zdZauEQzVOo3WrcIGQ4
	 Yw7NB0oSieldXeIDrFBT7LhqqLatFocmi6kpSvdYeymZ84+KGqdzUAM+ivb1aMvS0m
	 JR1WppK9RJ7gnaWNFkUZ5NcFTyGRJ/KPraE/i6fMUNVdFVS79FhBAKyQ14viEUgNGu
	 QaavOaK0vScHXv5jEnJQgxYSaqhI05Fi85YP4Bz9ge6HIsbJBqnT1mlilo687zWLtz
	 1Uiy+ynMwfb252sj411CjRW511xdx0nWlkxV27m8VA/qKjTmDQwC/MYzr9wTv95DUD
	 qLM/P2Tj076mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD2380CEF8;
	Thu, 27 Nov 2025 03:16:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fman_memac: report structured ethtool
 counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421341149.1916399.4189336297993126583.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:51 +0000
References: <20251122115931.151719-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251122115931.151719-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com, sean.anderson@seco.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.wilhelm@westermo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 13:59:31 +0200 you wrote:
> The FMan driver has support for 2 MACs: mEMAC (newer, present on
> Layerscape and PowerPC T series) and dTSEC/TGEC (older, present on
> PowerPC P series). I only have handy access to the mEMAC, and this adds
> support for MAC counters for those platforms.
> 
> MAC counters are necessary for any kind of low-level debugging, and
> currently there is no mechanism to dump them.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fman_memac: report structured ethtool counters
    https://git.kernel.org/netdev/net-next/c/37a96c2009f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



