Return-Path: <netdev+bounces-300278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lVFtF+w5M2oK+gUAu9opvQ
	(envelope-from <netdev+bounces-300278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CEC69CDCA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:20:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fboahXFe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300278-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300278-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80A9230202BE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870323505E;
	Thu, 18 Jun 2026 00:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19923AB87;
	Thu, 18 Jun 2026 00:20:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742056; cv=none; b=Dq7NI/Em+3nOw0pSEdnM/izOqP31exREmhuAoJbjbg2vmHhpdAXrd7sP/kbzEXmhAHh7nH8ab67ACbZILRlLdJbA7Yxz9lJh2+60vrnNBsbEE+xfAVES3qqHxHPAgTL3gx6rluaPA8ast7YDU2/Ubp4sZeRgeuiHF0NBrUynyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742056; c=relaxed/simple;
	bh=mejoA4gO+RdEYlIoGFmJ50uaHbXfwK79TYV6t48vFs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RQrINTs8y9kuY3ptjuGcWJGG7ZpgRS7SXzjTgKcVQ0zegex08YcDE+G+8nXeEa5ZziPAhiEq3INa/4XT4sBRlQF0OjPCQMdwv1f2D8oiwXvRTdMh30gP41yTQ+I1jYWib2Lt5BRMIaKv3pf9S66dw8thsaM4pG6B71qVXcmJVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fboahXFe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E51F000E9;
	Thu, 18 Jun 2026 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742055;
	bh=4fVcwov0xUbbsvxiR509uVDetK1RWIqoecjtKQCv7YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fboahXFexfnQG2mmEymI4v7jf3N6BQJODVoQswWVNXRmEI/DQvPH1yBnoWNfsd+q7
	 oAtIV/06GLHxrjBADEAO4nizn5DIgvYqYvqcLPAUm1SKE+ua8srU99ekdeBvxTk3+s
	 38GUM+deRGe5Rkf7Rl69YO9BteCmVrgvQ2nu65TtFH5nsqUdkAHtnsHy9LJI9Dw4qJ
	 Dh9/1VqdH45QNqoYpPp27XYn+NMCR9qVLrEUQim9rMM61jkOXY5x3AhMaBP/dYWHj/
	 JQX3sZPo7SEMPbP4MjUZVSnT/q0QRiT2P0GTjjLvIncSuNZFYgQKInwBAy6r/yfuKo
	 KDVSr22ZV6UjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4E393102B;
	Thu, 18 Jun 2026 00:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix supported_interface
 set
 after phylink_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174204913.1875263.9684568124296836411.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:49 +0000
References: <20260615151106.15438-1-ansuelsmth@gmail.com>
In-Reply-To: <20260615151106.15438-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, daniel@makrotopia.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk,makrotopia.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300278-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:daniel@makrotopia.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9CEC69CDCA

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 17:11:00 +0200 you wrote:
> Everything configured in phylink_config it's assumed to be set before
> calling phylink_create() to permit correct parsing of all the different
> modes and capabilities.
> 
> Commit 51cf06ddafc9 ("net: ethernet: mtk_eth_soc: add support for MT7988
> internal 2.5G PHY") while introducing support for 2.5G phy for MT7988,
> probably due to an auto-rebase, placed the configuration of the INTERNAL
> interface mode for the supported_interfaces for phylink_config right after
> phylink_create() introducing a possible problem with supported interfaces
> parsing.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: fix supported_interface set after phylink_create
    https://git.kernel.org/netdev/net/c/e4b4d8410c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



