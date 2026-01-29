Return-Path: <netdev+bounces-254824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKgyHBRxe2mMEgIAu9opvQ
	(envelope-from <netdev+bounces-254824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:39:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63CB10EA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E75B3055E76
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687ED2FDC28;
	Thu, 29 Jan 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IUnX78Xx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D073009C1;
	Thu, 29 Jan 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697419; cv=none; b=qVTfS1GQRDOzNfOEH0zuEGJBfIJ9Q2GIKeIIcKB002vp94Y4j4Au2KcaoxXoj0Aj4r2n5smk9jBlF/d1TJ7He88ceSNRMRDobUIy+Wy9HuVWwcI7IwGHiZXBGWvEDYOP8ey+plLYLZDeyUJCRwqC/0Ub/FMiACvGJSXhwbrg8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697419; c=relaxed/simple;
	bh=yww0n1QNnrxlybVtSgCO21H3L4gn8OoO3+1JzIRppgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isk7dzi6TkbsWSRogH18k6m57M+tV/sv9sRC5I6H7t2l8PR6weik7e7ZmBa7quV5acKfGwrg5+9+X6ve35kXPNlL48DuTGbJKmulvJOpnO8CsU8PAgQtu3d65wgVw0qRAPy3uJY0kLpxOnUSth53X+zVEh7QlmzDkLRNuTJzhN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IUnX78Xx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gdLx6MqvKMI7VkaiN5mQVnb2eVwGGL9NszyRmXRKFV0=; b=IUnX78XxTN3897xqwPd6BmA4/H
	EZehdxzJc8Fh5T/UIyymImNbkf0vAUqODyrY9JCzG8ckyviD4xiKe93el/EoD3p1JLof6a0DC3GNf
	MDMz6/TSocUiQyJUxzcbH9Xd2R6QBCL1sJWpQ6DzeMm3du9sH/8YX4h8VC04CU7DgWI3x87nqo0Fv
	+svJ8AlhFIV696xHGY3F35RC+v2S0PNnxW/If7wMVr310KDQjvREKy30qgwj74Ld1VIoUlzxxcb6U
	X8GtPYmrW8kuWScU4XpHe004klCUsff/h6SR7Iekv9OzSEGaTRSe3g9jRbp7X+ShCqfegy8iiMosG
	lkey1yOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37426)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlT8a-000000000BS-2Vfn;
	Thu, 29 Jan 2026 14:36:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlT8Y-0000000083Z-3wB7;
	Thu, 29 Jan 2026 14:36:46 +0000
Date: Thu, 29 Jan 2026 14:36:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vinod Koul <vkoul@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, neil.armstrong@linaro.org,
	Simon Horman <horms@kernel.org>, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
Message-ID: <aXtwfj1vqB1cXKFM@shell.armlinux.org.uk>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org>
 <aXsuRTZUUnw0kdzV@horms.kernel.org>
 <CAKfTPtDfnpzq2CB-isVzvh1ZCWo7kit9KRJvVGoU1C3zZTgdXw@mail.gmail.com>
 <aXtfVUb0eLwP4R28@shell.armlinux.org.uk>
 <CAKfTPtCiJcNOdoddZN5N1dKHXfUJBe0=zeWfZ5uENoXDvbMnpQ@mail.gmail.com>
 <aXtl6eQ8zD_olTdc@shell.armlinux.org.uk>
 <aXtvDn_-pCuKPrnf@vaman>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXtvDn_-pCuKPrnf@vaman>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254824-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,armlinux.org.uk:email,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B63CB10EA
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:00:38PM +0530, Vinod Koul wrote:
> On 29-01-26, 13:51, Russell King (Oracle) wrote:
> > On Thu, Jan 29, 2026 at 02:36:01PM +0100, Vincent Guittot wrote:
> > > On Thu, 29 Jan 2026 at 14:23, Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 02:01:13PM +0100, Vincent Guittot wrote:
> > > > > yes, the usual pattern is :
> > > > > - phy_set_mode_ext()
> > > > > - then phy_power_on()
> > > > > but I can add an additional check
> > > >
> > > > Please read Documentation/driver-api/phy/phy.rst section "Order of API
> > > > calls" which suggests phy_set_mode_ext() after phy_power_on().
> > > 
> > > Fair enough.
> > > That being said, all pcie drivers  that use phy_set_mode_ext(), call
> > > it before phy_power_on()
> > 
> > It looks like many ethernet drivers do the same, so I think maybe the
> > generic PHY documentation is incorrect or misleading, or is expressing
> > a preference that almost no one follows. Something for the generic PHY
> > maintainers to look at and/or comment on.
> 
> I would feel it makes sense to configure the mode first and then power
> the phy up. As commented above yes it looks like apart from one tegra
> driver rest seem to do it this way.
> 
> Lets update the documentation

Please also indicate in the documentation whether changing the submode
of the serdes (particularly for ethernet) is permitted without doing a
phy_power_down()..phy_power_up() dance around the phy_set_mode_ext()
call.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

