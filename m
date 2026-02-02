Return-Path: <netdev+bounces-255973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCWdGFnmgGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:00:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090BCFDE7
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90C853003813
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43538B9B5;
	Mon,  2 Feb 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mnsGnWB0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DF1F09B3;
	Mon,  2 Feb 2026 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055251; cv=none; b=I0l0XDOZckT2PKSwVNmOj/YWdUiSESkyDwsCeyjw8tiK6NiXs/7weHwxPP5fJRYcvCBcm0tnm9SPbnij/tDoUomIqGrJjCMhEhd20/ivRBXL7uXAtd9oTv1B5lS2FBUFiyQxtSZ0eZDrMtOBTAFg7/kmleQybhZFwRf5X33WWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055251; c=relaxed/simple;
	bh=n+32tUg6O9xBgJs12jayYezBMjMC+1eYFOQZvUKfdEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEXNMlsyNVRKrsYPZq5vVrFWCQczuwAXqwSunp1TXeaZbNo0bHVxJRfNtOEUvUFNq4j6IfsKTS6vkzW22pcp4SGkgPmo+71dKo1IfmqO6494sXo6E+io6cZsFlZYf5CkY4FQbsVDwXJjdj/aXJjbqFA8e1hPYVgh1hN2gr/LGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mnsGnWB0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F9Pa8fGQcKdQAj56BjKT9x2u/Vm+Xm14aWdPy01eY2Y=; b=mnsGnWB0p3aNqcH65j+Qel+xYn
	g6K3dhtIFiS8DkUnbAnYbdZxbe6oRxkf3c65aYN2a5qBOu3m65Vi/p8K4oBZ8vr9Yx6Xr1x2DjRAs
	vTFZ9yLMh7jgr6YxeKYLFrpFNQDbbUa2MhMfGGqXoWfnzFeELA1mW4BbfgmydHtVMdxEfrqJSJLK8
	VSYw87GWpAyt54LJaEgvjiDecPObpf6Ql8JdudQrq55GA/Cro1o1Jj1GyDn2MA818e+rmk5HjptaE
	0AzIHFrw00NILdSQ+7UEpgv/AgVtQ6Sc+78ZwvNrULuxoL6pyScMXg8AMANuvbkxU2LAXS9MKEE3c
	IN9sgd3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57954)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vmyDx-000000004Ew-3OHr;
	Mon, 02 Feb 2026 18:00:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vmyDt-000000003a5-1CT8;
	Mon, 02 Feb 2026 18:00:29 +0000
Date: Mon, 2 Feb 2026 18:00:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, florian.fainelli@broadcom.com,
	xiaolei.wang@windriver.com, quic_abchauha@quicinc.com,
	quic_sarohasa@quicinc.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: phy: change devlink flag to
 AUTOREMOVE_SUPPLIER for non-SFP PHYs
