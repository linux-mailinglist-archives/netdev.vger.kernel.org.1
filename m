Return-Path: <netdev+bounces-140008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FF9B5043
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56A91C22951
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B091D356C;
	Tue, 29 Oct 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ed0NIJQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBC199947;
	Tue, 29 Oct 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222471; cv=none; b=bUCP+RNYQzG65E67iy4LhrvMumzf/JuqNujK4D2wDc6Pk8OnfFiWPP+Miht/zCu3LZ8c1BaIg+FDtYDnP9SfQT+JJjlqfZjN5eeeWCRu7dOclUhhsA17U9yQJL+9sfGW0varJAAtJTXPjaAaEN31iTD9WITRDCg2gKk6Wwk7g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222471; c=relaxed/simple;
	bh=aZoSnhIYYGfzQEcndVUH53Dtr6Dv7M8RstKAy0UmYvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsqN9qvDGxyb9CNNfBnab3V84SgEYKh9mNi4qem7XXv0OgOQIC04j6fNKqoSNihOBB5w3blEURH+WKYdL5uT6Vwyi0+KfGUhFEjAfSmC3u1opzL7LcLIGOYxnU1MvpYQy8AFOMkcFBV229B1tTX4EXBHK9qVjr2/UsaJKNPgVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ed0NIJQK; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5psqtypMIhwv35psqt8BUl; Tue, 29 Oct 2024 18:19:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730222397;
	bh=A1ipq0+eL7tHuEVwett4pkXKganRU63kOI3vJXzeeWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ed0NIJQKTL+P2upxbWMHO0auzbSV9RzRVB0u6H7QBWvuAMEJHaN7D27zzxhv8UtGl
	 f9WBKYQUpxKylSMmZvk9ONwoBw4NT3oRwB0VV2x88tZAnnp1nDDdZwetxX49ziY4mi
	 HtQp3uyljQ6pMBUD9OwN1N3WPaQA+OmsqobNDv18k3LbOtLlQMTwJuIGOX6Ugh32uO
	 LUowdTBC/AIydclyN/CVYTJBvWEzlHeO1pOKO0RfyD8h8tFCcyKnu7w2fAWRtfv49S
	 HS2S7ymxNHwwmsd8AJXBjpKe057o+WC626Uop20YwsSMePQ8WKOML6EmvGNQHjAJk1
	 V790/COl27DZQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 29 Oct 2024 18:19:57 +0100
X-ME-IP: 90.11.132.44
Message-ID: <76147be2-9320-45a1-919c-4b41992fd7d9@wanadoo.fr>
Date: Tue, 29 Oct 2024 18:19:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
To: Robert Joslyn <robert_joslyn@selinc.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: lee@kernel.org
References: <20241028223509.935-1-robert_joslyn@selinc.com>
 <20241028223509.935-3-robert_joslyn@selinc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241028223509.935-3-robert_joslyn@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/10/2024 à 23:35, Robert Joslyn a écrit :
> Add support for SEL FPGA based network adapters. The network device is
> implemented as an FPGA IP core and enumerated by the selpvmf driver.
> This is used on multiple devices, including:
>   - SEL-3350 mainboard
>   - SEL-3390E4 card
>   - SEL-3390T card
> 
> Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
> ---

Hi,

a few nitpicks below, should it help.


> +/**
> + * selpcimac_rx_alloc_page() - Allocate a network fragment page.
> + */
> +static struct page *selpcimac_rx_alloc_page(struct selpcimac_rx_ring *ring)
> +{
> +	struct page *page = dev_alloc_page();
> +
> +	return page;

return dev_alloc_page()?

> +}

...

