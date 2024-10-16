Return-Path: <netdev+bounces-135919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B342C99FCA9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DD9B24901
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96DD14A630;
	Wed, 16 Oct 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA7Ms3c8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAD21E3CF;
	Wed, 16 Oct 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036828; cv=none; b=She/5NpINxT64hDVHncITUOESTHBphO2QHBhQZ60lUON+YHBm1D2lsF/vT9qs0Pi9QrKXIADE9ruSGgCk9DtDpBfR2hbOrA+ehsGNP2Qh8GKc/lC+UkC+iNQCIixLJ9qb4evF6hd+IrLcbZRKsQg3ow/qh1Hm/yQOHlbP7BuGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036828; c=relaxed/simple;
	bh=i+w2HYwMEHKjnYkj4tJhVsu8ncYPcRfNL6NwG8Efxsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RqxLchp3ZK54NjM1sYYR8+rPx0PpuB+wR8/HDalO+743UD2MUjKuFcBlB+MQjtqFASDHq5hhZ0x+A+OrBIyHOmuD5dk8h93D0Mfb6Z6gPx3wtKLp/yE2pxnJX+EqphrXp44qfzsNb4PK3s5NmSAtQ8yW+UkrJsWpxO32Dh1doRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA7Ms3c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE1EC4CECD;
	Wed, 16 Oct 2024 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729036828;
	bh=i+w2HYwMEHKjnYkj4tJhVsu8ncYPcRfNL6NwG8Efxsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kA7Ms3c8qGsBRjZI2+t0zesbmlDRqAgPAMC4pgmpfeXU/X9gyWF1B2pEWa6VTZAoT
	 PGNtaXQ/Iobgn6nRPpnMZV1m8Dw2UxiZBbEv74dGXTDgnRo54UJWj2a4WCif/4bFQ8
	 Ecx+vaXKdoHK+M3IJ7Q2RIdCjgLlSTTGyJi4WFLf/RgYchRMtElnCxAQJTSx92Ez3x
	 u38IwseGIcEtp5aQVqPuZ5kg9F2UTWIvCzqGgAwyitifIOMgdedNymLlMPsoRh9Gv7
	 Z92+mKFKQbAp5/dOWjy6sNn13o2SvfAEItLzb/BeDfBY/z+UzRWey6VGzTgvCGKFED
	 VacO/naq96jdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD763809A8A;
	Wed, 16 Oct 2024 00:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: cxgb3: Remove stid deadcode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172903683324.1331690.13747952979617087257.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 00:00:33 +0000
References: <20241013012946.284721-1-linux@treblig.org>
In-Reply-To: <20241013012946.284721-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Oct 2024 02:29:46 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cxgb3_alloc_stid() and cxgb3_free_stid() have been unused since
> commit 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module
> from kernel")
> 
> Remove them.
> 
> [...]

Here is the summary with links:
  - [net-next] net: cxgb3: Remove stid deadcode
    https://git.kernel.org/netdev/net-next/c/068f3b34c5c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



