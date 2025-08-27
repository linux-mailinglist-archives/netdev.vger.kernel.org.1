Return-Path: <netdev+bounces-217155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C57B379BF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81711B27686
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F130F941;
	Wed, 27 Aug 2025 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CrGX+oA6"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EE1F4634;
	Wed, 27 Aug 2025 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272412; cv=none; b=mrJt6JXKRNhDRD2Uy28WPBtnhlkJFoOuf2uhr+apqYn2JMnW8KDZsKOXW0JcA45PdB8G4S+cVl3Ejje+tllUsAVfb2TWQ8gAOgeCkLt+/KOYVhFZi71WiWB6sNU+fhQgp0AQ2atasgSll2uFUSa8elMYi3CJMvM+BTreFenmxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272412; c=relaxed/simple;
	bh=TJUP34WJXgMc/PFfTnwvvpNGYvGS1zSefzP7qdcI5EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjzI8VSSywAgcbvaZKPXU67mc6FSVlBFSJ2CTv3l0J23qt+DmGiIiVv8eZI2eM9zVOnLRvA+KDPoLWnkzMuC24uUEvVSXscS/KViNpl+q1LnlL2BwUB93r+bvtoHbKf2+aKgb+zQlZyMWqLGCiFTnvycwj+15wHebXcaLet3IQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CrGX+oA6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7B0I4tQu/4Ondp5JiMcitv5+BItz2nYZPupXPqkEpEU=; b=CrGX+oA6gsyrvUMxRv+4W2Nf8L
	BvzwVEqfQdLmdAw6dGIOTV+Z1sbfs6xmzOj5sRab31kBKGRr+AnLy/0Q17DT+ZGuLEEJXWz5UfQjD
	CVwTMd3f6WBnAwIf7nWNzUip0bSfYQVEm4bNKCdzz6qh0alHTzjQH1cZiTYUU1BygQVg1ZuRgSRyG
	EGvH98NDv46RdLw5uccDnf5R4G1IOC9DKsOi27tOeHHjzcsJ1CgRPfIJLnlZw3nHirfvBzrgY/In8
	KFI2hIJTtlZgIAeNfVEitX6wZ36zhYegBM6GbLERQtmMQwrve99exrSG6KaXG8Hhv/yGHVgkKDaDM
	P17haqVg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur8gB-0000000E7O8-29CU;
	Wed, 27 Aug 2025 05:26:39 +0000
Message-ID: <4b6eb676-10f5-4438-9457-6aeda0ee7fb0@infradead.org>
Date: Tue, 26 Aug 2025 22:26:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 4/5] net: rnpgbe: Add basic mbx_fw support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250827034509.501980-1-dong100@mucse.com>
 <20250827034509.501980-5-dong100@mucse.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250827034509.501980-5-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 8:45 PM, Dong Yibo wrote:
> Initialize basic mbx_fw ops, such as get_capability, reset phy
> and so on.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   1 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 253 ++++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 +++++++++
>  4 files changed, 382 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> 


> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> new file mode 100644
> index 000000000000..d3b323760708
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include <linux/pci.h>
> +#include <linux/if_ether.h>
> +
> +#include "rnpgbe.h"
> +#include "rnpgbe_hw.h"
> +#include "rnpgbe_mbx.h"
> +#include "rnpgbe_mbx_fw.h"
> +
> +/**
> + * mucse_fw_send_cmd_wait - Send cmd req and wait for response
> + * @hw: pointer to the HW structure
> + * @req: pointer to the cmd req structure
> + * @reply: pointer to the fw reply structure
> + *
> + * mucse_fw_send_cmd_wait sends req to pf-fw mailbox and wait
> + * reply from fw.
> + *
> + * @return: 0 on success, negative on failure

Use of @return: is not a documented feature although kernel-doc does accept it.
I prefer that people don't use it, but I can't insist since it does work.


> + **/
> +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> +				  struct mbx_fw_cmd_req *req,
> +				  struct mbx_fw_cmd_reply *reply)
> +{
> +	int len = le16_to_cpu(req->datalen);
> +	int retry_cnt = 3;
> +	int err;
> +
> +	err = mutex_lock_interruptible(&hw->mbx.lock);
> +	if (err)
> +		return err;
> +	err = mucse_write_posted_mbx(hw, (u32 *)req, len);
> +	if (err)
> +		goto out;
> +	do {
> +		err = mucse_read_posted_mbx(hw, (u32 *)reply,
> +					    sizeof(*reply));
> +		if (err)
> +			goto out;
> +		/* mucse_write_posted_mbx return 0 means fw has
> +		 * received request, wait for the expect opcode
> +		 * reply with 'retry_cnt' times.
> +		 */
> +	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> +out:
> +	mutex_unlock(&hw->mbx.lock);
> +	if (!err && retry_cnt < 0)
> +		return -ETIMEDOUT;
> +	if (!err && reply->error_code)
> +		return -EIO;
> +	return err;
> +}


[snip]

> +
> +/**
> + * mucse_fw_get_capability - Get hw abilities from fw
> + * @hw: pointer to the HW structure
> + * @abil: pointer to the hw_abilities structure
> + *
> + * mucse_fw_get_capability tries to get hw abilities from
> + * hw.
> + *
> + * @return: 0 on success, negative on failure

negative errno or just some negative number?

> + **/
> +static int mucse_fw_get_capability(struct mucse_hw *hw,
> +				   struct hw_abilities *abil)
> +{
> +	struct mbx_fw_cmd_reply reply = {};
> +	struct mbx_fw_cmd_req req = {};
> +	int err;
> +
> +	build_phy_abilities_req(&req);
> +	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
> +	if (!err)
> +		memcpy(abil, &reply.hw_abilities, sizeof(*abil));
> +	return err;
> +}

-- 
~Randy


