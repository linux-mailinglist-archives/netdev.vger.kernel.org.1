Return-Path: <netdev+bounces-144092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0C9C5937
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9718E1F24272
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD01158DDC;
	Tue, 12 Nov 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmqDwuq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F8158DB9;
	Tue, 12 Nov 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418522; cv=none; b=tsJI1b1HHkfdVC6fRMts6rMwsoK5RKePp2DwcbcN73cwYT4SiL2P8OGn0Tst6lalI9QkYVEXxZp65be+uTjXzjcyNReC1AUVe6Rxh5e7XpfoNr3OYv+8Lm0uyvxbUA1HjU6CS+kBsj2DziVoZeThuEfVV4s9n41ORo6XZ7BB9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418522; c=relaxed/simple;
	bh=anrwzrXOnjIAZZpGQQGNMBfN1xGtzIuPmbNrKiYeAjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccCJIUTlmoxfcBdPL9k+w8ESQqjAVm7J+vqHDG6Wc/Fk0ZWgwAe3ICXdTqs1UelSdhospHsGTq2b96KLPOKp2JfM4NzxN1MEhfzTO4PFxS+cFyfktnFCns6CsKzliN35kRppztF2R5beHvAgHfV80lOhfDnlSBZl7H/QNMDQTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmqDwuq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F838C4CECD;
	Tue, 12 Nov 2024 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418522;
	bh=anrwzrXOnjIAZZpGQQGNMBfN1xGtzIuPmbNrKiYeAjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmqDwuq0ho0MwAco2d13WUsQ5/eG4NTqoUkhUpYedkAG/eSFy4KZsq+ADu5NXT1Ej
	 ftZzF0e8fuFhbQNcGJ75hY9T9/hEOyzZB9RdqcoVz21luXDjKJmac3XnKv9fynWHIv
	 RvfHWD/SvY1yDjbC7t4cQm0OibpAFud1VB3N0euF5BctRlRAx2g+hd4xMJ194lMYz9
	 QDo/hEtbXtQfpSf1BbIV+O7ww6jR3JUGve2hdsPj/RiDvDpBH6iFasBknPz1h/ngDD
	 DxzymgMola6YXRcNLAs8kfJTxbtnRYpc5cls+f+PpboBQ5uoE1YuHFoNMyK2q5PRc9
	 6+gMnJ6q8PY3Q==
Date: Tue, 12 Nov 2024 13:35:18 +0000
From: Lee Jones <lee@kernel.org>
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] mfd: Add SEL PCI Virtual Multifunction (PVMF)
 support
Message-ID: <20241112133518.GF8552@google.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
 <20241028223509.935-2-robert_joslyn@selinc.com>
 <20241105173035.GE1807686@google.com>
 <PH0PR22MB3809DE8446E7EAEFB0F6103FE55C2@PH0PR22MB3809.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR22MB3809DE8446E7EAEFB0F6103FE55C2@PH0PR22MB3809.namprd22.prod.outlook.com>

On Thu, 07 Nov 2024, Robert Joslyn wrote:

> > -----Original Message-----
> > From: Lee Jones <lee@kernel.org>
> > Sent: Tuesday, November 5, 2024 9:31 AM
> > To: Robert Joslyn <robert_joslyn@selinc.com>
> > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org
> > Subject: Re: [RFC PATCH 1/2] mfd: Add SEL PCI Virtual Multifunction (PVMF)

These should not end up in the mail's body.

> > support
> > 
> > [Caution - External]
> > 
> > On Mon, 28 Oct 2024, Robert Joslyn wrote:
> > 
> > > Add support for SEL FPGA based PCIe devices. These expose a single PCI
> > > BAR with multiple IP cores for various functions, such as serial
> > > ports, ethernet, and time (PTP/IRIG). This initial driver supports
> > > Ethernet on the SEL-3350 mainboard, SEL-3390E4 ethernet card, and
> > > SEL-3390T ethernet and time card.
> > >
> > > Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
> > > ---
> > >  MAINTAINERS                |   8 +
> > >  drivers/mfd/Kconfig        |  16 ++
> > >  drivers/mfd/Makefile       |   3 +
> > >  drivers/mfd/selpvmf-core.c | 482
> > > +++++++++++++++++++++++++++++++++++++
> > >  drivers/mfd/selpvmf-cvp.c  | 431
> > +++++++++++++++++++++++++++++++++
> > > drivers/mfd/selpvmf-cvp.h  |  18 ++
> > >  6 files changed, 958 insertions(+)
> > >  create mode 100644 drivers/mfd/selpvmf-core.c  create mode 100644
> > > drivers/mfd/selpvmf-cvp.c  create mode 100644
> > > drivers/mfd/selpvmf-cvp.h

[...]

