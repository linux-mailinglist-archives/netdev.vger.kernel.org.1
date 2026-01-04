Return-Path: <netdev+bounces-246788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DFCF12D8
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58CD23002146
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D12D6E6B;
	Sun,  4 Jan 2026 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN0uDbJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF422D6E5A
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767549899; cv=none; b=iw9lZFf66U+IZNFjBl/nH9gNImEbBjhD1AZYHgjwTz8+1IOt8oBuwUS4O2f6cFeEgXXNuPPZLPSPpK9LamFda7jLe/6Dc36qLGPHTkHFReJhwGy+zJKoFoWdp2u5no0U9qnHrSAJakpxzyY7vnG51SAqQror7QwIj1dbCu0utQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767549899; c=relaxed/simple;
	bh=FPGo+lL0zGCrh+eaLOu0a4WnDcGsQjYyVn5UQ4U6MLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QPObNw8dJZYbvD89qXtqH6huKAJxAI7mz6fN4sHNMKlHduvVCzlKjcSV+4jlqPKUdJm/KXVTntnj/ZIwN1MrpcSnzxjiJHe8FmyvGEBhpZnGS2PNDsDfjngVy9sfzEGPlEhfFjumTk/A18dLLg+gW/1qPYcFnM7av9SMlhttpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN0uDbJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27688C4CEF7;
	Sun,  4 Jan 2026 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767549899;
	bh=FPGo+lL0zGCrh+eaLOu0a4WnDcGsQjYyVn5UQ4U6MLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YN0uDbJmCyT/mZFMPbKUS1JHeDyFQK49iRisJX9KhWKppX3Hz5kluA1R9x4QsNBHv
	 95cl0Z5JKRuq+6uHmFU1gcGnOEGjAXMce/9QJOu8mL0SxpJgxgxWGqVLefgBWuoLAN
	 7aITQGlLzcIa87f+W+KILCHSRgRE1/atoTH11BOk76yFANd3aOApzqOLV+Mt7ubJmE
	 Bsalu2kSGOD5L8SQwhjW2PCCHwUQZZV7Tcd3ybSvdDYdqzOxiF7d6EjUOH+31AI1gs
	 G+iXT/irlFApquYtZIJ3cO+DLzw1zuzQkx5gHEn+4uVeB+8FxtCTMSFLt/VDfVX9Wo
	 gjF57N7CQ8m3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9AF380AA4F;
	Sun,  4 Jan 2026 18:01:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: marvell: prestera: fix NULL dereference on
 devlink_alloc() failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176754969806.141026.18096309039043852139.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 18:01:38 +0000
References: <20251230052124.897012-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251230052124.897012-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: vadym.kochan@plvision.eu, andrew+netdev@lunn.ch,
 taras.chornyi@plvision.eu, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Dec 2025 21:21:18 -0800 you wrote:
> devlink_alloc() may return NULL on allocation failure, but
> prestera_devlink_alloc() unconditionally calls devlink_priv() on
> the returned pointer.
> 
> This leads to a NULL pointer dereference if devlink allocation fails.
> Add a check for a NULL devlink pointer and return NULL early to avoid
> the crash.
> 
> [...]

Here is the summary with links:
  - [net] net: marvell: prestera: fix NULL dereference on devlink_alloc() failure
    https://git.kernel.org/netdev/net/c/a428e0da1248

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



