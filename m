Return-Path: <netdev+bounces-175452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC4EA65FBF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D77ADDF4
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECBB1FDA65;
	Mon, 17 Mar 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw+P6Axc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB91FCCF2
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244608; cv=none; b=iAqSt4fSXvjs3xmxoaEynY7/P4/lp1abUh0+xs9DTxC6rZWUpGe3vqBL86xX1JnOCTyBXwV6IaivFuo+UDSovyLAFhSjDYeQ52+jju1CDRn15iZqhvwXFLlUpKu5v0kbjG2z7TJU67mMKFAxHQjRjAxVD/RgPK15vQMNI80cFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244608; c=relaxed/simple;
	bh=/5nrDEx/cxOivewhUUw6g+VfdmfMMLm0B54SjYnXGHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzuYnw7PmyU3OisWcpAxS6NFgO+5sHAfs/MPYGXbs4E+VfSEjRSSg7zkWHxmuc5/zp1mUXT7qddCsyP0gGIZR6x4dxcLZCiIgDK9GQF9hrLvZY+tXOMdsL8LTxLEDx425DhaTwv5VSAQ6eUAFQSD5CfSlu8ztbfcarH4MxpWXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw+P6Axc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E60C4CEE3;
	Mon, 17 Mar 2025 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244607;
	bh=/5nrDEx/cxOivewhUUw6g+VfdmfMMLm0B54SjYnXGHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tw+P6AxcSpleXMDQKUvlM+oW/xniTXfOfN+tGo9xkmTnjhuFjkfLPy+KZ9PQ6lDdB
	 KrQRk0VuujcjDy3Sa4xHIalESO16NSejUGgMLB3VsFLiybaLtHCu+uEEFNIZ4+BrhS
	 JGcoaZvVkE/mtzE14P9uOS77FOu7o+PlS+yospBYP8n2O7wKFBmAC6EN95+eGLTDqH
	 aeSGm4KOzsN+jpNdclSvt9ZBktK+IP1it8qAUH1xlAdJMINA98u6eMfi0X1Aj64bF6
	 wV08NlmutHo8bGR/FMRFAFX+wgYGRVy+j86omAMUMZncEjAeNQ/ABylqbtWU2cieHj
	 Wr+5g4APFzbIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5F380DBE5;
	Mon, 17 Mar 2025 20:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: remove unnecessary stmmac_mac_set() in
 stmmac_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224464324.3909531.15170592686789310939.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:50:43 +0000
References: <E1tt9Mq-006xIG-IC@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tt9Mq-006xIG-IC@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 18:02:44 +0000 you wrote:
> stmmac_release() calls phylink_stop() and then goes on to call
> stmmac_mac_set(, false). However, phylink_stop() will call
> stmmac_mac_link_down() before returning, which will do this work.
> Remove this unnecessary call.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Furong Xu <0x1207@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: remove unnecessary stmmac_mac_set() in stmmac_release()
    https://git.kernel.org/netdev/net-next/c/39b0a10d80d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



