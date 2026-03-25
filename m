Return-Path: <netdev+bounces-271484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMRvFHG2w2litgQAu9opvQ
	(envelope-from <netdev+bounces-271484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:18:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D51FE322C0E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECB8230F4479
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B20B3A2569;
	Wed, 25 Mar 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q/vnWAXd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9526396D16
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433742; cv=none; b=fWkIlSIsMfxfUhhOg6hS4xhXjRNqpdyuyl2dG/j3mZ77LDX+I0sY7/yJ5+/S3Ifl54D9Whz3Vsl7ssQ+8SR6mEsaRa1AfNwAFw5SpR8+Qc8LfRaKEPj7qwVGW8gQ5S5O9JM+Ffmk5GlXhcB0nCFVTsCoD8e6bQut4u/i4D0Gyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433742; c=relaxed/simple;
	bh=AdGU501r3U9B/Q09U+6X9PYTeUvzw1QB/jKjNjCbtG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV65dI4YxBVLyG2kUmfemiPiXGpRKfYApT9XcjqGGyxxj05P9w/5iDjZ+VpUJ0vsbek0msJsigiMqj1mBPdF0G+cOvQxkDJsTmHv+zXK0KR+gnJUaf790czCMJJMB/sT6Pkr9wrKbCs8FVnuav9ac4Tf1YgdLBbf19x4RTuJzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q/vnWAXd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3CDD31A2FE3;
	Wed, 25 Mar 2026 10:15:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 047A4601A1;
	Wed, 25 Mar 2026 10:15:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73D421045112C;
	Wed, 25 Mar 2026 11:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774433735; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zymKEv3Q5ro1k0w9BHw333t4WCsc1KZUs+hLCuWyblQ=;
	b=Q/vnWAXdVtRtRFRg8naetSprSkU0oB5w9nLDS1SxJVSO4LTT/pUBk8qCn/jh5urODcMjfR
	UYK7f0vUSo6tnUu+DuxhPTXiXXE8o9Ss78cRspV2gWnAlaqo+fMxkfim/vOo6bmCipFucu
	9+OBYuCT43Y4mVxM1U80nxEFtIo/dDXLHKqAFsJYFxbaZsl1A1Eus1ZpTI89TdoINKfCJ5
	e6y7jrPbWs2njaPvnOtrr2ZIGutBQI5lyz/kO85gb0NYZ2AH8HRR2Q8BgFCBPFGmuNr9Wt
	g7Aaw3fFvCedNdLMIFWs99aZt2PkonuQfxeX5tXI/lx7sDLIpnBt7j5E1rHrLA==
Message-ID: <5d632dae-41ea-4966-9c7c-91aec77d2e7b@bootlin.com>
Date: Wed, 25 Mar 2026 11:15:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/10] netlink: specs: Add ethernet port
 listing with ethtool
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
 <20260325081937.571115-10-maxime.chevallier@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260325081937.571115-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271484-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D51FE322C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 25/03/2026 09:19, Maxime Chevallier wrote:
> Ethernet network interfaces may have more than one front-facing port.
> The phy_port infrastructure was introduced to keep track of
> these ports, and allow userspace to know about the presence and
> capability of these ports. Add a ethnl netlink message to report this
> information.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  Documentation/netlink/specs/ethtool.yaml      | 50 +++++++++++++++++++
>  Documentation/networking/ethtool-netlink.rst  | 35 +++++++++++++
>  .../uapi/linux/ethtool_netlink_generated.h    | 19 +++++++
>  3 files changed, 104 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 5dd4d1b5d94b..9b907f40aba0 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -210,6 +210,10 @@ definitions:
>        -
>          name: discard
>          value: 31
> +  -
> +    name: port-type
> +    type: enum
> +    entries: [mdi, sfp]
>  
>  attribute-sets:
>    -
> @@ -1905,6 +1909,32 @@ attribute-sets:
>          name: link
>          type: nest
>          nested-attributes: mse-snapshot
> +  -
> +    name: port
> +    attr-cnt-name: --ethtool-a-port-cnt
> +    attributes:
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: id
> +        type: u32
> +      -
> +        name: supported-modes
> +        type: nest
> +        nested-attributes: bitset
> +      -
> +        name: supported-interfaces
> +        type: nest
> +        nested-attributes: bitset
> +      -
> +        name: type
> +        type: u32
> +        enum: port-type
> +      -
> +        name: vacant
> +        type: u32
>  
>  operations:
>    enum-model: directional
> @@ -2859,6 +2889,26 @@ operations:
>              - worst-channel
>              - link
>        dump: *mse-get-op
> +    -
> +      name: port-get
> +      doc: Get ports attached to an interface
> +
> +      attribute-set: port
> +
> +      do: &port-get-op
> +        request:
> +          attributes:
> +            - header
> +            - id
> +        reply:
> +          attributes:
> +            - header
> +            - id
> +            - supported-modes
> +            - supported-interfaces
> +            - type
> +            - vacant
> +      dump: *port-get-op
>  
>  mcast-groups:
>    list:
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index e92abf45faf5..0a5dfba55870 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -2537,6 +2537,40 @@ Within each channel nest, only the metrics supported by the PHY will be present.
>  See ``struct phy_mse_snapshot`` kernel documentation in
>  ``include/linux/phy.h``.
>  
> +PORT_GET
> +========
> +
> +Retrieve information about the physical connection points of a network device,
> +referred to as "ports". User needs to specify a PORT_ID for the DO operation,
> +in which case the DO request returns information about that specific port.
> +
> +As there can be more than one port, the DUMP operation can be used to list the
> +ports present on a given interface, by passing an interface index or name in
> +the dump request.
> +
> +Request contents:
> +
> +  ===================================== ======  ===============================
> +  ``ETHTOOL_A_PORT_HEADER``             nested  request header
> +  ``ETHTOOL_A_PORT_ID``                 u32     port id
> +  ===================================== ======  ===============================
> +
> +Kernel response contents:
> +
> +  ======================================= ======  =============================
> +  ``ETHTOOL_A_PORT_HEADER``               nested  request header
> +  ``ETHTOOL_A_PORT_ID``                   u32     the port's unique identifier,
> +                                                  per netdevice.
> +  ``ETHTOOL_A_PORT_SUPPORTED_MODES``      bitset  bitset of supported linkmodes
> +  ``ETHTOOL_A_PORT_SUPPORTED_INTERFACES`` bitset  bitset of supported MII
> +                                                  interfaces
> +  ``ETHTOOL_A_PORT_TYPE``                 u8      the port type
> +  ``ETHTOOL_A_PORT_VACANT``               u8      for non-mdi ports, indicates
> +                                                  if the port is connected to
> +                                                  another device that could
> +                                                  expose a MDI

ah forgot to update this doc here, should be u32...  :(


