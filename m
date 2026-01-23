Return-Path: <netdev+bounces-252832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNi6KYlnc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:20:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46A75ACA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8BD302BE30
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D18254AFF;
	Fri, 23 Jan 2026 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rKs+SNfJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713D18B0F;
	Fri, 23 Jan 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170617; cv=none; b=FE9VMHD2BWVmaEYyTRVWk1uL5sJWobPfsg+IfEmY6Y5S1ti6HWHgI7edbsVYBfDZo5vV6oFHurXSDmqOYR3yFfdMRWE6mcPR+6DF3EeQLHIVx5Tm8NHWYoGwhGprHheAKb9aFG4d57DCmTxP7f28F4syFd5ZujDXSMV6QI+o+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170617; c=relaxed/simple;
	bh=b24RI/D97T0GXR3dVAs7IIGT9wx0X7rDPh9+6D0S+yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeWP63aPo3os/b4m/hSkRim+7b/qM3aGSvqCRZlJcQD8L4/BQhHWQBRS9zUzmcT7Q+/MLCu+GztXtWn+B0zWRYOY8FRTDRy2TX4IUSQqsxxspQJtit13WYesDTiAlGHXVxW5D1KMYatXZu8NKpfKfQAjjUeBO82tE77atgXfhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rKs+SNfJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ciuUlnrZS5dMX8iutfmJQM7hUgar0C9zX6IcKy5DxsE=; b=rKs+SNfJkE6RykLpqsax8M2byb
	B8GGQ0rzsHPaM0xNOc1e3vqxG5sSsZITV/UsTueaXX15tbtasGKaYebtrZwAszXhoIgxhKGhS5Hu8
	AtKEhSQEbbjAa3Ky+SXMxY5QeaFLaSpnOSuZgMaPjnS1X/9di5Pjz31wd5B13gqlvqbG3/RLprs2P
	mZDyL4mYGKRqM3/HsA9cfec6AOmFsN5j55fDqu+xQAj6anKeHuoMuQyEIskMfKEK2D2whb++BWyBl
	SDFc0u91nfYece7ZaPbVBvKhDpVEx+gyvbIAQduh54bWDI6bvgvDi/3J7EtF1yPGuf8C48JztkmfO
	ECRWSAVg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57706)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vjG5n-000000001zU-2RGp;
	Fri, 23 Jan 2026 12:16:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vjG5l-00000000259-1Azj;
	Fri, 23 Jan 2026 12:16:45 +0000
Date: Fri, 23 Jan 2026 12:16:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 0/3] net: phy: as21xxx: toggle In Band
 feature support
Message-ID: <aXNmrVgpzvPwoyL1@shell.armlinux.org.uk>
References: <20260123120117.10883-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123120117.10883-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252832-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.828];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0E46A75ACA
X-Rspamd-Action: no action

[Please note: gmail.com has become unreliable for email delivery,
google has too much power to decide what is spam and what isn't, with
no route for appeal. please consider switching to a different email
provider.]

On Fri, Jan 23, 2026 at 01:00:28PM +0100, Christian Marangi wrote:
> This is a new variant of the previous submitted patch adding a similar
> feature.
> 
> Old Aeonsemi Firmware permitted only to enable or disable In Band
> support and it couldn't be disabled after (or there wasn't a
> way to detect the current state of it)
> 
> As suggested by Russell this was bad Implementation. Some talk
> with Aeonsemi permitted to release a new firmware with correct
> implementation.
> 
> This series adds support for this if new firmware (1.9.1+) is
> used. On the new firmware, 2 new IPC command are introduced
> to GET the current state of DPC RA (Rate Adaption) or SET it.
> (DPC RA is effectively In Band mode)
> 
> It was verified on the same scenario and can confirm it works
> as expected. (Airoha AN7581/AN7583 with and without In Band
> mode) (If PCS is set to In Band and PHY isn't then no
> connection, so it's easy to verify correct functionality of
> this)
> 
> The new firmware is currently submitted to linux-firmware
> awaiting it to be merged.
> 
> For old firmware to save on compatibility we still enable
> In Band by default (this is what the current driver do)
> 
> This was discovered to be needed in some scenario as is effectively
> the most compatible featureset.
> 
> On a BananaPi R4 Pro, one of the 2 AS21xxx PHY is connected to
> one of the Switch port and such switch supports only In Band when
> set to USXGMII (assuming the Switch expect an SFP module to be
> attached where in absence of i2c or MDIO line In Band is always
> required)

Coupling the PHY's rate adaption with inband support, but not setting
phydev->rate_matching anywhere in this driver seems wrong, and highly
suspicious. I'm not sure what to think given what you've said above,
it just seems completely wrong what has happened here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

