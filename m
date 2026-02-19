Return-Path: <netdev+bounces-259515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO6qEqE9l2kuwAIAu9opvQ
	(envelope-from <netdev+bounces-259515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:43:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D98160C3D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69A863006091
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEFD34C815;
	Thu, 19 Feb 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HeL4Yi7u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE314A4F9;
	Thu, 19 Feb 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519387; cv=none; b=SWxiFRIfMn9gHtt+LJDXD2eRy3bbI0QG+lK2hC+blLUjLUYW6DzpnLZz3JchX8Py664jqdcH5fI5Pv3ZJT13ihinbEo/dJWelWg3ufjTPvBYBmGPPvScBonJp6DtCB8duZB3X345KGoNVXTGAxWpRtvmZbDsNAGWnErBkpE3THY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519387; c=relaxed/simple;
	bh=bSi5J9+jf2DD76VDJVqu13bTxLkx5aIkRAc9MceVNFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afSiZRCW21ll21KqwnD6CIbAC64bgFC5j1RX6VrK7MwH5NQNZe71Msj//ppeUXlPrtOyunnklamw8eVSdXIfq/pjqFDPZlnqk0H87epAL8snprk07fVKPEwvmOrZDZy0KP2pu4Or/3VVHh/uX12V5YJ8vMMHnQCcwK40AvtXRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HeL4Yi7u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+Rpi5B9mieofuRvn4aUQgU1WELLotMUCncPEC7vcJmQ=; b=HeL4Yi7uHthOqg7HIMXDPjEeSs
	T8KR2XIToBHFMuoU1k9u7uWKxwLThW5JgSs+1gH7h/vtYsGVC1yFdTxesf6qZovamS4vb4qhhKmqV
	pA2fGflVHNoBhm2+7xHWfEg2N9rXdEb7BthfX8ZVQT6JfzDelsenC6++UWU43B7JfDaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vt77A-007wRj-FZ; Thu, 19 Feb 2026 17:42:56 +0100
Date: Thu, 19 Feb 2026 17:42:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [RFC PATCH 0/8] xilinx: tsn: Add TSN Endpoint Ethernet MAC
 driver support
Message-ID: <5f884e29-151a-4ee7-9e1a-d7e1f84d9f6c@lunn.ch>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219054911.2017362-1-srinivas.neeli@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259515-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 51D98160C3D
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 11:19:03AM +0530, Srinivas Neeli wrote:
> Introduce a new network driver for the AMD LogiCORE 100M/1G TSN
> Subsystem IP, also known as the TSN Endpoint Ethernet MAC, which
> implements IEEE 802.1 Time-Sensitive Networking (TSN) features for
> deterministic and low-latency Ethernet communication in real-time and
> industrial automation use cases.
> 
> IP Core Overview:
> The AMD LogiCORE 100M/1G TSN Subsystem IP solution (named as TSN Endpoint
> Ethernet MAC IP in the IP catalog) implements IEEE 802.1 Time Sensitive
> Networking (TSN) Standards and provides a low latency Bridged Endpoint or
> Endpoint only solutions.

So an Endpoint only solution is not connected to the switch? It
outputs RGMII, can have a PHY connected to it, and so is a single
netdev interface? You would typically use this in a client?

But you can also instantiate the same MAC multiple times, connected to
an Ethernet switch? That would be the bridged endpoint?

> The bridged endpoint solution consists of a 3-port
> switch that connects to an endpoint including Linux software drivers. For
> Bridged Endpoint (Switch Endpoint), two ports connects to the network and
> one port connects to an internal Endpoint.

To the host, does the internal endpoint just look like a standard
netdev?

What i'm trying to do is get an answer to: Is this a DSA switch, or a
pure switchdev switch. If the host sees a netdev which is connected to
a port of the switch, it is probably a DSA switch. If the host only
sees the user ports, it is probably a pure switchdev switch.

> It supports the use of
> GMII/RGMII interfaces connecting to a physical-side interface (PHY) chip
> with full duplex 100 Mb/s and 1 Gb/s operations.

No 10Mbps support?

> - Provides feature rich Ethernet Switch that caters to various network
>   needs
> 	* 3-port Switch (2-external, 1-internal)
> 	* Programmable cut-through and store-forward operations
> 	* 4-port Switch (2-external, 2-internal) extension through
>           'Endpoint Extension' and 'Endpoint Packet Switching' features

Why not N-ports? Is it really set to 3 or 4? It cannot be synthesised
for 5, 8?

> Sample hardware architecture diagram for Bidge End Point like below:
> 
>              +------------------+
>              |      MCDMA       |
>              +---------+--------+
>                     Q0---Q7
>                        |
>           +------------------------------------------------------------ +
>           |            |	 TSN sub system(Bridge End Point)	|
>           |            |                                                |
>           |     +------+----+  Port 0   +-----------------------+       |
>           |     |  EndPoint |<--------->|       TSN Switch      |       |
>           |     |    (EP)   |           +----+-------------+----+       |
>           |     +-----------+                |             |            |
>           |                                  |             |            |
>           |                              Port 1         Port 2          |
>           |                                  |             |            |
>           |                            +-----------+  +-----------+     |
>           |                            |  MAC-1    |  |  MAC-2    |     |
>           |                            |  (ETH1)   |  |  (ETH2)   |     |
>           |                            +-----+-----+  +-----+-----+     |
> 	  |			             |		    |           |
>           |				     |              |           |
>           +-------------------------------------------------------------+
>                                              |              |           
>                                           RGMII           RGMII
>                                              |              |
>                                       +-----------+  +-----------+
>                                       |  PHY1     |  |  PHY2     |
>                                       | (Port 0)  |  | (Port 2)  |
>                                       +-----------+  +-----------+
> 									  

So how does the host send a frame out Port 2? Is there an extra header
on the frame sent by EndPoint, which the switch interprets?

FYI: Seems like PHY1 (port 0) is a typO.

> - During driver initialization, all switch ports (Endpoint, MAC1, MAC2)
>   are configured into the Forwarding state to enable data flow across the
>   fabric.

Which is wrong. The Linux model is that switch ports are just
netdevs. You configure them just like every other netdev in the
system. Newly created netdevs are standalone. They only allow frames
to pass between the wire and the host. If you want them to L2 forwards
frames between ports you need to add them to a bridge.

	Andrew

