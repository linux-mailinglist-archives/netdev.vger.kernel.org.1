Return-Path: <netdev+bounces-138580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3469AE335
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0901C224CF
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBEC1C9B81;
	Thu, 24 Oct 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN4FpdJ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F81C4A33
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767627; cv=none; b=Rw/EkE5rpI0eUaXponcelX4qMeJr2stxgaqGhdd2CgprLa+0hGIeSqniaAOWrK81zqiQulWpZToFLaSznKMoiVa0svN1BUBcarKwZLbFVv7Vwrq17hTEWTe6Daj9TZxGC73a5yon0wu4NlLN+GrPmZ/gu7jronnWUCKYrLeGv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767627; c=relaxed/simple;
	bh=+l1e5LKa8wZ48pc/d+g8uQUZI92XnFFYeaCgQRHP+qM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G6LIlu/LeOlBOzpmakkR865qVTeVUspulnXzz1Wpi4Kz2HIWQ1NdRHtZ3zloBoA/N5/ym4JyNUe40LRn+Q8bQjPe9rwhHRGu6nnAnSBe5RseaS9vBl/4bf4lPZgpvmiOVqf3+GKzUbrkDhVVnYq6r+c65mv4CoOxIKyz7DB2h/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN4FpdJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF29AC4CEC7;
	Thu, 24 Oct 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767626;
	bh=+l1e5LKa8wZ48pc/d+g8uQUZI92XnFFYeaCgQRHP+qM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aN4FpdJ1/BkX55FwMtgzfmbBwiTcpnuHsO2LevdDZHIXDVyUo6tPXs06Vozd5fv0R
	 s1EzLkb3oNdYuG9kgMMejo1qA8JB3c91tfyVFXVzCbuVMHheQHYhI9MHxKT8RfkdO2
	 lraZ+deBdFaBVcHK0+sQXEdjZlBTAXXNOPI0jMeiw61l85S0FmzAOLHX805ah7BPDd
	 fOloF/S4prCwWpYNgsZK/sWLK8xTrq+oMhJxWavCo4MbYaOERdk8WaJqCyIyaEauNQ
	 1+c+Ctu9uACMGULKiTxO7jJFhV+V22BPjchtubMHfKWd9L3lWZ/fPEtbODBq6uV2+E
	 EHGyPE8WqE9kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD68380DBDC;
	Thu, 24 Oct 2024 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: dsa: mv88e6xxx: fix MV88E6393X PHC frequency
 on internal clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172976763352.2198052.11564087146899333434.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 11:00:33 +0000
References: <20241020063833.5425-1-me@shenghaoyang.info>
In-Reply-To: <20241020063833.5425-1-me@shenghaoyang.info>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
 pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org,
 andrew@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, kuba@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 20 Oct 2024 14:38:27 +0800 you wrote:
> The MV88E6393X family of switches can additionally run their cycle
> counters using a 250MHz internal clock instead of the usual 125MHz
> external clock [1].
> 
> The driver currently assumes all designs utilize that external clock,
> but MikroTik's RB5009 uses the internal source - causing the PHC to be
> seen running at 2x real time in userspace, making synchronization
> with ptp4l impossible.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: dsa: mv88e6xxx: group cycle counter coefficients
    https://git.kernel.org/netdev/net/c/67af86afff74
  - [net,v3,2/3] net: dsa: mv88e6xxx: read cycle counter period from hardware
    https://git.kernel.org/netdev/net/c/7e3c18097a70
  - [net,v3,3/3] net: dsa: mv88e6xxx: support 4000ps cycle counter period
    https://git.kernel.org/netdev/net/c/3e65ede526cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



