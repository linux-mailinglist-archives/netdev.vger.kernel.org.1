Return-Path: <netdev+bounces-114908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A28944A8A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BE61C211AD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C218FDC0;
	Thu,  1 Aug 2024 11:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097F18E051;
	Thu,  1 Aug 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512499; cv=none; b=uF1iXbE25PS1/ufQqFtgCaltTXCrQ3nE3YFiFTnQ6geUQ9RKvERSP78d7H47XY93qX7I4Eh24enR26PzxG1tPxPC+mWeiJjVugOkO3LdHso6CYvz376ATPPofsPdh6oczagruO10oDxVxkNxO4ddKhCWRt2uJILPMweYaeen29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512499; c=relaxed/simple;
	bh=VA4aajdQYA4BZmq2fOh1ASOrzA+FLFY/ZnhHV2ByOUk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRQ90DMy/6CVAn6tryBoDXx+xMESwM/BFPE1EZ4sbQS4y0Uwg9IFno2vlL2V7c8l7QnxzKejtiBvnaUxsjI7XUkVAE0Hmo2RamPsfH+5XxXCQDU8bY/LrCBtkxdmcFiBo5/fuozC+cqGPnJ28QQL2NF0hglGHlfPrirHSk5qPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WZRnq6Gc4z6K5Wh;
	Thu,  1 Aug 2024 19:39:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BA858140B33;
	Thu,  1 Aug 2024 19:41:28 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 12:41:28 +0100
Date: Thu, 1 Aug 2024 12:41:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <admiyo@os.amperecomputing.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar
	<jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Huisong Li
	<lihuisong@huawei.com>
Subject: Re: [PATCH v5 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <20240801124126.00007a57@Huawei.com>
In-Reply-To: <20240712023626.1010559-2-admiyo@os.amperecomputing.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
	<20240712023626.1010559-2-admiyo@os.amperecomputing.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jul 2024 22:36:24 -0400
admiyo@os.amperecomputing.com wrote:

> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Type 4 PCC channels have an option to send back a response
> to the platform when they are done processing the request.
> The flag to indicate whether or not to respond is inside
> the message body, and thus is not available to the pcc
> mailbox.
Hi Adam,

I've been meaning to look at this for a while, but finally
getting time for review catchup.

Would be good to have an explicit specification reference to
make it easy for reviewers to find the bit to compare with.

> 
> In order to read the flag, this patch maps the shared
> buffer to virtual memory.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/mailbox/pcc.c | 32 ++++++++++++++++++++++++--------
>  include/acpi/pcc.h    |  8 ++++++++
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 94885e411085..4a588f1b6ec2 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -90,6 +90,7 @@ struct pcc_chan_reg {
>   * @cmd_complete: PCC register bundle for the command complete check register
>   * @cmd_update: PCC register bundle for the command complete update register
>   * @error: PCC register bundle for the error status register
> + * @shmem_base_addr: the virtual memory address of the shared buffer

If you are only going to map this from this pointer for the
initiator/responder shared memory region, maybe it would benefit
from a more specific name?

>   * @plat_irq: platform interrupt
>   * @type: PCC subspace type
>   * @plat_irq_flags: platform interrupt flags
> @@ -107,6 +108,7 @@ struct pcc_chan_info {
>  	struct pcc_chan_reg cmd_complete;
>  	struct pcc_chan_reg cmd_update;
>  	struct pcc_chan_reg error;
> +	void __iomem *shmem_base_addr;
>  	int plat_irq;
>  	u8 type;
>  	unsigned int plat_irq_flags;
> @@ -269,6 +271,24 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>  	return !!val;
>  }
>  
> +static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> +{
> +	struct pcc_extended_type_hdr pcc_hdr;

I'd avoid name pcc_hdr, as it's only the header on a paricular type
of pcc subspace.  Either go super generic with hdr or
pcc_rsp_subspc_hdr or something along those lines.

> +
> +	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> +		return;

I'd put a blank line here. Next bit is unrelated to the error check
so white space will help with readability (a little bit anyway!)

> +	memcpy_fromio(&pcc_hdr, pchan->shmem_base_addr,
> +		      sizeof(struct pcc_extended_type_hdr));

sizeof(pcc_hdr)

> +	/*
> +	 * The PCC slave subspace channel needs to set the command complete bit
> +	 * and ring doorbell after processing message.
> +	 *
> +	 * The PCC master subspace channel clears chan_in_use to free channel.
> +	 */
> +	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
> +		pcc_send_data(chan, NULL);
> +}
> +
>  /**
>   * pcc_mbox_irq - PCC mailbox interrupt handler
>   * @irq:	interrupt number
> @@ -306,14 +326,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  
>  	mbox_chan_received_data(chan, NULL);
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
>  	pchan->chan_in_use = false;
>  
>  	return IRQ_HANDLED;
> @@ -352,6 +365,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
> +					      pchan->chan.shmem_base_addr,
> +					      pchan->chan.shmem_size);

devm doesn't seem appropriate here given we have manual management
of other resources, so the ordering will be different in remove
vs probe.

So I'd handle release of this manually in mbox_free_channel()


>  	return &pchan->chan;
>  }
>  EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 9b373d172a77..0bcb86dc4de7 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -18,6 +18,13 @@ struct pcc_mbox_chan {
>  	u16 min_turnaround_time;
>  };
>  
> +struct pcc_extended_type_hdr {
Spec reference would be useful for this.
Looks to be Table 14.12 in acpi 6.5.
I can't remember convention in this file for whether you need
to find earliest spec for references or not.

> +	__le32 signature;
> +	__le32 flags;
> +	__le32 length;
> +	char command[4];
> +};
> +
>  /* Generic Communications Channel Shared Memory Region */
>  #define PCC_SIGNATURE			0x50434300
>  /* Generic Communications Channel Command Field */
> @@ -31,6 +38,7 @@ struct pcc_mbox_chan {
>  #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
>  
>  #define MAX_PCC_SUBSPACES	256
> +#define PCC_ACK_FLAG_MASK	0x1

Maybe this should be something like
PCC_EXT_FLAGS_ACK_MASK
to give a hint of where it applies.
Also, can we keep name closer to the spec (even though it's
meaning is that we must ack the command when done)

PCC_EXT_FLAGS_NOTIFY_ON_COMPLETION_MASK


>  
>  #ifdef CONFIG_PCC
>  extern struct pcc_mbox_chan *


