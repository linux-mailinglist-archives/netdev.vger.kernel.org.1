Return-Path: <netdev+bounces-171027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C282A4B302
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 17:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169C41893C1B
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19531E9B29;
	Sun,  2 Mar 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G80g2gHm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97971E9B1A;
	Sun,  2 Mar 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932059; cv=none; b=SG3pOfTgIIO9OygqGeRDJ9aEAIKFGfUgukEsm/BCSSk+Anb4aGBbENuyCwi/o6v0qsi3doPuduqnfHkGCaxPo98gEfnUZminKQmsSPtn0TruOlu2tcJ8XSE5BJlygBmiGUb7J/I2ibyoqgRmtATdi31S2BM0/iE+jddevNp5HOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932059; c=relaxed/simple;
	bh=oxdHfYnR3WT0kdh9JqWocNJzCnrGPK7WPN31unxi4Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSCFA+2+emxMCzp6hBxLWAw6PNU8knECVcYXrtxoAau15wMY71lLkLcsHwWRgBVU/lMrfnZwCZWIi/rC9VOlvlEBJt0K/Cnp31+mwKsX0c7u5E0odFj+Ob945Cgv6fDuiEkIpgEaGItgaBT3yB/yYkecF+XC0ualDRwMiJb7Gkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G80g2gHm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+EEHHNKC7qnukuM0E3MdN9IeORIinbgYYPYrhGC8Q5A=; b=G8
	0g2gHmzJXHxsPgc/TCzQPVOUWge4g3qPw7PvPwmyqNelMNt9FhOURO2BwwBibYY6Wavd9NuOkrtBp
	DtG4YrCNj8AHmn+aif6O+vE5o6eyJkMuM70UrN/dKSOr3eyearHbFhYPf+4ivFHcmmeybainm4KLH
	lCgr3nj7jawHEkQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tolwp-001Y9j-WA; Sun, 02 Mar 2025 17:13:48 +0100
Date: Sun, 2 Mar 2025 17:13:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Link flap workaround option
 for false IRP events
Message-ID: <698700ab-fd36-4a09-8457-a356d92f00ea@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
 <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
 <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>
 <4b5b0f52-7ed8-7eef-2467-fa59ca5de937@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b5b0f52-7ed8-7eef-2467-fa59ca5de937@intel.com>

On Sun, Mar 02, 2025 at 03:09:35PM +0200, Lifshits, Vitaly wrote:
> 
> 
> Hi Mark,
> 
> > Hi Andrew
> > 
> > On Thu, Feb 27, 2025, at 11:07 AM, Andrew Lunn wrote:
> > > > > > +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);
> > > > > 
> > > > > Please add some #define for these magic numbers, so we have some idea
> > > > > what PHY register you are actually reading. That in itself might help
> > > > > explain how the workaround actually works.
> > > > > 
> > > > 
> > > > I don't know what this register does I'm afraid - that's Intel knowledge and has not been shared.
> > > 
> > > What PHY is it? Often it is just a COTS PHY, and the datasheet might
> > > be available.
> > > 
> > > Given your setup description, pause seems like the obvious thing to
> > > check. When trying to debug this, did you look at pause settings?
> > > Knowing what this register is might also point towards pause, or
> > > something totally different.
> > > 
> > > 	Andrew
> > 
> > For the PHY - do you know a way of determining this easily? I can reach out to the platform team but that will take some time. I'm not seeing anything in the kernel logs, but if there's a recommended way of confirming that would be appreciated.
> 
> The PHY is I219 PHY.
> The datasheet is indeed accessible to the public:
> https://cdrdv2-public.intel.com/612523/ethernet-connection-i219-datasheet.pdf

Thanks for the link.

So it is reading page 772, register 26. Page 772 is all about LPI. So
we can have a #define for that. Register 26 is Memories Power. So we
can also have an #define for that.

However, that does not really help explain how this helps prevent an
interrupt. I assume playing with EEE settings was also played
with. Not that is register appears to have anything to do with EEE!

> Reading this register was suggested for debug purposes to understand if
> there is some misconfiguration. We did not find any misconfiguration.
> The issue as we discovered was a link status change interrupt caused the
> CSME to reset the adapter causing the link flap.
> 
> We were unable to determine what causes the link status change interrupt in
> the first place. As stated in the comment, it was only ever observed on
> Lenovo P5/P7systems and we couldn't ever reproduce on other systems. The
> reproduction in our lab was on a P5 system as well.
> 
> 
> Regarding the suggested workaround, there isn’t a clear understanding why it
> works. We suspect that reading a PHY register is probably prevents the CSME
> from resetting the PHY when it handles the LSC interrupt it gets. However,
> it can also be a matter of slight timing variations.

I don't follow what you are saying here. As far as i can see, the
interrupt handler will triggers a read of the BMCR to determine the
link status. It should not matter if there is a spurious interrupt,
the BMCR should report the truth. So does BMCR actually indicate the
link did go down? I also see there is the usual misunderstanding with
how BMCR is latching. It should not be read twice, processed once, it
should be processed each time, otherwise you miss quick link down/up
events.

> We communicated that this solution is not likely to be accepted to the
> kernel as is, and the initial responses on the mailing list demonstrate the
> pushback.

What it has done is start a discussion towards an acceptable
solution. Which is a good thing. But at the moment, the discussion
does not have sufficient details.

Please could somebody describe the chain of events which results in
the link down, and subsequent link up. Is the interrupt spurious, or
does BMCR really indicate the link went down and up again?

> On a different topic, I suggest removing the part of the comment below:
> * Intel unable to determine root cause.
> The issue went through joint debug by Intel and Lenovo, and no obvious spec
> violations by either party were found. There doesn’t seem to be value in
> including this information in the comments of upstream code.

I partially agree. Assuming the root cause is not found, and a
workaround is used, i expect a commit message with a detailed
description of the chain of events which results in the link
flap. Then a statement that the root cause is unknown, and lastly the
commit message should say the introduced change, for unknown reasons,
solves the issue, and is considered safe because.... Ideally the
workaround should be safe for everybody, and can be just enabled.

	Andrew

