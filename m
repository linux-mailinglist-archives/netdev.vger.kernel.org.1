Return-Path: <netdev+bounces-209210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B1FB0EA69
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C1D16731D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644F248F4A;
	Wed, 23 Jul 2025 06:14:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB21A0BFD;
	Wed, 23 Jul 2025 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251267; cv=none; b=eNPx5sYnMsBxT1QWpM930RHkJincVL/YuSqc/WpBlZroNEe9W/Lt0/OvA1GD6A9NfmPZaOTwht2kPBOiaPqqzqVpkY+KkPJllulfYs9dAKD5D5dVLXMZZZrZMIjVIaiy1aztaDgKOVcBc4NRu+x4/hTCLCGjxatKHGm8HzBnjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251267; c=relaxed/simple;
	bh=eOp8B5FEQjPYgaY8oyZNnVe9OVIKUc0sH+uAJU1qXyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME31lEdUefrBHgsOSViMJ03/9733kOLa3w2i3FhXf/F22swaBqLQbzkfl+r9uUfhf/fqKlscq+ZcjkaZqtrD5LHfBXov8CTNMT0Ed3QiAS7Ra5IdOmlgg85J6gP9vB5vsTLfH3duMLaRGFYredHDI6cpKjO8tNPDPUpvZjM6Kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1753251185t633970d9
