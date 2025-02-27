Return-Path: <netdev+bounces-170245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B5A47F2C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562183AAD6F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B422FAC3;
	Thu, 27 Feb 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft2959c6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12821348
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662998; cv=none; b=eOd+2I5n0gLewKEf8ZU4gDccAOOAfh95Qv9sBqGhTFcLB5LwxEVz1nKyRBfI+a8OQNFI2LQ0gsBzRx+CjZxdAilVdbUIFVlKhHaEHMJsXI8qhaw2bCVVGuWiSUGvuu9JqH47HswkXTA0kwLxvZ6l8+IzrVGi/9RE1O4ttvkaTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662998; c=relaxed/simple;
	bh=q6n+FQHRrSV2YSdqbbBvG8YEXQck7BQiuITq56IIrNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=goh9tF+VAsEcpIav9s5OamLzX1S+vm7SCEcgydjdPxCJ1WO8Y/NeF2T28cTH4r2QUMUtqFCvuYP39PgqGBxkcWjPMGKsa5B2ayVsC5gl5PMPW+/YElCPSiSpz12lryIVlzHpWRSmjIQzTOCcoe+Ql/ibQKkGqfLa7Q2lcs3RIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft2959c6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E16C4CEDD;
	Thu, 27 Feb 2025 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740662997;
	bh=q6n+FQHRrSV2YSdqbbBvG8YEXQck7BQiuITq56IIrNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ft2959c6xH365j+R3tuFKp+rTSPOAbvKx4w3Bs5daj3G06uQI+4zw6CfDKeGbMw+Q
	 CsLKnpaivGZd8aS/a/vFSceGJZyY5XsUjXZAZYULzir+p4TbArb/TKa0K68IvWDx4H
	 ugN40Cr1YIZeHKK6DuNs5zmUwp3PKCKEOFAMKvww1/kSGksxgzf9CUQUpBXxuQX4AI
	 8zcjXan+UZZv3Hb2KLlIeyuCatSLhkTFsOLkgRVKSSnBVZvrbtmseq5FruC1v+IhlO
	 bs7eB284uHypQiTtSDCGSYiTveS/SaWzp3SiiU2OAvQZ02fkmxJwnreYbK9N9EHZpa
	 cHrJZUAv4pBWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7B380AA7F;
	Thu, 27 Feb 2025 13:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] fixes for seg6 and rpl lwtunnels on input
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174066302975.1429387.11593807652409434150.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 13:30:29 +0000
References: <20250225175139.25239-1-justin.iurman@uliege.be>
In-Reply-To: <20250225175139.25239-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Feb 2025 18:51:37 +0100 you wrote:
> v3:
> - split patch #1 from -v2 into two separate patches
> - drop patches #2 and #3 from -v2: they will be addressed later with
>   another series, so that we don't block this one
> v2:
> - https://lore.kernel.org/netdev/20250211221624.18435-1-justin.iurman@uliege.be/
> v1:
> - https://lore.kernel.org/netdev/20250209193840.20509-1-justin.iurman@uliege.be/
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ipv6: fix dst ref loop on input in seg6 lwt
    https://git.kernel.org/netdev/net/c/c64a0727f9b1
  - [net,v3,2/2] net: ipv6: fix dst ref loop on input in rpl lwt
    https://git.kernel.org/netdev/net/c/13e55fbaec17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



