Return-Path: <netdev+bounces-282409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLurMBwS8mmlngEAu9opvQ
	(envelope-from <netdev+bounces-282409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:13:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFA3495715
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF0413003D0E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050C83FD134;
	Wed, 29 Apr 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mOq5A09g"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51844303C8A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472021; cv=none; b=JVAIHeJlSTZ5K//kOsrcLmcQi4mn205aSR4z/mGs7bak8awqXw/HjH4e9gLDG10yRJrrKLhoFwOBP27UEJYOZUdabvy72dm7bmgcs6MJEBcwxDmjPp50OVK8p4MgqG1nRyuWWQjcFp7Vhi5ljVEL/Wgl6sWRwsSWHFmSk28Nkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472021; c=relaxed/simple;
	bh=jTtUl9ulq2p1KLcPt+OQvjW8C/NJ4C31akzcnbiE3MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E52jMDNR3lhLrEdbyoaZ4GwyC/aYilX2KhkTRN9MUeKP8to1V3HTHcSOeH6IlRujb/of1P8AFb9vgk+yfbyKT4yPoT4yRen+TCzeTTuGV6tsPHzlYe5vANeN8AeJX2zoF0NjmDxz2mYg73XIzu2ZbwLdO5e2ARf4Yz2JY/MzdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mOq5A09g; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <565fa668-0904-49f0-b53f-0b57e513dc8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777472008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LZSbzVWHtKhHsL/iZoIduGJ5Xv418vYwJv+dtxrITw=;
	b=mOq5A09gsDIMI0RvFP4QLRhiHgH1qDAu+Adbi7kVDY3f4Fc3jBiuAwhmv+zz1EivEv1IFB
	iyfQ0PyJGcDuwx775v9I/0Fz24YPDi2IEmG/SaVnSocIw5nMvTGgvGExxB+U+WTH3l2Fii
	sq1ZFd3ruhWdcxhfIAeNVcz6aqHYUSU=
Date: Wed, 29 Apr 2026 15:13:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC Patch net-next v2 2/8] r8169: add support for multi irqs
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
 <20260429070750.1477-3-javen_xu@realsil.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260429070750.1477-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7EFA3495715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282409-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]


[...]

>   static int rtl_alloc_irq(struct rtl8169_private *tp)
>   {
> +	struct pci_dev *pdev = tp->pci_dev;
>   	unsigned int flags;
> +	int nvecs = 1;

nit: unneeded initialization

>   
>   	switch (tp->mac_version) {
>   	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
> @@ -5402,7 +5519,15 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>   		break;
>   	}
>   
> -	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, tp->min_irq_nvecs, tp->max_irq_nvecs, flags);

for RTL8127 you try to allocate 30 to 32 IRQ vectors here...

> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +
> +	tp->irq = pdev->irq;
> +	tp->irq_nvecs = 1;

.. but completely ignores the result here. why?

> +
> +	return nvecs;
>   }
>   
>   static void rtl_read_mac_address(struct rtl8169_private *tp,
> @@ -5597,6 +5722,18 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
>   	}
>   }
>   
> +static int rtl8169_set_real_num_queue(struct rtl8169_private *tp)
> +{
> +	int retval;
> +
> +	retval = netif_set_real_num_tx_queues(tp->dev, 1);
> +	if (retval < 0)
> +		return retval;
> +
> +	retval = netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);
> +	return retval;

simply
	return netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);

> +}
> +
>   static int rtl_jumbo_max(struct rtl8169_private *tp)
>   {
>   	/* Non-GBit versions don't support jumbo frames */
> @@ -5657,6 +5794,19 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>   	return false;
>   }
>   
> +static void r8169_init_napi(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		struct rtl8169_napi *r8169napi = &tp->r8169napi[i];
> +		int (*poll)(struct napi_struct *napi, int budget);
> +
> +		poll = rtl8169_poll;
> +		netif_napi_add(tp->dev, &r8169napi->napi, poll);
> +		r8169napi->priv = tp;
> +		r8169napi->index = i;
> +	}
> +}
> +
>   static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
>   	const struct rtl_chip_info *chip;
> @@ -5761,11 +5911,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   	rtl_hw_reset(tp);
>   
> +	rtl_software_parameter_initialize(tp);
> +
>   	rc = rtl_alloc_irq(tp);
>   	if (rc < 0)
>   		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");

positive rc value (which is the allocated irq vectors) is lost here.

>   
> -	tp->irq = pci_irq_vector(pdev, 0);
>   
>   	INIT_WORK(&tp->wk.work, rtl_task);
>   	disable_work(&tp->wk.work);
> @@ -5774,7 +5925,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   	dev->ethtool_ops = &rtl8169_ethtool_ops;
>   
> -	netif_napi_add(dev, &tp->napi, rtl8169_poll);
> +	if (!tp->rss_support) {
> +		netif_napi_add(dev, &tp->r8169napi[0].napi, rtl8169_poll);
> +		tp->r8169napi[0].priv = tp;
> +		tp->r8169napi[0].index = 0;
> +	} else {
> +		r8169_init_napi(tp);
> +	}
>   
>   	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
>   			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> @@ -5836,6 +5993,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (jumbo_max)
>   		dev->max_mtu = jumbo_max;
>   
> +	rc = rtl8169_set_real_num_queue(tp);
> +	if (rc < 0)
> +		return dev_err_probe(&pdev->dev, rc, "set tx/rx num failure\n");
> +
>   	rtl_set_irq_mask(tp);
>   
>   	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),


