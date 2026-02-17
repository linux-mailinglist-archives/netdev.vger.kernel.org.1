Return-Path: <netdev+bounces-259075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KpgMteNlGn6FQIAu9opvQ
	(envelope-from <netdev+bounces-259075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:48:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D7D14DB02
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55E2A302E7F1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD5E36CE06;
	Tue, 17 Feb 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xlRCTUw8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5A354AC0;
	Tue, 17 Feb 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343313; cv=none; b=O2w13xc8rRhkmdkjPMq8N/mHhxy+duV9snzFm67NtT7/X3IVA7zMA5xb2AebsUxbSET81XjfLYL6swt6Gi6JXB1MV0GHAeIboRfldzaAhaxBo9ZN/Ag45orbuaUPJopfh03+FuqUwh0Taf3Dz2vUR1L6UXtAnHJYIzYNfSphGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343313; c=relaxed/simple;
	bh=of6jhKh4paDv6oNxp3xyBYuYr1UUgt80aS93zumMOoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxnsooPgTQj2Ws+svO2PxziQxJ/wHB1SGiT1M+G09U99WA29ZXfS0ip09gmuUjuR4wTzlSA1xxLntDaymnS/ltbeuX42l4T7ttr5iEFpje9i3svqiueAdJdViFMow5ze/aucOwn86TL50+dGmGQlJj5n0bQOpmXwAs5sFSdo2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xlRCTUw8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+371NQ9eGDzVnkhUU3rE6sVtGuXjy3WYTdBfNToOwNw=; b=xlRCTUw8UWw5U57mriwGdncej8
	iWR842JR4mvT7h9YEOvxdboASjQqJNhCmStg49BY/+C6lUxW/UZMUFITMxYHN+h4BwSir6l+gX0y7
	YXVe3c3SHrv85+RyiHqu83+8GeiAH22pw7FZR3qUaqzrHJ9Zdm1ovO36kI+yhszDxaawlk3aggMnf
	imkUS8DMk679odXR7mK7FzJ6e/cWcbXomMs1cGltKujQdmnnEupsiDzY7ICSnc58nGHaKdUfZD6KL
	Gq1QjouZCFK8oNc8pId33SOMWgNs3aMParyQAiquh4u2DPlbDK3uvHBSFsxK1pFOy7YEqTQc3h+g8
	XgGag0RA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59912)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vsNJL-000000007rL-2ZDE;
	Tue, 17 Feb 2026 15:48:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vsNJI-000000001K5-3i5e;
	Tue, 17 Feb 2026 15:48:24 +0000
Date: Tue, 17 Feb 2026 15:48:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: guard link replay helpers against
 NULL phylink instance
