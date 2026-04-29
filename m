Return-Path: <netdev+bounces-282415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HDIEtYW8mljnwEAu9opvQ
	(envelope-from <netdev+bounces-282415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:33:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FC495D82
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E1F0300752F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE810F1;
	Wed, 29 Apr 2026 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUYT7F6x"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57134330662
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473197; cv=none; b=lBsAiHC7oOwTlNTx3sWaLk1au0fVs9e0dlLUHy4Q6s4Z20Z6HEmIaNiu8mc+YRn0hBBOvut7E0c5rmqsaNzZnWqxYRvT9VUy7cqZ6WbNXerfEb10Y3TzBnzaI2Wu8aAVNwSWVgAMnKpZQgnhih0zD0LGVcuo6UALEUESdhkXHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473197; c=relaxed/simple;
	bh=hTnjAiR01SOk7RSeCjUUcEMfyPds8cHVElrUFX27zjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LByqct024TJ2m6uTE6UIm1cWs4aBZJeLJFGiYsvz12Eji4ie+Ht8OkMPg9dpTYkwirm/zuQNaCvpeA5NM4meMHpd0cBbORmWr4ZyvOM1PsXUOWEFUh063bj0xWbzOEREtwnyrsSMaRvRG+A400yXUjjn4Ulxz6SMWpJbuQAuZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUYT7F6x; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40fadbd2-e138-4000-85b2-dd4188d43e19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777473181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrHl3zdWM/Ro89gV/Wz+euIZqyZknxcZleaBg+KBugE=;
	b=iUYT7F6xT3qrZHVLPx9V/AJCBMLmzxaWSzSQrJzyFuHMWjMH6i3QFMbeCnImoceyI1Oeh8
	/Npn8as5dHaIQLvj9SHqX8xZRVbK4VMPvcHQj/JQ5Orvb+ThY2aBLRFx2wz/V0F7j+utQa
	1DBNLzgHQzRorkXWRTBIGWQk45a5XJ4=
Date: Wed, 29 Apr 2026 15:32:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC Patch net-next v2 4/8] r8169: add support for new interrupt
 mapping
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
 <20260429070750.1477-5-javen_xu@realsil.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260429070750.1477-5-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0E7FC495D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282415-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 29/04/2026 08:07, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.
> ISR_VER_MAP_REG is the hardware register to indicate interrupt status.
> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

[...]

>   
>   		napi = &tp->r8169napi[i];
>   		snprintf(irq->name, len, "%s-%d", dev->name, i);
> @@ -5664,10 +5717,17 @@ static const struct net_device_ops rtl_netdev_ops = {
>   
>   static void rtl_set_irq_mask(struct rtl8169_private *tp)
>   {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->features & RTL_VEC_MAP_ENABLE) {
> +		tp->irq_mask = ISRIMR_LINKCHG;
> +		tp->irq_mask |= ISRIMR_TOK_Q0;

       nit: you can set it in one line

> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
> +	} else {
> +		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>   
> -	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -		tp->irq_mask |= SYSErr | RxFIFOOver;
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> +			tp->irq_mask |= SYSErr | RxFIFOOver;
> +	}
>   }
>   
>   static int rtl_alloc_irq(struct rtl8169_private *tp)
> @@ -5695,6 +5755,16 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>   	if (nvecs < 0)
>   		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>   
> +	tp->features &= ~RTL_VEC_MAP_ENABLE;
> +
> +	if (nvecs > 0) {
> +		tp->irq_nvecs = nvecs;
> +		tp->irq = pci_irq_vector(pdev, 0);
> +		if (nvecs > 1)
> +			tp->features |= RTL_VEC_MAP_ENABLE;
> +		return 0;
> +	}
> +
>   	tp->irq = pdev->irq;
>   	tp->irq_nvecs = 1;

now these 2 lines are not needed, because in success they are never
executed, but in error path they provide wrong information.

the whole can be rewritten with error path in case both tries of
pci_alloc_irq_vectors failed and the common code for success path:

	if (nvecs < 0)
		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);

	if (nvecs < 0)
		return nvecs;

	tp->irq_nvecs = nvecs;
	tp->irq = pci_irq_vector(pdev, 0);

	if (nvecs > 1)
		tp->features |= RTL_VEC_MAP_ENABLE;

	return 0;

>   
> @@ -5965,6 +6035,53 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>   	return false;
>   }
>   
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
> +	struct net_device *dev = tp->dev;
> +	const int message_id = r8169_napi->index;

reverse xmass tree, please

> +	int work_done = 0;
> +
> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
> +{
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
> +	struct net_device *dev = tp->dev;
> +	unsigned int work_done = 0;
> +	const int message_id = r8169_napi->index;
> +	int tx_ring_idx = message_id - 8;

ditto

> +
> +	if (tx_ring_idx >= 0)
> +		rtl_tx(dev, tp, budget);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
> +{
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
> +	const int message_id = r8169_napi->index;
> +
> +	napi_complete_done(napi, budget);
> +	rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return 1;
> +}
> +
>   static void r8169_init_napi(struct rtl8169_private *tp)
>   {
>   	for (int i = 0; i < tp->irq_nvecs; i++) {
> @@ -5972,6 +6089,20 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>   		int (*poll)(struct napi_struct *napi, int budget);
>   
>   		poll = rtl8169_poll;
> +		if (tp->features & RTL_VEC_MAP_ENABLE) {
> +			switch (tp->hw_curr_isr_ver) {
> +			case 6:
> +				if (i < R8127_MAX_RX_QUEUES)
> +					poll = rtl8169_poll_msix_rx;
> +				else if (i > 7 && i < 16)

	magic constants?

> +					poll = rtl8169_poll_msix_tx;
> +				else
> +					poll = rtl8169_poll_msix_other;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
>   		netif_napi_add(tp->dev, &r8169napi->napi, poll);
>   		r8169napi->priv = tp;
>   		r8169napi->index = i;


