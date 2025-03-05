Return-Path: <netdev+bounces-171890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F3A4F365
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4246E16F4A7
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B0913AA2D;
	Wed,  5 Mar 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw8mn4yT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072E11187;
	Wed,  5 Mar 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137605; cv=none; b=MTLg+0erQdkkd0rTXlpn7YB3WI7LTiw3bYgagPL8PuNnTDjtC5CXa/H4mXYeFW66HP6eu0r99YgRP/zYoxPMGIVpKl3+bxIzZ/vap0FugrXZjveBBhCVfRvLrc11M/XrufEkp6ffT1v6wtak2O0zxKNpDIiGvheu0MZJ0nVv/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137605; c=relaxed/simple;
	bh=mDKHo0Pitg/ucTdMd+1cxtHXnsCmHgjQ5ITdIbe3Zgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gw+8HcOow/o/iKMOLBVVOjTKwk6qEtOW+NHhnWk8da5/F49kG0Gxv/QcIHwp0ukCW/fjG6lZw+ou714WPGEEwX2tfpX/jqymPKWeVgR7s2PQbdelTlhiPY8gNaRuPXovOeAWtSdnwg4/aDNsKHtClBwYfAPJ+hpsUMHWVMT7FGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hw8mn4yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717DC4CEE5;
	Wed,  5 Mar 2025 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137604;
	bh=mDKHo0Pitg/ucTdMd+1cxtHXnsCmHgjQ5ITdIbe3Zgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hw8mn4yTkUrGdGKZWmULRrc0s0uBZSgODD26zFl1iSWOSr7HxxdsF28pwBzvmPMNI
	 RuJJXdx7JaOkR/2sVdYkflySxM/qkZ4vZfiDKK/Jc0QCD0JEJzJ8wJjJG1ZetAiuek
	 qOm4E0D8UlxnwJ/z2P9l/xA+lrb4xM1wzoXIvm09K1Bz+2DSDNe/fLQhw7YdNXtl47
	 EcVSB1fsHYSlCP+Gvip7W6zjC11ikrxNkBOU0V1iUX+Ig0masrCv/OcQhKJiHR2CzU
	 DQ5LFOqFt7thh5KckBJ+TVVUXbgS/JamihC+TrGkjBvSjFxCclqB8NlwScbeT/oZiA
	 zpbO2lwmKR1Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6A2380CFEB;
	Wed,  5 Mar 2025 01:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] net: Convert Gianfar (Triple Speed Ethernet
 Controller) bindings to YAML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113763773.356990.16443776503702976199.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:20:37 +0000
References: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
In-Reply-To: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay_=3Cdevnull+j=2Ene=2Eposteo=2Enet?=@codeaurora.org,
	=?utf-8?q?=40kernel=2Eorg=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, claudiu.manoil@nxp.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, j.ne@posteo.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 18:32:49 +0100 you wrote:
> The aim of this series is to modernize the device tree bindings for the
> Freescale "Gianfar" ethernet controller (a.k.a. TSEC, Triple Speed
> Ethernet Controller) by converting them to YAML.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> Changes in v2:
> - various cleanups suggested by reviewers
> - use a 'select:' schema to disambiguate compatible = "gianfar" between
>   network controller and MDIO nodes
> - Link to v1: https://lore.kernel.org/r/20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net
> 
> [...]

Here is the summary with links:
  - [v2,1/3] dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to YAML
    https://git.kernel.org/netdev/net-next/c/e4c4522390c9
  - [v2,2/3] dt-bindings: net: fsl,gianfar-mdio: Update information about TBI
    https://git.kernel.org/netdev/net-next/c/0386e29e60bd
  - [v2,3/3] dt-bindings: net: Convert fsl,gianfar to YAML
    https://git.kernel.org/netdev/net-next/c/a70fdd936818

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



