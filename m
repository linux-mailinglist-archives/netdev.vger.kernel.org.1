Return-Path: <netdev+bounces-140894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87DC9B88FD
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C43C281DDC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0A762F7;
	Fri,  1 Nov 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XASnb0LE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9F3EA83;
	Fri,  1 Nov 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426424; cv=none; b=Y/p8ZBKv4LsjCU3aiGK+82+8arqStpZuRZmOnbXjSgkptrjRn9O/h10Y+R7kxfXTyCD2w19kg6WN8ATU0bQKdK8Mi+v619ZDxKS8ppHB8PySWWLSyTzVFwizhg/DXQFF6m9zfYpeFgenHtA0057h3Q5zj+FDbTAt6BPLrXVRd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426424; c=relaxed/simple;
	bh=fb7aOCl4XgdeRKd5/MatgM1K30h6jQLxZcWM0SZ/Frs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VuDK+zBpyvgicjBHLOiQxjEEB2EmicPCPxm/ipFXLXzOmqTz9HOW4AbSSbZHl9mJ/zXQbXHqdrEMyevkF9tNPQaepF5ICGqgm3POl5xYRZeSQppEC8RvKV4G2CKIECflln08FGderNYdHCi9PzxxslsMPUVF/sLhtj6l5V6ci3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XASnb0LE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42970C4CEC3;
	Fri,  1 Nov 2024 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730426424;
	bh=fb7aOCl4XgdeRKd5/MatgM1K30h6jQLxZcWM0SZ/Frs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XASnb0LEFqQDw31qP1E/Zs5z2ew7JbGNZvYFRrcu+Yo5Ibh7M7OYYHy7eDmxblNDe
	 YKC0n2kAY3doR/j1ltjN0SUmOB2R66OTMZTbmdnBel5YOkAnDqGwWZJolAVohRaEYk
	 WSHJvsjadA4NOxr829mMF6XcGZqgiMwRoUR72/VhdbvLCPJXkw3VqoR973JPb8fI13
	 iJDfw/eV3dBDST85Q2hIBBrcvL5BliqkBPjh5jxWYKsuKkQZnyQF3Fo5VkFrJUy1te
	 wlIxs7TqeF6xvnFY0bzEzGxmWsp4ugZ1oe6+Skhrj7dmOBAm50St+n+sYKRLujdAbY
	 g5czNMa7kza9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100A380AC02;
	Fri,  1 Nov 2024 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp_pch: Replace deprecated PCI functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042643226.2152368.2327696285873248607.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:00:32 +0000
References: <20241028095943.20498-2-pstanner@redhat.com>
In-Reply-To: <20241028095943.20498-2-pstanner@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Oct 2024 10:59:44 +0100 you wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Additionally, pass KBUILD_MODNAME to that function, since the 'name'
> parameter should indicate who (i.e., which driver) has requested the
> resource.
> 
> [...]

Here is the summary with links:
  - ptp_pch: Replace deprecated PCI functions
    https://git.kernel.org/netdev/net-next/c/9c5649c17737

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



