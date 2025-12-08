Return-Path: <netdev+bounces-243995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1AFCACED8
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15F8B300806B
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2E3016F8;
	Mon,  8 Dec 2025 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rsCzR1Zj"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95712D94B2;
	Mon,  8 Dec 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191338; cv=none; b=WHMoVG965ztQkil1RsvGIofsOBFqz+ayDpq+iuDM5Y+55KOnHkW0srRsJ0xQU4nB3DOrh1LzMiPhgH9ysxN8u9wi9R32NuGF1RIm0+S9nAUINaSCFz2DfkkP8wlbiQ8+0R6iTb9CPhHXuhQyXhVv57BUwrBp7QpTDzQWoekpIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191338; c=relaxed/simple;
	bh=e8HDt7e1hWwIm5+Z/p5sZYLoVUkftBAvfj3ShE0jJmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FkrpmSUzGcwPnGIIibR+7ZuQPKsvd0qzWnq2CSOM5lTyfeBJTYQVhXHRG22dwD5f3FGNrmQpeFPd6jyMOp0e+SBKEz2O3aQtOxY7MuItQU9PT4KghogNIxALJYjc++xrO4x4Zujg1jz5YPwr+6qdvrszYxa4zOi5NEH2aArhjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rsCzR1Zj; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dPzR35QRkz9sZv;
	Mon,  8 Dec 2025 11:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765191327; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8HDt7e1hWwIm5+Z/p5sZYLoVUkftBAvfj3ShE0jJmo=;
	b=rsCzR1ZjVhCZjSoJy0y6O5hJR2YqEz9Pv7UfzUu32N3HgElO5PdZ4QnMBmOW/zJTiJ70JP
	/7f3vHpOahZI5b9Qj7m1qdh024Drg7XtEEmhd7N02JTuqCdk1QCb/FaoAU24O4PoslQRAC
	sPie8XQqdR6FOF/DU65Fmf75G3PMrQ8ePoeTyswzQQRRjCh9SSWh/ZYOwQIhwbOSQrDPfb
	Z0gEiLmGkQuhOp5vFGs56Q7olY32r8eh2zcBQv06aPRJ4i3wPsJuyPY4YsRrEKz5xEtEB+
	cH6pNbhY2a+v3dzpyEu8xY57LfdaMzTip2O9691wJmwn2bSGQ0Oc6r2sVQLqwg==
Message-ID: <de15e1320f4ad6253c0db1178d8865b84899b097.camel@mailbox.org>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, phasta@kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,  Yao Zi <ziyao@disroot.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Frank
 <Frank.Sae@motor-comm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Chen-Yu Tsai <wens@csie.org>, Jisheng
 Zhang <jszhang@kernel.org>, Furong Xu <0x1207@gmail.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Mingcong Bai
 <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He
 <hua@aosc.io>,  Xi Ruoyao <xry111@xry111.site>
Date: Mon, 08 Dec 2025 11:55:19 +0100
In-Reply-To: <aTauNWvRKhn-muir@shell.armlinux.org.uk>
References: <20251205221629.GA3294018@bhelgaas>
	 <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
	 <aTalXy_85pvLraIy@shell.armlinux.org.uk>
	 <7e024db2557a4d5822a0dd409ae678d10d815d9c.camel@mailbox.org>
	 <aTauNWvRKhn-muir@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 3h5ibo9d7ow88xwyuc3eeu8zcncfw59q
X-MBO-RS-ID: 44bd187b0db683f0900

On Mon, 2025-12-08 at 10:53 +0000, Russell King (Oracle) wrote:
> On Mon, Dec 08, 2025 at 11:47:23AM +0100, Philipp Stanner wrote:
> > On Mon, 2025-12-08 at 10:15 +0000, Russell King (Oracle) wrote:
> > > On Mon, Dec 08, 2025 at 10:54:36AM +0100, Philipp Stanner wrote:
> > > > The bad news is that it's not super trivial to remove. I looked int=
o it
> > > > about two times and decided I can't invest that time currently. You
> > > > need to go over all drivers again to see who uses pcim_enable_devic=
e(),
> > > > then add free_irq_vecs() for them all and so on=E2=80=A6
> > >=20
> > > So that I can confirm, you're saying that all drivers that call
> > > pci_alloc_irq_vectors() should call pci_free_irq_vectors() in their
> > > ->remove() method and not rely on the devres behaviour that
> > > pcim_enable_device() will permit.
> >=20
> > "permit" is kind of a generous word. This behavior is dangerous and
> > there were bugs because of that in the past, because it confused
> > programmers. See:
> >=20
> > f00059b4c1b0 drm/vboxvideo: fix mapping leaks
> >=20
> >=20
> > pcim_enable_device() used to switch all sorts of functions into managed
> > mode. As far as I could figure out through git, back in 2009 it was
> > intended that ALL pci functions are switched into managed mode that
> > way. That's also how it was documented.
> >=20
> > The ecosystem then fractured, however. Some functions were always
> > managed (pcim_), some never, and some sometimes.
> >=20
> > I removed all "sometimes managed" functions since 2024. The last
> > remainder is MSI.
> >=20
> > If we want to remove that, we need to:
> > =C2=A0=C2=A0 1. Find all drivers that rely on pci_free_irq_vectors() be=
ing run
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 automatically. IOW those that use pcim_e=
nable_device() + wrappers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 around pci_setup_msi_context().
> > =C2=A0=C2=A0 2. Port those drivers to do the free_irq_vecs manually, if=
 it's not
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a problem if it's called twice. If that =
were a problem, those
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers would also need to replace pcim_=
enable_device() with
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_enable_device().
> > =C2=A0=C2=A0 3. Once all drivers are ported, remove the devres code fro=
m msi.c
> > =C2=A0=C2=A0 4. Do associated cleanup work in PCI.
> >=20
> > >=20
> > > In terms of whether it's safe to call this twice, pci_free_irq_vector=
s()
> > > calls pci_disable_msix() and pci_disable_msi().
> > >=20
> > > pci_disable_msix() checks:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pci_msi_enabled() || =
!dev || !dev->msix_enabled)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > >=20
> > > which will set dev->msix_enabled to 0 via pci_msix_shutdown().
> > >=20
> > > pci_disable_msi() does a similar check:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pci_msi_enabled() || =
!dev || !dev->msi_enabled)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > >=20
> > > and similarly pci_msi_shutdown() sets dev->msi_enabled to 0.
> > >=20
> > > So my conclusion is it's safe to call pci_free_irq_vectors() twice fo=
r
> > > the same device.
> > >=20
> >=20
> > Hm. Looks good.
>=20
> So, what do you want to see for new drivers such as the one at the top
> of this thread? Should they explicitly call pci_free_irq_vectors() even
> though they call pcim_enable_device() ?


Yes, I think that's the right thing to do. It makes removing that
feature from MSI easier, since there will not be even more drivers to
port.

P.

