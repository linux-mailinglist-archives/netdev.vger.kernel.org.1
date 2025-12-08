Return-Path: <netdev+bounces-243985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B591CACCA0
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 126523097BB9
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244F8314B8C;
	Mon,  8 Dec 2025 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aHKBJXNG"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE6314A7B;
	Mon,  8 Dec 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765187698; cv=none; b=MhTShO7nVVOh2NGU/lImrseU9PL33trhIEVBL+WY3J+pmR4yuiBOm7MckrDas3/Up6XFifGfzi806erECTNFZNf9g4hEKDxxeVPAOZ2ZZD8Bbn1QWHwFFVfrruudF+I++X6huT4Om6ddPu+7gerAMpDrBOLJ+f5aN0/CpxkKTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765187698; c=relaxed/simple;
	bh=TMzvKUjgodkMI/IZsdxWqJWx8tpCFtuFGx/wZEf0WMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t04aAGLhzMYswjkIC7yIV/40jfFvOcbdEAO49sKG7J0mLInxgrmL7LHqxqGuPT6uSNvXvYAHuYMBuaPKv3C8+yxjpIQEf99fzJoFHiYR1c0NUc8nVDZWIJc3t3QrY5Hh9v1sx2K41742KH1//cqFKz8pVk0sGayeD5CiDmB5X4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aHKBJXNG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dPy506TPXz9tgH;
	Mon,  8 Dec 2025 10:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765187685; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7G99GFEMW7DWtZHSnN3HRGF1QQf6WJ1ZrDBEDIVJp0=;
	b=aHKBJXNGpYWOeiJgwFHbzfw7wUJbdv3VcMzmvLVrEK4gep2XlLpVg7yCd/90gwKZZ5n5RS
	F+umOOat8SyOvxu21T33ZGo29sBJn4TXD3OHiGEJLKRBuUSaHtSsN1nc/4DWcwn0A2QjGg
	vplng6abSSlkuPfe8VwsOR70FHeCoKpbuoSU/EmtGFIy6bpA8XluW5wp5I74BByCI4y+kT
	r2RHA+Y6AZeBCdGseYUgkWNrZO0PUnfXA5qEtS4poUJiZ0Grgm2zZP4szVJGofC0Sla8mD
	jWTWSPu02tNiPrpku4YbL7694v8+pBCFJUPOml27/JuV9vDrBl2rmM+40Ph5aw==
Message-ID: <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Philipp Stanner <phasta@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>
Cc: Yao Zi <ziyao@disroot.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Frank <Frank.Sae@motor-comm.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>, Chen-Yu Tsai
 <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>, Furong Xu
 <0x1207@gmail.com>,  linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Runhua
 He <hua@aosc.io>,  Xi Ruoyao <xry111@xry111.site>
Date: Mon, 08 Dec 2025 10:54:36 +0100
In-Reply-To: <20251205221629.GA3294018@bhelgaas>
References: <20251205221629.GA3294018@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 38cd42a6ba75c52707c
X-MBO-RS-META: yigmkee8jr5ynr5ts8zd7ndt5ycufme3

