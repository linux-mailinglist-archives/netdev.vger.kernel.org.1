Return-Path: <netdev+bounces-78609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE9875DD8
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686DDB21AA1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781FC33CC4;
	Fri,  8 Mar 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miiRDQzD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FB32C89
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877638; cv=none; b=DfjXxanPeibkKqBoZWovye9ilW0+DYKzCRJ4GM+xnOAy4MasmLi1235GEvooXXhQm2YEM46woZ/72MdZNIGYGpjSCl/KfHHYjSacR40TVW1S3y2hwKWvlvV5ll3DBuEAOmdg0NMx/aSqszUst/zDDQ/G/aKxYIp26Cg4S6vObwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877638; c=relaxed/simple;
	bh=QBb6N3e9Wdxsv3v6HpayO9kNXmOqSbgR2AnEan4hsj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n5uyRvVoZsXsY34SF8xM3+qqPkt/EguM59J7/d6OgOgZd0UJyzPq+YTrILYlsQWWJ3Z1xrcmwxCighIWvZY/sh53ohuhaYbX7TSUOFMs1bcGioriJGvvM4D4TGMbI8o/svWlLgTSMzawZoBe3xeAIeIZuekP+k1kEkolRJoMzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miiRDQzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D3BBC433C7;
	Fri,  8 Mar 2024 06:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877638;
	bh=QBb6N3e9Wdxsv3v6HpayO9kNXmOqSbgR2AnEan4hsj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=miiRDQzDbxFOECeLNEcixGAjrxRE4WdW3SPByTHv2ry4e43jToaJHR7uW5RgFJaTj
	 7zR26oNzDyNKpjpWAwITeI0SdBVh9CVRodbRhwduIGYl4ksxmrl7G+DlTLymu77Hpk
	 XKWmiwKGtmjuR6lif1+oE+tu5tOCfjLX0OI9BYzC0sz3wJJl5Pbg3TJI0Y4lo/6vdG
	 Mki14+SHIqN9nLhBrVKa6EB5KIUnQdpVT4JlyJ4EZ16AyqFMfCxpRwKh6Ta+r3cPLS
	 1F0r0sj7wwFd6NI48SbV9RCGyZFO55sPPxfLT36AD8KXB5IRk12Q0Fp0NQ0BIayitn
	 MNuiPVFsHqfjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0C01D84BBF;
	Fri,  8 Mar 2024 06:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] netdev: add per-queue statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987763798.6902.7717910992204174114.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 06:00:37 +0000
References: <20240306195509.1502746-1-kuba@kernel.org>
In-Reply-To: <20240306195509.1502746-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com,
 mst@redhat.com, michael.chan@broadcom.com, sdf@google.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 11:55:06 -0800 you wrote:
> Hi!
> 
> Per queue stats keep coming up, so it's about time someone laid
> the foundation. This series adds the uAPI, a handful of stats
> and a sample support for bnxt. It's not very comprehensive in
> terms of stat types or driver support. The expectation is that
> the support will grow organically. If we have the basic pieces
> in place it will be easy for reviewers to request new stats,
> or use of the API in place of ethtool -S.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] netdev: add per-queue statistics
    https://git.kernel.org/netdev/net-next/c/ab63a2387cb9
  - [net-next,v3,2/3] netdev: add queue stat for alloc failures
    https://git.kernel.org/netdev/net-next/c/92f8b1f5ca0f
  - [net-next,v3,3/3] eth: bnxt: support per-queue statistics
    https://git.kernel.org/netdev/net-next/c/af7b3b4adda5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



