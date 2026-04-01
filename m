Return-Path: <netdev+bounces-274149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDB1BJ42zWlwawYAu9opvQ
	(envelope-from <netdev+bounces-274149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:15:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA537CD64
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D57EF314BD22
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418235CBD6;
	Wed,  1 Apr 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yCQz9F5O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C12D8393
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055951; cv=none; b=D3e/6usJfgG5q7zq/r4jhHsKYTkV4tO8gTNDHSBt9W8CfaRv6lcwGBfFNgYMl3DLq1eej+TnwiPu14voZtRokxcABKY7JfR6eCV+DQ/vcCwcG3WaE8NyRMURGpbh7TFPvqat1sEzeieOocF1YohuPUc2MiZq3pkf6PFR24XqnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055951; c=relaxed/simple;
	bh=K47QYkFPRa4LBLpvz2j90GLJBZw76Ip8q8b98zq762Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY2+3d2hYm+6eJwMFEDS633N/09dzUt1OJ2f1Fo7TsBN0ugPry7acNutIGR1M/+TsGmFeyn7yp6wyQjgrZxixtyjqy4ZF0cphocjapMzsDvBBfvO4o7SjaLW2HuPPNp6YFySFvkXtVVZP4pRdOc5SUcCJPxN5I+8pHllvkysJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yCQz9F5O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Fd0lPt2RDH2WakZNw3VBaW4YCoeOwMD8IQTHdhWaQc=; b=yCQz9F5O/2oH7Lthszd0K8qPWG
	HaM/xlOlrCCCeDOxV6surFqMrhjB83QhzAeM0CL2PmCdD5zgIO541cMrqKxqx4SBtYQRPxqF6U2J+
	qMGNH359fotdm9c+JWIFkKfDaEYsKO88UqdI34+oi65buaJt3/m8YOLven/N/4dOddoa0UceS9NFt
	H078uccdZv58w1Q1e6YmYJw5KM2r5UKNl0YsI7ZIzGc+9LMpEodqH9VNufbSzdMvoY+rAKN+NOoXj
	qwDSHKLVMaFDPkJ/PtTAsgLLSLd6yQB2Oeh6qOivxRv/neCsHcbB+dn9qVXtkGhInMqDcios7W44F
	WZi1w8mg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53234)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7x8d-000000003Kz-2QJR;
	Wed, 01 Apr 2026 16:05:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7x8O-000000004sC-29sh;
	Wed, 01 Apr 2026 16:05:32 +0100
Date: Wed, 1 Apr 2026 16:05:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <ac00PIpzXPjxktzC@shell.armlinux.org.uk>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
 <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
 <48abd3e3-a3ee-4e85-a3d8-20c8ceedfb77@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48abd3e3-a3ee-4e85-a3d8-20c8ceedfb77@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-274149-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.501];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: D5FA537CD64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 03:11:24PM +0200, Andrew Lunn wrote:
> > Thanks Russell and Andrew. You're both heading in the same direction,
> > so to make sure I understand correctly:
> > 
> > 1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
> >    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
> >    enable) and phy_get_autonomous_eee(phydev) to query the current
> >    state.
> 
> In the end, we want the MAC driver using phylib to just call the
> phylib methods for configuring EEE, and the MAC driver should not care
> if EEE is actually implemented in the PHY or the MAC. The adjust_link
> callback would simply not enable LPI if the PHY is doing EEE.

This won't work.

If we mask out eee.tx_lpi_enabled when calling into phylib to tell
phylib drivers to disable SmartEEE (that's what I'm calling it here
because it's easier to type)), then phylib records that tx_lpi_enabled
was false. This then makes the following in phy_check_link_status():

                phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
                                        phydev->eee_active;

set phydev->enable_tx_lpi to false, which in turn tells the MAC
driver or phylink not to enable LPI. So, we lose the ability to use EEE
- a regression - because we're overloading tx_lpi_enabled to mean
"disable SmartEEE" at the PHY.

To work around this, we'd need to go back to the old days of EEE and
have each and every MAC driver resolve the EEE state themselves
because phylib's resolution will now always teoo the MAC driver to
disable LPI.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

