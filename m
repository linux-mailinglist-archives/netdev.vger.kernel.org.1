Return-Path: <netdev+bounces-188936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404DAAF749
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41744E1266
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3013207DEE;
	Thu,  8 May 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaZ374IY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3334B1E48;
	Thu,  8 May 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698391; cv=none; b=Zmuf3sBL42ZN+K3bikxr9k+AFDjZEISNr8h98MwdlSJ+iqHGkp/C+L9qXgwVd3hzoZVB+Wui4aqcPxkviwmb9qnckSCuVxirU5qO10/hfsgcEVmFpjuTsOoQRXYzhRUibEGBlApKH+Hq3pPhbzOSz7/ykiHo60ze0qDmfbiFESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698391; c=relaxed/simple;
	bh=e3G0ZI1AqiLNpCUaMIy1salHpVtsB1W7fQyBWCso3a4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lsjEA02PhpB8Vo2eG2e137Gt83+1emFhIu9FJ4kbuPKEbEh/yF8SHjz63evXzA3dd5bdV9DWI03nr1tKfLinkAjhPXkuQUia7nAbWTBL+dUqFitl+mFt7RUJHjGi2yl9TYppcYX3jRP90gpnRi9Ola++0NqOZg7KogVrqUQh/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaZ374IY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED44C4CEE7;
	Thu,  8 May 2025 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746698391;
	bh=e3G0ZI1AqiLNpCUaMIy1salHpVtsB1W7fQyBWCso3a4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oaZ374IYA5Sby7wigX78P+Vzb45bqrpmIMd3ZAWzjJytttTiHEg2P3GVAqaIpKSpz
	 OLYcukCFmjNywc+JKv5+EUTKqwi8BJtquIy44xdg6lj3FUX9USr/7pg3rdI+dSyINp
	 NLJvw6ZJOc7+6f1wkRbgs0Ft+H0s7XiSx3j1iGmAePB3m+54T1o7lnxRvIRyzCzS0d
	 ZMscASZx1GQvCYhCwOfvizbYDd/bwh8WGpg411hZaupir2ymUgvOIKbp8tN9XERTJ1
	 mQQ28n39wqkwMtknMtUTnmxdm6JHC1+qy1L4A7MDcmA29bHIQmafK4Xomr+c81HufR
	 eqIKzqSnphmDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9E380AA70;
	Thu,  8 May 2025 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] virtio-net: fix total qstat values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174669842974.2857326.9626590973544032817.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 10:00:29 +0000
References: <20250507003221.823267-1-kuba@kernel.org>
In-Reply-To: <20250507003221.823267-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jdamato@fastly.com, virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 May 2025 17:32:19 -0700 you wrote:
> Another small fix discovered after we enabled virtio multi-queue
> in netdev CI. The queue stat test fails:
> 
>   # Exception| Exception: Qstats are lower, fetched later
>   not ok 3 stats.pkt_byte_sum
> 
> The queue stats from disabled queues are supposed to be reported
> in the "base" stats.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: export a helper for adding up queue stats
    https://git.kernel.org/netdev/net/c/23fa6a23d971
  - [net,2/2] virtio-net: fix total qstat values
    https://git.kernel.org/netdev/net/c/001160ec8c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