On Fri, 2025-12-05 at 16:16 -0600, Bjorn Helgaas wrote:
> [+to Philipp, Thomas for MSI devres question]
>=20
> On Fri, Dec 05, 2025 at 09:34:54AM +0000, Russell King (Oracle) wrote:
> > On Fri, Dec 05, 2025 at 05:31:34AM +0000, Yao Zi wrote:
> > > On Mon, Nov 24, 2025 at 07:06:12PM +0000, Russell King (Oracle) wrote=
:
> > > > On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:
> > > > > +static int motorcomm_setup_irq(struct pci_dev *pdev,
> > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct stmmac_resources =
*res,
> > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct plat_stmmacenet_d=
ata *plat)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret =3D pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
> > > > > +	if (ret > 0) {
> > > > > +		res->rx_irq[0]	=3D pci_irq_vector(pdev, 0);
> > > > > +		res->tx_irq[0]	=3D pci_irq_vector(pdev, 4);
> > > > > +		res->irq	=3D pci_irq_vector(pdev, 5);
> > > > > +
> > > > > +		plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > > > > +
> > > > > +		return 0;
> > > > > +	}
> > > > > +
> > > > > +	dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n", r=
et);
> > > > > +	dev_info(&pdev->dev, "try MSI instead\n");
> > > > > +
> > > > > +	ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> > > > > +	if (ret < 0)
> > > > > +		return dev_err_probe(&pdev->dev, ret,
> > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to allocate MSI\n");
> > > > > +
> > > > > +	res->irq =3D pci_irq_vector(pdev, 0);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int motorcomm_probe(struct pci_dev *pdev, const struct pc=
i_device_id *id)
> > > > > +{
> > > > ...
> > > > > +	ret =3D motorcomm_setup_irq(pdev, &res, plat);
> > > > > +	if (ret)
> > > > > +		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n")=
;
> > > > > +
> > > > > +	motorcomm_init(priv);
> > > > > +
> > > > > +	res.addr =3D priv->base + GMAC_OFFSET;
> > > > > +
> > > > > +	return stmmac_dvr_probe(&pdev->dev, plat, &res);
> > > >=20
> > > > If stmmac_dvr_probe() fails, then it will return an error code. Thi=
s
> > > > leaves the PCI MSI interrupt allocated...
> > >=20
> > > This isn't true. MSI API is a little magical: when the device is enab=
led

s/magical/confusing and explosive

;)

> > > through pcim_enable_device(), the device becomes devres-managed, and
> > > a plain call to pci_alloc_irq_vectors() becomes managed, too, even if
> > > its name doesn't indicate it's a devres-managed API.

Just to be clear: Callers of pci_setup_msi_context() are the last users
in PCI which express this strange behavior. All the other APIs behave
as one could expect from their name (pcim_ vs pci_).

> > >=20
> > > pci_free_irq_vectors() will be automatically called on driver deattac=
h.
> > > See pcim_setup_msi_release() in drivers/pci/msi/msi.c, which is invok=
ed
> > > by pci_alloc_irq_vectors() internally.

Yes, this is correct.

> >=20
> > This looks very non-intuitive, and the documentation for
> > pci_alloc_irq_vectors() doesn't help:
> >=20
> > =C2=A0* Upon a successful allocation, the caller should use pci_irq_vec=
tor()
> > =C2=A0* to get the Linux IRQ number to be passed to request_threaded_ir=
q().
> > =C2=A0* The driver must call pci_free_irq_vectors() on cleanup.
> > =C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >=20
> > because if what you say is correct (and it looks like it is) then this
> > line is blatently incorrect.

True, this line is false. It should probably state "If you didn't
enable your PCI device with pcim_enable_device(), you must call
pci_free_irq_vectors() on cleanup."

I don't know whether calling pci_free_irq_vectors() is a bug (once
manually, once hidden by devres), though.

If it's not a bug, one could keep the docu that way or at least phrase
it in a way so that no additional users start relying on that hybrid
mechanism.

There is actually no reason anymore to call pcim_enable_device() at
all, other than that you get automatic device disablement.

> >=20
> > Bjorn?

BTW, if PCI has a TODO list somewhere, removing that hybrid devres
feature for MSI should be on it, for obvious reasons.

The good news is that it's the last remainder of PCI hybrid devres and
getting rid of it would allow for removal of some additional code, too
(e.g., is_enabled bit and pcim_pin_device()).

The bad news is that it's not super trivial to remove. I looked into it
about two times and decided I can't invest that time currently. You
need to go over all drivers again to see who uses pcim_enable_device(),
then add free_irq_vecs() for them all and so on=E2=80=A6

If you give me a pointer I can provide a TODO entry. In any case, feel
free to set me as a reviewer!

Regards
Philipp

