Return-Path: <netdev+bounces-293277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ga+MkcPGmqa1AgAu9opvQ
	(envelope-from <netdev+bounces-293277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:12:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF96092C6
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 960AC30091EA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A743A7843;
	Fri, 29 May 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ctrLLl72"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FB329E79;
	Fri, 29 May 2026 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780092738; cv=none; b=b61Lu4P1Kf0qDPb7fgwlQl6105yNB4PIRpj0NbqiRmd4+Ag5IbvDMH2IOkRWGBkZjB2F0AcIqv+g2moPoYkvQ8b15oi+51SQWAELuDeqwF8/NgajMZq0/aXSL228BQ+Inx+ryT8krSdTpFzUFI+yJP5DeWLXJAcvrqP8CBPRFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780092738; c=relaxed/simple;
	bh=flnlIv1W/HRGz7xoLpUAozTvk1NhrFCnWZQf93XdNp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+QXvj2zqdC1ALxBqwH+f/zVpIeb2puCH3s9xX5T9iL6lyb4rYP893xxR8RMgfXsKSLeYROrQIO2n70RZ4L9xWhpFhMfMJsK7OeRJN66eqXz3MuKBq2/TGbXySg3pO/Waz02vo7wOG5dJ/xC+7w3uTxTT03oKkdRrPZk/rZJK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ctrLLl72; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jTX1kAhF6byq9vG8pOgGLR2vzWuKgfWQJVmtjHUCvrA=; b=ct
	rLLl72nEsIwOISRGU0xHiz9E8MMSw1l6HMdkduP7yE7zQQdtkhQ2scFvTsd1+KdgIkkLvGpvZzkvf
	K/6bR7xmU5WzLtg5ZjpTkOA5dYxJz5Hxaj6hNoxOn8NaZ1x4KmbO1WIpPupYwegUhpFN3HLxwKSZ9
	Pyia1CthAuq+kAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wT5Qp-005B0c-5k; Sat, 30 May 2026 00:11:55 +0200
Date: Sat, 30 May 2026 00:11:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 01/14] net: phy: Helper to read and write
 through C45 without lock
Message-ID: <f5010898-3d43-48c6-9b0b-2e4968b9799a@lunn.ch>
References: <CY8PR02MB92499C9080614FA3CEB8CD0483162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR02MB92499C9080614FA3CEB8CD0483162@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293277-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[lunn.ch:server fail,sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 7FCF96092C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +/**
> + * genphy_phy_read_mmd - Helper for reading a register without lock
> + * from the given MMD and PHY.
> + * @phydev: The phy_device struct
> + * @devnum: The MMD to read from
> + * @regnum: The register on the MMD to read
> + *
> + * Description: PHYs can have both C22 and C45 registers space. Once PHY
> + * is discovered via C22 bus protocol, it uses C22 indirect access to
> + * access C45 registers. Some PHYs, like 10Base-T1S PHYs defined by OPEN
> + * Alliance 10BASE‑T1x, support only direct access.
> + *
> + * If PHY indicates C45 support through DTS entry, it avoid C22 APIs
> + * entirely and therefore generic MDIO registers are inaccessible.
> + *
> + * MDIO bus isn't locked here because when called through read_mmd
> + * callback of phy_driver, caller is expected to lock the bus as
> + * implemented in phy_read_mmd.
> + */
> +int genphy_phy_read_mmd(struct phy_device *phydev, int devnum,
> +			u16 regnum)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;

You could add:

	lockdep_assert_held(&bus->mdio_lock);

which is stronger than the documentation.

Otherwise this looks good.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

