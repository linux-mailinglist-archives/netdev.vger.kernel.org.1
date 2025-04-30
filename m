Return-Path: <netdev+bounces-186963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886AAA45E9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FDA189E8A9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B121ABB1;
	Wed, 30 Apr 2025 08:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E81219314;
	Wed, 30 Apr 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002853; cv=none; b=cwSGN86ymxWIHlAUQrOmTzpCUNIbA0VbLXsRTcoyVgsRaw5yIk4SFWhLTdw2SQACU3C2uk6BhkaYrRnamXvy/Nv++a6X2evDHg2j3ci6ebpNWOOOMlrZOMMw0aygD4PqQy0z7J1JJSFkYsjJzZFIidYMl9L2KIdSbyzZ+aWTsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002853; c=relaxed/simple;
	bh=2V3oi+zTqj6+6yjxoEi2u/vt/w1/hvUqDh25JFcZBjg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vq5+1E8ziDppc22EjA/EVyjGrXjPZDrJrZC92XQ2YAjXJBEZKS0Kobcub16jYIBFfLdAjTFApP7d4lZ3QSXY8JO2uKNmll78nsJzvZogkSC67Jtuf8H0FZamSFwgw/hzJhVyLXD/kkFM10+6IXnHJg2FIOEs6PjbFxgi3u9xJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZnW0B6JHsz6K9YP;
	Wed, 30 Apr 2025 16:42:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 152FC1402EE;
	Wed, 30 Apr 2025 16:47:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Apr
 2025 10:47:27 +0200
Date: Wed, 30 Apr 2025 09:47:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <admiyo@os.amperecomputing.com>
CC: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
	<matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v21 1/1] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <20250430094725.000031ac@huawei.com>
In-Reply-To: <20250429222759.138627-2-admiyo@os.amperecomputing.com>
References: <20250429222759.138627-1-admiyo@os.amperecomputing.com>
	<20250429222759.138627-2-admiyo@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Apr 2025 18:27:58 -0400
admiyo@os.amperecomputing.com wrote:

> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
Hi Adam,

> 
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/\
> DSP0292_1.0.0WIP50.pdf

Don't line break a link.

Is the WIP status something we should be concerned about?


> 
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified
> in the PCCT.  Messages are sent on a type 3 and
> received on a type 4 channel.  Communication with
> other devices use the PCC based doorbell mechanism;
> a shared memory segment with a corresponding
> interrupt and a memory register used to trigger
> remote interrupts.
> 

Very short wrap.  Convention for patch descriptions tends to be around
75 chars.

> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

A couple more trivial things on a final look through from me.
Obviously the netdev and mctp bits aren't my specialty as I only dip
into them occasionally, but with that in mind and some concerns
about possibility for this getting abused as a work around for things
should have more specific kernel level support...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..aa5c5701d581
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024, Ampere Computing LLC
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf

https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0.pdf

Looks to be final version of that doc, but it's not what your title says...




> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr *mctp_pcc_header;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +	int rc;
> +
> +	rc = skb_cow_head(skb, sizeof(*mctp_pcc_header));
> +	if (rc)
> +		goto err_drop;
> +
> +	mctp_pcc_header = skb_push(skb, sizeof(mctp_pcc_header));
> +	mctp_pcc_header->signature = cpu_to_le32(PCC_SIGNATURE | mpnd->outbox.index);
> +	mctp_pcc_header->flags = cpu_to_le32(PCC_CMD_COMPLETION_NOTIFY);
> +	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
> +	       MCTP_SIGNATURE_LENGTH);
> +	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer = mpnd->outbox.chan->shmem;
> +	memcpy_toio(buffer, skb->data, skb->len);
> +	rc = mpnd->outbox.chan->mchan->mbox->ops->send_data
> +		(mpnd->outbox.chan->mchan, NULL);

Not the most readable of line wraps. I'd just go long on this one for readability.
It's still < 100 chars. Or use a local pointer to outbox chan.
That will shorten this and at least one other place.


	rc = mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan, NULL);


> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +	if ACPI_FAILURE(rc)
> +		goto err_drop;
> +	dev_dstats_tx_add(ndev, len);
> +	dev_consume_skb_any(skb);
> +	return NETDEV_TX_OK;
> +err_drop:
> +	dev_dstats_tx_dropped(ndev);
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}

> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct mctp_pcc_lookup_context *luc = context;
> +	struct acpi_resource_address32 *addr;
> +
> +	if (ares->type != PCC_DWORD_TYPE)
> +		return AE_OK;
> +
> +	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
> +	switch (luc->index) {
> +	case 0:
> +		luc->outbox_index = addr[0].address.minimum;
Really trivial but as this is a walk of the resources, I'd expect it
to be conceptually providing one resource per walk iteration.
As such, is 
		luc->outbox_index = addr->address.minimum;

more representative of what is going on here than an array look up?

> +		break;
> +	case 1:
> +		luc->inbox_index = addr[0].address.minimum;
> +		break;
> +	}
> +	luc->index++;
> +	return AE_OK;
> +}



