Return-Path: <netdev+bounces-68781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B401F8483CB
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 05:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBCDB2115D
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B02101D0;
	Sat,  3 Feb 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/nY6CxD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8030FC03
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706935828; cv=none; b=PrwFeamiWf3RuwhfY4SIMMMxw+fepmljqelk2ZqTH7vPr/DoKPVzXFjURqTXmuyfZj29twWyR/mTk8915SajvLT3rMeRzXN+EzplWXtJNCXIIbAuHO3V5/nCtwH8GKQ9c3JJbprX0tOPBABKr3dtZ6tFhOVL46kzSDrQ+Hk8dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706935828; c=relaxed/simple;
	bh=fkN7ZyEKcagegtUbCU+fVxZXIX3BGnQwRwWdY9IXvv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=egKTHIHhtr9YbXHT3lL9EEXI+oLMKMEuMZj0oyhGIvmg2ycSdivUqpFcaNSt28d4VcMlItcenk+lrvT+U2LqAmPdX/zzHbtHDuJAYB7oPE+4ev0ygpkdo+F4fGZ49Q0Jm0Tf1YmRrmze7RGyXGSamm9U+2CgSApE+jbkIQTiX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/nY6CxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D5DC433B2;
	Sat,  3 Feb 2024 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706935828;
	bh=fkN7ZyEKcagegtUbCU+fVxZXIX3BGnQwRwWdY9IXvv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/nY6CxDmogE0Gt9sCK3mcApgDe4/3rhefFQP5XofEY2GGWoOMtnFTOjmqVNo7E5+
	 ya5JP9O/VGDJYTNd0XX7TU4Dd0hOUhygU4jp+NB636HqJeDVe4lQRHcKjddD+asP3J
	 +hvvpQNSTPnbJ3ysHKSVEWFLBHgSaoLH+bwirwqwFmBgVi3Us6+uCRp8PhbbNuW0Mj
	 j04/jeY7P3gA598jyueV1CdJc5ofYQ9SOKRTLTf0qbILGVr4/Q+NxPFX9N7IatGdL0
	 lC+FosuvsykGK6EHwEiUC6wjOzcoYeBgQdmpBsV2a1Wx76zzJ1WDIvLWue2TMPIXKD
	 F19Pq2IBInI7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 209F8C395F3;
	Sat,  3 Feb 2024 04:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: add support for
 RTL8126A-integrated 5Gbps PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170693582813.20949.15509947212669286478.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 04:50:28 +0000
References: <0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com>
In-Reply-To: <0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, jmscdba@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jan 2024 21:24:29 +0100 you wrote:
> A user reported that first consumer mainboards show up with a RTL8126A
> 5Gbps MAC/PHY. This adds support for the integrated PHY, which is also
> available stand-alone. From a PHY driver perspective it's treated the
> same as the 2.5Gbps PHY's, we just have to support the new PHY ID.
> 
> Reported-by: Joe Salmeri <jmscdba@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: add support for RTL8126A-integrated 5Gbps PHY
    https://git.kernel.org/netdev/net-next/c/5befa3728b85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



