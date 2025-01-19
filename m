Return-Path: <netdev+bounces-159589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65133A15FD1
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB41886B16
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BC714286;
	Sun, 19 Jan 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA2GXNU4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4911185
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251410; cv=none; b=roUomU6CEyjZM64SPr41KeZdlsc/4zVsG8e/Z2UfAEwyYTwfHzpBeJby3Ts83tvrM3WpqtK2lCT+vRoI2EDrKoJksrqRPpE4kwk6MoOaZL7Cixw59ncp2Kc77vowEgWTgJ9OPlFx1qwDepixM0lb6LNO0BcBYBFVPKU0+kHvykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251410; c=relaxed/simple;
	bh=9nQymEnauec6QbOnnAA8pRl9+Jbx9fXNcPkeLMG9GD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lVuks9FKEu34mTJ9SgyBJktwNIwL4tslH0sWvp7hzKOG6MOcvBhTNgdVr/8G4B5HWjq6KaeoCBWxQ9UPMQnItwfKx1/rL7s5gFI8dq7XHuKD+D6AvfxDXzQGFW8c6+bLy2o0p7uYMgxZbNRs1WphaQ1udSzUGZQlgBZ2tMd6tUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA2GXNU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DC9C4CEE3;
	Sun, 19 Jan 2025 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251410;
	bh=9nQymEnauec6QbOnnAA8pRl9+Jbx9fXNcPkeLMG9GD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TA2GXNU4w86jD+mcPcmUWgyV0/YlVcNChmgOXBIK8KmwMeudx97YizZVzA30U875y
	 tMRl1k6phPZzfpFLoP5E3YIQO39yeSDx4m6v6JspswxSurWtJF5YtvBInTNmP0uC/v
	 yLeIUudXuEbpOVifAgZcm6lcVqXpYbLTm06/inuMTr/Nj+xIs9KZ17ihK5grcxmrSn
	 EADdMlwQOOEaks0uhkL8ed3j4lcp6pkuMsgaIm/0QwZVfZth5WQp9POTLPhZfc/eFX
	 t9eyNw1gJUvF1vS1bQnW1J2MDIXSLm2lQl5h/4SKr/I0/ouOLiUJseF3OP/mS9fRew
	 N3raw5R/VuzdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC7C380AA62;
	Sun, 19 Jan 2025 01:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlxsw: Move Tx header handling to PCI driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725143374.2533015.1397683051270788445.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:33 +0000
References: <cover.1737044384.git.petrm@nvidia.com>
In-Reply-To: <cover.1737044384.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 richardcochran@gmail.com, idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 17:38:13 +0100 you wrote:
> Amit Cohen writes:
> 
> Tx header should be added to all packets transmitted from the CPU to
> Spectrum ASICs. Historically, handling this header was added as a driver
> function, as Tx header is different between Spectrum and Switch-X.
> 
> From May 2021, there is no support for SwitchX-2 ASIC, and all the relevant
> code was removed.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mlxsw: Add mlxsw_txhdr_info structure
    https://git.kernel.org/netdev/net-next/c/349856655504
  - [net-next,2/5] mlxsw: Initialize txhdr_info according to PTP operations
    https://git.kernel.org/netdev/net-next/c/e8e08279d3ce
  - [net-next,3/5] mlxsw: Define Tx header fields in txheader.h
    https://git.kernel.org/netdev/net-next/c/c89d9c3d0a97
  - [net-next,4/5] mlxsw: Move Tx header handling to PCI driver
    https://git.kernel.org/netdev/net-next/c/6ce1aac7480e
  - [net-next,5/5] mlxsw: Do not store Tx header length as driver parameter
    https://git.kernel.org/netdev/net-next/c/448269fa05c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



