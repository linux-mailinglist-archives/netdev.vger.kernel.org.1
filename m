Return-Path: <netdev+bounces-97311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E08CAB46
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2954CB22FEE
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1061664;
	Tue, 21 May 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWo0OGbi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BCA5490A
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285028; cv=none; b=oiriI8SE03l/+QxINIqcqVQBiPOiIV3U1s3DXhfNf9nrT6Ag7qUhKNGUY30xuF+nOP+WSHbXOlIrCwPs3VNt7cl/syEcto7JgpQ9ypp6SoSsXG2xXk1/973WSmM9Fk11jZ3y9oXzXcoe6fot0pbhbtTJFYybf37sTWwWWe69KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285028; c=relaxed/simple;
	bh=Z2STJygJr5ut26krcWaTFGK3FdZdTkoP7A4cdiPUVlw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D64YTwa+QXrpkSs7oB54eck0fwjF0xgmk5Oq+tImLgiBqIJKahMiSHD0EPHuwmGNIBXSCfO6HSDSCCxllk1Vyw+lKgi+FTESjmFoSIcJmQuzVv/ZHWS/O/N9rqmsoEbqi0mhJkK7jCCGXGiWqqDdd+EvJEQtQ8GYXCq/Lfz/JVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWo0OGbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0271DC32782;
	Tue, 21 May 2024 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716285028;
	bh=Z2STJygJr5ut26krcWaTFGK3FdZdTkoP7A4cdiPUVlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kWo0OGbiBgUUKGXIUoO+yxGQU3AlKcjhssCeP9OompN9HWKeu3gEFv0Blm86N7OIH
	 uNIlSVUfa8HNJKXuZ0/bL9FVQdo4wGOX1DdFMISNKhgOt1g+UfC4YblTpWR4+FKqoJ
	 qKXhAkgGU4sxUsAyP7UwC4TGulU1vnFOYv4EBNKbI6ydlyR3cSYCT56qGZbJIM525q
	 zSZgUBiUC8voBRGmTTAhcIZBjLB3sghqXrHNwoCcVH4LB2giQLk6ndm+CBlwWiuSBz
	 CoZ3+k5V0+OgDVnJYqVX336pSTBz0ezIa+LXst5l5A9Ii2YaHKjlUVDdjEnGOXe7+w
	 x9wyq/g+UewgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2123C54BB1;
	Tue, 21 May 2024 09:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "r8169: don't try to disable interrupts if NAPI
 is, scheduled already"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171628502791.29879.3558658720405565780.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 09:50:27 +0000
References: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
In-Reply-To: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, nic_swsd@realtek.com, netdev@vger.kernel.org,
 ken.milmore@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 May 2024 08:18:01 +0200 you wrote:
> This reverts commit 7274c4147afbf46f45b8501edbdad6da8cd013b9.
> 
> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> default value of 20000 and napi_defer_hard_irqs is set to 0.
> In this scenario device interrupts aren't disabled, what seems to
> trigger some silicon bug under heavy load. I was able to reproduce this
> behavior on RTL8168h. Fix this by reverting 7274c4147afb.
> 
> [...]

Here is the summary with links:
  - [net] Revert "r8169: don't try to disable interrupts if NAPI is, scheduled already"
    https://git.kernel.org/netdev/net/c/eabb8a9be1e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



