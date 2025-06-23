Return-Path: <netdev+bounces-200269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C97AE40C5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F330188541B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270FD248F46;
	Mon, 23 Jun 2025 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDG6ED74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FED248F40
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682379; cv=none; b=R2k4PVzN+GbHXGcR+sv/mojse41sYRB//JZvcPYzliN9s7N+TvEoaZOdJipVrPN2L8qKK1urOLb6VRxqtENCfx8e2C4N36zfiIMUg5CUvXCMFpE6k+zHg91AeJJ7ijeL6A+RpP8QAAEDw77Y1Z+ruQU4l0cJnxUTQgJdZoGlwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682379; c=relaxed/simple;
	bh=x3rrT6FGkRw/aX0YwRAPWKEZe4JfTzCq4ZRfxAgId2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p42Gi2hPDsJhDdvZ2r6HS/RFq+4jS2nVibMI6A6FUi4iUDX3OuakugQWBOFZgT4kXshSOqSr3Mmk6saTCgHuCh+Odh6VI4hT0xOSGkZOdEfF3KUoRaP4kOzUcjtDYK617zeUBFy/RKo5XOTmezlqvD9YDHxRwQfdb7UsDitMIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDG6ED74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA3AC4CEEA;
	Mon, 23 Jun 2025 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750682378;
	bh=x3rrT6FGkRw/aX0YwRAPWKEZe4JfTzCq4ZRfxAgId2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TDG6ED74an6UwkPfo1uialEvCYLEPdc4o3q+TrybpR3EKgRy1VonZqE6epqogKXKS
	 fXdyt5okGdTLj5Ww1XIQ1Sy+SMCRlwQHDGpdGK+jgXfIttTLGBRjrQYiIQI6oXJZK1
	 r9KmVK8ETdG9k3a/fsUqy+aQgA+F7VNWJWWo/PbFqsff1jmLu7Oxpvp9GikFVjwsu1
	 jlC5XHp2hdXiJidrRxgReGccdOMF0sidjwFOn2oL9Fc9IsAnWhuFbhVyRKTrYlSre5
	 WqXJJyDk2n7UVvSqUqJjcjyZcVFGNuPpj86nIV40gNWjsOAbjtCk/UEwC+b6/trMm2
	 aUc8KHIF5rH7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5839FEB7D;
	Mon, 23 Jun 2025 12:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] testptp: add option to enable external
 timestamping
 edges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175068240576.3133721.15719917280116272975.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 12:40:05 +0000
References: <20250619135436.1249494-1-mlichvar@redhat.com>
In-Reply-To: <20250619135436.1249494-1-mlichvar@redhat.com>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Jun 2025 15:53:42 +0200 you wrote:
> Some drivers (e.g. ice) don't enable any edges by default when external
> timestamping is requested by the PTP_EXTTS_REQUEST ioctl, which makes
> testptp -e unusable for testing hardware supported by these drivers.
> 
> Add -E option to specify if the rising, falling, or both edges should
> be enabled by the ioctl.
> 
> [...]

Here is the summary with links:
  - [net-next] testptp: add option to enable external timestamping edges
    https://git.kernel.org/netdev/net-next/c/27390db9592d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



