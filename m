Return-Path: <netdev+bounces-243067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EBC99265
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 398444E3366
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81142882AF;
	Mon,  1 Dec 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSr/6hCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DC2877E8;
	Mon,  1 Dec 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623597; cv=none; b=FxkqmDjsTxGWHi99SipJLItyz79Xyzj+ov3YtZf/lAb85oEAe/DF5yJOSpjrxqrq9HXVYvv1KG6IOzneOY14QbHCZbNNvHiusn0yNgQ9GA2b+qW9TTTNnJa+udSsertbQXK6CPqsN9Me351CaMTh7KzKZltVeaWcVa2jiw+HHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623597; c=relaxed/simple;
	bh=rQGd4yp48udflVO24/d9CsxGU+MdjTSpQ/DAoDyzCbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=flQk8MbYPDlCrCbWUOBQpnfNMA4FaMV+6nOZ2f/vds0YRRz63aZqpeXsBgZB/WhbvTbU98MpqWTv/C66ZhopGW7DfLlcSAeT/pngVQeym/QRe4zTVQoDl7tHQ5IykaNkkrEi/XBgBBYh2/WWRzD0k1cH8vBBBc4ftQb25WZ9t4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSr/6hCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF31C4CEF1;
	Mon,  1 Dec 2025 21:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623597;
	bh=rQGd4yp48udflVO24/d9CsxGU+MdjTSpQ/DAoDyzCbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nSr/6hCar1aqFp2owSC2nu5Ud0iCkJmnPc1gw2BBm0uF/WWeX65X+0VA77tm4jNu7
	 oTBRcv2Vj9Ds4/ei9JQYd+tH+hh6sWbGQ33UbXFAttl+ix4DXFD21wl9tU42bkqNbi
	 p0N27lUxllldYjRZ0+PtP3AKNSB38umLR3Z1T8zpT+3C8kMu5cZ+BKzmbFu2i99Npq
	 AeIXyN35B7DH4qURhkpfYjQlHUmAJXERjr81mtLO8MD8xd/3aT0iQRpx2MtZ40ckpJ
	 /uopyeldiHYJAxehQntSSknpIOi/Sv55fxNu1Gdm3sgmp0tmCy2ZioK8Qk3A8d6+gE
	 MFjmhYJrNvAdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B30381196A;
	Mon,  1 Dec 2025 21:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: yt921x: Set
 ageing_time_min/ageing_time_max
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462341702.2539359.9930486634449983337.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:10:17 +0000
References: <20251129042137.3034032-1-mmyangfl@gmail.com>
In-Reply-To: <20251129042137.3034032-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Nov 2025 12:21:34 +0800 you wrote:
> The ageing time is in 5s step, ranging from 1 step to 0xffff steps, so
> add appropriate attributes.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] net: dsa: yt921x: Set ageing_time_min/ageing_time_max
    https://git.kernel.org/netdev/net-next/c/ea2d3befcf29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



