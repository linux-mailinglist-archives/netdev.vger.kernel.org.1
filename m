Return-Path: <netdev+bounces-261095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKUDOC+Fn2mYcgQAu9opvQ
	(envelope-from <netdev+bounces-261095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:26:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A919ED56
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6860301918C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 23:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B633769B;
	Wed, 25 Feb 2026 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a0SUhybm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FD14BF97
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061995; cv=none; b=hLcACENHTuHdHmjtK9VI4VFtJhPz89LwG7lnljdzuNWtHuDEP9fsjDqZfVnBuAmrdVYBJy7tes9n9bMwdoS9lkO7eBx+TupBrZUZ3YCTW78YkcGaswIzRfOmGIZBqe47rhZeTT/s8LrrCAsVcXBXHPwNq2WEEr0Ufzs/JSbXMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061995; c=relaxed/simple;
	bh=YWydEKbSDecXz8WEblQtyqu9kmMAuW6ToHQCnxUA9qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSxpI7MQ80/NbZR2B76xIhXvlvAyGxRnwPyNtNqA6Ddcdk5MvACsTYr9VfS0eir57A7U4kaDh4dZq20LCOnj1c1UeZLn/UyH5leEc0KqJjSbtwuvqTWtfjqaaXXGOX/oN5JOpTeed9V/Yv8ZcMGKbEpnonIJGbdiVpj5W8j5CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a0SUhybm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qxLuugSIe05VbLeQgST2gdnWVcyHEeV94/aWEFPJuIk=; b=a0SUhybmNHFwOTVStYfY6qM+HR
	EUkrN/F1uTh9gSbbmOxDeG5zn0y0MUKOX1cAMsJ4gLZcr1H0kkHw4MJQoNFF0RQ3dfoRgVRqtXTpy
	s5eKqO84PmQQoI6Jl0Cev2cjafRsPhrC9QDdls5JWSUEUivhNEdWFAom1QAq3N3KLViQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvOH0-008oFU-Rj; Thu, 26 Feb 2026 00:26:30 +0100
Date: Thu, 26 Feb 2026 00:26:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Patryk <pbiel7@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: 10G-QXGMII phy no autonegotiation on LS1028A
Message-ID: <5bbafc78-9dbb-448f-a86e-c5e94618f2f8@lunn.ch>
References: <CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261095-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 297A919ED56
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:32:28AM +0100, Patryk wrote:
> Hello, I've been trying to bring-up the 10G-QXGMII PHY on LS1028A
> based board and I have some problems. I guess that they come from the
> fact that I do not see the whole picture as this is the second phy
> I've been working on (actually the first one that uses serdes, the
> previous one was connected through RGMII). Anyway I decided to send
> this mail and post some of my questions hoping someone will find some
> time to steer a newbie in the right direction.
> 
> The phy I've been using, once started, autoconfigures to 10G-QXGMII
> mode with auto negotiation enabled. It detects the link partner
> abilities and completes the autoneg process (at least on the line
> side). I think we can assume it works as expected. From the SoC side,
> as I understand the crucial part is pcs-lynx implementation. It
> configures the USXGMII mode, checks the state, reads the link partner
> ability that is carried "in-band". and so on. In the device tree I
> configure my phy to use mode="in-band-status".
> 
> The problem is as follows - the pcs-lynx correctly detect the USXGII
> link however does not detect the link partner ability thus, the link
> never becomes functional. It looks like the autonegotiation on the SoC
> side does not work at all. I browsed through the pcs-lynx sources,
> looking at the LS1028A reference manual, and I've found that Serdes
> module on this SoC features some MDIO devices, whereas one of them is
> "QXGMII USXGMII Replicator" (LS1028ARM 29.6 MDIO register spaces for
> anyone interested). I checked this device and it features the Control
> Register, which contains the Auto_Negotiation_Enable bit that is never
> set by the pcs-lynx driver.

I'm not the expert here. Adding Vladimir and Ioana to Cc:

lynx_pcs_inband_caps() says:

        case PHY_INTERFACE_MODE_USXGMII:
        case PHY_INTERFACE_MODE_10G_QXGMII:
                return LINK_INBAND_ENABLE;

This is saying it does have the capability to do inband.

lynx_pcs_config() does:

       case PHY_INTERFACE_MODE_USXGMII:
        case PHY_INTERFACE_MODE_10G_QXGMII:
                return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
                                               neg_mode);

static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
                                   phy_interface_t interface,
                                   const unsigned long *advertising,
                                   unsigned int neg_mode)
{
        struct mii_bus *bus = pcs->bus;
        int addr = pcs->addr;

        if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
                dev_err(&pcs->dev, "%s only supports in-band AN for now\n",
                        phy_modes(interface));
                return -EOPNOTSUPP;
        }

        /* Configure device ability for the USXGMII Replicator */
        return mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
                                 MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
                                 MDIO_USXGMII_FULL_DUPLEX |
                                 ADVERTISE_SGMII | ADVERTISE_LPACK);
}

Looks sensible, setting what will be advertised.

> I patched the driver (just out of
> curiosity) and in lynx_pcs_config_usxgmii I added code that sets this
> bit.

The call which is supposed to start autoneg is lynx_pcs_an_restart().

static void lynx_pcs_an_restart(struct phylink_pcs *pcs)
{
        struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);

        phylink_mii_c22_pcs_an_restart(lynx->mdio);
}

This is hitting the normal MII_BMCR, where as it seems like USXGMII
has all it registers in MDIO_MMD_VEND2. Does this go together with
what you found?

The problem here is, lynx_pcs_an_restart() is not passed the interface
mode, so there is no obvious indication you should be using
MDIO_MMD_VEND2. Probably lynx_pcs_config() needs to store away ifmode
in struct lynx_pcs.

	Andrew

