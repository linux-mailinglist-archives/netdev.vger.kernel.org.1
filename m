Return-Path: <netdev+bounces-88398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB98A7002
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF961F22063
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2AC13119F;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml6OFkyu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640C131185
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282028; cv=none; b=VGEAJDFe0Oine1//gjc+fm2ncw/EY2JkpNX1uP/UYgPunkYuSOUJL2hVZeOrnuskrNybmhW+CqmNhcMUwYnN2H7gjizxvxGZiR+Q3VPwkybyWSRZjfMdZ3BIuZYaHKauO/6f0pW4qJKLpYmyM5U3ykN7KlnSwcmYutISdoj6fGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282028; c=relaxed/simple;
	bh=rGXV5Ik/rDlHRZtBWXFBgPyD2qXXUD9wUe4gglKYAUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+UZluXz3JNs2SnvoXs1Z2M+BSVydHvdoMmUAbh8cxS1azFAR41fY098tQKLIkv2NgfSqmYirgqNv5C8ypKpMuLqkoYYlsLDsXnMcdmjPC8DcWkTH37gtjGeItqsK2gDqFSErVNMKKGQpziRHNg51B9/kjmhIjG9lAiR8xovQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml6OFkyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42549C32786;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282028;
	bh=rGXV5Ik/rDlHRZtBWXFBgPyD2qXXUD9wUe4gglKYAUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ml6OFkyu6ZprcSJ2b1oTQPVM6TauKrtO2HZjy+yJAJdAzV8D3d+cufs+emXKwkfBL
	 F7ccLKYzy9A22YjjtcmLzrlOB8zPgP/tPNHcnv8NDqMcElcKdp9M2V1uE2tq+vGavd
	 5vIrBG+zHkpz6A4PCSKNcnqjPGCkwV5me3fj57HMXdm95SyKdn5t2jo8bVWvFO0SjP
	 6yFgwo4m15sT/iPo/KRsBREz+efty2QW2h3hcDPIAJtF63aURsmiFemMPEp7LBktAj
	 UqArJR+kUFMQhbLAJd2rkZniT6BIXhJIxvx5uGKJjAb3Hot/xddC5AeaOaw+ddb1tY
	 7Wz59aPaeu1Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F2FCD4F15D;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] man: use clsact qdisc for port mirroring
 examples on matchall and mirred
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171328202818.2661.13622342567404919438.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:40:28 +0000
References: <20240413-man-use-clsact-qdisc-for-matchall-and-mirred-v1-1-5c9f61677863@arinc9.com>
In-Reply-To: <20240413-man-use-clsact-qdisc-for-matchall-and-mirred-v1-1-5c9f61677863@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: dsahern@gmail.com, mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 netdev@vger.kernel.org, arinc.unal@arinc9.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 13 Apr 2024 17:48:48 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The clsact qdisc supports ingress and egress. Instead of using two qdiscs
> to do ingress and egress port mirroring, clsact can be used. Therefore, use
> clsact for the port mirroring examples on the tc-matchall.8 and tc-mirred.8
> documents.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] man: use clsact qdisc for port mirroring examples on matchall and mirred
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=dedcf62f3956

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



