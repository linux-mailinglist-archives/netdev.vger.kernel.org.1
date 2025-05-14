Return-Path: <netdev+bounces-190349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83035AB666B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081543AD5A4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24035221D94;
	Wed, 14 May 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOy17hXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00597221729
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212597; cv=none; b=Gdzmx0hbgf9plODEgIU3S7dPprxpAUCo/v0L+OX3EZOAohmCTw84MbEYm9apDWKXvFf1lyeJnhmZHCrnkPcR8P10yk6smniAupIUreXWSKRzjDjAk9YI8IACahtQaxaLoPpqyobHoVJ1qUYxcr5n6LXTjK1zZcOc8JaEo+fwgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212597; c=relaxed/simple;
	bh=LjJhNb+NPIusx9+nibzxtjjPldfVpWbRMVl8XIL7cpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RdvHBr7yZ4EtRmmzDCIJnHYWheLgkbbEXzeOw/zh6FNMFbXRQY6fgy9M9CIot/LbItq9WEMjUlcxCoBHKNGnGpC+zKTE32Ujw3+Iu46nkEBfeqlZPlTb0nPnEFNYZhI1XVIbPi7eoO0ljUS6D12ybJdSYfJNyT5hXiAMZQjkkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOy17hXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9E9C4CEF0;
	Wed, 14 May 2025 08:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747212596;
	bh=LjJhNb+NPIusx9+nibzxtjjPldfVpWbRMVl8XIL7cpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WOy17hXqd6nJvuJxu8j9v3zZGRbywpDdS28DmnSSDvhUkBHc7dRlNfFZuTU50qWBK
	 NMWaOdVGmTY7glua+So8cpVaGwFrupIb4HY8tAP3QIIo1Gs6NDwnl50AscieFJDTYi
	 b0+wTN+6M3+04be0vThSSP4QfCjzRp5vIjt7jp9LHiqbdKvGkuYzkg6WcOvet+uIeq
	 OJ2pc9Lt1Zp/Xd+yWERsJDicairVUA0vDZcmvzuQMecW0xHL7Uv2AHSAde2oxxjqZv
	 9/xTB7A3j45Mzt1kQHnBYb6QpchBc0knr0kM2GcIlmhrpYZthRIsKwVben+ToiEB+C
	 /Fv45Fn6p11cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF8380AA66;
	Wed, 14 May 2025 08:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: wangxun: Correct clerical errors in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174721263375.1942803.6208331215896701801.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 08:50:33 +0000
References: <06CD515316BD5489+20250512020333.43433-1-jiawenwu@trustnetic.com>
In-Reply-To: <06CD515316BD5489+20250512020333.43433-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 May 2025 10:03:33 +0800 you wrote:
> There are wrong "#endif" comments in .h files need to be corrected.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.h    | 2 +-
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: wangxun: Correct clerical errors in comments
    https://git.kernel.org/netdev/net-next/c/838b2a28c031

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



