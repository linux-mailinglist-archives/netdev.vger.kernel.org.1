Return-Path: <netdev+bounces-203076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147FAF0777
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CD33AF6AF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104EA80034;
	Wed,  2 Jul 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ85lQTZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CB78F51;
	Wed,  2 Jul 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417393; cv=none; b=Qfkf58HgvnRU3ubjjK+20eALoC6kxtri5MgMafwmBdO0E0qBQwHW/cy6Jg1DLuC6SatZvQN4wmpHckWGGWv6LyNQMrl2GCkG7YOzASaf0FlVr81CiqXpqcdkvPSks1KgIpndW7iBFBwiy9xGfiw7xfCxX+z+Ri7ns8NA6EygHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417393; c=relaxed/simple;
	bh=9pmS1r+NUKM6GwYPe0/1xFH/myUByv2YF4GN6MCRvNs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UDyt0gfnDtAwGeJ/sRNWUQnjR3lXZLCRMq0+JueMYQRwfWH0i7eVyC1DzwlBtVVAE10cK7ZMOp3K+1IuA31ZYHQhAZf0U8bewssCY6rmoSMf6djpRQ2mKApuN3QebmSwugW/QldUfz9OGWBzTxQfvoZT5g9AsYAo7W+e3oe4kfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ85lQTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F93C4CEF1;
	Wed,  2 Jul 2025 00:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417392;
	bh=9pmS1r+NUKM6GwYPe0/1xFH/myUByv2YF4GN6MCRvNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mJ85lQTZR2lONcY5z7KIwWI9p5CeEO01vZTHn/rgFsPVNEujA+2j+Le0+vqPYpsQz
	 4J8XyvKqJomK4C8CCX1MxdYWiMrtCLMvK5O9c5Hpu5DnBZQsgO0oVgRhavEvSHabdG
	 dBImWXXij0ANzt9H/qh2kvGNMiYXHM27+qOoyZeSnxaVHwhFwAKpJAOUNkCSfTsqWB
	 F/N7novewWBobHnZZSRpGPcPz7FNgURaH9YcVzgqicVPyNMTpPPEl7pvgw8PnkOT6+
	 7SPyYpVZ5YmVOwM3nasf+qpnv/f+eJaxpShOBGg/pQ1UYOd2rMpfrwbWb6ei3rlooi
	 cB8fJoei3zB2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3D383BA06;
	Wed,  2 Jul 2025 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert nxp,lpc1850-dwmac.txt to
 yaml format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141741724.160580.15489613753821420716.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:50:17 +0000
References: <20250630161613.2838039-1-Frank.Li@nxp.com>
In-Reply-To: <20250630161613.2838039-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, vz@mleia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 12:16:12 -0400 you wrote:
> Convert nxp,lpc1850-dwmac.txt to yaml format.
> 
> Additional changes:
> - compatible string add fallback as "nxp,lpc1850-dwmac", "snps,dwmac-3.611"
> "snps,dwmac".
> - add common interrupts, interrupt-names, clocks, clock-names, resets and
>   reset-names properties.
> - add ref snps,dwmac.yaml.
> - add phy-mode in example to avoid dt_binding_check warning.
> - update examples to align lpc18xx.dtsi.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] dt-bindings: net: convert nxp,lpc1850-dwmac.txt to yaml format
    https://git.kernel.org/netdev/net-next/c/69fcb70c4334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



