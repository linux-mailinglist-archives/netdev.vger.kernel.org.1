Return-Path: <netdev+bounces-213169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D2B23EB8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 05:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B653B887B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB928DB54;
	Wed, 13 Aug 2025 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtaFsfBp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132B28D8F8;
	Wed, 13 Aug 2025 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054083; cv=none; b=l1QqINhMO2R55CxFR7uerRI7GrC5/1nOsKlreGFbVaNm0s+VUDG/32AJAeru9bXdOdhMoN8LOPh4PxgNbfhVNlIGZNQKUyGeiRf3b8z+wnxJoVxStux/2MLQj5hBLdewDSXEpZ7o4FqHIUSEkteoDgEpk173tQcVVyoKrT6JSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054083; c=relaxed/simple;
	bh=ah5s8QI5yHtW13rFxqFgRLPbL9Ck1PJlUKhkvkzSQak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oUNzYk1Voo8dQqpcktJW2GK/wpmiAszFR7JkVl1m26Hf3JwryWB0rfx+JTYIhIf69rzl3bYXGL8IJCo9GcaQrHAWUIYZo2EgOyzutDXStA0k+/u0ZUDtSIirpmwYbqHzI+YY5sffZa7FJN1JVtkdCbhS8zaHvJw73DU2BVWPQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtaFsfBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B7FC4CEF0;
	Wed, 13 Aug 2025 03:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755054082;
	bh=ah5s8QI5yHtW13rFxqFgRLPbL9Ck1PJlUKhkvkzSQak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZtaFsfBpGd4++cIB4bzulDyJTU+BzAc+HjH/48RK5e+BPK6wUbQjUptHB+rpDh6wQ
	 dDpxmjbLnJKlG3eoXWwo7sDZLmCkRzYGzH1hsS1dQ/i4n3sFNCCH8hZI6iTVW0eLYD
	 31YhUsdh/x7zHyQxISNMxz2cf+N0R/gZ/fl2w2ffneruvZ37TuK1O6TO0zB7HmyYsl
	 NPGIM56c4rXmAoq5dJB71XU1oq+27uzWrOcJE7v1+UqUW0YKXJVuIKbbBOSocxg0ea
	 Xwe4wSh070Dz9L5uYr+MsJ9e4kzIGivLxNqnCWMC0J3J/brzB87wQBxYX/hoXf50os
	 W70J47kv1lMPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2539D0C2E;
	Wed, 13 Aug 2025 03:01:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/7] net: airoha: Introduce NPU callbacks for
 wlan offloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175505409423.2923440.2479531614501125802.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 03:01:34 +0000
References: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
In-Reply-To: 
 <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, horms@kernel.org, nbd@nbd.name,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 17:31:35 +0200 you wrote:
> Similar to wired traffic, EN7581 SoC allows to offload traffic to/from
> the MT76 wireless NIC configuring the NPU module via the Netfilter
> flowtable. This series introduces the necessary NPU callback used by
> the MT7996 driver in order to enable the offloading.
> MT76 support has been posted as RFC in [0] in order to show how the
> APIs are consumed.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/7] dt-bindings: net: airoha: npu: Add memory regions used for wlan offload
    https://git.kernel.org/netdev/net-next/c/cebd717d8f01
  - [net-next,v7,2/7] net: airoha: npu: Add NPU wlan memory initialization commands
    https://git.kernel.org/netdev/net-next/c/564923b02c1d
  - [net-next,v7,3/7] net: airoha: npu: Add wlan_{send,get}_msg NPU callbacks
    https://git.kernel.org/netdev/net-next/c/f97fc66185b2
  - [net-next,v7,4/7] net: airoha: npu: Add wlan irq management callbacks
    https://git.kernel.org/netdev/net-next/c/03b7ca3ee5e1
  - [net-next,v7,5/7] net: airoha: npu: Read NPU wlan interrupt lines from the DTS
    https://git.kernel.org/netdev/net-next/c/a1740b16c837
  - [net-next,v7,6/7] net: airoha: npu: Enable core 3 for WiFi offloading
    https://git.kernel.org/netdev/net-next/c/29c4a3ce5089
  - [net-next,v7,7/7] net: airoha: Add airoha_offload.h header
    https://git.kernel.org/netdev/net-next/c/b3ef7bdec66f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