> +/**
> + * selpcimac_cleanup_rxbd() - Remove an RXBD from hardware control.
> + *
> + * This is only safely called if RSTAT[RX_EN] == 0
> + *
> + * @desc: Pointer to the buffer descriptor to cleanup
> + */
> +static void selpcimac_cleanup_rxbd(struct sel_rx_bd *desc)
> +{
> +	desc->rxbd_ctrl &= (cpu_to_le32(~(RXBD_CTRL_EMT)));

Un-needed outer ().

> +}
> +
> +/**
> + * selpcimac_alloc_mapped_page() - Allocate a new page and map it for DMA.
> + *
> + * This function will ensure the passed in rx_buffer has a valid page to
> + * give to the hardware.  A new page will be allocated only if the page
> + * pointer in the RX buffer is NULL.  If the page pointer is not NULL, the
> + * page is already allocated and we are reusing it.
> + *
> + * @ring: Pointer to the ring that owns the RX buffer.
> + * @bi:   Pointer to the RX buffer structure to allocate for.
> + *
> + * Returns:  true if a page was successfully allocated, false otherwise.
> + */
> +static bool selpcimac_alloc_mapped_page(struct selpcimac_rx_ring *ring,
> +					struct selpcimac_rx_buffer *bi)
> +{
> +	struct page *page = bi->page;
> +	dma_addr_t dma;
> +
> +	/* Already allocated, nothing to do */
> +	if (page)
> +		return true;
> +
> +	page = selpcimac_rx_alloc_page(ring);
> +	if (likely(page)) {
> +		dma = dma_map_page(ring->dev, page, 0,
> +				   PAGE_SIZE, DMA_FROM_DEVICE);
> +		if (dma_mapping_error(ring->dev, dma)) {
> +			selpcimac_rx_free_page(ring, page);
> +			page = NULL;
> +		} else {
> +			bi->dma = dma;
> +			bi->page = page;
> +			bi->page_offset = 0;
> +		}
> +	}
> +	return (page);

No need for ()

> +}

...

> +/**
> + * selpcimac_initialize_rx_ring() - Initialize the receive ring.
> + *
> + * This function allocates the buffer descriptor ring for the hardware,
> + * initializes it, and programs it to the hardware.  It also starts the
> + * receive buffer allocation process.
> + *
> + * @ring: RX ring to initialize
> + *
> + * Returns: 0 if successful, -ENOMEM if we couldn't initialize the ring.
> + */
> +static int selpcimac_initialize_rx_ring(struct selpcimac_rx_ring *ring)
> +{
> +	/* Allocation is an array of the currently configured number
> +	 * of RX buffer descriptors rounded up to the nearest 4k.
> +	 */
> +	ring->size = (sizeof(struct sel_rx_bd) * ring->count);
> +	ring->size = ALIGN(ring->size, 4096);
> +
> +	ring->desc = dma_alloc_coherent(ring->dev,
> +					ring->size,
> +					&ring->dma,
> +					GFP_KERNEL);
> +	if (!ring->desc)
> +		goto err;

return directly and avoid the 'err' label?

> +
> +	WARN_ON_ONCE((ring->dma % SEL_DATA_ALIGN) != 0);
> +
> +	memset(ring->desc, 0, ring->size);

If I recollect correctly, dma_alloc_coherent() returns some zeroed memory.

> +	ring->last_bd = ring->dma +
> +		(ring->count - 1) * sizeof(struct sel_rx_bd);
> +	ring->next_to_use = 0;
> +	ring->next_to_clean = 0;
> +
> +	if (selpcimac_init_rx_buffers(ring))
> +		goto err_free;

Why no simply propagate the error code from selpcimac_init_rx_buffers()?
Won't change anything, but more standard.

> +
> +	return 0;
> +
> +err_free:
> +	dma_free_coherent(ring->dev, ring->size, ring->desc, ring->dma);
> +	ring->desc = NULL;
> +	ring->dma = 0;
> +	ring->last_bd = 0;
> +	ring->size = 0;
> +err:
> +	return -ENOMEM;
> +}

...

