Return-Path: <netdev+bounces-109032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAA926926
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C609828629B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF126188CAE;
	Wed,  3 Jul 2024 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJmjpvqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FD181D18;
	Wed,  3 Jul 2024 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036357; cv=none; b=M8HxL3nyQond7flaQ1g5uR73kS8thEAFVNYrq1M8DbGQWW3bK7y67uMuEbFZJK9YGUyygjnAeg4E4q8RowL2rRtGTQi9enD67Zt2rxIrkn49ow3dSQxzZE4QXAZw8v2P4+P8Bx90RaZpKVNC1jYFsveOvjyKAAkM2U7j8II/BG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036357; c=relaxed/simple;
	bh=SSf8EEiYJl+cIBUyLGw+GzZZCxWRqRns//AUx52kaDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLhwL/E0Xc9kRZA//LpYDTbJ4uAr1/PDiSrek9rRWxiSkgwr1Or0txYFuTRkSyqg9RzxxZA0bBtpd0laFTswGjPHJCdH2ws7yHkx2LUo1Wg32XBMKgcwG0g8so00Tcg2Sy9MOwy+4R1Js28f1/Q/fIRf+9psQ8YnE0kLtN4/bMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJmjpvqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D3C2BD10;
	Wed,  3 Jul 2024 19:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720036357;
	bh=SSf8EEiYJl+cIBUyLGw+GzZZCxWRqRns//AUx52kaDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJmjpvqKwRkF2aYo0BrtDm0bKqnEKEPvSsmBsTLKtHvjQ48UksLjDehIgwvCKUHDv
	 EUZNIsmpUhm4dw1wcObPn9+FQUZ7WAql7bplRe/RCmQV+/EMZ94O+5p5wOx3xpYWgP
	 iah9QAjUygQEon8wouxZuOp1ODDoOCulIvqT//WGpSmGdGwr9uAER46YWPY9lMd7lU
	 /mX1qdxeXbd82l1umXe9VAjtqrZ9tgAjz0bE7jBxsGIetEcnpaNodBeTMLDIA2UYYt
	 +ur+KI3WQexudfUHJ6WHCd9DI/K/sDf3flv755A8+Fq2p5+9AMCyOcZjhYE3KBncFN
	 TJGWmA/3xQe7g==
Date: Wed, 3 Jul 2024 20:52:32 +0100
From: Simon Horman <horms@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v4 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <20240703195232.GQ598357@kernel.org>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
 <20240702225845.322234-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702225845.322234-2-admiyo@os.amperecomputing.com>

On Tue, Jul 02, 2024 at 06:58:43PM -0400, admiyo@os.amperecomputing.com wrote:
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
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/mailbox/pcc.c | 31 +++++++++++++++++++++++--------
>  include/acpi/pcc.h    |  8 ++++++++
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 94885e411085..cad6b5bc4b04 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -107,6 +107,7 @@ struct pcc_chan_info {
>  	struct pcc_chan_reg cmd_complete;
>  	struct pcc_chan_reg cmd_update;
>  	struct pcc_chan_reg error;
> +	void __iomem *shmem_base_addr;

Hi Adam,

Please add an entry for shmem_base_addr to the Kernel doc for this
structure, which appears just above the structure.

Flagged by ./scripts/kernel-doc -none

>  	int plat_irq;
>  	u8 type;
>  	unsigned int plat_irq_flags;
> @@ -269,6 +270,24 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>  	return !!val;
>  }
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
> +	 * and ring doorbell after processing message.
> +	 *
> +	 * The PCC master subspace channel clears chan_in_use to free channel.
> +	 */
> +	if (!!le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)

Should this be:

	if (!!(le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK))

In which case I think it can be more simply expressed as:

	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)

Flagged by Smatch and Sparse.

> +		pcc_send_data(chan, NULL);
> +}
> +
>  /**
>   * pcc_mbox_irq - PCC mailbox interrupt handler
>   * @irq:	interrupt number

...

> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h

...

> @@ -31,6 +38,7 @@ struct pcc_mbox_chan {
>  #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
>  
>  #define MAX_PCC_SUBSPACES	256
> +#define PCC_ACK_FLAG_MASK       0x1

nit: For consistency please follow the white-space pattern of the preceding
     line: please use a tab rathe rthan spaces between ...MASK and 0x1.

>  
>  #ifdef CONFIG_PCC
>  extern struct pcc_mbox_chan *
> -- 
> 2.34.1
> 
> 

-- 
pw-bot: changes-requested


