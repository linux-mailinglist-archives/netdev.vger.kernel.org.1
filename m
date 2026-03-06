Return-Path: <netdev+bounces-264872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJKrFzX7qmmcZAEAu9opvQ
	(envelope-from <netdev+bounces-264872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:05:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8B7224876
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07D64311C30C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A037AA94;
	Fri,  6 Mar 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GAgOA75l"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262D3E9F9B;
	Fri,  6 Mar 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812635; cv=none; b=bVp3eoBmzWjDV3l4CMqRBABI3MAyHqm6Ae0yzSAtPcedZmgybAemuHwM0zy3eP4AsqAy5aYfJPRELfEU3N4nENAyiEaR5NNB91bF7DJLGRdCYb5mTZJOTsSMNnld8b4i4BQgeOw6L9ZTLYtrbosThoHL/SpcIges/2Scl2AdT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812635; c=relaxed/simple;
	bh=8r00pW6Q9uDGqyGobuST3k0d6BYLtWGg6QiP406yolc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUJNpGKC0ykI0MKZXYS5GUcY5L+QWIzYiYR4N7/vqDxGrItW0VOQUw+huDyRREVgQuZ6gEB3jORSb2+wmBMKVZ3csJih2ErHkO5CPqqQpIagwlxLT/EsmNGB4stdueVnehDihl/+60OfrpkCXZi3IRRbaCXUBOGiPd3QjO1Y0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GAgOA75l; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D625DC40436;
	Fri,  6 Mar 2026 15:57:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD11E5FF92;
	Fri,  6 Mar 2026 15:57:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FE5C10369A49;
	Fri,  6 Mar 2026 16:57:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772812630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/oDtwXYJePOZOJfcB2Qcle6W1Fo3aY7tJghm+eZoljg=;
	b=GAgOA75liw3nRK3Cg2k7ikjjpPt4kGW+go2YVdLM2R2VZ1Kg5J2uiS7FaIc/JbAZ+Oqb4e
	bvPnTO+igV/sMWtYre8OzZmBSnTeD2/ksDWg8T6dTPbCuZiXu2p4W/kqQ2bB42AISqkPxf
	D8A4VqxHkqQWaiE3d1tblb4qgxxlocA8PdnSHb8gftlLFLOEZ7Gxjq1eGDHX9HAVNbMeUB
	05Gn5iEgIA1WQ7XQuDw9RIdFeqq0FITEltVSXQFVdiYPLfx0MativgFgFnXp5jaBq8GO0i
	NrODI3numqVxeyW/MzbXO+32DXHhJTPEgEbRlPH6yvOFmlRib5r36QqCklleuA==
Message-ID: <5b123b12-fcc3-45f5-bbdd-407fa83fff15@bootlin.com>
Date: Fri, 6 Mar 2026 16:57:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v6,02/10] net: phy: phy_link_topology: Track ports in
 phy_link_topology
To: Simon Horman <horms@kernel.org>
Cc: vladimir.oltean@nxp.com, andrew@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, hkallweit1@gmail.com,
 kory.maincent@bootlin.com, davem@davemloft.net, romain.gantois@bootlin.com,
 edumazet@google.com, daniel@makrotopia.org, herve.codina@bootlin.com,
 nicveronese@gmail.com, kuba@kernel.org, kabel@kernel.org,
 dimitri.fedrau@liebherr.com, christophe.leroy@csgroup.eu,
 f.fainelli@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 mwojtas@chromium.org, thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de
References: <20260304145444.442334-3-maxime.chevallier@bootlin.com>
 <20260306140911.495181-1-horms@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260306140911.495181-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9E8B7224876
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264872-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,redhat.com,vger.kernel.org,gmail.com,bootlin.com,davemloft.net,google.com,makrotopia.org,kernel.org,liebherr.com,csgroup.eu,armlinux.org.uk,chromium.org,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,linux.dev:url]
X-Rspamd-Action: no action



On 06/03/2026 15:09, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: phy: phy_link_topology: Track ports in phy_link_topology
> 
> This commit adds port tracking to phy_link_topology by introducing a
> ports xarray alongside the existing phys xarray. PHY-driven ports are
> registered and tracked with unique IDs that can be reused.
> 
>> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
>> index fdfafd951905..f7946c73dc5f 100644
>> --- a/drivers/net/phy/phy_link_topology.c
>> +++ b/drivers/net/phy/phy_link_topology.c
> 
> [ ... ]
> 
>> @@ -89,8 +126,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
>>  	if (ret < 0)
>>  		goto err;
>>
>> +	/* Add all the PHY's ports to the topology */
>> +	list_for_each_entry(port, &phy->ports, head) {
>> +		ret = phy_link_topo_add_port(dev, port);
>> +		if (ret)
>> +			goto del_ports;
>> +	}
>> +
>>  	return 0;
>>
>> +del_ports:
>> +	list_for_each_entry_from_reverse(port, &phy->ports, head)
>> +		phy_link_topo_del_port(dev, port);
> 
> Does this rollback sequence incorrectly delete a port that was never added?
> list_for_each_entry_from_reverse() starts at the current entry (the port
> that FAILED to add) and iterates backward. This means phy_link_topo_del_port()
> is called on the failed port that was never successfully added to the xarray.
> 
> Looking at phy_link_topo_del_port():
> 
> void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port)
> {
> 	struct phy_link_topology *topo = dev->link_topo;
> 
> 	if (!topo)
> 		return;
> 
> 	xa_erase(&topo->ports, port->id);
> }
> 
> The spurious xa_erase() is likely harmless in the -ENOMEM case from
> xa_alloc_cyclic with port->id == 0, because XA_FLAGS_ALLOC1 reserves index 0.
> 
> However, in the xa_insert -EBUSY failure case where port->id is non-zero
> and the slot is occupied by a different port, the rollback incorrectly
> erases the other port's xarray entry, causing silent data corruption in
> the topology's port tracking.
> 
> Should this use list_for_each_entry_continue_reverse() instead? That macro
> starts from the entry BEFORE the current position, skipping the failed port
> and only rolling back successfully-added ports.
>

Indeed ! thanks :)

Maxime


