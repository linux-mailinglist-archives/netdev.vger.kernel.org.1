Return-Path: <netdev+bounces-134029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3B997AEE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E5F1F21AF1
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD618BC0F;
	Thu, 10 Oct 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq5fDOgi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78586189919;
	Thu, 10 Oct 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529230; cv=none; b=eoUAGAYnw7G2kRweSqYdWs/g1WVZtY3GGobo1ux+RU5qBMsDBI4CtsY0qDvB/wmYG7zlOELt5BdQ6UyuGv80Z6b1XkZ81l29ZekJCi+Cke8UkwOdo2rmgcg6A+v6GoAuKaxQcKqaxIksu+yCG/LeWdWZXQNDyK5cTNWdYxLXkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529230; c=relaxed/simple;
	bh=R+46kwx4752B6j5G/ApPrfa3me8Ik8AUV1Hj0sfi8TA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tf5VLROOIBXBpeLfll1w2t4NYq06fHvh78Tu4zYTDhc7ofAfwjGt5nHWxspXPTpEo517XIqSgQIQLrhy6/Ql2xlchtfxHeB8bVTkADz5NwAb7vD6FyRWH/cQYHFMPp4tqnp6S/CRmKKTYPBr/yTZn9B1GaW+kUuyis61Sa5j1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq5fDOgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FE2C4CEC3;
	Thu, 10 Oct 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529230;
	bh=R+46kwx4752B6j5G/ApPrfa3me8Ik8AUV1Hj0sfi8TA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hq5fDOgipTPppJ4Hnv5i+mf6CBbD0v/10Kz6vL2ZnJbo46VdM5mMRZXkNA9PssanD
	 4TFdydTZKMTPMS417CWApNRFfxdhaj7cpcpt+oPhJYjhuw4f5EklwGOv8GOBCmUcvR
	 xlB50eL+xZ0j+nhFQAUcaabEqSCcsS0GEzrK7J/RNWUVrfONKsctq4mFMkZpv0MCKC
	 kMH1H4LM/B8OGwLOeoKwGJ4PyvDEisIW51XXJODzzr18drnTzO9Ell//oIyru8VLIJ
	 6KdZshIMnXnjrzrwfao2GdR3pj/EWrNjuKX9ooDIiTzZDMNZzTPAoh9MzTPEWuU99J
	 Ptnmoa/gvCrRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B7983806644;
	Thu, 10 Oct 2024 03:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: stmmac: Add DW QoS Eth v4/v5 ip payload
 error statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852923449.1548394.13199964588329484925.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 03:00:34 +0000
References: <20241008111443.81467-1-minda.chen@starfivetech.com>
In-Reply-To: <20241008111443.81467-1-minda.chen@starfivetech.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 19:14:43 +0800 you wrote:
> Add DW QoS Eth v4/v5 ip payload error statistics, and rename descriptor
> bit macro because v4/v5 descriptor IPCE bit claims ip checksum
> error or TCP/UDP/ICMP segment length error.
> 
> Here is bit description from DW QoS Eth data book(Part 19.6.2.2)
> 
> bit7 IPCE: IP Payload Error
> When this bit is programmed, it indicates either of the following:
> 1).The 16-bit IP payload checksum (that is, the TCP, UDP, or ICMP
>    checksum) calculated by the MAC does not match the corresponding
>    checksum field in the received segment.
> 2).The TCP, UDP, or ICMP segment length does not match the payload
>    length value in the IP  Header field.
> 3).The TCP, UDP, or ICMP segment length is less than minimum allowed
>    segment length for TCP, UDP, or ICMP.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: stmmac: Add DW QoS Eth v4/v5 ip payload error statistics
    https://git.kernel.org/netdev/net-next/c/0a316b16a6c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



