Return-Path: <netdev+bounces-190584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38133AB7B56
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 03:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495B7980688
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 01:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7AA27933E;
	Thu, 15 May 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWAmZMRy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AD41C71;
	Thu, 15 May 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274393; cv=none; b=J2OpfawTyfCuMmscAcMzn6prRHaCit+gn9ODYbt8r9F5tal3C0RSMoUSshRKBqDoqqIWKHDR4HrZPpNWusYjjzfwo2Jo/tXqHIbtk0grIQm2k3kgl4+AaQfnQ3UtJ/GaxCvSrmLDOqZjQGQv6CNgKsUUztJZrRQ3vqI5dn0Z0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274393; c=relaxed/simple;
	bh=S2H6UqBUBTSb4vAbOGk+4FjIFfo9bZNgQsNmb4DJWus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qg/XuuxqGUQzQpwRRzJHe9uC/atFGeJHuPJj3Hr5BeklrFlT7MSl5NdpQCFWISQxI9SKlb0FFD4fM4kJN7PtEZDAIiqwKzi2gua37PNRiETJaSQ9BYfkTURytAouiecC6rbvQ+JxVlmlXlRuyNKqSjbA9aAYN6nQYLRDaplnG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWAmZMRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE70C4CEE3;
	Thu, 15 May 2025 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747274393;
	bh=S2H6UqBUBTSb4vAbOGk+4FjIFfo9bZNgQsNmb4DJWus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BWAmZMRyp/hs9OfqWgWlqXug8+EL0U49kOKnAaQxj6GxR/62iH0c5mgxgMBGf5/z1
	 m2ilAprhlrYBZqbUQL02mHKSTLyjwyD1dlXLwskTw/zHwNjrsBiJrouzuiMCuTaxTQ
	 /w2HjDbVdxoErbzZhgYoU52VGM4C5R5JDukbo/nltRuhcb3VjRH+DKJpZGFBB/Y348
	 INhP6Ysyunt+Hxifb7/wWJQFuFMAPDTNGJ1t/4VZCSOqCQOTKKSBPXkJEm0WHHv55t
	 WVF+9pybgE1foF57YJIOv9PHWzKQa8SIItJrazYBKbzddizUbKJ2uqWvFtnx1kcK4B
	 gRFJcr7+02KoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD05380AA66;
	Thu, 15 May 2025 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: snps,dwmac: Align mdio node in example with
 bindings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727443076.2577794.8072853416288852164.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:00:30 +0000
References: <308d72c2fe8e575e6e137b99743329c2d53eceea.1747121550.git.geert+renesas@glider.be>
In-Reply-To: <308d72c2fe8e575e6e137b99743329c2d53eceea.1747121550.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 09:33:56 +0200 you wrote:
> According to the bindings, the MDIO subnode should be called "mdio".
> Update the example to match this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> For dwc-qos-ethernet-4.10, the Linux driver insists on "mdio".
> For other devices, the Linux driver does not seem to care, and just
> looks for subnodes that are compatible with "snps,dwmac-mdio":
> https://elixir.bootlin.com/linux/v6.14.6/source/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c#L302
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: snps,dwmac: Align mdio node in example with bindings
    https://git.kernel.org/netdev/net-next/c/685e7b1522f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



