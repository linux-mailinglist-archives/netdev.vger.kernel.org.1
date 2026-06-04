Return-Path: <netdev+bounces-295224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZEx3MNJwIWrnGQEAu9opvQ
	(envelope-from <netdev+bounces-295224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681A63FE9E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:34:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=lUNzcnOe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295224-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295224-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCAB302412E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D51426D37;
	Thu,  4 Jun 2026 12:28:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF418EB0;
	Thu,  4 Jun 2026 12:28:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576083; cv=none; b=rrtI2Tq2WCRu6COFnDFP8dpVxDU1KJtKDSyA/XY6UBPydsIu6OPOPn3HWID5Qb1k9ycs45hxyS3tqdNEGix1PVUSvgW9AW5/CLL187rMwp4Rn1lsJDjiD3WFkPm7EK6CgUCgAM0eZXkWo78Syihnf+BfqtYAyWV1IUHBLTytDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576083; c=relaxed/simple;
	bh=iC1JKZwh6KYUm+GL10uTLhw4nuH2oT9Hf20McyPRe9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTHfvMwN52t5IBvoTtO5xrkJfzyjaTaGLyz7jdC046SElmg50mVqX4GM5in+nIEWOfkwOogYANWUp3kFn00XvuqnXdYXtedQfajZOY16nZvVm8lal278jsiYKBwUTcdMjP4ufMC+fxK5nQzaV1dyxdOx9+eFVSJEroZES81B6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lUNzcnOe; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tjxK9kQvrnV25eSapXgxCTW+fRl1m+DJpHF40IT8DfY=; b=lUNzcnOeQJl4W1WzPemTmW4SO3
	Zyvu1uRttj+In636N/PitX6KuziY+XSV5syIGnpoSqCWL3sUHr8gx8WSTgmu/oufKMHUDQY5JUfNx
	ZS0/VpzYfdRNlqU1CRB9vfaf+IAYya8MQBmwrxnpO83myGv0Fh5/gePcl93hkch2oook=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wV7Au-0062b9-U3; Thu, 04 Jun 2026 14:27:52 +0200
Date: Thu, 4 Jun 2026 14:27:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 2/4] net: phy: c45: add
 genphy_c45_config_master_slave()
Message-ID: <8e1017e5-0baf-4dd2-9e9e-00733284b5a2@lunn.ch>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-3-javen_xu@realsil.com.cn>
 <521e53fe8f22eb938ea7b9073516378f@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521e53fe8f22eb938ea7b9073516378f@tipi-net.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[realsil.com.cn,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1681A63FE9E

> > +/**
> > + * genphy_c45_config_master_slave - Configure Master/Slave setting for
> > C45 PHYs
> > + * @phydev: target phy_device struct
> > + *
> > + * Description: Configures the Master/Slave manual setting in the
> > + * 10GBASE-T control register (MMD 7, Register 0x0020) according to
> > + * IEEE 802.3 standards.
> > + */
> 
> Please document the return value (0 = unchanged, 1 = changed, <0 errno),
> like
> it is done for genphy_c45_an_config_aneg().
> 
> > +int genphy_c45_config_master_slave(struct phy_device *phydev)

We already have genphy_c45_pma_baset1_setup_master_slave(). This new
function does the same thing, but not for T1 PHYs. It probably should
use a similar name.

> > +{
> > +	u16 val = 0;
> > +
> > +	switch (phydev->master_slave_set) {
> > +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> > +		val = MDIO_AN_10GBT_CTRL_MS_ENABLE | MDIO_AN_10GBT_CTRL_MS_VALUE;
> > +		break;
> > +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> > +		val = MDIO_AN_10GBT_CTRL_MS_ENABLE;
> > +		break;
> > +	case MASTER_SLAVE_CFG_UNKNOWN:
> > +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> > +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> > +	default:
> > +		break;
> > +	}
> 
> Per IEEE 802.3 (45.2.7.10.3), 7.32.13 (port type) is a copy of 9.10 /
> CTL1000_PREFER_MASTER, like it is done in c22's genphy_setup_master_slave().
> 
> So set it for MASTER_PREFERRED, clear it for SLAVE_PREFERRED and leave
> UNKNOWN/UNSUPPORTED
> untouched (return 0). Use -EOPNOTSUPP only for default.

Agreed, making it the same as
genphy_c45_pma_baset1_setup_master_slave().

    Andrew

---
pw-bot: cr

