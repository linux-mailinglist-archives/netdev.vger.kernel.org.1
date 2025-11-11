Return-Path: <netdev+bounces-237399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9BEC4AA90
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FE43BB491
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FC340A62;
	Tue, 11 Nov 2025 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/T7yiv3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE72D29D6;
	Tue, 11 Nov 2025 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824038; cv=none; b=CUEJmBfZ0UbQUyLqvitxSh2fudX0nBUtiM6DmduYgX4GSASsspNVN4qHDgwj5/6lhqPSeoCnHsZZly6P7hH+noXhGYP/TJSM4yV04f9zCU/WRJFs/JWh8lwm3QWN/8Xcqr4EI3J+bsTB0ZYy9VT1vhVF5ChaW7SyWb3cvfM5VFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824038; c=relaxed/simple;
	bh=2VKB3jDJRmEkdtBml0Q8AWulnd0epS3VyG9whUlXFZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XzE1Skl15mWht1EyATp96iJ//suTklFaeJGKRvteR740a99uXUq5sBzhvDD+HJIYSVfUjTLBBFW6gleBrE2UkZnmdMT2Ff1Ru3RObuj0u22FYKpma1/Lcq9buNsYd6K41B0LJp7omgPsPEXAvE8rMCMfR4cPeiEXce402Vkp1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/T7yiv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6476BC19421;
	Tue, 11 Nov 2025 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824038;
	bh=2VKB3jDJRmEkdtBml0Q8AWulnd0epS3VyG9whUlXFZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/T7yiv33Qzszgd14LCidiXjYRttzyMGn8RY2jUUPh9mjfwMEGu7XlG/5oA7a+O1d
	 MMJaKc692uF8M/q6ZAdwQWNxtuxrbOo+KRJDdrlYty70by6ie+zHsRgDiLhmX4oGFP
	 ajMAab3FKJyUyqzfc7hwx3GBA6+hgw0iAoghH1ytEB/t1J0WCkY0nkpLk2zVnwaWZf
	 +dliqBgWnEQVLFHmVy0JCq9v0l/W5HQ1Q/mh6+ZsL8kdj0DdjnSTgymGAb7od/U/xT
	 +12g+aB+MaPd2YTLvfetMUxE0R6oL9qPhShYiRmyuOZu9ciD4/d9gMUk+DFuE46GMF
	 +OMSHQmlPp5nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEA380CFD7;
	Tue, 11 Nov 2025 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: tag_brcm: do not mark link local traffic as
 offloaded
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282400901.2838761.5874391648959720079.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:20:09 +0000
References: <20251109134635.243951-1-jonas.gorski@gmail.com>
In-Reply-To: <20251109134635.243951-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, noltari@gmail.com, vivien.didelot@gmail.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Nov 2025 14:46:35 +0100 you wrote:
> Broadcom switches locally terminate link local traffic and do not
> forward it, so we should not mark it as offloaded.
> 
> In some situations we still want/need to flood this traffic, e.g. if STP
> is disabled, or it is explicitly enabled via the group_fwd_mask. But if
> the skb is marked as offloaded, the kernel will assume this was already
> done in hardware, and the packets never reach other bridge ports.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: tag_brcm: do not mark link local traffic as offloaded
    https://git.kernel.org/netdev/net/c/762e7e174da9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



