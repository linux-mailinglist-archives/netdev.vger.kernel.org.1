Return-Path: <netdev+bounces-254681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFsOGD8xe2kVCQIAu9opvQ
	(envelope-from <netdev+bounces-254681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:06:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD2AE63C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B651300600C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340EC37D137;
	Thu, 29 Jan 2026 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VekGAvxE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4E288C96;
	Thu, 29 Jan 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681210; cv=none; b=iuAvveLOC30SH8jkcAPVY+Nnxxu72TTf00clwR6PQLXZd3TRiOIZRVfdhWnspj7wrBT2sfQvq3lLAwhpTKNFJ5yvYUq/tOq3+ssyQ1JlXSzhw1NvuXhZzw38crMKYgCB/epoJX93K7axL1KIeLP9pQ6lL1Qrik6Bkt7ySGUhTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681210; c=relaxed/simple;
	bh=cN09YzmR0fzVyRFg4rahUJrUZvvI9rD6MsO1W+gcUNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU630o6LE6wMmt97BSKwldlrFwzAsKqXYDJ85W7p2caL0Xr85CkKmiK0ZnUnYuqt3UqXVb9TgyN14JsvhVDv7GRsop0JHrW2sZ5OoNGgkYN8rpOj6upCY2fLphGxCnJHejcnA7slh1jxfT1u3gCX4PLvKq0MwEsTf7PuY8225j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VekGAvxE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=svkwx0NshCcsO+yR80vd0YBjeoCZtSBX4d8WP0yXRbs=; b=VekGAvxE8Eu1SIZkErp0iZrORG
	F3kNxW1P6fRlURSmd6uwxm3AP0P5XpcBv3UEisnzywYrxhZiTk8gFSr7c3IkNBCFA6BpCl4kymB33
	AQmEnQe8tg0mTamgSb2zQtWsDLbNUXYn6dS3OsF5GjjS6dR+39pihL+htKJNHNz3q98DxcIZra0qL
	ma/AdXOekcnB7OvZqjegN+SVAoF0vMuT5Gkrt4dhiOFr+2Lpx3VoOM8Ww8Y1HtHyHCCERaUXbP6Qi
	Nsb+RVnLhI/1jpFp8KI7jDfaIvYbUHWRsiTCaK+4hbn2KcZnIvZf/ULr/vgEkpAG5r/krixuXsi77
	lEKQoNBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57626)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlOv5-000000008Ob-08xQ;
	Thu, 29 Jan 2026 10:06:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlOuz-000000007rA-1giq;
	Thu, 29 Jan 2026 10:06:29 +0000
Date: Thu, 29 Jan 2026 10:06:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, florian.fainelli@broadcom.com,
	xiaolei.wang@windriver.com, Wei Fang <wei.fang@nxp.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, quic_abchauha@quicinc.com,
	quic_sarohasa@quicinc.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Message-ID: <aXsxJa0D0bohafRs@shell.armlinux.org.uk>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <20260128201501.04bb6e5c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128201501.04bb6e5c@kernel.org>
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
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,broadcom.com,windriver.com,nxp.com,davemloft.net,google.com,redhat.com,bootlin.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254681-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 83FD2AE63C
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 08:15:01PM -0800, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 18:44:09 +0800 Wei Fang wrote:
> > The commit bc66fa87d4fd ("net: phy: Add link between phy dev and mac
> > dev") has created a device link between the MAC and the PHY if the MAC
> > uses a shared MDIO bus (The MDIO and the MAC are two separate devices).
> > Sarosh Hasan tried to change the DL_FLAG_STATELESS flag to
> > DL_FLAG_AUTOREMOVE_SUPPLIER to fix the issue [1]. However, the solution
> > does not take into account the hot-swappable PHY devices (such as SFP).
> > so when the PHY device is unplugged, the MAC driver will automatically
> > be removed, which is not the expected behavior.
> > 
> > Therefore, to solve this issue of the shared MDIO bus, we create the
> > device link between the MAC device and the MDIO device, rather than
> > between the MAC device and the PHY device. And when the shared MDIO bus
> > is removed, all MAC drivers that depend on it will also be removed.
> 
> Anyone willing to venture a review tag?

No, I don't agrew with the patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

