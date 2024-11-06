Return-Path: <netdev+bounces-142188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF59BDB70
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740232848FD
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39518DF71;
	Wed,  6 Nov 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwK13Mb+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFA18D649;
	Wed,  6 Nov 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857829; cv=none; b=CfsCiNGAX/nfs/7QPLpcQSEdamcVJb5Dk7WsZ8KErANY0gb9YtTeNB70qzCaGpeoISKZRBxPrZ0yX1m6GiEuvq6N5FqfkOwZEQeVcmZvBhM8LXAcZAj8CBwrQg1+HLDt5yjP0OAWUjfccBxv4kfMLlT05ka2eckCl5gDZWNUhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857829; c=relaxed/simple;
	bh=y8MG1WBPKCKkhseOfwN6igxneU0mxRhDtteJDtTIZ80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lNucGj7W+MKQeJuCnswE8g+oiGbwHjKW/8gUkfPu1LLrIukl3zoRat5bebeFo5R36U41x9Q1eqeaBoxifxSsgweucVndphVu4G0D7WXECXMXzvfjZK/xSaF4IkuEt9kpqAWhjAFm5hScJlpZ/d5gaWtEY98d99hJ9lOXq5Nayz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwK13Mb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3BFC4CECF;
	Wed,  6 Nov 2024 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857828;
	bh=y8MG1WBPKCKkhseOfwN6igxneU0mxRhDtteJDtTIZ80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JwK13Mb+stiNLS4FappBwqATmT30X/8M77CVZWPXX0ILf0rvNKTm+fhkg8LmxGiMe
	 B8oIrb9B5XKT+OAGhlLNtOnRCNUTv1Y6kzteIM8SWbTb7sEE9VMFPMdyvmJFcERcfB
	 o5Sgy3AJaSZJ6uDsrtkNWdObQewVHpt/w3UVLLndy8ivr+ze04OrA05LCtihwkD2KI
	 GeeNNvfQgAFGcTmUXUIBOtjvEmKxGsquWKxfn7j32Yw9lswZDsq3ylPgP2LYIl8377
	 aww6Ayqqb1VebtT+WXNgvKwHIVTp1szu4MskpXIKHZ5W4LL5zRGJhcLOFpeX0gwSaS
	 jAegtPvI35cgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD233809A80;
	Wed,  6 Nov 2024 01:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/2] Add support for Synopsis DesignWare version 3.72a
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085783749.762099.1620260205741649555.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:50:37 +0000
References: <20241102114122.4631-1-l.rubusch@gmail.com>
In-Reply-To: <20241102114122.4631-1-l.rubusch@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, kuba@kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, peppe.cavallaro@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Nov 2024 11:41:20 +0000 you wrote:
> Add compatibility and dt-binding for Synopsis DesignWare version 3.72a.
> The dwmac is used on some older Altera/Intel SoCs such as Arria10.
> Updating compatibles in the driver and bindings for the DT improves the
> binding check coverage for such SoCs.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/2] net: stmmac: add support for dwmac 3.72a
    https://git.kernel.org/netdev/net-next/c/ffda5c62878f
  - [v1,2/2] dt-bindings: net: snps,dwmac: add support for Arria10
    https://git.kernel.org/netdev/net-next/c/8bed89232a8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



