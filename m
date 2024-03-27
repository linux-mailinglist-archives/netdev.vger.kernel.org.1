Return-Path: <netdev+bounces-82341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F398288D559
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 05:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B701F2F54F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 04:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D683824A08;
	Wed, 27 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAqnuxPQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A424205
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512575; cv=none; b=HkXa37jvPpMRuKMC+phOR6fkHePR4EuD9JbghzPMcHdCekIend4+2ESbNAxiP1555y8kLMH6C1Vh0fU5FruHEi6kkqVHaNImO52h3ymZhiqRSHsbcFVCnfqlqICtCJcqSG+zru0phIByUjVcXhb/w5OG5KDtA8cg5tlNSVR/WfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512575; c=relaxed/simple;
	bh=q31/8B2SpeicIxOOnAtj2J6PqK6Quct4VhvLR73c0KU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NcE1RxEEfWqwjHP+Xjje3AXKoxFVWGlIVTb2gcrtQcCHDefe5GVG4mbVNiwEmH25zSfPNzKAha1ERU374PVyHyNbDsqWOrGrfytIYoXiZFfhFo+jZP0Eh6V4nfhNf0u6J4p+T5ZNe7aZ2TnaP6KKm6FUmcWpSfDmY1Vi3HRcLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAqnuxPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CCFDC433A6;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711512575;
	bh=q31/8B2SpeicIxOOnAtj2J6PqK6Quct4VhvLR73c0KU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZAqnuxPQG34ujcaeYHTV73ChxubmmeXJKbuezltMFobiD04Ff/WviXxF4T5BrVRvJ
	 vQTAdtdOK7DXO8oYf31fmeoPq6z+L6/QvQKUMPV4Toc9+8uNpJf4LA1/HciVaARcLz
	 48v9MDG3I7WykG6mgY6N/x8Zr8dLVAHw0+wlFt/PrusjE8hsQ92He1xj4PcYTQU1g5
	 YD9r1QAOymu/Nr11JrzqoHxrMSMHRU8gnJfcBWaMXWNn3Ok7ugouf+3/dS+Z4QlKRF
	 TOtuA9h+NV7kXGNzKLoRkHxEx9Kae4h1ZhGT8bu/YExLB/QjEVy53dTTm/VeKtISeJ
	 H3f9//8PVkj7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DC1AD95061;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] tls: recvmsg fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171151257431.29046.2588768601360918338.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 04:09:34 +0000
References: <cover.1711120964.git.sd@queasysnail.net>
In-Reply-To: <cover.1711120964.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 16:56:44 +0100 you wrote:
> The first two fixes are again related to async decrypt. The last one
> is unrelated but I stumbled upon it while reading the code.
> 
> Sabrina Dubroca (4):
>   tls: recv: process_rx_list shouldn't use an offset with kvec
>   tls: adjust recv return with async crypto and failed copy to userspace
>   selftests: tls: add test with a partially invalid iov
>   tls: get psock ref after taking rxlock to avoid leak
> 
> [...]

Here is the summary with links:
  - [net,1/4] tls: recv: process_rx_list shouldn't use an offset with kvec
    https://git.kernel.org/netdev/net/c/7608a971fdeb
  - [net,2/4] tls: adjust recv return with async crypto and failed copy to userspace
    https://git.kernel.org/netdev/net/c/85eef9a41d01
  - [net,3/4] selftests: tls: add test with a partially invalid iov
    https://git.kernel.org/netdev/net/c/dc54b813df63
  - [net,4/4] tls: get psock ref after taking rxlock to avoid leak
    https://git.kernel.org/netdev/net/c/417e91e85609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



