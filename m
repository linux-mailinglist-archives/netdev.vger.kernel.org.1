Return-Path: <netdev+bounces-286092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP/tLHCc/mnItwAAu9opvQ
	(envelope-from <netdev+bounces-286092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:31:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80C4FDA71
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C354D3015477
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE92517AF;
	Sat,  9 May 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPLZ02ll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C461FCE;
	Sat,  9 May 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293869; cv=none; b=kmbmnyLbMbmuKqLzI1n6SQU+hcYBfssb85SAd04QRoRCMYieps9QlXdR28/Govze0f3vcw01mR+HpMcw7rv8Y51VxoQMYPx6m86dB9X1ePx+wXC/KOmOIVIMX5qUYEEmIPgnTOgehchiSYMztl58PbCChL0hGc8YSV4roZkJDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293869; c=relaxed/simple;
	bh=b7b/9oHIhOsCVcPcBIn+wuwRqo3R1RFplH414IGXim4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tIpdka/uHZKBh6qZ/Ct+k2a0zpZ8EHvH77o1Y7PIawJj0QtnvjMwwi9cfyRov4sgfCOpwWgEAA/gzb656vo6b0aUQnB9tCCI+Yg/qJYT4xMqmZLaXzbL364izL75gYMIkrO8ZwMYG0xHaB3RHwSdj88qCLxnBoaA82iDHDn2Ebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPLZ02ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B17C2BCB0;
	Sat,  9 May 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778293869;
	bh=b7b/9oHIhOsCVcPcBIn+wuwRqo3R1RFplH414IGXim4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NPLZ02llpHSntIJ0ZN+QA5m/g8/3keECKsJqbmvjUotQePoo3ptObFaPLzpzStCLm
	 VbxvD+O7DazKbHawSCPCAvWSCw6vDD+KyKqECi5QH4+cd84o6yqCIEnX5yZPsnpnF8
	 iZqkcvgdam2bexGvoKEvsPxR6ptWPQ164x0pJTlklwleM3Zmqj1/qEcsPx03Fg1vlo
	 w7WeII7nhyq5LRTTsM5VojbUMoLIsJEAav8xTJK32p8hu1lgpgcan6Gr15tDpcs7LV
	 nLsMsWEqAV10q8RqFThUAVfQrHu6602qVG59qUBs96qnDuAvE5NZYarcXmNfNc1x/5
	 2EiJPWZ0Ik8cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF938119E9;
	Sat,  9 May 2026 02:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: dsa: microchip: Remove one indirection
 layer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177829381730.943364.9337401831191138271.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 02:30:17 +0000
References: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
In-Reply-To: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, linux@armlinux.org.uk,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, tristram.ha@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
X-Rspamd-Queue-Id: 1E80C4FDA71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,se.com,vger.kernel.org,nxp.com];
	TAGGED_FROM(0.00)[bounces-286092-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 May 2026 16:25:00 +0200 you wrote:
> Hi all,
> 
> This series follows the discussions we had on a previous series that
> aimed to add PTP support for the KSZ8463 (cf [1]).
> 
> The KSZ driver got way too convoluted over time because it uses a common
> framework to handle more than 20 switches split in 5 families (see below
> table)
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: dsa: microchip: Remove unused ksz8_all_queues_split()
    https://git.kernel.org/netdev/net-next/c/ac271f93f24a
  - [net-next,2/9] net: dsa: microchip: remove unused port_cleanup() callback
    https://git.kernel.org/netdev/net-next/c/7ab8c9db2d32
  - [net-next,3/9] net: dsa: microchip: move KSZ8 ksz_dev_ops to ksz8.c
    https://git.kernel.org/netdev/net-next/c/2d0a20e4afd3
  - [net-next,4/9] net: dsa: microchip: move KSZ9477 and LAN937 ksz_dev_ops to individual drivers
    https://git.kernel.org/netdev/net-next/c/0e3e45d330e7
  - [net-next,5/9] net: dsa: microchip: move phylink_mac_ops to individual drivers
    https://git.kernel.org/netdev/net-next/c/617bd10450ef
  - [net-next,6/9] net: dsa: microchip: ensure each ksz_dev_ops has its own dsa_switch_ops
    https://git.kernel.org/netdev/net-next/c/a774b19c117d
  - [net-next,7/9] net: dsa: microchip: hook up ksz_switch_alloc() to chip-specific dsa_switch_ops
    https://git.kernel.org/netdev/net-next/c/adb50fc9960b
  - [net-next,8/9] net: dsa: microchip: split ksz_get_tag_protocol()
    https://git.kernel.org/netdev/net-next/c/af96c2f08ddb
  - [net-next,9/9] net: dsa: microchip: split ksz_connect_tag_protocol()
    https://git.kernel.org/netdev/net-next/c/1df461e52747

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



