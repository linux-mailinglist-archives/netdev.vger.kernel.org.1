Return-Path: <netdev+bounces-57018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B87D81198D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86C7282061
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572F35EFC;
	Wed, 13 Dec 2023 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F9FacYpA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9E91;
	Wed, 13 Dec 2023 08:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N/E28jRK/viDvwysZ67eINh1B/xnv1AANrAAo+m468A=; b=F9FacYpAvC8VBP83kNMIpHTuVL
	StsEhcooImqRL0oa7xdnDBllK6KkpkYTk4gTnuRIertAdiNTHp46DxpNDNkPXUyY+qmdUNEk+D1SA
	Y6EeaRQWlHQl0ztEkl4ENZhDEj2QYIJeIWfrxOu0/3+b4418i6lBBlF44tHLDS/PHuAaewGCrZFZO
	e/l1KFXkDC9rYxkwhe7qw3Vq8NOoXmrGZmZZxGEaWXG7UPAXtkBRH71zg7IecLdbT96sUJqvLbBTh
	bSZIRZgFS8fOdfUo0i+S0ewDHQU3lMDUgcCJ3dOOtUMa5WJS93cn8lz7MuT+uBAgeA26m9zUfusQ+
	Q5lacQ0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59474)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDS9o-0000HK-1N;
	Wed, 13 Dec 2023 16:32:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDS9l-0001eT-VG; Wed, 13 Dec 2023 16:32:21 +0000
Date: Wed, 13 Dec 2023 16:32:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <ZXnclVEz10K2XD2+@shell.armlinux.org.uk>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8pxM3RvyHJTwqH@shell.armlinux.org.uk>
 <gbkgtb4yp3cwyw7xcuhmkdl3io2wlia2gska2xmjbwjvhigpz3@w52b6tdyugqo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbkgtb4yp3cwyw7xcuhmkdl3io2wlia2gska2xmjbwjvhigpz3@w52b6tdyugqo>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 13, 2023 at 03:01:45AM +0300, Serge Semin wrote:
> On Tue, Dec 05, 2023 at 01:46:44PM +0000, Russell King (Oracle) wrote:
> > xpcs_create_mdiodev() as it originally stood creates the mdiodev from
> > the bus/address, and then passes that to xpcs_create(). Once
> > xpcs_create() has finished its work (irrespective of whether it was
> > successful or not) we're done with the mdiodev in this function, so
> > the reference is _always_ put.
> 
> You say that it's required to manage the refcounting twice: when we
> get the reference from some external place and internally when the
> reference is stored in the XPCS descriptor. What's the point in such
> redundancy with the internal ref-counting if we know that the pointer
> can be safely stored and utilized afterwards? Better maintainability?
> Is it due to having the object retrieval and storing implemented in
> different functions?

The point is that the error handling gets simpler:
- One can see in xpcs_create_mdiodev() that the reference taken by
  mdio_device_create() is always dropped if that function was
  successful, irrespective of whether xpcs_create() was successful.

- xpcs_create() is responsible for managing the refcount on the mdiodev
  that is passed to it - and if it's successful, it needs to increment
  the refcount, or leave it in the same state as it was on entry if
  failing.

This avoids complexities in error paths, which are notorious for things
being forgotten - since with this, each of these functions is resposible
for managing its refcount.

It's a different style of refcount management, one I think more people
should adopt.

> While at it if you happen to know an answer could you please also
> clarify the next question. None of the ordinary
> platform/PCI/USB/hwmon/etc drivers I've been working with managed
> refcounting on storing a passed to probe() device pointer in the
> private driver data. Is it wrong not doing that?

If we wanted to do refcounting strictly, then every time a new
pointer to a data structure is created, we should be taking a refcount
on it, and each time that pointer is destroyed, we should be putting
the refcount. That is what refcounting is all about.

However, there are circumstances where this can be done lazily, and
for drivers we would prefer driver authors not to end up with
refcount errors where they've forgotten to put something.

In the specific case of drivers, we have a well defined lifetime for
a device bound to a driver. We guarantee that the struct device will
not go away if a driver is bound to the device, until such time that
the driver's .remove method has been called. Thus, we guarantee that
the device driver will be notified of the struct device going away
before it has been freed. This frees the driver author from having
to worry about the refcount of the struct device.

As soon as we start doing stuff that is outside of that model, then
objects that are refcounted need to be dealt with, and I much prefer
the "strict" refcounting implementation such as the one I added to
xpcs, because IMHO it's much easier to see that the flow is obviously
correct - even if it does need a comment to describe why we always
do a put.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