> > > +/**
> > > + * sel_create_cell() - Create an MFD cell and add it to the device.
> > > + * @pdev: The PCI device to operate on
> > > + * @name: MFD cell name
> > > + * @start: Start address of memory resource
> > > + * @length: Length of memory resource
> > > + * @msix_start: MSIX vector number to start from.
> > > + * @resources: Pointer to resources to add to the cell.
> > > + * @num_resources: Number of resources. The first resource is assumed to
> > > + *                 be memory, all other resources are IRQs.
> > > + */
> > > +static int sel_create_cell(struct pci_dev *pdev,
> > 
> > This is misleading.  It should be sel_register_device.
> 
> I'll rename the function.

Please refrain from responding to comments that you agree with, then
trim the rest.  It will save multiple people a lot of time.

> 
> > 
> > > +                        const char *name,
> > 
> > This never changes.  Why supply it as a variable?
> > 
> > > +                        unsigned int start, +
> > > unsigned int length,
> > 
> > This never changes.  Why supply it as a variable?
> > 
> > > +                        unsigned int msix_start,
> > 
> > This never changes.  Why supply it as a variable?
> > 
> > > +                        struct resource *resources, +
> > > unsigned int num_resources)
> > 
> > This never changes.  Why supply it as a variable?
> 
> This patch only enables ethernet, but we have additional functionality
> that we will enable in subsequent patches, such as serial ports, a
> time component, and a firmware upgrade mechanism. Those components
> have different names, lengths, interrupt counts, etc. If you prefer, I
> can remove this abstraction until we have another cell type to add.

I can only review what I see before me.

Add the extra pieces when/if you upstream the additional functionality.

[...]

> > > +     if (rc != 0) +             return rc; + +     /* Perform CvP
> > > program if necessary */ +     cvp_capable =
> > > pci_find_ext_capability(pdev, CVP_CAPABILITY_ID); +     if
> > > (!skipcvp && cvp_capable) {
> > 
> > The '_' inconsistency is bothering me.
> > 
> > As is the placement of "cvp".
> 
> Would you prefer to see skipcvp called skip_cvp? Or cvp_skip? I'm
> happy to change it.

The latter seems more consistent.

[...]

> > > +             rc = cvp_start(pdev); +             if (rc != 0) { +
> > > dev_err(&pdev->dev, "Error: CvP failed: 0x%x\n", + rc);
> > 
> > This is a user facing error message and I still don't know what CvP
> > is.
> > 
> > Please be more forthcoming.
> 
> CvP is Configuration via Protocol. It's a method for loading firmware
> into Altera FPGAs. If CvP fails, it means we're unable to load
> firmware into the FPGA and the card is basically dead. I can improve
> the error message. Maybe something like, "Loading FPGA firmware
> failed"?

Sounds good.

[...] 

> > 
> > > +                     goto out_disable; +             } +     } +
> > > +     rc = alloc_fn(pdev);
> > 
> > These call-backs are horrible.  Please don't do this.
> 
> Ok, we'll do something else. Would you prefer to pass in a constant
> and use a switch statement to select which function to call?

That sort of thing, yes.

[...]

> > > + +             pci_restore_state(pdev); +     } + +
> > > pci_set_master(pdev); + +     return 0; +} + +static const struct
> > > dev_pm_ops selpvmf_pm_ops = { +
> > > SYSTEM_SLEEP_PM_OPS(selpvmf_suspend, selpvmf_resume) }; + +static
> > > struct pci_device_id selpvmf_pci_tbl[] = { +     { +
> > > PCI_DEVICE(PCI_VENDOR_ID_SEL, PCI_DEVICE_ID_B1190), +
> > > .driver_data = (kernel_ulong_t)b1190_alloc_mfd_cells,
> > 
> > Pass an identifier here instead of call-back functions.
> 
> Do you have a preference for the type of construct we use? Just a
> #define integer with a switch statement in probe? Something else?

Probably an enum.  Take a look at some other drivers.

> > > +     }, +     { +             PCI_DEVICE(PCI_VENDOR_ID_SEL,
> > > PCI_DEVICE_ID_B2077), +             .driver_data =
> > > (kernel_ulong_t)b2077_alloc_mfd_cells, +     }, +     { +
> > > PCI_DEVICE(PCI_VENDOR_ID_SEL, PCI_DEVICE_ID_B2091), +
> > > .driver_data = (kernel_ulong_t)b2091_alloc_mfd_cells, +     }, +
> > > { +             PCI_DEVICE(PCI_VENDOR_ID_SEL,
> > > PCI_DEVICE_ID_B2093), +             .driver_data =
> > > (kernel_ulong_t)b2093_alloc_mfd_cells, +     }, +     {0,}
> > 
> > What is this?  Where have you seen that before?
> 
> The {0,} is how to signal the end of this array. I don't think the
> comma is required though. Random example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/lpc_sch.c?h=v6.12-rc6#n66

{} is fine.

-- 
Lee Jones [李琼斯]

