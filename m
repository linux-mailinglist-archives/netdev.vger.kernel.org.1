Return-Path: <netdev+bounces-105928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB4913A43
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 14:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763D6B203BB
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 12:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C1180A73;
	Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO4AC8CJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139912FF71
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144030; cv=none; b=odtMf/bQ5RB5GphFVue8J/4m169e1yRZJkPpQpl2nykxF6lxdJr8/nPxhhB1IrvtIZlBk/nAfvBqTt6jT6Uf15z17okkdbpOow7EHxnIx/cCa8AyUQ5B309zc7JAAEtdCQVRBgOe9mYyBZtVsF6Yp2rVfQRrw3zFYQnNTSmbT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144030; c=relaxed/simple;
	bh=1TQ95mxK7EpiRsyjjGlT7Jz2qSCPovxH2b667/H0JQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t4xx4Yfrhu0u3+TBlXpRzKa/mdRruiCSSyd3moIKL9u4Pk3T2RYBz4gDDqDSiZ2T/OPtO92f44pUGwkMtEmZEPqr1IfbtoQfvyK1i3JJqxpJJ52Qq6cwtlECUKTShZzrpAZ1EKk1a1MLYF19Vum5xMhirDTVYhCt/XHITQQf2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO4AC8CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63007C4AF07;
	Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719144030;
	bh=1TQ95mxK7EpiRsyjjGlT7Jz2qSCPovxH2b667/H0JQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pO4AC8CJoRaR3smTKXSBR67pT/qSs+fqGdze6su9Qq7aDU5RJrbbgX5VjTHK8gxmg
	 0crz8l9+1RbiqHW2x3eO3dz4smVQG0e3bfwVz2n55T5OA9mgZ9t3Zg2ctVSYczSPC7
	 2eShP/fiybm5cZUH+P0PvtxT13+FUX93m2EGbdf0bYTabdL4JknLTTYTO2lORGnZoM
	 9AVVuSA4s/y2qfoaPUKb3lDaXvPciKQFR8a9g8cBjMmQMUqpn//9V5OPKlnVoxYf0K
	 uDG6b6Kkx9Urb70tq+XegbF2EugVGPX10oZuJhZ+qBNMWk+92WeAxk2iEwCqRv3z1q
	 Pda2oZV/2fY+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 440E0C43140;
	Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Rebuild TC queues on VSI queue reconfiguration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171914403027.11613.14439670659310143558.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 12:00:30 +0000
References: <20240621175420.3406803-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240621175420.3406803-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jan.sokolowski@intel.com,
 wojciech.drewek@intel.com, karen.ostrowska@intel.com,
 himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 21 Jun 2024 10:54:19 -0700 you wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> TC queues needs to be correctly updated when the number of queues on
> a VSI is reconfigured, so netdev's queue and TC settings will be
> dynamically adjusted and could accurately represent the underlying
> hardware state after changes to the VSI queue counts.
> 
> [...]

Here is the summary with links:
  - [net] ice: Rebuild TC queues on VSI queue reconfiguration
    https://git.kernel.org/netdev/net/c/f4b91c1d17c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



