Return-Path: <netdev+bounces-221909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C1B52538
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037213A05D0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EF1F3B98;
	Thu, 11 Sep 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syIAh+Ob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6261F237A
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552404; cv=none; b=bpLSFpqSm9Zk5qmF3DzyJLnmGsX0tMLOwZfdRsvCaV02IE7VcLFhoYchfnwy6BluumA8DbdARqpJ3D2inHBXA7mv8+Toq0kZ5t1aiwSFdwnAvdjVb+xVbWj57L6Yu+WxMIOl0k6Rqq/roPN5Hvh9b43r0EfDQDJ8soFPzwtRMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552404; c=relaxed/simple;
	bh=DRtCX1OgZcfnYUPNDwEMV/MItTo6xliwHZL+vUxPzPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JUCweQ6o9ZgwFtTN05l1/ZF0qWRcsIDtNARXvO4nNV22pZGfCRVDpZasvLFjXfFy+fQh2OkHb5Gsj2zdDb8p22zV02fH20d4+Mt64qBvrJN8EdziiyMX10PIvHBdfX2ffFyXCvu9Z2OH1OO2xMqcxVF2K5kh9AHiyS9iwcrD900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syIAh+Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDE1C4CEF7;
	Thu, 11 Sep 2025 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757552403;
	bh=DRtCX1OgZcfnYUPNDwEMV/MItTo6xliwHZL+vUxPzPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=syIAh+ObHB2WHbGjO5/JaA3DG8791jSqYt3zXwAVN6qYCaIUM2zgGFh/lDfauOcrR
	 Oa0AbimMln0+OSouipgZDGYDXlaizoSGRYZKGQkOjWgsdozPDPB3H+g69ITCHB8q5G
	 UUukpPOZ/9jWs9U73T+T83xtUR6atYEk1QDr8E+nqh4TBx28WXl6i3jIQfrPZSa/0Y
	 1HMoDmSqemaf49wcDC+NzjOyTOATfp0SPaASLtUFeJQnVO51wTRAyTtmij69awrRH/
	 ezx6VCM7T8u6VVV8X/ek3RBW8eP8vH2uO5gFvb2I7tCqgyifSYVeBov7jv6ITgIueR
	 pcRGQyNTxAgaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE172383BF6C;
	Thu, 11 Sep 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: fix wrong type used in struct
 kernel_ethtool_ts_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755240661.1614523.16873488190452553602.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 01:00:06 +0000
References: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: kory.maincent@bootlin.com, wintera@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, sln@onemain.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 07 Sep 2025 21:43:20 +0100 you wrote:
> In C, enumerated types do not have a defined size, apart from being
> compatible with one of the standard types. This allows an ABI /
> compiler to choose the type of an enum depending on the values it
> needs to store, and storing larger values in it can lead to undefined
> behaviour.
> 
> The tx_type and rx_filters members of struct kernel_ethtool_ts_info
> are defined as enumerated types, but are bit arrays, where each bit
> is defined by the enumerated type. This means they typically store
> values in excess of the maximum value of the enumerated type, in
> fact (1 << max_value) and thus must not be declared using the
> enumated type.
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: fix wrong type used in struct kernel_ethtool_ts_info
    https://git.kernel.org/netdev/net/c/6fef6ae764be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