Message-ID: <aYDmPUN5Z-eRWW2K@shell.armlinux.org.uk>
References: <20260202054533.539883-1-wei.fang@nxp.com>
 <267c78c1-4ad2-4f06-be63-0fb506c5134d@bootlin.com>
 <aYCzxVTTZvok9_d1@shell.armlinux.org.uk>
 <0689a2ab-352a-4275-9662-0c45daf8a0b2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0689a2ab-352a-4275-9662-0c45daf8a0b2@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255973-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,bootlin.com:email,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 7090BCFDE7
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:38:48PM +0100, Maxime Chevallier wrote:
> 
> 
> On 02/02/2026 15:25, Russell King (Oracle) wrote:
> > On Mon, Feb 02, 2026 at 12:10:41PM +0100, Maxime Chevallier wrote:
> >> Hi Wei,
> >>
> >> On 02/02/2026 06:45, Wei Fang wrote:
> >>> For the shared MDIO bus use case, multiple MACs will share the same MDIO
> >>> bus. Therefore, these MACs all depend on this MDIO bus. If this shared
> >>> MDIO bus is removed, all the PHY devices attached to this MDIO bus will
> >>> also be removed. Consequently, the MAC driver should not access the PHY
> >>> device, otherwise, it will lead to some potential crashes. Because the
> >>> corresponding phydev and the mii_bus have been freed, some pointers have
> >>> become invalid.
> >>>
> >>> For example. Abhishek reported a crash issue that occurred if the MDIO
> >>> bus driver was removed first, followed by the MAC driver. The crash log
> >>> is as below.
> >>>
> >>> Call trace:
> >>>  __list_del_entry_valid_or_report+0xa8/0xe0
> >>>  __device_link_del+0x40/0xf0
> >>>  device_link_put_kref+0xb4/0xc8
> >>>  device_link_del+0x38/0x58
> >>>  phy_detach+0x2c/0x170
> >>>  phy_disconnect+0x4c/0x70
> >>>  phylink_disconnect_phy+0x6c/0xc0 [phylink]
> >>>  stmmac_release+0x60/0x358 [stmmac]
> >>>
> >>> Another example is the i.MX95-15x15 platform which has two ENETC ports.
> >>> When all the external PHYs are managed the EMDIO (the MDIO controller),
> >>> if the enetc driver is removed after the EMDIO driver. Users will see
> >>> the below crash log and the console is hanged.
> >>>
> >>> Call trace:
> >>>  _phy_state_machine+0x230/0x36c (P)
> >>>  phy_stop+0x74/0x190
> >>>  phylink_stop+0x28/0xb8
> >>>  enetc_close+0x28/0x8c
> >>>  __dev_close_many+0xb4/0x1d8
> >>>  netif_close_many+0x8c/0x13c
> >>>  enetc4_pf_remove+0x2c/0x84
> >>>  pci_device_remove+0x44/0xe8
> >>>
> >>> To address this issue, Sarosh Hasan tried to change the devlink flag to
> >>> DL_FLAG_AUTOREMOVE_SUPPLIER [1], so that the MAC driver will be removed
> >>> along with the PHY driver. However, the solution does not take into
> >>> account the hot-swappable PHY devices (SFP PHYs), so when the PHY device
> >>> is unplugged, the MAC driver will automatically be removed, which is not
> >>> the expected behavior. This issue should not exist for SFP PHYs, so based
> >>> on the Sarosh's patch, the flag is changed to DL_FLAG_AUTOREMOVE_SUPPLIER
> >>> for non-SFP PHYs.
> >>>
> >>> Reported-by: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
> >>> Closes: https://lore.kernel.org/all/d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com/
> >>> Link: https://lore.kernel.org/imx/20250703090041.23137-1-quic_sarohasa@quicinc.com/ # [1]
> >>> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
> >>> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >>
> >> I gave that patch a test, with the following cases :
> >>
> >>  - On Macchiatobin (we have PHYs that share an mdiobus).
> >> When unbinding a PHY, the MAC dissapears as well :
> > 
> > Correct, this is why these band-aids are harmful. One "device" can
> > correspond with *multiple* network interfaces, and the loss of one
> > PHY can have a *very* detrimental effect.
> > 
> > Consider the case where root-NFS is being used, and removing a PHY
> > on another interface takes out the interface that root-NFS is
> > using. Your machine is now dead in the water.
> 
> That's what I've been seeing. I unbound one PHY, it took out 3 netdevs
> and I don't have log regarding "why". I guess there's devlink debug
> knobs for that, but not enabled by default it seems.

See what I said above. "One "device" can correspond with *multiple*
network interfaces".

On Armada 8040, one network "device" has multiple ports - they all
share the same packet infrastructure. Each port is a separate
interface in the kernel.

Consequently, the "struct device" is common across all ports on one
of the CP110 dies (there are two dies.) If one triggers an unbind
of that struct device, then you lose *all* ports on that CP110 die
whether or not the others _could_ remain functional.

Consider a DSA switch, which has external PHYs connected. Should
unbinding one port's PHYs take out the entire switch - and in the
case of multiple switches, cause the entire switch tree to be taken
out?

This is why devlinks is a bad idea. It's too heavy handed for cases
beyond the simple "one network device per struct device" model that
doesn't exist everywhere. For simple cases, yes, maybe, but not
where it means that taking out one minor part of the system destroys
the entire system because it chose to unbind a multi-interface device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

