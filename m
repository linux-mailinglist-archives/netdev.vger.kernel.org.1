Return-Path: <netdev+bounces-244397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B548CB63DF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85598300A1F2
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E694423F439;
	Thu, 11 Dec 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lorCRtaB"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8A220F37;
	Thu, 11 Dec 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765464318; cv=none; b=oOTutW/yFCvLgTkNpG6YfToGLLDBPcUhixbybtgNQQvbpKV21u3MT4q7rIGc888s3p+Wka6lRdid1DuV7BqqvajUv0BfkuJoCEDAOl07NYKamCSEsOeJYBI0fHAgb0mqthRVjIbmyWUPPmY0G57nH8gJdPPo0eO+hQduwLdNjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765464318; c=relaxed/simple;
	bh=Rn5ctt9toG1dhvX7KH2XC7syM1SfFxKIrbnE7/2XRkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U52PM0bxdw4oXSaCQup0e8Wb38TltJ5ySOdHU1KULWNowWd3VS6xoX3GLDhiAANM4WOFG9W/2lYMflUR6mJIA6AdHJRZIdE5/Qc/6lPXXEkR37i03Y6SLds6puS/fqMqxtoPMkFEhSY5VySZj4sUjbJzH4Xas8oUOfqzsx+eMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lorCRtaB; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dRwNg13KYz9spF;
	Thu, 11 Dec 2025 15:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765464307; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rn5ctt9toG1dhvX7KH2XC7syM1SfFxKIrbnE7/2XRkw=;
	b=lorCRtaB+hEfb5/FCHWF1mrQrWbp0b0l8qOGJMF6812UTQp4gPV0SlUBeJOX/MvFqrqc1m
	p6zNHUWDuisYFJMJNVJyH3WLyLXZY7nfK7NQnlRnNFF9lImT27f0iQXISkz09QMyPE/nJB
	bLfgM4wW3U4EyWMPYjsxP+d6Rig7T+XKrCjgjefGs/jVr4dLWRpa9oPyPaLqFWOx6w3mNM
	dKsJcRI+1aPpxXhNvkYqwFd0APxkjTQ3RqPbD09Sjd07GWUO4rt00k11fBCN5xU0XuU+kL
	WRcy9FPJ2oyEyCGbssUgPqt6mQfcMXJ7LLNHi68qmZF0oXw8bJweSbFtylDOqw==
Message-ID: <130064e95124f32a40618620450016bec0a96ffd.camel@mailbox.org>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Yao Zi <me@ziyao.cc>, phasta@kernel.org, Bjorn Helgaas
 <helgaas@kernel.org>,  "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Frank <Frank.Sae@motor-comm.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>, Chen-Yu Tsai
 <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>, Furong Xu
 <0x1207@gmail.com>,  linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Runhua
 He <hua@aosc.io>,  Xi Ruoyao <xry111@xry111.site>
Date: Thu, 11 Dec 2025 15:44:57 +0100
In-Reply-To: <aTrT3rHhtXkSyPOO@pie>
References: <20251205221629.GA3294018@bhelgaas>
	 <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
	 <aTrT3rHhtXkSyPOO@pie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: e7cebc86a28cdecb066
X-MBO-RS-META: rzi1kojuuhsp3kmd1ynxcm1appakrfq9

On Thu, 2025-12-11 at 14:23 +0000, Yao Zi wrote:
> On Mon, Dec 08, 2025 at 10:54:36AM +0100, Philipp Stanner wrote:
> > On Fri, 2025-12-05 at 16:16 -0600, Bjorn Helgaas wrote:
> > > [+to Philipp, Thomas for MSI devres question]
> > >=20
> > > On Fri, Dec 05, 2025 at 09:34:54AM +0000, Russell King (Oracle) wrote=
:
> > > > On Fri, Dec 05, 2025 at 05:31:34AM +0000, Yao Zi wrote:
> > > > > On Mon, Nov 24, 2025 at 07:06:12PM +0000, Russell King (Oracle) w=
rote:
> > > > > > On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:
>=20
> ...
>=20
> > > > This looks very non-intuitive, and the documentation for
> > > > pci_alloc_irq_vectors() doesn't help:
> > > >=20
> > > > =C2=A0* Upon a successful allocation, the caller should use pci_irq=
_vector()
> > > > =C2=A0* to get the Linux IRQ number to be passed to request_threade=
d_irq().
> > > > =C2=A0* The driver must call pci_free_irq_vectors() on cleanup.
> > > > =C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
> > > >=20
> > > > because if what you say is correct (and it looks like it is) then t=
his
> > > > line is blatently incorrect.
> >=20
> > True, this line is false. It should probably state "If you didn't
> > enable your PCI device with pcim_enable_device(), you must call
> > pci_free_irq_vectors() on cleanup."
> >=20
> > If it's not a bug, one could keep the docu that way or at least phrase
> > it in a way so that no additional users start relying on that hybrid
> > mechanism.
>=20
> Thanks for the clarification, would you mind me sending a patch to fix
> the description, and also mention the automatic clean-up behavior
> shouldn't be relied anymore in new code?

If I would mind if *you* send such a patch? I for sure wouldn't mind,
that's the entire idea of open source development ^^

I can of course review it if you +Cc me.

>=20
> ...
>=20
> > The good news is that it's the last remainder of PCI hybrid devres and
> > getting rid of it would allow for removal of some additional code, too
> > (e.g., is_enabled bit and pcim_pin_device()).
> >=20
> > The bad news is that it's not super trivial to remove. I looked into it
> > about two times and decided I can't invest that time currently. You
> > need to go over all drivers again to see who uses pcim_enable_device(),
> > then add free_irq_vecs() for them all and so on=E2=80=A6
>=20
> Do you think adding an implementation of pcim_alloc_irq_vectors(), that
> always call pci_free_irq_vectors() regardless whether the PCI device is
> managed, will help the conversion?
>=20
> This will make it more trival to rewrite drivers depending on the
> automatic clean-up behavior: since calling pci_free_irq_vectors()
> several times is okay, we could simply change pci_alloc_irq_vectors() to
> pcim_alloc_irq_vectors(), without considering where to call
> pci_free_irq_vectors().
>=20
> Introducing pcim_alloc_irq_vectors() will also help newly-introduced
> drivers to reduce duplicated code to handle resource clean-up.

That's in fact how I have cleaned up the hybrid nature that was present
until this year in pci_request_region() et al.:

https://lore.kernel.org/linux-pci/20250519112959.25487-2-phasta@kernel.org/

It's one way to do it. First port everyone who relies on managed
behavior to a pcim_ function, and once they're all ported, remove the
hybrid nature from the pci_ function.

So that works, yes. The real question is just whether one wants a pcim_
function for the irq vectors. My personal impression is that this looks
like a useful feature; but my expertise with MSI is a bit limited.
There's also this strange kernel-wide msi_enabled global bool..=20

I guess the best way to find out is to try implementing it.

In case of doubt, the boring unmanaged pci_ version is the safe choice.
One contributor around here has once called the managed versions "the
crazy devres voodoo" :p

(BTW, just to be sure, pcim_ functions must not be interconnected with
pcim_enable() in the future anymore, nor shall they use global state.
All PCI devres functionality should purely work on the device file
through pure devres. The pcim_enable() interconnection cam only from
the hybrid feature.)


P.

>=20
> > If you give me a pointer I can provide a TODO entry. In any case, feel
> > free to set me as a reviewer!
>=20
> > Regards
> > Philipp
>=20
> Regards,
> Yao Zi


