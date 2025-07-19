Return-Path: <netdev+bounces-208290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D26B0AD13
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B235A32B4
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF36824A3;
	Sat, 19 Jul 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbWaA49M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769876034
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886208; cv=none; b=EI6WWLArCT1BDAGK8/BkVv0e3/XTucgFyuAdRfbZdKyWVqPA/50g6FopOPgd5QbI0v8vFGFQ7ZzB0J2G5yHtti2GAGCcZag/QDtrwN2If+FNmnxNBXeXn1+Sa+fujons1dsaxALemtoK9Ic7mwLuq5vXjlb+0yz9WDhlVmib4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886208; c=relaxed/simple;
	bh=thsEqbxsCdYwbZi+B+oAl1U8Y99TvShwyoPe+n0ijL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L11YnoMts2K7Cmwx9nJs5bbN2rF90pIWwjLdiIOkEWw5nDrF6kLCDqIfs9HQNWyrirKHOqt3qxQqU4NHJBlNK6tTNO97eZ54YZokUomURm22Xrnj8itEbB58ntGACuov1Wihp5FHoW5EpHZ7RMIoRnz0Wzu03kWbHmd4oc+PUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbWaA49M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B2DC4CEEB;
	Sat, 19 Jul 2025 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886208;
	bh=thsEqbxsCdYwbZi+B+oAl1U8Y99TvShwyoPe+n0ijL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RbWaA49MkHrbPcPDCI2hmCyXdlmbDEKG+mbor5LiSTceCyQ/vvQ4t+YI/Meh9CBDC
	 0Un+XezelWTHUKv83s6y3xS1MZ0pk4Znucx9J0sShrGSdB8AIqVYm1PzfZef1+Y5UA
	 NCzZxBgelDripwKADp0IkUEez5aXSzAkRvj8Oz7toEV2JI8/9cmKPltkcA+O1N8mUc
	 xavLGV45iGB1rTbI9rmZoIX/c5k5Tg/JWlXcSD8jpGM+dYAFkPpvmq4ESq3GPLQGI5
	 JU0MUiJXWpF+jJqZaUWlMsTUgiwOGpM4BIfWoFcBF+jW7mGylfmodvUdRTJEpCK/B5
	 rqVcThMUkRXjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6B383BA3C;
	Sat, 19 Jul 2025 00:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] be2net: Use correct byte order and format string
 for
 TCP seq and ack_seq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288622774.2839493.14681669640006771135.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:50:27 +0000
References: <20250717193552.3648791-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250717193552.3648791-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: somnath.kotur@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 12:35:47 -0700 you wrote:
> The TCP header fields seq and ack_seq are 32-bit values in network
> byte order as (__be32). these fields were earlier printed using
> ntohs(), which converts only 16-bit values and produces incorrect
> results for 32-bit fields. This patch is changeing the conversion
> to ntohl(), ensuring correct interpretation of these sequence numbers.
> 
> Notably, the format specifier is updated from %d to %u to reflect the
> unsigned nature of these fields.
> 
> [...]

Here is the summary with links:
  - [net-next] be2net: Use correct byte order and format string for TCP seq and ack_seq
    https://git.kernel.org/netdev/net-next/c/4701ee5044fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



