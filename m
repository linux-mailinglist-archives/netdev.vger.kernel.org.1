Return-Path: <netdev+bounces-258259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPoGJJtjjGkFmgAAu9opvQ
	(envelope-from <netdev+bounces-258259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C9123C1A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E25830131CB
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823CE358D3A;
	Wed, 11 Feb 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz7p6kY/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F599353EEE;
	Wed, 11 Feb 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770808216; cv=none; b=hPFdcuep2q9YhRRWBs7gpEswT5n6EkaP5NGmFw0YHf3vywEShxCFR5E0yXAf2vR3PJbzAyoyNNdpaIUcbytoXA1y0ZETQBZZ0quDIB6ZWVKS33d9cX2ct5aaLJapjSOLOd2oT3/rFENcKK0ix/yOd0dZrSWZ8ybPBbNyeZJs9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770808216; c=relaxed/simple;
	bh=v0WSedBlAJ9Wb9CX5BiyZ3c+zBc23T73GAjjKjh3R7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JrfRyRU3KHAJgpxpYgx5oYlaQ0Z7JBmCOtvXhqOfJJseCKByfBkV8xD3hJcR9xomdl3ORpwEkUx+u7fRkC7ZHBqqWIloCGc95dfCtyDSdpCZDDmaYNPB/AqM6IekzeolhtQc+17na6blRGXGIL+KVQe1wdBf2+OmKHKed4j9W68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz7p6kY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93E0C4CEF7;
	Wed, 11 Feb 2026 11:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770808215;
	bh=v0WSedBlAJ9Wb9CX5BiyZ3c+zBc23T73GAjjKjh3R7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sz7p6kY/hO+SMctxovAJq61NMuw9SRgHPXMLR6DpEgdTrFkqXMFK2hUokZOSkRYZf
	 fr2jRqhhLbh7rnpPaJNR3it3zT7bbsaNOat88wdGEZ4KKilRpQlfazYVG87EzcpyAX
	 VmLqDb2eCD5i8BcEB86Bwne2Q7AAOnQdN7hDr5oXNxbvTvgAAyCDu5erMzN+EIn+4T
	 QyIgm5JdARTJEz5XpKBVrPV5yq7xUuZNFUdDtLyP0vTGr7PLsXqIKTGcEFN9EqAoCU
	 cuyz3mgtjXqTjstJxzKCc3/WYUvGoeEuiQO49/5OwQjLAapwpbt7FeQzfiIX8n+9lQ
	 I2jgfiV1FDvQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFD639E960E;
	Wed, 11 Feb 2026 11:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177080821083.129637.546631770343886977.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 11:10:10 +0000
References: <cover.1770433307.git.daniel@makrotopia.org>
In-Reply-To: <cover.1770433307.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, horms@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, frankwu@gmx.de,
 chad@monroe.io, cezary.wilmanski@adtran.com, lxu@maxlinear.com,
 john@phrozen.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258259-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF8C9123C1A
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 7 Feb 2026 03:06:48 +0000 you wrote:
> This series adds very basic DSA support for the MaxLinear MxL86252
> (5x 2500Base-T PHYs) and MxL86282 (8x 2500Base-T PHYs) switches.
> In addition to the 2.5G TP ports both switches also come with two
> SerDes interfaces which can be used either to connect external PHYs
> or SFP cages, or as CPU port when using the switch with this DSA driver.
> 
> MxL862xx integrates a firmware running on an embedded processor (based on
> Zephyr RTOS). Host interaction uses a simple netlink-like API transported
> over MDIO/MMD.
> 
> [...]

Here is the summary with links:
  - [net-next,v14,1/4] dt-bindings: net: dsa: add MaxLinear MxL862xx
    https://git.kernel.org/netdev/net-next/c/4ccc9851355f
  - [net-next,v14,2/4] net: dsa: add tag format for MxL862xx switches
    https://git.kernel.org/netdev/net-next/c/85ee98742902
  - [net-next,v14,3/4] net: mdio: add unlocked mdiodev C45 bus accessors
    https://git.kernel.org/netdev/net-next/c/b405b26d8d27
  - [net-next,v14,4/4] net: dsa: add basic initial driver for MxL862xx switches
    https://git.kernel.org/netdev/net-next/c/23794bec1cb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



