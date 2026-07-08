Return-Path: <netdev+bounces-305690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i86qNi4UTmq4CgIAu9opvQ
	(envelope-from <netdev+bounces-305690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:11:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C27237DA
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:11:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mVzIDkyV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305690-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305690-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AD4B30036DE
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B13FE37A;
	Wed,  8 Jul 2026 09:10:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854A3E63B7;
	Wed,  8 Jul 2026 09:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501842; cv=none; b=oSmA1BokKEFnxHHMU4Fxun36GWq8PBKhF2Zo3dNsCnRdMmHe+ieVeukGfDwQY9ZPjpov277grBWxurOiG+UpnAlw1K+br7+sSn2IBZp7EkwxbZBS9UI0kt/419YBmYcxaGDCu669QNUFqE/mIjPbBJ0lTEU3/pmpM/WoEFPpnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501842; c=relaxed/simple;
	bh=0sUL3+aJiUYmMDcQh9ThfNfCmQ/IiGTOA4cRVGsQcuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h+pO3D2v4Rm32qcBP+nRz3XnUSQhI9f/KjgW6im23XjdR7fBQbVCvocTvq3JkJJ1cqUUE7NrUB41Rn18xPTyvf8oLYUWWItym0fe62SuTcHfZT7/6UlNwXcwVTcPQvvhP5yN7wK1PswPJKodShZ2jYwpVNLKghcztrNnnMt9PxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVzIDkyV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452D21F000E9;
	Wed,  8 Jul 2026 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783501841;
	bh=AbHCrpgnhZAReBZ/2Y02VNZH638XGlqqfQepZimy0oQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mVzIDkyV2CYGM9LAecPpz+jB6MW2r3IJF6gi3PMKHSKGW00fvPcT48/WFPJ80TXQ6
	 255etu1ZQL+5U8qrOw27R+kTYQpKUv/AE0+ORg62j+1GkzGCrmn9DdItn5I0fIrpcR
	 pn5ZkTjfuox3em2We0+nBon9NPrWkEpFtuYrvT+Rp+MMWtjAyWK2ATslzA13oIezka
	 Hu48ndtjnDVYdSjKlJSqousP0KBZTd0XnhhnsrE1IcvLxYfjgPUSJoKgqn0YczzzBS
	 04nNgydzbKyw12jcki/AgEui64+9TTwx9urI8rLIkX6dJ0gdRmWRW+CLPWzaB2dP6o
	 QiKaGU3xdcYbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D8F3926388;
	Wed,  8 Jul 2026 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] net: dsa: microchip: move non-common
 function out of ksz_common.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350182064.2389464.8671802680771875517.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 09:10:20 +0000
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305690-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,se.com,bootlin.com,vger.kernel.org,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:bastien.curutchet@bootlin.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E1C27237DA

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 02 Jul 2026 11:07:22 +0200 you wrote:
> Hi all,
> 
> This series continues the rework of the KSZ driver initiated by three
> previous series (see [1], [2] & [3]).
> 
> The KSZ driver handles more than 20 switches split in several families.
> This was previously handled through a common set of dsa_switch_ops
> operations that used device-specific ksz_dev_ops callbacks. The three
> previous series have split this common struct dsa_switch_ops into 5
> to connect the ksz_dev_ops's implentations directly to the new
> dsa_swicth ops.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: dsa: microchip: split ksz8_change_mtu()
    https://git.kernel.org/netdev/net-next/c/15604320877e
  - [net-next,02/10] net: dsa: microchip: split port_max_mtu() implementation
    https://git.kernel.org/netdev/net-next/c/18a856b23680
  - [net-next,03/10] net: dsa: microchip: make ksz_is_port_mac_global_usable() static
    https://git.kernel.org/netdev/net-next/c/caf5d68b51e6
  - [net-next,04/10] net: dsa: microchip: move ksz88xx stats handling in ksz8.c
    https://git.kernel.org/netdev/net-next/c/a7e806f11f37
  - [net-next,05/10] net: dsa: microchip: move ksz_get_gbit() and ksz_get_xmii() to ksz9477.c
    https://git.kernel.org/netdev/net-next/c/7a83196e9012
  - [net-next,06/10] net: dsa: microchip: move KSZ9477 errata handling to ksz9477.c
    https://git.kernel.org/netdev/net-next/c/ab4b571d44fb
  - [net-next,07/10] net: dsa: microchip: handle KSZ8-specific tc setup in ksz8.c
    https://git.kernel.org/netdev/net-next/c/610106257cd7
  - [net-next,08/10] net: dsa: microchip: move ksz9477_set_default_prio_queue_mapping() to ksz9477.c
    https://git.kernel.org/netdev/net-next/c/e8de229a62ec
  - [net-next,09/10] net: dsa: microchip: rename ksz9477_drive_strength_write()
    https://git.kernel.org/netdev/net-next/c/da466bf62b01
  - [net-next,10/10] net: dsa: microchip: move the drive strength config out of the common section
    https://git.kernel.org/netdev/net-next/c/90c676dd4bb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



