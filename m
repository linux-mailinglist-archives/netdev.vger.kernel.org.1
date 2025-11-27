Return-Path: <netdev+bounces-242154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C1C8CC75
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 05:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 476B24E1A58
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3CC2D480F;
	Thu, 27 Nov 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izw90za9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC82D47E6;
	Thu, 27 Nov 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216060; cv=none; b=Syvp8MqfthTjydDs/35h54fjj8jBEfSIT/6eD5h2M+rg2roXwZaLZxLeY5lI4nKhZaWVok9QvWkJJRZIZ1kGxPpC+sstm9D53pB5zdEIWc2whuKi8KXyhRLncryCRVS5/uEpzogVRYDtF6X/DSBlDZyguJ4ZoteTflQQ3Ci682w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216060; c=relaxed/simple;
	bh=3aCGaBnIfCx4h8Z2uhdj17JTB/p7VbR03R+k2BdsM+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rCcGSFa2io5q/NVXfbx988rndiTrM627B+7nV+zvS59qZBJSi4f+5rV8/DvpbNEOMkAyLoex97f3hiPPlQovsQ8EneVprmNc0m/rUI9xbYWv2M23UyblJ7ulKRR/TiIkqqTK0BM0FjgGA50uJjEpEQLllnFiGtDI2+dRHHUWbzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izw90za9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A283C4CEFB;
	Thu, 27 Nov 2025 04:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764216060;
	bh=3aCGaBnIfCx4h8Z2uhdj17JTB/p7VbR03R+k2BdsM+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=izw90za9yH4ZqtoG9agqWrt727npog/cdOPlLRnOyyGkz8jCk1CQh8kSDJW4nvKeh
	 QwuJJ4xOGPPwMzn0z/GJNG6FuBZLQ1jrQGFL5+2BWMuNNL/hePGVa/YRcvHzBwHpcf
	 rVyPX5X5FdB0Xh6l6FgPkPTqwPi+va3EWmLWlbjBUr1ZKaSSkH+lzRBLr9cD8PicWx
	 Zsel6BUm4mN9jpUwroyG889fYJvX8E5T0lsGeSs+LOtWz1UGcSv/YwJtU04ew7wpcq
	 h3wf5WsiNPg4aRaxctKbytT1/FXVJgvZ6J6OKbKLU3TqTVDSgXnG0MZcXpOOByyOFx
	 75SJJ8LwVkMSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB5380CEF8;
	Thu, 27 Nov 2025 04:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] MAINTAINERS: separate VIRTIO NET DRIVER and
 add
 netdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421602174.2412149.10628596524537108392.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 04:00:21 +0000
References: <20251126015750.2200267-1-jon@nutanix.com>
In-Reply-To: <20251126015750.2200267-1-jon@nutanix.com>
To: Jon Kohler <jon@nutanix.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 18:57:48 -0700 you wrote:
> Changes to virtio network stack should be cc'd to netdev DL, separate
> it into its own group to add netdev in addition to virtualization DL.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
> v2: Narrow down scope of change to just virtio-net (MST)
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20251125210333.1594700-1-jon@nutanix.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v2] MAINTAINERS: separate VIRTIO NET DRIVER and add netdev
    https://git.kernel.org/netdev/net/c/384c1a4e2722

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



