Return-Path: <netdev+bounces-288664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W5D2InvNCGrg5wMAu9opvQ
	(envelope-from <netdev+bounces-288664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:03:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E255D9D0
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB21300CE4F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 20:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD42FFF99;
	Sat, 16 May 2026 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lCYhNtqU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C494248166;
	Sat, 16 May 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778961783; cv=none; b=ZX51dUB304Yx52L4D0IIzFLeiSO1pwgD5vpAiqCeK5fazYNYd4PgLbrzXDO0I3dw873ETj+QWHVw5MP4ccLiTWzImu4RUM/CRq20ZpzxgpJTMMxpjT4TYdd4c2gahzOV435dT0t5QDwo88WLO1b800csIMlyCBAMFkR5T2cEikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778961783; c=relaxed/simple;
	bh=PN9uZdwK+CxAxLvRlU7rBUAIwFyUXnoGDiuWJmFDlxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJAEdbSosJI6iVjVWAoW57Z0u+nnDtF8yyrSCi7ia42xuR61bgBJ7qDlod2bPkaeV/U31LCh5Nn5ain4+5NPNfOzYGMgYh4Xe5sQPwxZ3jwUR3k9Mqf3/S8DbbR7Sc6G/DQs2Aq5zMWMDGVjQrI40FlMiNSX7T+E0UVOSARrkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lCYhNtqU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZmITtLTZpI66hIzuP6HmbpRfvOldnPVLLVQuNKN6VdI=; b=lCYhNtqU8eB6kZwreSs3lkU9Sv
	7OnOqVXwLcl2mgIWTQbCTM9DtKcGwYEHRfeJ9c6ph4uiERCpbGmOQ1vPAxJvFHCoLPrTa7Pg/LYf1
	00z8JX0m266U+dNIzMq/sBBUnuPIYebSflbRuMPNohZaRTacqx6J00VmlTceoyF86KYY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOLDm-003GIE-Tk; Sat, 16 May 2026 22:02:50 +0200
Date: Sat, 16 May 2026 22:02:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org
Subject: Re: [RFC net-next 1/1] net: tpmr: add Two-Port MAC Relay driver
Message-ID: <1f611710-005d-48bd-8425-a1532ca95a21@lunn.ch>
References: <20260516050858.23858-1-devnexen@gmail.com>
 <20260516050858.23858-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516050858.23858-2-devnexen@gmail.com>
X-Rspamd-Queue-Id: 954E255D9D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> +static bool tpmr_should_relay_reserved(const u8 *dst)
> +{
> +	static const u8 prefix[5] = { 0x01, 0x80, 0xc2, 0x00, 0x00 };
> +
> +	if (memcmp(dst, prefix, sizeof(prefix)) != 0)
> +		return true;
> +
> +	return dst[5] != 0x01;

I would assume the traffic is mostly unicast, with only a few
multicast thrown in. So would it not make sense to first test for
multicast?  Only if it is multicast do you need to look deeper into
the address?

Also, is_multicast_ether_addr() exists.

> +	eh = eth_hdr(skb);
> +	if (is_multicast_ether_addr(eh->h_dest) &&
> +	    !tpmr_should_relay_reserved(eh->h_dest))
> +		return RX_HANDLER_PASS;

Ah, you already have it here. I still think this can be optimized.

> +	/* Enforce MTU consistency between the two members. */
> +	if (tpmr->n_ports == 1) {
> +		struct net_device *first;
> +
> +		first = rtnl_dereference(tpmr->ports[tpmr->ports[0].slot].dev);
> +		if (first && first->mtu != slave_dev->mtu) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Member MTU must match the other member's");
> +			return -EINVAL;
> +		}
> +	}

This seems to assume that tpmr->ports[0] is filled first. But what
about:

ip link eth0 set master tpmr0
ip link eth1 set master tpmr0
ip link eth0 set nomaster
ip link eth42 set master tpmr0

> +static int tpmr_del_slave(struct net_device *dev, struct net_device *slave_dev)
> +{
> +	struct tpmr_priv *tpmr = netdev_priv(dev);
> +	struct tpmr_port *port = NULL;
> +	unsigned int slot;
> +
> +	ASSERT_RTNL();
> +
> +	for (slot = 0; slot < TPMR_MAX_PORTS; slot++) {
> +		if (rtnl_dereference(tpmr->ports[slot].dev) == slave_dev) {
> +			port = &tpmr->ports[slot];
> +			break;
> +		}
> +	}

For the above to work, there needs to be some juggling here.

> +static int tpmr_device_event(struct notifier_block *nb,
> +			     unsigned long event, void *ptr)
> +{
> +	struct net_device *slave_dev = netdev_notifier_info_to_dev(ptr);
> +	struct net_device *master;
> +	struct tpmr_priv *tpmr;
> +
> +	if (slave_dev->reg_state == NETREG_REGISTERED) {
> +		master = netdev_master_upper_dev_get(slave_dev);
> +		if (!master || master->rtnl_link_ops != &tpmr_link_ops)
> +			return NOTIFY_DONE;
> +	} else {
> +		return NOTIFY_DONE;
> +	}
> +
> +	tpmr = netdev_priv(master);
> +
> +	switch (event) {
> +	case NETDEV_CHANGE:
> +	case NETDEV_UP:
> +	case NETDEV_DOWN:
> +		tpmr_update_carrier(tpmr);
> +		break;
> +	case NETDEV_UNREGISTER:
> +		tpmr_del_slave(master, slave_dev);
> +		break;
> +	}
> +	return NOTIFY_DONE;

Maybe you also want to act on NETDEV_PRECHANGEMTU and reject it?

> +static void tpmr_get_drvinfo(struct net_device *dev,
> +			     struct ethtool_drvinfo *drvinfo)
> +{
> +	strscpy(drvinfo->driver, TPMR_DRV_NAME, sizeof(drvinfo->driver));
> +	strscpy(drvinfo->version, TPMR_DRV_VERSION, sizeof(drvinfo->version));

Driver version is meaningless because it never changes. Please leave
it empty, and the core will fill it with the kernel version.

I also wounder if this is the correct home, or if it should be in net,
next to bridge? I don't know...

Andrew

