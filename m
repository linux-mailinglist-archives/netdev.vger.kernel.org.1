Return-Path: <netdev+bounces-125510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9496D716
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E1428751C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F012E199EB4;
	Thu,  5 Sep 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icvAo9sz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4465199EA7;
	Thu,  5 Sep 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535831; cv=none; b=bYmZTgprVYdqylo9l1ZkC7RfllBE6BU5dijuGPOSEZznx6GDFrlPh4NqBrJmaSRmk/kGiAXaKdSOUHq+NSO9Xz0BN5MFZD//VhDkJW7je5A4yAW7Uug2lLFnfI0jd/o9LzDph8pLARjR+ygA4l7fGco8LJDmDPhBieemCUIMI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535831; c=relaxed/simple;
	bh=3KBDMRhKBiKoS2oBNaYjWMKIz+MDkWgGXsEUMwFCMTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c5JYFsx6Hl0u2jBNnbu74XcFGbNW+8LCogpHeowkXNFHDFOG5P8wfJXMXxHfBFEPE95PuotJi5w7SdLfze4Ea/BFssLzdPlzqD4S30CxQT6MUoEd5HdMpOZO59W+eA1kRaX/GWukY1ThLBaQMoGkqH1+HYywd2t4ilPga5yrMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icvAo9sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D75BC4CECA;
	Thu,  5 Sep 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535830;
	bh=3KBDMRhKBiKoS2oBNaYjWMKIz+MDkWgGXsEUMwFCMTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=icvAo9szxLR+tQeYWaIIvlZWotha7L5EP+5EXBoMuUkSEvlzkh3qpKBrEMx+fehCQ
	 h2z6GMTU1zcmQImoioMGZ5CZtdgSaDSswm2lVKso3x06Wq5+UMHNrsC38fxmSlSpRu
	 W7gc/xbJX4sE92k0j9gaWA4nyIXsNppWzldPTrHarISSePFHAtoQxv/pcfMMNnhmi3
	 mooQGthV6Pw/4y2xRVnPc3IZfdA2IUWurhDZYl8r3qF+/Fr8vWlCzFQU5FwHnEgtIy
	 NpzO1Drv5vO2+Xog4SCgpBBDAM6/Nto+Hn6D8rNDlTuKqWZzw52hTZf7T/eln6VsWt
	 C5YvlxKR/kUiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C883806644;
	Thu,  5 Sep 2024 11:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: dsa: felix: Annotate struct action_gate_entry with
 __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172553583075.1653140.16718879512076834238.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 11:30:30 +0000
References: <20240904014956.2035117-1-lihongbo22@huawei.com>
In-Reply-To: <20240904014956.2035117-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 4 Sep 2024 09:49:56 +0800 you wrote:
> Add the __counted_by compiler attribute to the flexible array member
> entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/net/dsa/ocelot/felix_vsc9959.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [-next] net: dsa: felix: Annotate struct action_gate_entry with __counted_by
    https://git.kernel.org/netdev/net-next/c/50ddaedeae75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



