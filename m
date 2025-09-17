Return-Path: <netdev+bounces-223829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E6B7CFE9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13C4523A3D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 01:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3621C9FD;
	Wed, 17 Sep 2025 01:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B0A55;
	Wed, 17 Sep 2025 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758073122; cv=none; b=l5mGc4OnYJh1bsfHf6FgwJcNGhIRf6FMV1UJ9WuJMNOzmKnxq3Zjv5ojEmk5gTpofY5396pFz0p0NNyforULqOHL+zqfpwgr6GlVrnb/0ztt717nOxApkme50kNbCz4lIzoYTL4JdHJYa/XcwIhISDq5OwnUPfhD7SVKcAIrwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758073122; c=relaxed/simple;
	bh=c96r5g9/2TrMWF+E4shOu1iKxd/UIq2uyTWVCc7wfeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXwgT5Jw3ctnDUS+nfSaverKvZDvL+I4+S/Ix6eE2K7JnU7vavXglbpzTXxge6myJQb3+mneYaIAg27Q9iPniTt2lBq4N1mayOI/hD7OIo2aOPJG4hejVK2gk7nln6ZA9zpBDNu1zpiHFjcLuf/Jxw1uVNucmd41Oqz85YG7DZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1758073078tc590936c
X-QQ-Originating-IP: DSQOi3WrbOSImlheDRdqyOR7Vym4llyrGDEqhpWxiX0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 09:37:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17397237642805600174
Date: Wed, 17 Sep 2025 09:37:55 +0800
From: Yibo Dong <dong100@mucse.com>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v12 1/5] net: rnpgbe: Add build support for
 rnpgbe
Message-ID: <B4DFD08F6CE2FA99+20250917013755.GA33236@nic-Precision-5820-Tower>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-2-dong100@mucse.com>
 <mr6wuiqeucy6shybrqrg3pwim22ep5tbdivspsjwpo5335ri7j@u4jcc6os3ndr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mr6wuiqeucy6shybrqrg3pwim22ep5tbdivspsjwpo5335ri7j@u4jcc6os3ndr>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NWDl/EfWhAWl8xsYaJNDzPSYWIrCBwtoaDBKq3D05mRoZgaZHm7Gb/z9
	KWyRgdBfy9eLai5qMkqIrL1/H/vBbbFPxPa835n6TLBWUw+73LUTCkd8tz4bWKcDxuMJY36
	oabF+NzkLcBbWOVLNgmelbPH98eT5WsuV7ZDdZ7dHCKKYGukd0/skPVF6689W583WPOTmYk
	44gw3nWjhU7F/meTtlhefHvxXb2zaoIAApFtjw8+tfSxhAKTe+eExe9cl58cS8zRwZ9/rDA
	7+AlxXnAFtEcPRlaWLGXnyb59wIzUF+pZa+8M5sWWKZ5cUeVFO/tEG/e9FUlHpwt8o8gjMy
	6WIXKeR3CyJS1lNcLPrJpbnbahowF5uQ/feODgnyeTFYmzNWHNOt8j6O9gIdCQLBpXLsMmY
	7fIn+u+Qs1nMPzxEhACAkrGpi73Q/0v3ddxVWijNMhrDmXSp+VMyshc8iwBaXXI4dxen+yN
	GD9AkIkm0PLN5WiSpn8bjx/T5q6C25X+1Wd1vxd5jG667ksNkuA9dJFv7Ug2irx6bIDyvqd
	nz/ikLFNE9YgXBXElTzxnmizVfXXK00OzyOAaDdj55WcIBEfbcZ2y+xlPN3c8XAlV9ZqETY
	i+S7yD0m+pfO5SYbKcvnj5FBjghM2TnOQtIXnXJHix3OBiJ6JlrmUDiuDDIzb4GPA6zsbV1
	KzOVL/ORFzinPDqOU0mXzA9swzd2ZAU/85Yunewf6cZUCHDm5QvREtu+JtjNnrQ7CD2t7TO
	0N9KS/eb7qKZynNivtSjR/KemzCUPa7P2CFzsa7SZYTGcp0x4Q6MlIckj+YATZgeatNwik1
	fnPUkX/D2a0UbH8aFv3Uj46LvXuS9TWXfdKljtVIsvJuqFFSTdSStzwRoLzwLV0lHk8jOE8
	gC3GxqO44Z9TFrMz2NdUqA0jTozwj+eTxFrkmAhE6gakLohxcuKRLANahTKYUIFdHu1s6Uw
	PoXBQCSLLe4j5i9Lmz9YpydAk+ZjSeqoMNlKxPeiT0oSBQOWsOiHfFNJGetBTVq53+YF6NI
	iMMx9jGwdBLg0Ulg/a
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Sep 16, 2025 at 09:00:23PM +0200, Jörg Sommer wrote:
> Dong Yibo schrieb am Di 16. Sep, 19:29 (+0800):
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > new file mode 100644
> > index 000000000000..60bbc806f17b
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/pci.h>
> > +
> > +#include "rnpgbe.h"
> > +
> > +static const char rnpgbe_driver_name[] = "rnpgbe";
> > +
> > +/* rnpgbe_pci_tbl - PCI Device ID Table
> > + *
> > + * { PCI_DEVICE(Vendor ID, Device ID),
> > + *   driver_data (used for different hw chip) }
> > + */
> > +static struct pci_device_id rnpgbe_pci_tbl[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_QUAD_PORT),
> > +	  .driver_data = board_n500},
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_DUAL_PORT),
> > +	  .driver_data = board_n500},
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210),
> > +	  .driver_data = board_n210},
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210L),
> > +	  .driver_data = board_n210},
> 
> Should there be a space before }?
> 

