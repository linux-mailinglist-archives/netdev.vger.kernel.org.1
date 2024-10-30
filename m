Return-Path: <netdev+bounces-140313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE469B5F18
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6383B22640
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00761E25FE;
	Wed, 30 Oct 2024 09:45:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966091DE2B6;
	Wed, 30 Oct 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281512; cv=none; b=gx242v6f4LdFXpmgok9jlLiYQzH5TNidU4Fmm5r34HBydXR9yKE0YTgPGsNDoiJQ9HTRUfcOJ0dty+aeUadWBz+I5iolnY/h6Y11gUAl97GSlCuiXvO/Hs772Z5UObmzHSgzwaMUXLC7DqhLSVQYnSQHNBIv2HIfrdlXTJ9iC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281512; c=relaxed/simple;
	bh=I9XPdxjoC7VciZ+wY//vgYzOAebYo9U+w3J9yl/ksKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RXt5qeapAC97LInZm3V61ggU+/qUEv+d25s3/81reRHTG45FOcKrxnpz3gnyxgfyg4Q4s2SSj/yY/MfMu+t7eyG4pFDSVZgA1on1ekKgWZ86xaLr2Nv8u3LZ6AEoTP/IDopu7TY7JqvqHdRf0nMUxV+hP0aweFKUona9mc4B6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xdhz96McHzQsVD;
	Wed, 30 Oct 2024 17:44:05 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 63256180103;
	Wed, 30 Oct 2024 17:45:05 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 17:45:04 +0800
Message-ID: <a05fd200-c1ea-dff6-8cfa-43077c6b4a99@huawei.com>
Date: Wed, 30 Oct 2024 17:45:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
To: <admiyo@os.amperecomputing.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Len
 Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Robert Moore <robert.moore@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Jassi Brar <jassisinghbrar@gmail.com>, Sudeep
 Holla <sudeep.holla@arm.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-2-admiyo@os.amperecomputing.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20241029165414.58746-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Hi Adam,

在 2024/10/30 0:54, admiyo@os.amperecomputing.com 写道:
> From: Adam Young <admiyo@os.amperecomputing.com>
>
> Type 4 PCC channels have an option to send back a response
> to the platform when they are done processing the request.
> The flag to indicate whether or not to respond is inside
> the message body, and thus is not available to the pcc
> mailbox.
>
> In order to read the flag, this patch maps the shared
> buffer to virtual memory.
>
> If the flag is not set, still set command completion
> bit after processing message.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   drivers/mailbox/pcc.c | 35 +++++++++++++++++++++++++++--------
>   include/acpi/pcc.h    |  8 ++++++++
>   2 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 94885e411085..b2a66e8a6cd6 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -90,6 +90,7 @@ struct pcc_chan_reg {
>    * @cmd_complete: PCC register bundle for the command complete check register
>    * @cmd_update: PCC register bundle for the command complete update register
>    * @error: PCC register bundle for the error status register
> + * @shmem_base_addr: the virtual memory address of the shared buffer
>    * @plat_irq: platform interrupt
>    * @type: PCC subspace type
>    * @plat_irq_flags: platform interrupt flags
> @@ -107,6 +108,7 @@ struct pcc_chan_info {
>   	struct pcc_chan_reg cmd_complete;
>   	struct pcc_chan_reg cmd_update;
>   	struct pcc_chan_reg error;
> +	void __iomem *shmem_base_addr;
>   	int plat_irq;
>   	u8 type;
>   	unsigned int plat_irq_flags;
> @@ -269,6 +271,27 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>   	return !!val;
>   }
>   
> +static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> +{
> +	struct pcc_extended_type_hdr pcc_hdr;
> +
> +	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> +		return;
> +	memcpy_fromio(&pcc_hdr, pchan->shmem_base_addr,
> +		      sizeof(struct pcc_extended_type_hdr));
> +	/*
> +	 * The PCC slave subspace channel needs to set the command complete bit
> +	 * after processing message. If the PCC_ACK_FLAG is set, it should also
> +	 * ring the doorbell.
> +	 *
> +	 * The PCC master subspace channel clears chan_in_use to free channel.
> +	 */
> +	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
> +		pcc_send_data(chan, NULL);
> +	else
> +		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> +}
> +
>   /**
>    * pcc_mbox_irq - PCC mailbox interrupt handler
>    * @irq:	interrupt number
> @@ -306,14 +329,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   
>   	mbox_chan_received_data(chan, NULL);
>   
> -	/*
> -	 * The PCC slave subspace channel needs to set the command complete bit
> -	 * and ring doorbell after processing message.
> -	 *
> -	 * The PCC master subspace channel clears chan_in_use to free channel.
> -	 */
> -	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> -		pcc_send_data(chan, NULL);
> +	check_and_ack(pchan, chan);
>   	pchan->chan_in_use = false;
>   
>   	return IRQ_HANDLED;
> @@ -352,6 +368,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> +	pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
> +					      pchan->chan.shmem_base_addr,
> +					      pchan->chan.shmem_size);
Currently, the PCC mbox client does ioremap after requesting PCC channel.
Thus all current clients will ioremap twice. This is not good to me.
How about add a new interface and give the type4 client the right to 
decide whether to reply in rx_callback?
>   	return &pchan->chan;
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 9b373d172a77..0bcb86dc4de7 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -18,6 +18,13 @@ struct pcc_mbox_chan {
>   	u16 min_turnaround_time;
>   };
>   
> +struct pcc_extended_type_hdr {
> +	__le32 signature;
> +	__le32 flags;
> +	__le32 length;
> +	char command[4];
> +};

No need to define this new structure and directly use "struct 
acpi_pcct_ext_pcc_shared_memory".

> +
>   /* Generic Communications Channel Shared Memory Region */
>   #define PCC_SIGNATURE			0x50434300
>   /* Generic Communications Channel Command Field */
> @@ -31,6 +38,7 @@ struct pcc_mbox_chan {
>   #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
>   
>   #define MAX_PCC_SUBSPACES	256
> +#define PCC_ACK_FLAG_MASK	0x1
directly use the macro PCC_CMD_COMPLETION_NOTIF
>   
>   #ifdef CONFIG_PCC
>   extern struct pcc_mbox_chan *

