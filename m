Return-Path: <netdev+bounces-100197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF498D81F1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DC41F26001
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CFE127E38;
	Mon,  3 Jun 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT5Q0PtW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96C127E33
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416631; cv=none; b=fivspmjf+S5sMtOpoZR7hUPLJxlMDpRIFkH4zxCj0ai7m/4/9NDaopXAur+moXzD2iwYvx51d3zf3XvynX6OwsL7xHy73kZhN7kJbwlbVvhpUUQF3avq90nFgPyicNOXldUVXTTEeQjXPk2vABrcvZg62Ip20oZgsrOYyxhc8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416631; c=relaxed/simple;
	bh=WjxW9lODJQdfwmuafrHDfCNlT2rpCoNcN77WLzHsins=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HjzZ/WuZeMJTeMlgntukr7OHDLmEuJtdWryM2jnTvEWFPzsvKNJomq23pZD5+otyf2ppkEy61PuabsvDCxdlyptY7BY1yHMRCF3Sg1SD3JkY92tws1QQWAhvGCRRMD36XAy/ECHbMvfLVstLhYK2nzTgUz04cRPS1CnxpPgCSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT5Q0PtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8501BC4AF07;
	Mon,  3 Jun 2024 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717416631;
	bh=WjxW9lODJQdfwmuafrHDfCNlT2rpCoNcN77WLzHsins=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XT5Q0PtW6qvj1Afm3mur9/wPoK26f/Vz8LeeomUv+923m6Sq2iv0JXqSY9WgW2rDU
	 R1KILb9mtzoBMPWXzhJ4k2fpXl6eB1Wn9P8bCLOnfwr701DO7ZRqSrawkPS9X+81Kl
	 ZQ1aEf1KYC1vZFquQ30XyEfWUIjzNx4AkSg9f8JhDK+j77QV5OFrN3ds+GFTWgkAhG
	 W5D/rRP7PCC+kSTMSV78jViLD2bUMetqdnaMacluYxqop1TPAuUheiV37Wsn+CtOG7
	 JAB4aFahPqxwcZgj6PyX34VMQgJZAfQ5CR84gQiVse0UK3lnicAqVvDyaa3d9HSDT6
	 qMbLYt+n9G2FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 782CAC54BB3;
	Mon,  3 Jun 2024 12:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] Probing cleanup for the Felix DSA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171741663148.18102.7606532000098551833.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 12:10:31 +0000
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, colin.foster@in-advantage.com, linux@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 May 2024 19:33:25 +0300 you wrote:
> This is a follow-up to Russell King's request for code consolidation
> among felix_vsc9959, seville_vsc9953 and ocelot_ext, stated here:
> https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/
> 
> Details are in individual patches. Testing was done on NXP LS1028A
> (felix_vsc9959).
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: dsa: ocelot: use devres in ocelot_ext_probe()
    https://git.kernel.org/netdev/net-next/c/454cfffe8dc1
  - [net-next,2/8] net: dsa: ocelot: use devres in seville_probe()
    https://git.kernel.org/netdev/net-next/c/90ee9a5b49ce
  - [net-next,3/8] net: dsa: ocelot: delete open coded status = "disabled" parsing
    https://git.kernel.org/netdev/net-next/c/cc711c523da7
  - [net-next,4/8] net: dsa: ocelot: consistently use devres in felix_pci_probe()
    https://git.kernel.org/netdev/net-next/c/4510bbd38cbe
  - [net-next,5/8] net: dsa: ocelot: move devm_request_threaded_irq() to felix_setup()
    https://git.kernel.org/netdev/net-next/c/0367a1775933
  - [net-next,6/8] net: dsa: ocelot: use ds->num_tx_queues = OCELOT_NUM_TC for all models
    https://git.kernel.org/netdev/net-next/c/4ca54dd96eca
  - [net-next,7/8] net: dsa: ocelot: common probing code
    https://git.kernel.org/netdev/net-next/c/efdbee7d0791
  - [net-next,8/8] net: dsa: ocelot: unexport felix_phylink_mac_ops and felix_switch_ops
    https://git.kernel.org/netdev/net-next/c/a4303941c6f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



