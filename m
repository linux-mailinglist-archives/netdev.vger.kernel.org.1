Return-Path: <netdev+bounces-126299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C897091A
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E389282429
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC17175D56;
	Sun,  8 Sep 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP9DaMzZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801216D4E5
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725817828; cv=none; b=DdJYgxOvfkZAyh2v1jddjjpj0EBNY+t0XL8mdiR1onUaUFocMqbevv5V9jlCkmU0k1tlpPrMDdKzB5soSjBV5iT4AlVDmSSSUUZVKctVzOSDTibIWHpq6GUPA+CPvyu4OH+j3dOAVAJ8LF1sC9UYccpZRtPjN6/YNn1Td9Y3fNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725817828; c=relaxed/simple;
	bh=W1l6Ym9vIRmI/33aq1xwLqXSr6UTVjgmfBoYKjalWUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hWVuroLEIOKgacNaaSslYu1+O48flzzTyVLo0JumG1gm6CdiqQYGabbPhOvRoUKwq5k6LswNbZfAv16eXPZEAM7aoUqVbBUIimiDMs/E4bFWjPC+LEmNaiNU+u1dHV4MUJp1uCLsb+UYfpFh2S2/JkmnNsD3BTxwINTseQoS3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP9DaMzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8607C4CEC3;
	Sun,  8 Sep 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725817827;
	bh=W1l6Ym9vIRmI/33aq1xwLqXSr6UTVjgmfBoYKjalWUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qP9DaMzZXFzBICf/Eb9GFuND8PmwVI4EMCEtbZRXCeFQ6nJ5rhdlWhP1A/CpGYI+q
	 /LzPbHmkiDS2a7kgmaMtML0RwTECwjLmR4Q1eiWc5dpUvGC5iM3UMU3lJ758aCnJD9
	 N2J66JTurXDvSZRTcPyy/aXUtDNwdMtR4+/ekkPGVeoxB2DTuvLnk/kFDQCrqTK5XG
	 Gxkleszz+3KhQdji12M31PIgRRKSdlh01Cre1NbOBeuzOYTjsCpnaHlOz55GJEHVsQ
	 WMkDh3Z+z4gGHzxbUuI7eIjacR66kCZIP0AiTm5UFRj25m0MhgHae9JVOk09FsopQY
	 j0SnxRhA9RoHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC93805D82;
	Sun,  8 Sep 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] ptp/ioctl: support MONOTONIC{,_RAW} timestamps
 for PTP_SYS_OFFSET_EXTENDED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172581782878.2932928.5343199731521697871.git-patchwork-notify@kernel.org>
Date: Sun, 08 Sep 2024 17:50:28 +0000
References: <20240904141305.2856789-1-vadfed@meta.com>
In-Reply-To: <20240904141305.2856789-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, pabeni@redhat.com,
 tglx@linutronix.de, richardcochran@gmail.com, maheshb@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 4 Sep 2024 07:13:05 -0700 you wrote:
> From: Mahesh Bandewar <maheshb@google.com>
> 
> The ability to read the PHC (Physical Hardware Clock) alongside
> multiple system clocks is currently dependent on the specific
> hardware architecture. This limitation restricts the use of
> PTP_SYS_OFFSET_PRECISE to certain hardware configurations.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] ptp/ioctl: support MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED
    https://git.kernel.org/netdev/net-next/c/c259acab839e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



