Return-Path: <netdev+bounces-168318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B771BA3E818
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538D9423071
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD9267729;
	Thu, 20 Feb 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGm5bDpo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD5265CD8
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093018; cv=none; b=i/rEn3gf9BREm/ZmP/PPnHIT+g6sZALrPqH20eAVf4gSbvDp4t3XbqbtNTWeAWmuweBVR9aPlYhm9ZJSbn7MO+Q1B3041rECFq7UNYbG08ELKWWR6EsUZKDnQfIslIxibQAjVSHE4kFabOpdoi+jRCyhlDu95VwKShbATkIO3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093018; c=relaxed/simple;
	bh=nccQlSGyMmGp9VH0qZlNnQsuIb9TY7JJJDFbTmoHVck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FGf9uQ5ECX38PEXe5zRO2LAJn3HbUaNCp7TTSPUEsGNtOrqF9AMoaIS9sUo7scTzr060o6/MqBLeS5z8W0N5OKoZGnDT0kTrL2iYqKcG4a3Jig6hCQAaKKmyxDxDuyHjoD+C3OL+4UlBCtN1gRK6T3jd6XFsUgd+CvBrs3VkRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGm5bDpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D4FC4CED1;
	Thu, 20 Feb 2025 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093017;
	bh=nccQlSGyMmGp9VH0qZlNnQsuIb9TY7JJJDFbTmoHVck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGm5bDpoKN7cz5DsL7+WBwv8gqja7MlsLrCsGpRquUIiBtA2eg+6B85vE7oAAGRSu
	 G5o6fz85LZ2sElBy0P/2YLrk1RsF5SDs4j/4G9rvKFTyxIM5cRTOZR1H85Pfz90ecK
	 Ih+NCxyb5k1mX6msMEkx7BY0HxsAMWGxZAszZt4ygviPly6tU5SOizjyulwm4dYlj7
	 4f1lFwdTbpTHZRfWTrfXUuxsm97eTKegjzZwEryAHklyqu4hZV30ox/aDPEyxKzfwi
	 MF+SjlP2AD+9XeDAHrqUnwJRISswkWw1KP4r71daYgKWg4Gx41eY49aT3GJAAXFHvX
	 rO/IOp5nXum6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7C4380CEE2;
	Thu, 20 Feb 2025 23:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V4] eth: fbnic: Add ethtool support for IRQ
 coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174009304741.1506397.793459286632700375.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 23:10:47 +0000
References: <20250218023520.2038010-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250218023520.2038010-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, sanman.p211993@gmail.com,
 vadim.fedorenko@linux.dev, suhui@nfschina.com, sdf@fomichev.me,
 jdamato@fastly.com, brett.creeley@amd.com, aleksander.lobakin@intel.com,
 kernel-team@meta.com, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 18:35:20 -0800 you wrote:
> Add ethtool support to configure the IRQ coalescing behavior. Support
> separate timers for Rx and Tx for time based coalescing. For frame based
> configuration, currently we only support the Rx side.
> 
> The hardware allows configuration of descriptor count instead of frame
> count requiring conversion between the two. We assume 2 descriptors
> per frame, one for the metadata and one for the data segment.
> 
> [...]

Here is the summary with links:
  - [net-next,V4] eth: fbnic: Add ethtool support for IRQ coalescing
    https://git.kernel.org/netdev/net-next/c/7b5b7a597fbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