X-QQ-Originating-IP: 7fAbvXkimtFsEETOli6idrq+iTqKCtYaOTIC1dZ/jwM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 14:13:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7362397933906693450
Date: Wed, 23 Jul 2025 14:13:03 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] net: rnpgbe: Add netdev irq in open
Message-ID: <2C80B81E5B7F54CD+20250723061303.GE169181@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-11-dong100@mucse.com>
 <20250722140326.GJ2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722140326.GJ2459@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NZcrde3zhHkVc4vD6pFJ0MsmdlniyAZ1/GnUJawXfuNgJNYvhe66+B2Q
	hAjz+caQByEVUdAJLe+AOq7TSO39J5A9v9jhjUCmgLhNvERxR+5rylo6XiQayJZhFPHk+f5
	kwzMSTFoiZ0OeJPGwOoW6yRA5LN7r9tyuu3fj/OpaPYgTLxlo3JslmpZ6Us30vF6cRNRbrn
	w4QLBpsvkOz1p4zlbw8BwEVpqy5U1bhqbLdVqeLT+Q+h+yMP8pfDyNk665NP4EmiHtIjklL
	a7YUJUPyIQkaC3xjjHG5t9U2OBExkmzb3YHZ4ojQzKDg/PEqo8J8I4l64dVcrojO6CMzAN0
	dmDkub3G303j4Yc0VyMm6Lfwgm2lltrVpbbnlYYfGsgrJyCAUvTMd7XHx+YrkKDvR03Xs/0
	hwpvFBfg2oWmrMZpr721wogaAX/3pxtzfnDyEMRsSBN7hfJxl921t1lz21LTTPeLDhXfwzh
	HUYi+SVrkfturNKML1Fa2OWTpvh0KgSGfTKaxiozFWsHzylhm1BPMzXqvUBpf+8A52Nfl8e
	bTe8uaDy8eW0AJAgKz7GoVl8V6YnnMneCUPQYzBMJLJBkW3lt2sPAQHwlZ4Bjgkekf500u8
	aX36pok1PF7fimdAptFALf5geA5OOpeCBk+/4dndYX8k1NbcxD/Rh6thqEvSUVmb+3vOqm2
	xMqslxbC+NHFbJOd5HAoo8VDOSl63U8bGLuJg8PvMEhcDjJ/9sbQQ3+6DPDqx7T+FjfHWk7
	DfqhFxLgNRz/B6mdubc4jnm6vNq1k86n4oEkvUcNi4OBqTimIngGyQVzxFPxbArbGqD6RM9
	wGGcsPzVoLuk0SiYvvRGPckweZ9k1uOl3ykNV34iFT5fSP6I0VJ4uxRplk9BG9D2G/gm7Hu
	B5DCPCnzPlAa3Ce7gDdaOgT0zSPeYD+x/NqFabWfhuozBAo5dj5Du4euZM7Osyu2Fo7F8ju
	ZCHVBRkSbTTnCYVfiQKTS+AUs39Z6i3Sh2qfayo+2CBYmahfmczrZaCLy
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 03:03:26PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 07:32:33PM +0800, Dong Yibo wrote:
> > Initialize irq for tx/rx in open func.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> 
> ...
> 
> > +/**
> > + * rnpgbe_set_mac_hw_ops_n500 - Setup mac address to hw
> > + * @hw: pointer to hw structure
> > + * @mac: pointer to mac addr
> > + *
> > + * Setup a mac address to hw.
> > + **/
> > +static void rnpgbe_set_mac_hw_ops_n500(struct mucse_hw *hw, u8 *mac)
> > +{
> > +	struct mucse_eth_info *eth = &hw->eth;
> > +	struct mucse_mac_info *mac_info = &hw->mac;
> 
> Reverse xmas tree here please.
> 

Got it, I'll fix it.

> > +
> > +	/* use idx 0 */
> > +	eth->ops.set_rar(eth, 0, mac);
> > +	mac_info->ops.set_mac(mac_info, mac, 0);
> > +}
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> 
> ...
> 
> > +/**
> > + * rnpgbe_msix_clean_rings - msix irq handler for ring irq
> > + * @irq: irq num
> > + * @data: private data
> > + *
> > + * rnpgbe_msix_clean_rings handle irq from ring, start napi
> 
> Please also document the return value of this function.
> Likewise for rnpgbe_request_msix_irqs(), rnpgbe_intr() and
> rnpgbe_request_irq().
> 

Got it, I'll fix it.

> > + **/
> > +static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
> > +{
> > +	return IRQ_HANDLED;
> > +}
> 
> ...
> 
> > +/**
> > + * rnpgbe_request_msix_irqs - Initialize MSI-X interrupts
> > + * @mucse: pointer to private structure
> > + *
> > + * rnpgbe_request_msix_irqs allocates MSI-X vectors and requests
> > + * interrupts from the kernel.
> > + **/
> > +static int rnpgbe_request_msix_irqs(struct mucse *mucse)
> > +{
> > +	struct net_device *netdev = mucse->netdev;
> > +	int q_off = mucse->q_vector_off;
> > +	struct msix_entry *entry;
> > +	int i = 0;
> > +	int err;
> > +
> > +	for (i = 0; i < mucse->num_q_vectors; i++) {
> > +		struct mucse_q_vector *q_vector = mucse->q_vector[i];
> > +
> > +		entry = &mucse->msix_entries[i + q_off];
> > +		if (q_vector->tx.ring && q_vector->rx.ring) {
> > +			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
> > +				 "%s-%s-%d", netdev->name, "TxRx", i);
> 
> Probably the full range of i is not used, in particular I assume
> it is never negative, and thus i and mucse->num_q_vectors
> could be unsigned int rather than int.
> 
> But as it stands q_vector->name is once character too short to
> fit the maximum possible string formatted by snprintf().
> 
> I was able to address the warning flagged by GCC 15.0.0 about this by
> increasing the size of q_vector->name by one byte.
> 
>   .../rnpgbe_lib.c: In function 'rnpgbe_request_irq':
>   .../rnpgbe_lib.c:1015:43: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
>    1015 |                                  "%s-%s-%d", netdev->name, "TxRx", i);
>         |                                           ^
>   In function 'rnpgbe_request_msix_irqs',
>       inlined from 'rnpgbe_request_irq' at drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c:1069:9:
>   .../rnpgbe_lib.c:1014:25: note: 'snprintf' output between 8 and 33 bytes into a destination of size 32
>    1014 |                         snprintf(q_vector->name, sizeof(q_vector->name) - 1,
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1015 |                                  "%s-%s-%d", netdev->name, "TxRx", i);
>         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 

Yes, q_vector->name is too short, I'll fix it.

> > +		} else {
> > +			/* skip this unused q_vector */
> > +			continue;
> > +		}
> > +		err = request_irq(entry->vector, &rnpgbe_msix_clean_rings, 0,
> > +				  q_vector->name, q_vector);
> > +		if (err)
> > +			goto free_queue_irqs;
> > +		/* register for affinity change notifications */
> > +		q_vector->affinity_notify.notify = rnpgbe_irq_affinity_notify;
> > +		q_vector->affinity_notify.release = rnpgbe_irq_affinity_release;
> > +		irq_set_affinity_notifier(entry->vector,
> > +					  &q_vector->affinity_notify);
> > +		irq_set_affinity_hint(entry->vector, &q_vector->affinity_mask);
> > +	}
> > +
> > +	return 0;
> > +
> > +free_queue_irqs:
> > +	while (i) {
> > +		i--;
> > +		entry = &mucse->msix_entries[i + q_off];
> > +		irq_set_affinity_hint(entry->vector, NULL);
> > +		free_irq(entry->vector, mucse->q_vector[i]);
> > +		irq_set_affinity_notifier(entry->vector, NULL);
> > +		irq_set_affinity_hint(entry->vector, NULL);
> > +	}
> > +	return err;
> > +}
> 
> ...
> 

Thanks for your feedback.


