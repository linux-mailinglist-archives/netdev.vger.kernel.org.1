Return-Path: <netdev+bounces-243993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E39CACE93
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A444F303DD14
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC782D24B7;
	Mon,  8 Dec 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qUIvIm5W"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335F23183B;
	Mon,  8 Dec 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765190858; cv=none; b=SSwGNvo4k5qvQ25qkaoWZ+kPeiNo71/MpUw+vmr2875Yd+Y0+NxO10VqNZ/20QeY+zdvi29eacFPiAj2OneKx7+rMhqJWTUZUA+9E+UFGl1dIkzjds2KzjoYXTcwCwS3tGx9Oq/abmuDbQsPXPQE3pRNK3rIFK/hzGqmEcCst0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765190858; c=relaxed/simple;
	bh=WzbXPEAcQPTmLJy41cM0M99eeBpuSZa2bekf2ctOUAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mam1GBRgFcCSVNTSwfh0YwgvGsl/HMt2C176eJwonNN69RUQuibvYX9jA1odpwNcXqnfwVW+oIVHE28b8r74B1lJh0w9DoGe/JjBUNb/2kIw5nywjDpYXWiiHI4xyDTv/2zNX8d0bu4ZW/gbrHs8xMjQ59Lgr8+ptvWfAVTM8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qUIvIm5W; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dPzFv3jPyz9tS3;
	Mon,  8 Dec 2025 11:47:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765190851; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikrPw0q82LvUmD4VSYFk9Xq5eibrnKKXcb1J19zdzkY=;
	b=qUIvIm5WcatFrSOOLbrNh831FMBEzblAlXdzV8nb9MumI3Hhy/e8UruBkoqUkQRmokRP50
	21ZKojCz5pDpXqopDsdLwauWGgK2usp6ZWNPu2RWuexvmXVkoiNrI3ivxFj/KP+eie1hhE
	ujyNVkV81coJiZHcCQ4RmuCGd95Ch2mxBFbcB1M+UsL0ZzLGEtjpArnlepmbUdAd4YdL8c
	9JSjP5g4CYBDD/XlFd2tb7iKEpQIK1q8jKVxVERbmIG6h0VtuiXM2HVfedjFoQWdN2xPJ3
	lAQ7NrHpyyL4fIM5L1oyh1UqF58vLQ8qhkWHJZ7yEcC4RSDGdX8G2xJiPtFzGA==
Message-ID: <7e024db2557a4d5822a0dd409ae678d10d815d9c.camel@mailbox.org>
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
Date: Mon, 08 Dec 2025 11:47:23 +0100
In-Reply-To: <aTalXy_85pvLraIy@shell.armlinux.org.uk>
References: <20251205221629.GA3294018@bhelgaas>
	 <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
	 <aTalXy_85pvLraIy@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1c50ea5d21e4466c377
X-MBO-RS-META: jc8gdnan86sbupzmxwfst4jquqm7a3k7

On Mon, 2025-12-08 at 10:15 +0000, Russell King (Oracle) wrote:
> On Mon, Dec 08, 2025 at 10:54:36AM +0100, Philipp Stanner wrote:
> > The bad news is that it's not super trivial to remove. I looked into it
> > about two times and decided I can't invest that time currently. You
> > need to go over all drivers again to see who uses pcim_enable_device(),
> > then add free_irq_vecs() for them all and so on=E2=80=A6
>=20
> So that I can confirm, you're saying that all drivers that call
> pci_alloc_irq_vectors() should call pci_free_irq_vectors() in their
> ->remove() method and not rely on the devres behaviour that
> pcim_enable_device() will permit.

"permit" is kind of a generous word. This behavior is dangerous and
there were bugs because of that in the past, because it confused
programmers. See:

f00059b4c1b0 drm/vboxvideo: fix mapping leaks


pcim_enable_device() used to switch all sorts of functions into managed
mode. As far as I could figure out through git, back in 2009 it was
intended that ALL pci functions are switched into managed mode that
way. That's also how it was documented.

The ecosystem then fractured, however. Some functions were always
managed (pcim_), some never, and some sometimes.

I removed all "sometimes managed" functions since 2024. The last
remainder is MSI.

If we want to remove that, we need to:
   1. Find all drivers that rely on pci_free_irq_vectors() being run
      automatically. IOW those that use pcim_enable_device() + wrappers
      around pci_setup_msi_context().
   2. Port those drivers to do the free_irq_vecs manually, if it's not
      a problem if it's called twice. If that were a problem, those
      drivers would also need to replace pcim_enable_device() with
      pci_enable_device().
   3. Once all drivers are ported, remove the devres code from msi.c
   4. Do associated cleanup work in PCI.

>=20
> In terms of whether it's safe to call this twice, pci_free_irq_vectors()
> calls pci_disable_msix() and pci_disable_msi().
>=20
> pci_disable_msix() checks:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pci_msi_enabled() || !dev=
 || !dev->msix_enabled)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>=20
> which will set dev->msix_enabled to 0 via pci_msix_shutdown().
>=20
> pci_disable_msi() does a similar check:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pci_msi_enabled() || !dev=
 || !dev->msi_enabled)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>=20
> and similarly pci_msi_shutdown() sets dev->msi_enabled to 0.
>=20
> So my conclusion is it's safe to call pci_free_irq_vectors() twice for
> the same device.
>=20

Hm. Looks good.


P.

