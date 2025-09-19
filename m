Return-Path: <netdev+bounces-224784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A67B89FE6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB43A061EB
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75B3191AE;
	Fri, 19 Sep 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql93Z7cT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700E3191A7
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292228; cv=none; b=c50onvbsjoYtyAWCMyzfboQAuos0nmxl3dYafhqQDCjrJSqwpekWxzUWe3as6iR8xvXTjOUqoppPKBDsgoBqH0NmtmImZ/UVdTJgJNYG+y09AKHEbsNP68nAHxLdwd2ZyApiO2Er0w0SNWb+hRqmP6G5iqg5lNfQyMJu5ZIfB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292228; c=relaxed/simple;
	bh=c9/5HoVo1O1NAvSb/lFEeZzzDDmksUU6EjQYusrC/Mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=INH6koCxx1hmW/zwzPZ7ApW/sz2YVsihzr6+8F4bcVNsA/dCB+lp3lGR0MwjVBlgcWXoEK2puoAd0A+e6qBx58XHuB0x8WqjIXlb31Vtt3E/SLwaMyXVk8Ip44/2D3rC35Plsf7b+AUWbfK439LDIqt5XWTTVAMFHRL2yMJzuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql93Z7cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BB4C4CEF9;
	Fri, 19 Sep 2025 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292228;
	bh=c9/5HoVo1O1NAvSb/lFEeZzzDDmksUU6EjQYusrC/Mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ql93Z7cTwJE2w8DGh8GkDSywRgg1JLf6KQcP9PVGR8xhN8kx3mki4Cw65ZFSQwErQ
	 QHZeERLlEuRw+7X8mPlQw71GaYDPuqojzElFU1ufPYxyzfjdyxxt2x/0CnvRI3piSP
	 RK5bV7Z1lkx7+7xfg8LVS2cEb0n4hdO1//amLHG3DJCbRk3/ZbYbWVRV/a2Y24gFs2
	 dUA7eDEsR89FHA0f1+uvOm9N5+gnHdzIFMn/9tRe65m/zD5T/l8MT2xkPiW8aTkqgq
	 SNXOm/ZJG1PdDu+VL+BD2dUxEyOKvZa40XlO/AyKZWQab5CfHSc7KjhvAbxR8CQ3Jg
	 jWQRwVDDM8dYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1339D0C20;
	Fri, 19 Sep 2025 14:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix PPE_IP_PROTO_CHK register
 definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175829222724.3219626.11285913383137248734.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 14:30:27 +0000
References: 
 <20250918-ppe_ip_proto_chk_ipv4_mask-fix-v1-1-df36da1b954c@kernel.org>
In-Reply-To: 
 <20250918-ppe_ip_proto_chk_ipv4_mask-fix-v1-1-df36da1b954c@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 08:59:41 +0200 you wrote:
> Fix typo in PPE_IP_PROTO_CHK_IPV4_MASK and PPE_IP_PROTO_CHK_IPV6_MASK
> register mask definitions. This is not a real problem since this
> register is not actually used in the current codebase.
> 
> Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Fix PPE_IP_PROTO_CHK register definitions
    https://git.kernel.org/netdev/net-next/c/e156dd6b856f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



