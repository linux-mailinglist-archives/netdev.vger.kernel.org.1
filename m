Return-Path: <netdev+bounces-185353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE7CA99E5F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BC6462A52
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6578F2D;
	Thu, 24 Apr 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gisNR/Iw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F762701C3
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458794; cv=none; b=VsjXfwugrHJ8OEfP79Gxw0SpM4k+UHrjOqSXC4ceenvkHai5/f2xbXDkkXOvQFYR10ks82ompGy4PfYchvOudJ7G4acJ1ZuL3kGiGSwRfDQm8zfGuMCYEI3/4wbLHi8LwNIqIdC7nSCDYh2P6cJhejPnSWkqejvNnV1U077KE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458794; c=relaxed/simple;
	bh=MUMowXKySVj403uO6ye6TCP61gA0UokMAHamm+UsjNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B5NOVSU7ZlPAhnbIWVhaceXd5HB6q68f2IUm7RNuibGWJb/cpARXoRC0sJv8Jl859F8Ww3PuXrClSix1qk+qRkVxtjPvRYm+vAuMO6/kf6eWKa++WJliie7jgywT+THM9A1J/f2wDQBfHnT3R6Cg8RXWtd7b2ZGYyFRrPxlWDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gisNR/Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E335AC4CEE3;
	Thu, 24 Apr 2025 01:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745458793;
	bh=MUMowXKySVj403uO6ye6TCP61gA0UokMAHamm+UsjNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gisNR/IwLGHfeoeM8pxMoxl1Bth84kzBNNaFrKvNB/GcM78obL6Mk44mHR98Yri2J
	 sTKI1Xs0DVmyclzZZYxit0bK/AuXicpMGdrrpFUyaBJ6ciKixxCqi4tWZbDP+AqSl4
	 Q0Q1tAO6VoxxkvoT3yWBzWeAxUeUeCjqNnM472pBxS6bw/AXFw+AtvdaukPdArrweF
	 oYNxLOuzO3uJjXsqoyFfoXJrV68M8flkNoQRKS65PBz3qOCDhGXqoTNRdG8bhtKVPM
	 bcxyI7dOFke1L1IoiWphjQzVS9+ubpw1Dqm5tYzpUz1qaR5fm+2QadML0n7sh9wVX5
	 0Uxv/pphyE5Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0E1380CED9;
	Thu, 24 Apr 2025 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net v2 0/3] net_sched: Fix UAF vulnerability in HFSC qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545883253.2827090.11383416506982477015.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 01:40:32 +0000
References: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 gerrard.tai@starlabs.sg

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 11:47:29 -0700 you wrote:
> This patchset contains two bug fixes and a selftest for the first one
> which we have a reliable reproducer, please check each patch
> description for details.
> 
> ---
> v2: Add a fix for hfsc_dequeue
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net_sched: hfsc: Fix a UAF vulnerability in class handling
    https://git.kernel.org/netdev/net/c/3df275ef0a6a
  - [net,v2,2/3] net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
    https://git.kernel.org/netdev/net/c/6ccbda44e2cc
  - [net,v2,3/3] selftests/tc-testing: Add test for HFSC queue emptying during peek operation
    https://git.kernel.org/netdev/net/c/7629d1a04ad2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



