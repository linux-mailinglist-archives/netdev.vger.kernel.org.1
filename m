Return-Path: <netdev+bounces-185563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7B3A9AE61
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA54A23EC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134938DEC;
	Thu, 24 Apr 2025 13:03:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF627BF78;
	Thu, 24 Apr 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499837; cv=none; b=fx1iLGTgAkjpWdV2J8BCSd+1a+Z5N6Ck4Dza4p9gDt3+AtFvWOVnQdN8OJiQ852IWM1KXcXF8UXW9urO0kY+MKfKTUL8EiSEj2QgWBNaFONaZIRaCb+KMaHv58yZgEdJEPea3s6B+iXbexdC86tw4tOVSf2yaaRmdPAFzxqG6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499837; c=relaxed/simple;
	bh=NRDsnEv3o636ENTLs9ZZIuX6FZkhFAEJxroFHxiPKqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B/cSsbFRRQWuQwLQ8mWSDZqHqw3VrNYRQYvMX4vcz8eUjsirzNMp8c3G1J2adBnO/Hysil4KefKYsM5TkFVBuFKAiU1p8p3FPSquEi15B7d/Ct3KdTR18U7vfdlx+yu7i4+bSa+p27/AgVrBwbBxvVo2B0iFbP+/PnY/1MXesyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Zjx3x3dc9zsTDR;
	Thu, 24 Apr 2025 21:03:25 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E3911A0188;
	Thu, 24 Apr 2025 21:03:44 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 21:03:43 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Apr
 2025 21:03:43 +0800
Message-ID: <497a60df-c97e-48b7-bf0f-decbee6ed732@huawei.com>
Date: Thu, 24 Apr 2025 21:03:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: <admiyo@os.amperecomputing.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250423220142.635223-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi,

在 2025/4/24 6:01, admiyo@os.amperecomputing.com 写道:
> From: Adam Young <admiyo@os.amperecomputing.com>
>
> Implementation of network driver for
> Management Control Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
>
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/\
> DSP0292_1.0.0WIP50.pdf
>
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified
> in the PCCT.
>
> Communication with other devices use the PCC based
> doorbell mechanism.
 From your code, I think mctp driver use type3 and type4, right?
So suggest that add some comments about this in commit log.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   MAINTAINERS                 |   5 +
>   drivers/net/mctp/Kconfig    |  13 ++
>   drivers/net/mctp/Makefile   |   1 +
>   drivers/net/mctp/mctp-pcc.c | 317 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 336 insertions(+)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
<...>
> +#define MCTP_HEADER_LENGTH      12
> +#define MCTP_MIN_MTU            68
> +#define PCC_MAGIC               0x50434300
> +#define PCC_HEADER_FLAG_REQ_INT 0x1
Please use PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY in pcc.h
no need to repeatedly define macro.
> +#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
> +#define PCC_DWORD_TYPE          0x0c
> +
> +struct mctp_pcc_hdr {
> +	__le32 signature;
> +	__le32 flags;
> +	__le32 length;
> +	char mctp_signature[MCTP_SIGNATURE_LENGTH];
> +};
> +
<...>
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr *mctp_pcc_header;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +	int rc;
> +
> +	rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
> +	if (rc)
> +		goto err_drop;
> +
> +	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
> +	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
> +	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
> +	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
> +	       MCTP_SIGNATURE_LENGTH);
> +	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer = mpnd->outbox.chan->shmem;
> +	memcpy_toio(buffer, skb->data, skb->len);
> +	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
> +							NULL);
> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +
Why does it not need to know if the packet is sent successfully?
It's possible for the platform not to finish to send the packet after 
executing this unlock.
In this moment, the previous packet may be modified by the new packet to 
be sent.
> +	dev_dstats_tx_add(ndev, len);
> +	dev_consume_skb_any(skb);
> +	return NETDEV_TX_OK;
> +err_drop:
> +	dev_dstats_tx_dropped(ndev);
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops mctp_pcc_netdev_ops = {
> +	.ndo_start_xmit = mctp_pcc_tx,
> +};
> +
<...>
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0, 0, 0};
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct device *dev = &acpi_dev->dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	int mctp_pcc_mtu;
> +	char name[32];
> +	int rc;
> +
> +	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
> +		return -EINVAL;
> +	}
> +
> +	/* inbox initialization */
> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	spin_lock_init(&mctp_pcc_ndev->lock);
> +
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
> +					 context.inbox_index);
> +	if (rc)
> +		goto free_netdev;
> +	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
It is good to move the assignemnt of  rx_callback pointer to initialize 
inbox mailbox.
> +
> +	/* outbox initialization */
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
> +					 context.outbox_index);
> +	if (rc)
> +		goto free_netdev;
> +
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->inbox.client.dev = dev;
> +	mctp_pcc_ndev->outbox.client.dev = dev;
> +	mctp_pcc_ndev->mdev.dev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	/* There is no clean way to pass the MTU to the callback function
> +	 * used for registration, so set the values ahead of time.
> +	 */
> +	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
> +		sizeof(struct mctp_pcc_hdr);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	/* ndev needs to be freed before the iomemory (mapped above) gets
> +	 * unmapped,  devm resources get freed in reverse to the order they
> +	 * are added.
> +	 */
> +	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto free_netdev;
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001"},
> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");

