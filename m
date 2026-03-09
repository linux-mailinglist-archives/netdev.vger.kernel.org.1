Return-Path: <netdev+bounces-265566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ING8H3DWrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:17:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC823A5BB
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A28B30214D8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686403B8945;
	Mon,  9 Mar 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X5Pq2wBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16617A305
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065818; cv=none; b=NNokkkIfc4nhqGuLmkI2IUCKDQWC8F/DPQ6E8lNwFNft8hKEtppaTAFHCiMf2eSxAtyQQx5Xv19MrsXJb872C3m7M67AyKJTCQ9XPWhtatKBBgxN1WbRJ+WNzOPITfdIRe1ah8s1z/FIVwRHbklLuJpMOoBTUo3f/yaan7/6BZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065818; c=relaxed/simple;
	bh=8liySUEDGYrpUI1rMgWcIxLKUNWyHE5MJ7BpW1iSeNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1cm1OH0x6rQJkPCZHO3z4pg/nvLJXMDNjZUbFSbGqMsTW5lZC6ZqSBHAH8SM2QqulkhWkfrqYCOAnkmK4E/V/I9HpBwXp/fURrJueo5Q5/oD84rLPnMLGGYRanpVnWlHJyRzeaJ3oCnYCZNi8UCjAIqHDmjDLvaaSrXIr0p8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X5Pq2wBX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9F70C4E425D5;
	Mon,  9 Mar 2026 14:16:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CE825FFB8;
	Mon,  9 Mar 2026 14:16:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B71C910369A24;
	Mon,  9 Mar 2026 15:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773065813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=B6Sfd+3RAw+T1+wBoUFyStbgtRDwov9ZbOCNeaAw/iE=;
	b=X5Pq2wBXmLmNdseOmRz8sJ1oQbGCKF/UO0qIGck3B8QYoU4lPzZnRkCriDP+scGSrLw0p8
	1hh3Q4mDb3f5VbnqPjfcqncqGVvwY36KjcSr/N30fE7lQDnXVTK+YF8qci7NGGN8OBEAL8
	IgO+lbuiq5tfdzHj3RZjKzNHNYGtugJWUyY3nEOk1TpeVzwgdbZwP4sEIBD9zqTXOXuZTP
	prlcO0ODgdF0rLSeU4eeWUzlaC0cmUOsoFQzutXbtad10TnqyGPAsxV0tsg3kNMCPbBf1W
	ZIHKEKCP90/uerxYc/VjRKkLl9xAcVAUz06AEQ0Z1LuMkhmy9sXl7kDqIaGqDQ==
Message-ID: <456697d6-c0d8-4edf-abd2-85062f4b25ab@bootlin.com>
Date: Mon, 9 Mar 2026 15:16:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 1/6] ethtool: Add loopback netlink UAPI
 definitions
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <20260308124016.3134012-2-bjorn@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260308124016.3134012-2-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: D4CC823A5BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265566-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action

Hi,

On 08/03/2026 13:40, Björn Töpel wrote:
> Add the netlink YAML spec and auto-generated UAPI header for a unified
> loopback interface covering MAC, PCS, PHY, and pluggable module
> components.
> 
> Each loopback point is described by a nested entry attribute
> containing:
> 
>  - component  where in the path (MAC, PCS, PHY, MODULE)
>  - name       subsystem label, e.g. "cmis-host" or "cmis-media"
>  - id         optional instance selector (e.g. PHY id, port id)
>  - supported  bitmask of supported directions
>  - direction  NEAR_END, FAR_END, or 0 (disabled)
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  Documentation/netlink/specs/ethtool.yaml      | 115 ++++++++++++++++++
>  .../uapi/linux/ethtool_netlink_generated.h    |  52 ++++++++
>  2 files changed, 167 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 4707063af3b4..05ebad6ae4e0 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -211,6 +211,39 @@ definitions:
>          name: discard
>          value: 31
>  
> +  -
> +    name: loopback-component
> +    type: enum
> +    doc: |
> +      Loopback component. Identifies where in the network path the
> +      loopback is applied.
> +    entries:
> +      -
> +        name: mac
> +        doc: MAC loopback
> +      -
> +        name: pcs
> +        doc: PCS loopback
> +      -
> +        name: phy
> +        doc: PHY loopback
> +      -
> +        name: module
> +        doc: Pluggable module (e.g. CMIS (Q)SFP) loopback

Should we also add "serdes" ?

> +  -
> +    name: loopback-direction
> +    type: flags
> +    doc: |
> +      Loopback direction flags. Used as a bitmask in supported, and as
> +      a single value in direction.
> +    entries:
> +      -
> +        name: near-end
> +        doc: Near-end loopback; host-loop-host
> +      -
> +        name: far-end
> +        doc: Far-end loopback; line-loop-line
> +
>  attribute-sets:
>    -
>      name: header
> @@ -1903,6 +1936,60 @@ attribute-sets:
>          name: link
>          type: nest
>          nested-attributes: mse-snapshot
> +  -
> +    name: loopback-entry
> +    doc: Per-component loopback configuration entry.
> +    attr-cnt-name: __ethtool-a-loopback-entry-cnt
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: component
> +        type: u32
> +        enum: loopback-component
> +        doc: Loopback component
> +      -
> +        name: id
> +        type: u32
> +        doc: |
> +          Optional component instance identifier. Required for PHY,
> +          optional for MODULE, omitted for MAC and PCS.

it doesn't have to be required for PHY. The current idea is that if you
don't pass any PHY index when issueing a PHY-targetting command, then it
means you're targetting net_device->phydev, that is the PHY device
attached to the netdev (if any).

I think we can keep that behaviour, as systems with multiple PHYs are
not very common.

> +      -
> +        name: name
> +        type: string
> +        doc: |
> +          Subsystem-specific name for the loopback point within the
> +          component.

We'll need to be careful about keeping this subsystem-specific and not
driver-specific :)

> +      -
> +        name: supported
> +        type: u32
> +        enum: loopback-direction
> +        enum-as-flags: true
> +        doc: Bitmask of supported loopback directions
> +      -
> +        name: direction
> +        type: u32
> +        enum: loopback-direction
> +        doc: Current loopback direction, 0 means disabled

no need for an u32 for 3 different values I think :)

Maxime


