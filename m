Return-Path: <netdev+bounces-290352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF7yAXXpDmqwDAYAu9opvQ
	(envelope-from <netdev+bounces-290352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:16:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543185A3D5B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371983014C1D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7A33BB13D;
	Thu, 21 May 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeUc+TU8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484936167B;
	Thu, 21 May 2026 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361818; cv=none; b=PPENIQNHSqjkhZ0y07FnnumuqSgrqWWPbQKHc0eVaqDCuCTeobBiFCQ4rPw7wTJXTFZ/Nr7kwUnUzE95DyAF8Xzgj/RKhlw+2ofszN/ECpWkBsIytE4vuigXCfYwOOgUBZst1XHrwByROOOMZL+LqYmAVfLn59hhHTyIo753XNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361818; c=relaxed/simple;
	bh=AjG2vD1PvA7zKoaZI9CzAq+yF5earU4+fGX5qmr6FsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dq8PA43UmdhetX3cVmD3NpsllerTFRzsJD9YrWnyjGdi7xXVxlx6g07FcTF5nAxrk+t8ChBwoVRAGhkrSWHwQ2Mw8v6xDEtlBBWSmhqlrqYe0yvwaMs0tIGM7owiC9vfWKi8ojw0XbxkMSaQ+HUVDVWgHDSMmSQ61Mutz06cNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeUc+TU8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECDA1F000E9;
	Thu, 21 May 2026 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779361816;
	bh=xU8Xda3hTS+TH6/kqkYtkfd/gVphmpM5ys0iuESx0eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IeUc+TU8KfmOdLpDtUOEaJcHiCUK87i4XfCq0IgsjEVMuvTatrPzUduaPqXtzGTYF
	 +yb2Nag0bIqi7PsRqx4bPgfzLke4z29ohFAEWnQi2AlyhcGncxJiaA/IZe1EF94T+T
	 oZ4md4kwYc30zpyZJ5jGP4dnqcp/6BHFKBMb9RcBvqDZEJmDllHDy/gxpYJXz7chU2
	 H6Js8SX//oWDtT2rKN8o6VL3jM9QSCDhaIsmZPtYkVxlTh1LHC9gr8lUyeE/uxe2q7
	 OtuOhiDBT00ei8HkIJiz+38j+qvwE/foOTPD0SKFwPfzUiODrmT+LN85NCZsf/j8cK
	 Ylfd5f8lf9sEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994C3930D65;
	Thu, 21 May 2026 11:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 net-next 00/15] Add preliminary NETC switch support for
 i.MX94
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177936182689.4032976.7498848495414588133.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 11:10:26 +0000
References: <20260518082506.1318236-1-wei.fang@nxp.com>
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, f.fainelli@gmail.com, frank.li@nxp.com,
 chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290352-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,bootlin.com,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 543185A3D5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 May 2026 16:24:51 +0800 you wrote:
> i.MX94 NETC (v4.3) integrates 802.1Q Ethernet switch functionality, the
> switch provides advanced QoS with 8 traffic classes and a full range of
> TSN standards capabilities. It has 3 user ports and 1 CPU port, and the
> CPU port is connected to an internal ENETC through the pseduo link, so
> instead of a back-to-back MAC, the lightweight "pseudo MAC" is used at
> both ends of the pseudo link to transfer Ethernet frames. The pseudo
> link provides a zero-copy interface (no serialization delay) and lower
> power (less logic and memory).
> 
> [...]

Here is the summary with links:
  - [v8,net-next,01/15] dt-bindings: net: dsa: update the description of 'dsa,member' property
    https://git.kernel.org/netdev/net-next/c/0c89a779c373
  - [v8,net-next,02/15] dt-bindings: net: dsa: add NETC switch
    https://git.kernel.org/netdev/net-next/c/6d019124be60
  - [v8,net-next,03/15] net: enetc: add pre-boot initialization for i.MX94 switch
    https://git.kernel.org/netdev/net-next/c/f059d55fd8a0
  - [v8,net-next,04/15] net: enetc: add basic operations to the FDB table
    https://git.kernel.org/netdev/net-next/c/4566269803ff
  - [v8,net-next,05/15] net: enetc: add support for the "Add" operation to VLAN filter table
    https://git.kernel.org/netdev/net-next/c/d0ac4d4bd299
  - [v8,net-next,06/15] net: enetc: add support for the "Update" operation to buffer pool table
    https://git.kernel.org/netdev/net-next/c/cb4d95d79d85
  - [v8,net-next,07/15] net: enetc: add support for "Add" and "Delete" operations to IPFT
    https://git.kernel.org/netdev/net-next/c/123db6a27511
  - [v8,net-next,08/15] net: enetc: add multiple command BD rings support
    https://git.kernel.org/netdev/net-next/c/c5aed83ddc53
  - [v8,net-next,09/15] net: dsa: add NETC switch tag support
    https://git.kernel.org/netdev/net-next/c/0850005c26d2
  - [v8,net-next,10/15] net: dsa: netc: introduce NXP NETC switch driver for i.MX94
    https://git.kernel.org/netdev/net-next/c/187fbae024c8
  - [v8,net-next,11/15] net: dsa: netc: add phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/bbe97e347219
  - [v8,net-next,12/15] net: dsa: netc: add FDB, STP, MTU, port setup and host flooding support
    https://git.kernel.org/netdev/net-next/c/46d6407692c8
  - [v8,net-next,13/15] net: dsa: netc: initialize buffer pool table and implement flow-control
    https://git.kernel.org/netdev/net-next/c/a5ccb7f5e067
  - [v8,net-next,14/15] net: dsa: netc: add support for the standardized counters
    https://git.kernel.org/netdev/net-next/c/25049d8b6e6b
  - [v8,net-next,15/15] net: dsa: netc: add support for ethtool private statistics
    https://git.kernel.org/netdev/net-next/c/beb0e54f3806

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



