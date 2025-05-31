Return-Path: <netdev+bounces-194458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457AEAC98E8
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 04:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FE19E59FD
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AADF12CDAE;
	Sat, 31 May 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz+W4q75"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080B78F36;
	Sat, 31 May 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748658604; cv=none; b=mCkRiG5HpTqKj13NXsDz1j+7JgflauTqgyR7XlvmhW/NvrL5hiCa7BugK+R4ziTEf2smDCDnjgz86YfsOsezYTed2y554kUF86Dczo68KcnvpLmOdDEfYL+5KvlvXAx5e2wtXdPEyJHWmRxG/PDJkZpKdtgMmXcyf1bhDM3lf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748658604; c=relaxed/simple;
	bh=R9JtyYLi+HUPhorbsC7ql/gTBchMouVdefcKXOb+kPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ukMV3qnDU/CFohF2mbmvVeTwuKtHGZrksWIaZ5w1BKz3UjmsAUTgIR5zlxz/s5LJzDhHUwzcvZXGlM+GuNjEbFYvVJxe3jVRcTXv8L+WG/COfkGNdJpztsD5ulujVEFedFAtsngPPdjocObpudanlGgh8TOT5mrmrhe7cbKVVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz+W4q75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E1FC4CEEB;
	Sat, 31 May 2025 02:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748658603;
	bh=R9JtyYLi+HUPhorbsC7ql/gTBchMouVdefcKXOb+kPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tz+W4q75RwtBzPDv3g/dt4qydhaZh+YYVvBXA/avx7Z3H3Bu6+9DsVxDRSMztJhfv
	 bHIinPz1Wbk+T/GXpEfwssg10or5N7tq2g8y9JEtELkxI4dHeA4vMsaF5tlGZRhVUf
	 zcK5XQVgTxsQ/XKqei294sAaJO/DmQRh2b8viF2d2hvqsUsw7WSIFMX9PGKVZQDDHu
	 n/8WUGsGNP+L6wH3Jhu5cpK7ZESGV2kCc/G+lz69c9mtuWiM86cHb2vpnfS7GVbSVb
	 rvb6YjLhfCEJvZJZKg/4WCm6nmZj/W2Axq7eHoM5HuaQPpVTFPyDPdKl9V+M6bSAvn
	 uA/xFA56tpS+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA539F1DF3;
	Sat, 31 May 2025 02:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: tag_brcm: legacy: fix pskb_may_pull length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174865863700.8596.4449682105659316697.git-patchwork-notify@kernel.org>
Date: Sat, 31 May 2025 02:30:37 +0000
References: <20250529124406.2513779-1-noltari@gmail.com>
In-Reply-To: <20250529124406.2513779-1-noltari@gmail.com>
To: =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas_=3Cnoltari=40gmail=2Ecom=3E?=@codeaurora.org
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, dgcbueu@gmail.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 May 2025 14:44:06 +0200 you wrote:
> BRCM_LEG_PORT_ID was incorrectly used for pskb_may_pull length.
> The correct check is BRCM_LEG_TAG_LEN + VLAN_HLEN, or 10 bytes.
> 
> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  net/dsa/tag_brcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: dsa: tag_brcm: legacy: fix pskb_may_pull length
    https://git.kernel.org/netdev/net/c/efdddc448485

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



