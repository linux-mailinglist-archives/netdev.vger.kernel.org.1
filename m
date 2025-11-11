Return-Path: <netdev+bounces-237591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279EC4D841
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6713A9B6D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E72A2F7479;
	Tue, 11 Nov 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTaPU1PR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5362D97AF
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861840; cv=none; b=lnF7gupB+x0BtvrWKOVJMuBTAFGVIsCRP1Z7uIEcXPLPLb9xUGd299zJaUCEzFm3pI2wcAbmL4JKbMRdr7OGwn9052hk7oFxRPnORVa4m9vbHOuc2OxfxpbMz0ffWOttRgLh00KEAb2Cfx+Qblyoli8esv/tJlB6/I83VTXhu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861840; c=relaxed/simple;
	bh=ZTzMfAdbokWAMu52c+kckiizg2ij0E72BrqK1tOeeAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnAcoyX/NVZo5/PGmvM4hoLuJkC9u98CJCFzoAsNk+JS4U+kxXcnKZm4fNNowNd7X6Avw1WF2lox7L9w0Vzug2nD0t4Jw11I5O+dbZ6ZlWiLyBYJaMQZ5T6U+lhmLCv+QKdYiSn228uMZglwPuFeZeUFJMkTQAHqdDlyp9Vw8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTaPU1PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38C4C16AAE;
	Tue, 11 Nov 2025 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861840;
	bh=ZTzMfAdbokWAMu52c+kckiizg2ij0E72BrqK1tOeeAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lTaPU1PRx5An4hFjxBH/Fvxzf5S7FLddRhV//X7qTCPkr8bNkqnYQtdcdpKnXpbbi
	 wqPLWBmWt6nACZ6NcaSQhuYYrCqpRgvp5i4Efz2fFVznfOM/zVceh2Oxvk/2YL3DJk
	 dR63T+PvlG/6bczLldyZz41W7yEwwNzG+DFl5g/UZzQjx/r4Ud/1AQl/9dEbZYtBS+
	 cCnW30/bHaVzzRq8zLH770+bIJgPnU/L27Uwa2DcO5YVTldoImpX3CNw+8Sy5P3jq1
	 OLPQRAFPyZFZL5gRD/ybLp9vFrhyZMOe62/IZNgHg7J1YOsaIj6Fkl3jfuRb/P0haV
	 Dq05QcDTmlOUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDA380CFFA;
	Tue, 11 Nov 2025 11:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] tools: ynl: turn the page-pool sample
 into a
 real tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176286181025.3403894.3277156213268110660.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 11:50:10 +0000
References: <20251107162227.980672-1-kuba@kernel.org>
In-Reply-To: <20251107162227.980672-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Nov 2025 08:22:23 -0800 you wrote:
> The page-pool YNL sample is quite useful. It's helps calculate
> recycling rate and memory consumption. Since we still haven't
> figured out a way to integrate with iproute2 (not for the lack
> of thinking how to solve it) - create a ynltool command in ynl.
> 
> Add page-pool and qstats support.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] tools: ynltool: create skeleton for the C command
    https://git.kernel.org/netdev/net-next/c/b02d229013aa
  - [net-next,v2,2/4] tools: ynltool: add page-pool stats
    https://git.kernel.org/netdev/net-next/c/124dac9b421c
  - [net-next,v2,3/4] tools: ynltool: add qstats support
    https://git.kernel.org/netdev/net-next/c/3f0a638d45fc
  - [net-next,v2,4/4] tools: ynltool: add traffic distribution balance
    https://git.kernel.org/netdev/net-next/c/9eef97a9dea3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



