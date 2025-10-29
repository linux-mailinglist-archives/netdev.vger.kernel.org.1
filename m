Return-Path: <netdev+bounces-233739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF6C17DB0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF1B04FF8F2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E94B2DECA3;
	Wed, 29 Oct 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzfMT1gU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7C2DEA73;
	Wed, 29 Oct 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700850; cv=none; b=CW2u07oEZ4czcXSp24H5ee/6OKtr/PxpjUG5Q4HwK1yJM6tUugGDJos/XXvlgbK96pthesTNiL2R/F/TnixxMAdnOzBhHykkPElgZiY29/uGs5T3iG3uF/4yTMU4dLQmxSGR3A5fH92r7CjsnMndbrVj8R1tZ6WQbGaJ1bSLOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700850; c=relaxed/simple;
	bh=V24FVdOSSQQLQl5pzOheopn5ohARiGHPDeaEBp1przE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FxXGjjuSLw29hCOBqacLBVpuBHMvrIHM3P7Mu7V4EiGuIVMUD+scb2vvPjzVUGvr9z+sEmt/LO7nCwfWPOhunK6kCDyJBwvGOQde7Vnu3YTv8AZMxC5CfxsAIt95XY5/lT634qZpBWUZ+DXb2X3ZfNSFwTpy338EU8+7g1noUpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzfMT1gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA469C4CEFD;
	Wed, 29 Oct 2025 01:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700850;
	bh=V24FVdOSSQQLQl5pzOheopn5ohARiGHPDeaEBp1przE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LzfMT1gU63MqjmnyEChpKwhBe8j+3DSJYue6pATt68XCDTa+pbrgs5XNyNy8pc2+J
	 ZkamS3tf3HaZQ2jQSHuAd/0vRdGML2Dggapx4cslPI2RcV1FWJfhJAdoQ9+1TiZLOP
	 Q5KvwR5CDyu20Jbk01tfELfvGHaLlfp0EFGjcQ/OLajIqIdOWGz++MpHwOx8vDipjG
	 Ag02pQVEnDHOzcy5M5LAqf9adaDPUcbwRI/Eoo7Svh430+EJHHqn4rpt+5XLI1UMnc
	 oIxGdWtpQFAOjoKHaqGimaGXyfQsySZb1VNyC8Uns8E05lOQExfb0p4orWZO+gMKv0
	 idVPk1IHIxvPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4C39FEB6D;
	Wed, 29 Oct 2025 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netmem: remove NET_IOV_MAX from
 net_iov_type
 enum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170082724.2452213.14420016215055097284.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:20:27 +0000
References: <20251024-b4-devmem-remove-niov-max-v1-1-ba72c68bc869@meta.com>
In-Reply-To: <20251024-b4-devmem-remove-niov-max-v1-1-ba72c68bc869@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, almasrymina@google.com, byungchul@sk.com,
 sdf@fomichev.me, bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 11:02:56 -0700 you wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Remove the NET_IOV_MAX workaround from the net_iov_type enum. This entry
> was previously added to force the enum size to unsigned long to satisfy
> the NET_IOV_ASSERT_OFFSET static assertions.
> 
> After commit f3d85c9ee510 ("netmem: introduce struct netmem_desc
> mirroring struct page") this approach became unnecessary by placing the
> net_iov_type after the netmem_desc. Placing the net_iov_type after
> netmem_desc results in the net_iov_type size having no effect on the
> position or layout of the fields that mirror the struct page.
> 
> [...]

Here is the summary with links:
  - [net-next] net: netmem: remove NET_IOV_MAX from net_iov_type enum
    https://git.kernel.org/netdev/net-next/c/8443c3160858

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



