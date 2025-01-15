Return-Path: <netdev+bounces-158342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EDDA11705
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31E0163E76
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1FF22DC43;
	Wed, 15 Jan 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMgDowTq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7F3594F;
	Wed, 15 Jan 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907010; cv=none; b=NDFr+abdhpws/nDYctyMVn4xy3S4MXtzgnB5niJ5tFiSgleOCe6l529pjtGlgIMv2Wea51/CIt9m1mst5plVINmM1/EJHSQIXmy2hQYzIlWX/tkse4C97CP14BPQ3/AbaOqvvG6EUsc2rs+tl/xUThu1EjG8MllIXDGlr+fbLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907010; c=relaxed/simple;
	bh=VkD0rcWwKLY34VeqN/EnCIzaNzNTN+EiI+U6FIg54dM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ibsiHTlnpzZ5Do1NA/ZVypUW9ZWSkSQVdfXt/GuscrJAs3igLN+FWRHXyxQ5+7stgEm6iRqANSEdCcGPThiKXfwua4cgkOmmez4g5NG3F1ZKqZeU4arWt+8vvbdJRRvAaJfU/5OHfOd7fbcPM864bz2b5q/rpKVUw12WLKU4uA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMgDowTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A632EC4CEDD;
	Wed, 15 Jan 2025 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736907009;
	bh=VkD0rcWwKLY34VeqN/EnCIzaNzNTN+EiI+U6FIg54dM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WMgDowTqRPpbE57sxITSzs/kv1ehXK1gTO23zp8BZbecDWQc0eAcp6YLK85IGhlWI
	 XG9NokMApljZw4MpAguV2jINE7uVcMsvRxasVIXR9zmy7POqMnTn9Yjt0NAO+G8uWw
	 t1BOa82Z04DnOA/6lbKvNWx3fBT9k7qtg+lo675KgzLhqHn5xkMC2mQoXQVBeKOq3e
	 gstguUqUKDFkVT0l5Ax6/3xEKBTbWjCQ5MzACJV5uL7vMkWpNvEDb2bb/wadS5bcKz
	 hwqVpJYUD0xppn4PLKxTpFs5VbFP/Pkrkfd+KsvhxEvug5S5Xnq+uu3lIWlrtxxSHK
	 r7Ah36iSz4htA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE10A380AA5F;
	Wed, 15 Jan 2025 02:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: ethernet: Simplify few things
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173690703250.220881.14038994805665516239.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 02:10:32 +0000
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Jan 2025 14:32:42 +0100 you wrote:
> Few code simplifications without functional impact.  Not tested on
> hardware.
> 
> Best regards,
> Krzysztof
> 
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: ti: icssg-prueth: Do not print physical memory addresses
    https://git.kernel.org/netdev/net-next/c/136fff12a759
  - [net-next,2/5] net: ti: icssg-prueth: Use syscon_regmap_lookup_by_phandle_args
    https://git.kernel.org/netdev/net-next/c/621c88a39276
  - [net-next,3/5] net: stmmac: imx: Use syscon_regmap_lookup_by_phandle_args
    https://git.kernel.org/netdev/net-next/c/1e38b398b671
  - [net-next,4/5] net: stmmac: sti: Use syscon_regmap_lookup_by_phandle_args
    https://git.kernel.org/netdev/net-next/c/92ef3e4b3a5b
  - [net-next,5/5] net: stmmac: stm32: Use syscon_regmap_lookup_by_phandle_args
    https://git.kernel.org/netdev/net-next/c/6e9c6882f9ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



