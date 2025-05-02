Return-Path: <netdev+bounces-187355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D1AA682B
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB6A7AFDF1
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E185260;
	Fri,  2 May 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwszXV43"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F24C6C;
	Fri,  2 May 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148196; cv=none; b=NUMEi+tIYZHhchY+ofuXy48uEqlI8EL38kiHixMNl6WDSrPodP9KzvwCpy0/nqf2fGPJgCfUnz8hmTU4gMrdwkz/9l24tufsJtR7ujjkWyK6dzhT4N/M0fAypn4d94bxbMIyonO9gRblkAxQfLNfe3hJ5uWmFIdylxKsDmUmxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148196; c=relaxed/simple;
	bh=lleui9YZj1ZPGW2rU3DcmlJmd8ORLV6xd0I6f7lEiZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pkK7FXUA/CoCO5Ct88KN3Rv82yTMLfwEzQscLugJz/EGV/qsPU609W5AQmzbADJUt7Qey40hGrQYhQTLblITm3FAwXFk/QAd2/CgnVs+JE9ubl5Cv3ovnMshc4pY0GW0UFA9UMB+5XFjZCwmsdSObpBytSTGgYSFk3D6Nuv/P9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwszXV43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E3AC4CEE3;
	Fri,  2 May 2025 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746148196;
	bh=lleui9YZj1ZPGW2rU3DcmlJmd8ORLV6xd0I6f7lEiZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jwszXV43n5sTI/lJNUFvmM8lAunWNcPqcuMNwG4asIyPKU7Vura+g1O1N+p+Wup80
	 F1501QBwu/9u9VRttT20Jns5ySZNAAnRF0oAlfuj1aBfL81VzNPJ4HurgjkrfBGNlT
	 26wifFgaIubylluwyDNddzZ30ovmRyTUWOeh2312gqbPeQ+W/e28VqUSeeTo1oIChm
	 CGasaMCTIhy+JSCf2hp6WbN7VN/VQEM01PbK8cU9RU13hwCrzFKTpMsRZwvH2oRpXX
	 x3Ij7rwtjX/zIoWJb6lNEXXK0KiYnjv3MKgUxC6pjxIsrS2openH1zZWLlJqOCGzJE
	 /Ogds3RM0Dltw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 635023822D59;
	Fri,  2 May 2025 01:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: via-rhine: Convert to YAML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614823526.3123530.12844866461637872055.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:10:35 +0000
References: <20250430-rhine-binding-v2-1-4290156c0f57@gmail.com>
In-Reply-To: <20250430-rhine-binding-v2-1-4290156c0f57@gmail.com>
To: Alexey Charkov <alchark@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 14:42:45 +0400 you wrote:
> Rewrite the textual description for the VIA Rhine platform Ethernet
> controller as YAML schema, and switch the filename to follow the
> compatible string. These are used in several VIA/WonderMedia SoCs
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Changes in v2:
> - Dropped the update to MAINTAINERS for now to reduce merge conflicts
>   across different trees
> - Split out the Rhine binding separately from the big series affecting
>   multiple subsystems unnecessarily (thanks Rob)
> - Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-4-f9af689cdfc2@gmail.com/
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: via-rhine: Convert to YAML
    https://git.kernel.org/netdev/net-next/c/630cb33ccfcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



