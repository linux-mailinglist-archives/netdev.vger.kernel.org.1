Return-Path: <netdev+bounces-205071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58BAFD04A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE22B1752F5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF32E5B3D;
	Tue,  8 Jul 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYT7nDvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE442E7169
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991001; cv=none; b=cNQbNkdXuO3z66hbWzwqXr/uAIP8J3Rk/OrHi0H8/qyzw7QdLbhIADjpKcuF8DafliM4VylYzKGIgIfXfp36BozX4FxgXgGql+C4HteDlwEwW7/4e+AaEYVMSFM/vWO0rFPORnF1+SQoL3AsGR8F3GupHvCdj0u9jVIMftqrIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991001; c=relaxed/simple;
	bh=bDhonFgpdihbC4A+dmq6P/KdH0SHRMNa1pih4wOKYG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LXzpxu/IOAlUDa967c8k0Ul3PN/2Y6S1PdBlqECMvlztZ5oD0ukpVj9BpFDgZgtQaPLxcY9kv2Vg/J+yeP51Hgk/WcPmrsBhaBe49/6XvdUlJFir2ZuzIKiikUaQwsreff7ITgKL1RKw/Z8JUJpMvL0L1klFMoTL8ntglUZsmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYT7nDvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19211C4CEED;
	Tue,  8 Jul 2025 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991001;
	bh=bDhonFgpdihbC4A+dmq6P/KdH0SHRMNa1pih4wOKYG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uYT7nDvlSTVhYUhiRnf/5mVqWMZTuikr3R8lX1ppsFvBFsVYBUAR68AQTDGX+9GAp
	 c+M48PFPMR9dLnfZDRfJ7kN9UtqOO2KEu/bRg6wN5kanLAT7Msl+s8g+YricH+3yCV
	 8lq3/5MEWhq/eg0ITDD1eGk4nO+EJEFuPS6vsKBvK3C+nQledWOmC+fxPD5Z7rb/Z+
	 Y4rOStUyov2UkRVma6HxyTRWlsSpzscRdEyp7xHuI3LdLrLpVQ6opDcmtWJVu/TXx7
	 30JBDlkWDUxfq4sZKka9e165loL64/nreO9TZiZyW3HxSHsGhNYo9NC914RTGBv5go
	 dEUTCy6tpzfPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C37380DBEE;
	Tue,  8 Jul 2025 16:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: declare package-related struct members
 only if CONFIG_PHY_PACKAGE is enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199102400.4122127.11571289435393980799.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:10:24 +0000
References: <f0daefa4-406a-4a06-a4f0-7e31309f82bc@gmail.com>
In-Reply-To: <f0daefa4-406a-4a06-a4f0-7e31309f82bc@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Jul 2025 07:55:52 +0200 you wrote:
> Now that we have an own config symbol for the PHY package module,
> we can use it to reduce size of these structs if it isn't enabled.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/phy.h | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [net-next] net: phy: declare package-related struct members only if CONFIG_PHY_PACKAGE is enabled
    https://git.kernel.org/netdev/net-next/c/c523058713ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



