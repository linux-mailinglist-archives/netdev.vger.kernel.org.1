Return-Path: <netdev+bounces-165039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEFA30230
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8128C3A9672
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B41D5CDD;
	Tue, 11 Feb 2025 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTuHL+dI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF752FC23
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244618; cv=none; b=rPuV4Bwz/EoI8IfIEUeKcAcSEVV1TNqBkn1df2QKnGWxtk0vF7ids5jkSRM4cZoBK8F+ZakN/YlohYB3Pa4aVpa9eIRXpTl+ISCqy6ovork92Mr7ME4cIqIs5CNmpgLKYeoKHzDwliG2xl4xZBka7s9dD2dNiz88ab5qop9BfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244618; c=relaxed/simple;
	bh=5U3v5pk0wiidRbcLWpT2TWG/Q5Znu62srQFq2gcBU78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NuC9q7ogNvSaCvJ+CjEh4dP7P6Y0Rct8a1edIZQawyqTu1h5Rg92hzD1d071u90I+KnRuefVh2IzCpxTtksaEOSSpViLMEuYxfXXwv035RvqZzYe1MavYclvfUV034nup8izAAhJu60H/OgRL3Bs5/DY9oEsLOh/INourhTRWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTuHL+dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D27C4CED1;
	Tue, 11 Feb 2025 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244617;
	bh=5U3v5pk0wiidRbcLWpT2TWG/Q5Znu62srQFq2gcBU78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UTuHL+dIWqpQronnVt/S7sjdQCEVm0pwO7e/lzWjtKE2AksYN8OiSvqCmr0RLWy3p
	 5ua/BKwVTEtAukagSmRvqk5K6XQOtT6fWpYGTbkOmQuYCn9LQ2KXvYs48onNDQfsjP
	 nn4OC90a2WByr1tUGlvGY+oWFJQi+1NU42DHd+PSUQ85YrxHTZGcSoN9t+OZziwfuw
	 MPYuq/VLlJVmkZY1S3IYHz3Z3Ln2UFwHGA1kYPXDeg9ME2F954GuXh58kSdTplhcDT
	 iQ7HXWkLFy0jyqp4vDSVeDU4ICGETgJ/F/5bDLWyTtdtm5hci8zzXbbu230hjc96Lg
	 WSIXj+2oI9ZoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72FAC380AA7A;
	Tue, 11 Feb 2025 03:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: Enable Tx checksum offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924464599.3948401.9270109919749537760.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:30:45 +0000
References: <8dc86c95474ce10572a0fa83b8adb0259558e982.1738950446.git.petrm@nvidia.com>
In-Reply-To: <8dc86c95474ce10572a0fa83b8adb0259558e982.1738950446.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Feb 2025 19:00:44 +0100 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The device is able to checksum plain TCP / UDP packets over IPv4 / IPv6
> when the 'ipcs' bit in the send descriptor is set. Advertise support for
> the 'NETIF_F_IP{,6}_CSUM' features in net devices registered by the
> driver and VLAN uppers and set the 'ipcs' bit when the stack requests Tx
> checksum offload.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: Enable Tx checksum offload
    https://git.kernel.org/netdev/net-next/c/907dd32b4a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