Message-ID: <aZSNyIhG6oTNSTa9@shell.armlinux.org.uk>
References: <20260205192344.21797-1-vladimir.oltean@nxp.com>
 <173190b1-aed6-4366-bb7d-c6ea64d26899@redhat.com>
 <877b4780-9f99-478c-82fa-a32817d72004@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877b4780-9f99-478c-82fa-a32817d72004@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FREEMAIL_CC(0.00)[redhat.com,nxp.com,vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259075-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 27D7D14DB02
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 02:51:25PM +0100, Andrew Lunn wrote:
> On Tue, Feb 17, 2026 at 09:22:25AM +0100, Paolo Abeni wrote:
> > On 2/5/26 8:23 PM, Vladimir Oltean wrote:
> > > There is a crash when unbinding the sja1105 driver under special
> > > circumstances:
> > > 
> > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> > > Call trace:
> > > phylink_run_resolve_and_disable+0x10/0x90
> > > sja1105_static_config_reload+0xc0/0x410
> > > sja1105_vlan_filtering+0x100/0x140
> > > dsa_port_vlan_filtering+0x13c/0x368
> > > dsa_port_reset_vlan_filtering.isra.0+0xe8/0x198
> > > dsa_port_bridge_leave+0x130/0x248
> > > dsa_user_changeupper.part.0+0x74/0x158
> > > dsa_user_netdevice_event+0x50c/0xa50
> > > notifier_call_chain+0x78/0x148
> > > raw_notifier_call_chain+0x20/0x38
> > > call_netdevice_notifiers_info+0x58/0xa8
> > > __netdev_upper_dev_unlink+0xac/0x220
> > > netdev_upper_dev_unlink+0x38/0x70
> > > del_nbp+0x1a4/0x320
> > > br_del_if+0x3c/0xd8
> > > br_device_event+0xf8/0x2d8
> > > notifier_call_chain+0x78/0x148
> > > raw_notifier_call_chain+0x20/0x38
> > > call_netdevice_notifiers_info+0x58/0xa8
> > > unregister_netdevice_many_notify+0x314/0x848
> > > unregister_netdevice_queue+0xe8/0xf8
> > > dsa_user_destroy+0x50/0xa8
> > > dsa_port_teardown+0x80/0x98
> > > dsa_switch_teardown_ports+0x4c/0xb8
> > > dsa_switch_deinit+0x94/0xb8
> > > dsa_switch_put_tree+0x2c/0xc0
> > > dsa_unregister_switch+0x38/0x60
> > > sja1105_remove+0x24/0x40
> > > spi_remove+0x38/0x60
> > > device_remove+0x54/0x90
> > > device_release_driver_internal+0x1d4/0x230
> > > device_driver_detach+0x20/0x38
> > > unbind_store+0xbc/0xc8
> > > ---[ end trace 0000000000000000 ]---
> > > 
> > > which requires an explanation.
> > > 
> > > When a port offloads a bridge, the switch must be reset to change
> > > the VLAN awareness state (the SJA1105_VLAN_FILTERING reason for
> > > sja1105_static_config_reload()). When the port leaves a VLAN-aware
> > > bridge, it must also be reset for the same reason: it is returning
> > > to operation as a VLAN-unaware standalone port.
> > > 
> > > sja1105_static_config_reload() triggers the phylink link replay helpers.
> > > 
> > > Because sja1105 is a switch, it has multiple user ports. During unbind,
> > > ports are torn down one by one in dsa_switch_teardown_ports() ->
> > > dsa_port_teardown() -> dsa_user_destroy().
> > > 
> > > The crash happens when the numerically first user port is not part of
> > > the VLAN-aware bridge, but any other user port is.
> > > 
> > > Tearing down the first user port causes phylink_destroy() to be called
> > > on dp->pl, and this pointer to be set to NULL. Then, when the second
> > > user port is torn down, this was offloading a VLAN-aware bridge port, so
> > > indirectly it will trigger sja1105_static_config_reload().
> > > 
> > > The latter function iterates using dsa_switch_for_each_available_port(),
> > > and unconditionally dereferences dp->pl, including for the
> > > aforementioned torn down previous port, and passes that to phylink.
> > > This is where the NULL pointer is coming from.
> > > 
> > > There are multiple levels at which this could be avoided:
> > > - add an "if (dp->pl)" in sja1105_static_config_reload()
> > > - make the phylink replay helpers NULL-tolerant
> > > - mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
> > >   has run, such that subsequent dsa_switch_for_each_available_port()
> > >   iterations skip them
> > > - disconnect the entire switch at once from switchdev and
> > >   NETDEV_CHANGEUPPER events while unbinding, not just port by port,
> > >   likely using a "ds->unbinding = true" mechanism or similar
> > > 
> > > however options 3 and 4 are quite heavy and might have side effects,
> > > option 1 is very unassuming and option 2 seems a more elegant variant
> > > of 1, given the fact that sja1105 is the only user of these phylink
> > > replay helpers. It allows to keep the driver simple and is the option
> > > I went with.
> > > 
> > > Functionally speaking, transforming the replay helpers into no-ops for
> > > ports without a phylink instance is fine, because that only happens
> > > during driver removal (an operation which cannot be cancelled). The
> > > ports are not required to work.
> > > 
> > > Fixes: 0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of link callbacks")
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > 
> > I think this patch could land on current net, but it would be nice an
> > ack from phylib SMEs.
> 
> Sorry, weekend away.
> 
> I prefer option 1. I _think_ option 2 only works because the MAC
> driver set dp->pl to NULL. phylink is not responsible for the NULL, so
> it seems odd for phylink to assume there is a NULL. Only the MAC
> driver knows if the MAC driver has set dp->pl to NULL.

I also prefer option 1. Currently, none of phylink's driver API permits
struct phylink to be NULL, and I'd prefer that to remain the case for
consistency.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

