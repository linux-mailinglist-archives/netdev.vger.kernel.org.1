Return-Path: <netdev+bounces-185788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F26A9BB96
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55744927F34
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917BE635;
	Fri, 25 Apr 2025 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIRkfh3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775F382;
	Fri, 25 Apr 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745539800; cv=none; b=RXEKLT7MXnPugZRNEI8cBM/WiEGpzXBjO8Ev1LudEpKLEbe36jPQmsQzL3EsxR+nLhC0F0qlcGF9oqG4cwo0Nkj70bKvn3nTAVEB5ketXp7/D3PQMZS4qfZbLy6IaqYk3VWTlg6IpzkmXcMvAE9ReDw66v7UpwOP+CnDolcycr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745539800; c=relaxed/simple;
	bh=nQICgtHxwmv7XZd+j3FJlSP5VbeYVx9lWdXfjR+/H5c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sw8WU/f3CtIe0wl0/vgevmlVOenKWn3p5zoLI0EGzGF5ixlDUjIhOAlIDPrZl7XkuWevKSM4oKkXimNOqdCL4KWuAA7BWVuhXw57256VifmFpf45QfB/bty6a7oI/Hwb6UwO/8oYRcFlZP7IKhvmlr/xnK4JibLSLrvzkZujtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIRkfh3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB285C4CEEB;
	Fri, 25 Apr 2025 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745539799;
	bh=nQICgtHxwmv7XZd+j3FJlSP5VbeYVx9lWdXfjR+/H5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EIRkfh3OFpC7mVrFgkrMq17Vz0PJIAYgvI/CWYpu311U75poZn+GO2NNfq9WGmsno
	 DT2F4BIoi/rJC8INnqcj2XC+vZA4ILZEGvj/Q3HCa9Lukbg47uXeaeVWPyhh6xD3j6
	 SemXCbf0pyt4IS9ddlPN/ZjpnLDC8HweS/41FcWVdSkKRBsdk4VqH4bGyOQ5fuSz4T
	 lLnK6G29MDdda6yTJO6WA5mb96kw270sPD49ydTWb6h2MvSU4sBy1wiFLHqsmMLbqT
	 Z2yvdAN+kY3z00g6GQAYA08q1sjAHA4RJ8vOCLECjl37kthA0c5mzqUWKXphdIG9m1
	 hfh0FWo+HfPag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCCF380CFD9;
	Fri, 25 Apr 2025 00:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: bcmasp: Add v3.0 and remove v2.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174553983824.3526942.6555892578388860662.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 00:10:38 +0000
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, rafal@milecki.pl,
 linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Apr 2025 16:36:37 -0700 you wrote:
> asp-v2.0 had one supported SoC that never saw the light of day.
> Given that it was the first iteration of the HW, it ended up with
> some one off HW design decisions that were changed in futher iterations
> of the HW. We remove support to simplify the code and make it easier to
> add future revisions.
> 
> Add support for asp-v3.0. asp-v3.0 reduces the feature set for cost
> savings. We reduce the number of channel/network filters. And also
> remove some features and statistics.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] dt-bindings: net: brcm,asp-v2.0: Remove asp-v2.0
    https://git.kernel.org/netdev/net-next/c/ef7c993ae247
  - [net-next,v2,2/8] dt-bindings: net: brcm,unimac-mdio: Remove asp-v2.0
    https://git.kernel.org/netdev/net-next/c/62c8c4656ef1
  - [net-next,v2,3/8] net: bcmasp: Remove support for asp-v2.0
    https://git.kernel.org/netdev/net-next/c/4ad8cb76bd0d
  - [net-next,v2,4/8] net: phy: mdio-bcm-unimac: Remove asp-v2.0
    https://git.kernel.org/netdev/net-next/c/8c28aace8864
  - [net-next,v2,5/8] dt-bindings: net: brcm,asp-v2.0: Add asp-v3.0
    https://git.kernel.org/netdev/net-next/c/e4bf8f8a22d8
  - [net-next,v2,6/8] dt-bindings: net: brcm,unimac-mdio: Add asp-v3.0
    https://git.kernel.org/netdev/net-next/c/9a8a73766b34
  - [net-next,v2,7/8] net: bcmasp: Add support for asp-v3.0
    https://git.kernel.org/netdev/net-next/c/e9f31435ee7d
  - [net-next,v2,8/8] net: phy: mdio-bcm-unimac: Add asp-v3.0
    https://git.kernel.org/netdev/net-next/c/538cb5573ae7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



