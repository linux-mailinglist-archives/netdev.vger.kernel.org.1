Return-Path: <netdev+bounces-184062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375BA93021
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B9A19E7CD3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621B267F79;
	Fri, 18 Apr 2025 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrLrmicd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35A267F72;
	Fri, 18 Apr 2025 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944624; cv=none; b=VwoW01tr0D+fisWTOHKY+Aop3xF2cDroKnLdm6ujwjmAXPUr1flsJZHyY8juGmm3JeZpGwLRCeDSOVO3KjcbgvsPbt/3+Qewg1bvbSTh+WNvnDiD6HlnLp+qcW1P2RuBGzPjOVhxU0c53atQ9eV4EIdBfU55sKvMDugaNluZtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944624; c=relaxed/simple;
	bh=Fubtw2LiX2h/GPykQvwD3PKeaygyJWRoQRtP0y3Cyys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iBy6LqD1b2IG+qbmfB/F5eCnRhnQ5aPnzyf0s9cdoKT+HO1tH/sk3SXjcayK1z78VAGuvPqC6xZV0gJJ2IodTI5Z6SCFRzZOKXuevQ2sXnomi3ciA88EBUcSoX6h7f0i1bDt4ttfCDMqOjx8o0VlShYSqypIpyJ+t27dWkaXxkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrLrmicd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D709AC4CEEB;
	Fri, 18 Apr 2025 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744944623;
	bh=Fubtw2LiX2h/GPykQvwD3PKeaygyJWRoQRtP0y3Cyys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LrLrmicdbk6MVe40iOt2KjI6qz+qKZ/v8+Wtul4PQO1f5RQ468hL2LgpBVpGZ2Ab5
	 kLLLYyKoUNFoPW0YO/k+fc1ekoBITcLEzWT6DTBcDs7wmHGwgOn7WemXvKXLLLBqXm
	 CUC3G+Zcx9X+48NZP2VdNwMtxSr8Y23BvueAAqP63WW2kBZ/7wCfcP9a+v/lCe0fjw
	 vPL7sWvp4zz/NsT1oQ72oEt2dv7JKVIdiSXCiLYi+ApvmtHk9Uu7uVO8LZOeYh1amL
	 CT6G/SSPM+RfZ5LkjbWkgsz1ozA8OoTLqE8/2SrkPvsTkVxkcG/iycoEMQI6an4O4R
	 ZJDM9OjWq1+wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD9380AAEB;
	Fri, 18 Apr 2025 02:51:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Delete the outer () duplicated of macro
 SOCK_SKB_CB_OFFSET definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494466188.88264.18380333809771483443.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:51:01 +0000
References: <20250416-fix_net-v1-1-d544c9f3f169@quicinc.com>
In-Reply-To: <20250416-fix_net-v1-1-d544c9f3f169@quicinc.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, quic_zijuhu@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 19:56:23 +0800 you wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For macro SOCK_SKB_CB_OFFSET definition, Delete the outer () duplicated.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/net/sock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: Delete the outer () duplicated of macro SOCK_SKB_CB_OFFSET definition
    https://git.kernel.org/netdev/net-next/c/2b905deb43ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



