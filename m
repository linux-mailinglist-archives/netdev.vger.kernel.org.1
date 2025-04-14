Return-Path: <netdev+bounces-182276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DAA885E6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8E17AA2F6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6825229A;
	Mon, 14 Apr 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FdCde/YX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131742DFA2C
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642519; cv=none; b=ZbQNrKeTb0bVgzAzOCel7+7JkoxMNfpTXwtX8OFHzCTug4V9JOk9hyGiaAPOh+7PViIiNyBaE4VgE/CcSYzoXhBZpYjVm5CWWaKEmUAzDZZXiR4TCjpSKQnDdGHCFe2UcUF27STVYYDW0Fj1/m35SoMaehdUuD2Z7oJlzmzJrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642519; c=relaxed/simple;
	bh=5OYy29gSdyugGov6QiCC31lAMh53v/pvjU6ZlZ9EF68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zoz7FP+iKNRrAjpwYweirYEJSKrX8yNaTdXZi/71jMnRVioc85VBjZTbWz5aVNvZbm3xKwsz7/bRZ/otA6n938cSDaW+STHobLeHSGuCy3cKC5veAur5viBoWgRWJvRA3lK3UEroZTQV8OlrIShtQwenwbllzDdJ7feZgzlXPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FdCde/YX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=skoI0eJIQuNaRmSkZF1voV6TiQl0glKj//2IJMmXzFI=; b=FdCde/YX5DQfJgBUhs9QBMIEE2
	OKUz+CLt7ylhdAFahXunvSOsE9L8ep8U6Oxa3aACPhw9X1hDCapDlxLJpBWbDPTtxmHdzpYz3uaNc
	7TOMQj9xrn1jUb2/E7O1BfOJN+79E1ps6Ilf9PXsGa9HqGvmErhWQZVwzoOir4oBp9fK5fKYIf6sE
	q+mqfNM/j61QQnwpRrm1AzpHOl+eidxkQeon88rgMTca4ODvUti7msqMePg+7u9mCqHImxCTe1GIk
	KEfB8dOO63yBRT91B7UzkF3XduHdlnZjUSql110BUTVD8UH/QsZsyHxQOm/MdXU/0jdut9TwbjT8S
	d6JshC/g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54284)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4LDL-0006jm-2n;
	Mon, 14 Apr 2025 15:55:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4LDJ-0007qO-36;
	Mon, 14 Apr 2025 15:55:09 +0100
Date: Mon, 14 Apr 2025 15:55:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <Z_0hzd7Bl6ECzyBB@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
 <20250414164314.033a74d2@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414164314.033a74d2@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 14, 2025 at 04:43:14PM +0200, Kory Maincent wrote:
> On Fri, 11 Apr 2025 22:26:42 +0100
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Add PTP basic support for Marvell 88E151x single port PHYs.  These
> > PHYs support timestamping the egress and ingress of packets, but does
> > not support any packet modification, nor do we support any filtering
> > beyond selecting packets that the hardware recognises as PTP/802.1AS.
> > 
> > The PHYs support hardware pins for providing an external clock for the
> > TAI counter, and a separate pin that can be used for event capture or
> > generation of a trigger (either a pulse or periodic). Only event
> > capture is supported.
> > 
> > We currently use a delayed work to poll for the timestamps which is
> > far from ideal, but we also provide a function that can be called from
> > an interrupt handler - which would be good to tie into the main Marvell
> > PHY driver.
> > 
> > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > drivers. The hardware is very similar to the implementation found in
> > the 88E6xxx DSA driver, but the access methods are very different,
> > although it may be possible to create a library that both can use
> > along with accessor functions.
> 
> It seems a lot less stable than the first version of the driver.
> 
> Lots of overrun:
> ptp4l[949.894]: port 1 (eth0): assuming the grand master role
> [  954.899275] Marvell 88E1510 ff0d0000.ethernet-ffffffff:01: tx timestamp overrun (stat=0x5 seq=0)
> [  954.908670] Marvell 88E1510 ff0d0000.ethernet-ffffffff:01: rx timestamp overrun (q=1 stat=0x5 seq=0)

I've explained why this happens - it will occur if timestamping has
been enabled but there's been no packets to be stamped for a while
but there _have_ been packets on the network that the hardware
decided to stamp. There is no way around this because the driver isn't
told when to shutdown timestamping.

> PTP L2 in master mode is not working at all maybe because there is no
> configuration of PTP global config 1 register.

No, sorry, wrong. There is, and you haven't read what I've written
previously if you're still thinking this.

Look in "ptp: marvell: add core support for Marvell PTP v2.1".

Look at marvell_tai_global_config(). (I've explained why it's there.)

Look at:

+       /* MsdIDTSEn - Enable timestamping on all PTP MessageIDs */
+       err = tai->ops->ptp_global_write(tai->dev, PTPG_CONFIG_1,
+                                        MV_PTP_MSD_ID_TS_EN);

> Faced also a case where it has really high offsets and I need to reboot the
> board to see precise synchronization again:
> ptp4l[4649.618]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
> ptp4l[4652.519]: master offset 7650600217 s0 freq +32767998 path delay -33923681843
> ptp4l[4653.487]: master offset 7617827584 s1 freq      +6 path delay -33923681843
> ptp4l[4654.454]: master offset     -27201 s2 freq  -27195 path delay -33923681843
> ptp4l[4654.454]: port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
> ptp4l[4655.422]: master offset 33926879673 s2 freq +32767999 path delay -67850561538
> ptp4l[4656.389]: master offset 33649307442 s2 freq +32767999 path delay -67605734496
> ptp4l[4657.356]: master offset 33454635535 s2 freq +32767999 path delay -67443834753

I don't see that, I get way smaller offsets with this when using the
ZII rev B platform as the master.

> The PTP set as master mode seems really buggy.

That's something I didn't test, but as the hardware is symmetrical (there
aren't separate settings for PTP MSGIDs that get stamped on the transmit
and receive paths) I'm not sure what's going on. If one enables
timestamping for MSG ID 0 (Sync) then the hardware will stamp packets
received and transmitted that have a PTP MSG ID 0.

In any case, I can't do any testing now, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