ixgbe_main.c has sapce before }, but no sapce after {.
ngbe_mainc. no sapce before }, but space after {.
mlx5/core/main.c has space both.
It seems not the same....
I will add sapce before }.

> > +	/* required last entry */
> > +	{0, },
> > +};
> > +
> > +/**
> > + * rnpgbe_probe - Device initialization routine
> > + * @pdev: PCI device information struct
> > + * @id: entry in rnpgbe_pci_tbl
> > + *
> > + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> > + * structure.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +	int err;
> 
> In rnpgbe_mbx.c you use `int ret` for this pattern. I think you should unify
> this. But I'm more in favour of `err` than `ret`.
> 

I see, I will use err in rnpgbe_mbx.c

> > +
> > +	err = pci_enable_device_mem(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"No usable DMA configuration, aborting %d\n", err);
> > +		goto err_disable_dev;
> > +	}
> > +
> > +	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"pci_request_selected_regions failed %d\n", err);
> > +		goto err_disable_dev;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +	err = pci_save_state(pdev);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "pci_save_state failed %d\n", err);
> > +		goto err_free_regions;
> > +	}
> > +
> > +	return 0;
> > +err_free_regions:
> > +	pci_release_mem_regions(pdev);
> > +err_disable_dev:
> > +	pci_disable_device(pdev);
> > +	return err;
> > +}
> > +
> > +/**
> > + * rnpgbe_remove - Device removal routine
> > + * @pdev: PCI device information struct
> > + *
> > + * rnpgbe_remove is called by the PCI subsystem to alert the driver
> > + * that it should release a PCI device. This could be caused by a
> > + * Hot-Plug event, or because the driver is going to be removed from
> > + * memory.
> > + **/
> > +static void rnpgbe_remove(struct pci_dev *pdev)
> > +{
> > +	pci_release_mem_regions(pdev);
> > +	pci_disable_device(pdev);
> > +}
> > +
> > +/**
> > + * rnpgbe_dev_shutdown - Device shutdown routine
> > + * @pdev: PCI device information struct
> > + **/
> > +static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
> > +{
> > +	pci_disable_device(pdev);
> > +}
> > +
> > +/**
> > + * rnpgbe_shutdown - Device shutdown routine
> > + * @pdev: PCI device information struct
> > + *
> > + * rnpgbe_shutdown is called by the PCI subsystem to alert the driver
> > + * that os shutdown. Device should setup wakeup state here.
> > + **/
> > +static void rnpgbe_shutdown(struct pci_dev *pdev)
> > +{
> > +	rnpgbe_dev_shutdown(pdev);
> 
> Is this the only user of rnpgbe_dev_shutdown?
> 

No, it maybe called by suspend callback in the future.
Device relative code will be added in rnpgbe_dev_shutdown, and power state
code in rnpgbe_shutdown. This is the same like other driver did
(ixgbe_main.c)

> > +}
> > +
> > +static struct pci_driver rnpgbe_driver = {
> > +	.name = rnpgbe_driver_name,
> > +	.id_table = rnpgbe_pci_tbl,
> > +	.probe = rnpgbe_probe,
> > +	.remove = rnpgbe_remove,
> > +	.shutdown = rnpgbe_shutdown,
> > +};
> > +
> > +module_pci_driver(rnpgbe_driver);
> > +
> > +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> > +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> > +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.25.1
> > 
> > 
> 
> -- 
> Als deutscher Tourist im Ausland steht man vor der Frage, ob man sich
> anständig benehmen muss oder ob schon deutsche Touristen dagewesen sind.
>                                                 (Kurt Tucholsky)

Thanks for your feedback.