> +/**
> + * dump_sfp_id() - Print the id values for this ports SFP
> + *
> + * @mac:	SEL MAC device
> + * @buff:	Buffer to write id values to
> + * @size:	The size of the buffer to write to
> + *
> + * @returns: Number of bytes written to buff
> + */
> +static ssize_t dump_sfp_id(struct sel_pci_mac *mac, char *buff, int size)
> +{
> +	struct sel_sfp_id id;
> +	ssize_t rc = 0;
> +
> +	if (sfp_read_id(mac, &id) < 0)
> +		return 0;
> +
> +	if (id.sel_part[0] != 0) {
> +		rc += snprintf(buff + rc, size - rc,
> +			       "SELPartNumber: %.4s-%.2s\n",
> +			       id.sel_part, id.sel_part_option);

I think that sysfs_emit_at() should be preferred in this function.

> +		rc += snprintf(buff + rc, size - rc,
> +			       "SELSerialNumber: %.15s\n", id.sel_sn);
> +	}
> +	rc += snprintf(buff + rc, size - rc,
> +		       "Manufacturer: %.16s\n", id.name);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "PartNumber: %.16s\n", id.part);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "Version: %.4s\n", id.rev);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "SerialNumber: %.16s\n", id.sernum);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "DateCode: %.8s\n", id.datecode);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "Wavelength: %u nm\n", id.wavelength);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "LengthSingleMode: %u m\n", id.length_smf_km);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "Length50umOM2: %u m\n", id.length_om2);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "Length62p5umOM1: %u m\n", id.length_om1);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "LengthCopper: %u m\n", id.length_copper);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "Length50umOM3: %u m\n", id.length_om3);
> +
> +	return rc;
> +}
> +
> +/**
> + * dump_sfp_diag() - Print the diag values for this ports SFP
> + *
> + * @mac:	SEL MAC device
> + * @buff:	Buffer to write diag values to
> + * @size:	The size of the buffer to write to
> + *
> + * @returns: Number of bytes written to buff
> + */
> +static ssize_t dump_sfp_diag(struct sel_pci_mac *mac, char *buff, int size)
> +{
> +	struct sel_sfp_diag diag;
> +	ssize_t rc = 0;
> +
> +	if (sfp_read_diag(mac, &diag) < 0)
> +		return 0;
> +
> +	rc += snprintf(buff + rc, size - rc,
> +		       "Temperature: %d C\n", diag.temp);

I think that sysfs_emit_at() should be preferred in this function.

> +	rc += snprintf(buff + rc, size - rc,
> +		       "SupplyVoltage: %u uV\n", diag.vcc);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "TxBiasCurrent: %u uA\n", diag.tx_bias);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "TxPower: %u nW\n", diag.tx_power);
> +	rc += snprintf(buff + rc, size - rc,
> +		       "RxPower: %u nW\n", diag.rx_power);
> +
> +	return rc;
> +}
> +
> +/**
> + * __show_attr() - Return data for a specific attribute
> + *
> + * @dev:            device object
> + * @attr:           device attribute to show info for
> + * @buff:           buffer to store output
> + * @attribute_type: the type of attribute to return information for
> + *
> + * Return: number of bytes stored in the buffer
> + */
> +static ssize_t __show_attr(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buff,
> +			   enum sel_dev_attributes attribute_type)
> +{
> +	struct selpcimac_platform_private *priv = dev_get_drvdata(dev->parent);
> +	struct sel_pci_mac *mac = priv->priv;
> +	ssize_t bytes_written = 0;
> +	int length = 0;
> +
> +	switch (attribute_type) {
> +	case SFP_CONFIGURATION:
> +		bytes_written =	sprintf(buff, "%d\n",
> +					(u32)mac->sfp_configuration);
> +		break;
> +
> +	case INTR_MOD_RATE:
> +		bytes_written =	sprintf(buff, "%d\n",
> +					(u8)mac->interrupt_moderation_rate);
> +		break;
> +
> +	case INTR_RX_ABS:
> +		bytes_written =	sprintf(buff, "%d\n",
> +					ioread32(&mac->hw_mac->intr_moderation.rxabs));
> +		break;
> +
> +	case INTR_RX_PACKET:
> +		bytes_written =	sprintf(buff, "%d\n",
> +					ioread32(&mac->hw_mac->intr_moderation.rxpacket));
> +		break;
> +
> +	case INTR_TX_ABS:
> +		bytes_written =	sprintf(buff, "%d\n",
> +					ioread32(&mac->hw_mac->intr_moderation.txabs));
> +		break;
> +
> +	case INTR_TX_PACKET:
> +		bytes_written =	sprintf(buff, "%d\n",
> +					ioread32(&mac->hw_mac->intr_moderation.txpacket));
> +		break;
> +
> +	case INTR_THROTTLE:
> +		bytes_written = sprintf(buff, "%d\n",
> +					ioread32(&mac->hw_mac->intr_moderation.throttle));
> +		break;
> +
> +	case ETH_REGISTERED:
> +		length += snprintf(buff + length,

You could remove 'lenght', as in all other cases.

I also think that sysfs_emit() should be preferred.

> +				   PAGE_SIZE - length,
> +				   "%s\n",
> +				   mac->netdev->name);
> +		bytes_written = length;
> +		break;
> +
> +	case SFP_ID:
> +		bytes_written = dump_sfp_id(mac, buff, PAGE_SIZE);
> +		break;
> +
> +	case SFP_DIAG:
> +		bytes_written = dump_sfp_diag(mac, buff, PAGE_SIZE);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return bytes_written;
> +}

...

CJ


