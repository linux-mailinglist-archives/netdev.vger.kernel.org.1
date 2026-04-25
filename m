Return-Path: <netdev+bounces-281128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8bg5Eb887WmUhAAAu9opvQ
	(envelope-from <netdev+bounces-281128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 00:14:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2BB468057
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A38FD30039B5
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73CE3806AF;
	Sat, 25 Apr 2026 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mae9EZux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237518632B
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777155258; cv=none; b=nbNYgo/gktE27571+LDT5VvCDk+tXRatLXeUjnTFTDZXj/FeJagC/SDE72UJ68FcPMLPMpLxZHakhuP8VT8Q6p2v4Ce/1vA+kZ5k8VF8ys+kc0mEkBs/MZGprBJvF1pFbJ9FqHI5lb+Q7aMa+w/pwQ9kkCaYuI1KZgdmz5sNlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777155258; c=relaxed/simple;
	bh=o6sZQetaTFeAvq6dRcJ5y7xUoiKA4pLaiHX6NPMPOYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhhPO6athOFcLi/mf8ncNzJCgsg6IrWnCt+CVOKipsw/mIXnotoVVdrzLRDZ9mvQFBpHD5MAjASvPBEtCmrRSKeDRqw9zqnmL5HJPdLQ/bVkRzxaNoqQOkXoxg5t15CT9pZJbVIn+urOvPiph2882uur8pWfYYJF/g61vGj23Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mae9EZux; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so103386815e9.0
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777155255; x=1777760055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqgYsvBF+sUONTYrvoK5noelmDSfKskdUabgceS6bHU=;
        b=Mae9EZux7BL522choqhuAAEC15QEhUZEoHO6BfeDLWULZdxCMYeCFC1muxUklJUw1D
         PmTEX2xjae3NKIWmZbEDvxN5x0dvOWmykVvjzRlQPCufy1TYVUUpx8iey9wh8s2j/fIz
         qVqP3evEYIefszFKKrfzVJX87ouzx+aBSqyGdQn/RPg+ItvDMNpAroR1RXeRLx/u5pfH
         jh3eFQhYPG30/bnz1M2po5+OBO3WK0nyHDLQmjE4cx+2OPvkV4PsDhyt9vDj9ypEUGTf
         C4E/KQ4eJzwWQk7aEIioXng8b8ytzchIIbkclLFVybWjkPxYpA6n5SJzx8ta/AE6LRfL
         ZVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777155255; x=1777760055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqgYsvBF+sUONTYrvoK5noelmDSfKskdUabgceS6bHU=;
        b=KoLdaoYmD4PicQJQqQqvOMAO3hdKYnFKBIz0BOTmHMqyzb4gYWvaAwrzSiylJZ3xMj
         4aP0UsoVzIOJpLlcJzkQQrSS16+k0Yt+V6wOmNIDlfz5DXrVl4q0gq40h6I3ScLaz14C
         zoldy7WHuWZxnbaXxgwn7pVbMsfiyAAGDArN/+yk/SKWDOd3qDazdIl5teb2oFANUTIr
         FMptwJryxQt0D+E5tmj4LYKEMjL2YHc58CzmKHjtQ3PJTZqgnqm111T4M63Ds6SKUXnN
         I20B+RAGukG7H8AqzW9wO/5cP2gfdfecjCqzN4uH6vJkfQ/hsOakdeKrhvOS8Vi5+HAs
         32oA==
X-Gm-Message-State: AOJu0YwE0A1Z/2A/fPn4v8FMlMC3s7pH6a00Q4b653AqRs+ZV+bFPjfy
	kpohsvZF3A48/my43XbLwZSmQ7MX0vN6vg7DVGCBjBb3BpHK71O4somq
X-Gm-Gg: AeBDievtIKBLvfDOzJksyG1q4t+5reMu0tbA310koBi9j3fCfBrphpGl0fXONTUPiZ4
	oiNsxOsoNGJvawsrk7uhRQxpblAZDskbbYx4oSzISuAnvyWhut+EwVvpHuaFMV+KudcAGH7vUjC
	4fNTKjBiWrkWW9pfF62Z4Sjbicalco1pOiHAt3kHw4q74fYZIxjF2VWEh6QZSOpHv6wVRMUqOa0
	43q/AegRq8ZBgnxcH8kb8/TK7qk2QJ3L5EuaWODZqI39rPvZJLa2ABBX4wFs3AQAZiZUVH4BsAJ
	My8OkTsqIWhlSO2OtFVROC6ZIlIIeRF5s833/iRZAagbhxXGleBa+bhNdoLPQu6tIzcLS0YmM1+
	KYIeH3tQT8DEHHw9wAE11DB7QbTzj9pTXuCN82bIuKQOCrT7tC0bEFgbQQZ/O/xNAcbC1ev1UWo
	CEp/AQvcjj1LocL457UbEsLHRJcGEBEE7xMnDa/1hgpFWsjhbmnSQxUndz5iwWTgNHARdQ29Jpd
	UfR679HoQ/ghXwAUTg9SViGN5K6lAJhE4srj/L0tXuk1rvbLurJw9cmpuN2YnbwQmvJ+yFX1EuV
X-Received: by 2002:a05:600c:a408:b0:48a:592c:e632 with SMTP id 5b1f17b1804b1-48a592ce943mr194133525e9.16.1777155255271;
        Sat, 25 Apr 2026 15:14:15 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f34:b800:6020:70f3:48c1:ca3e? (p200300ea8f34b800602070f348c1ca3e.dip0.t-ipconnect.de. [2003:ea:8f34:b800:6020:70f3:48c1:ca3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm626712145e9.15.2026.04.25.15.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 15:14:14 -0700 (PDT)
Message-ID: <6345109a-3e87-476a-9abe-b8828e0fe9b6@gmail.com>
Date: Sun, 26 Apr 2026 00:14:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch net-next v1 5/9] r8169: add support for msix
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-6-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260420021957.1756-6-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CD2BB468057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281128-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 20.04.2026 04:19, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch add support for msix. But we still use MSI here. And we force
> nvecs to 1. We will modify it in rss patch.

This description is wrong. Also as of today r8169 supports MSIX.
Reason likely is that you're copying code from vendor driver.

> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 162 ++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 52e690eba644..7d493342ab4b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1764,26 +1764,40 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
>  
>  static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
>  {
> -	if (rtl_is_8125(tp))
> +	if (rtl_is_8125(tp)) {
>  		RTL_W32(tp, IntrStatus_8125, bits);
> -	else
> +		if (tp->features & RTL_FEATURE_MSIX) {
> +			RTL_W32(tp, ISR_V2_8125, 0xffffffff);
> +			RTL_W32(tp, ISR_V4_L2_8125, 0xffffffff);
> +		}
> +	} else {
>  		RTL_W16(tp, IntrStatus, bits);
> +	}
>  }
>  
>  static void rtl_irq_disable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> +	if (rtl_is_8125(tp)) {
>  		RTL_W32(tp, IntrMask_8125, 0);
> -	else
> +		if (tp->features & RTL_FEATURE_MSIX) {
> +			RTL_W32(tp, IMR_V2_CLEAR_REG_8125, 0xffffffff);
> +			RTL_W32(tp, IMR_V4_L2_CLEAR_REG_8125, 0xffffffff);
> +		}
> +	} else {
>  		RTL_W16(tp, IntrMask, 0);
> +	}
>  }
>  
>  static void rtl_irq_enable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->features & RTL_FEATURE_MSIX)
> +			RTL_W32(tp, IMR_V2_SET_REG_8125, tp->irq_mask);
> +		else
> +			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> +	} else {
>  		RTL_W16(tp, IntrMask, tp->irq_mask);
> +	}
>  }
>  
>  static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
> @@ -2894,6 +2908,10 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  	tp->InitRxDescType = RX_DESC_RING_TYPE_DEAFULT;
>  	tp->HwCurrIsrVer = tp->HwSuppIsrVer;
>  
> +	/* This just force nvecs, and will be remove in the following patch*/
> +	tp->min_irq_nvecs = 1;
> +	tp->max_irq_nvecs = 1;
> +
>  	rtl_setup_mqs_reg(tp);
>  	rtl_set_ring_size(tp, NUM_RX_DESC, NUM_TX_DESC);
>  }
> @@ -5321,6 +5339,44 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_V2_CLEAR_REG_8125, BIT(message_id));
> +}
> +
> +static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, ISR_V2_8125, BIT(message_id));
> +}
> +
> +static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_V2_SET_REG_8125, BIT(message_id));
> +}
> +
> +static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
> +{
> +	struct rtl8169_napi *napi = dev_instance;
> +	struct rtl8169_private *tp = napi->priv;
> +	int message_id = napi->index;
> +
> +	rtl8169_disable_hw_interrupt_msix(tp, message_id);
> +
> +	rtl8169_clear_hw_isr(tp, message_id);
> +
> +	if (message_id == MSIX_ID_V4_LINKCHG) {
> +		phy_mac_interrupt(tp->phydev);
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +		return IRQ_HANDLED;
> +	}
> +
> +	tp->recheck_desc_ownbit = true;
> +
> +	napi_schedule(&napi->napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int rtl8169_request_irq(struct rtl8169_private *tp)
>  {
>  	struct net_device *dev = tp->dev;
> @@ -5331,10 +5387,14 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>  
>  	for (int i = 0; i < tp->irq_nvecs; i++) {
>  		irq = &tp->irq_tbl[i];
> +		if (tp->features & RTL_FEATURE_MSIX && tp->HwCurrIsrVer > 1)
> +			irq->handler = rtl8169_interrupt_msix;
> +		else
> +			irq->handler = rtl8169_interrupt;
>  
>  		napi = &tp->r8169napi[i];
>  		snprintf(irq->name, len, "%s-%d", dev->name, i);
> -		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt, NULL, napi, irq->name);
> +		rc = pci_request_irq(tp->pci_dev, i, irq->handler, NULL, napi, irq->name);
>  
>  		if (rc)
>  			break;
> @@ -5786,10 +5846,18 @@ static const struct net_device_ops rtl_netdev_ops = {
>  
>  static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->features & RTL_FEATURE_MSIX) {
> +		tp->irq_mask = ISRIMR_V6_LINKCHG;
> +		for (int i = 0; i < tp->num_tx_rings; i++)
> +			tp->irq_mask |= ISRIMR_V6_TOK_Q0 << i;
> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_V6_ROK_Q0 << i;
> +	} else {
> +		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>  
> -	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -		tp->irq_mask |= SYSErr | RxFIFOOver;
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> +			tp->irq_mask |= SYSErr | RxFIFOOver;
> +	}
>  }
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
> @@ -5817,6 +5885,18 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  	if (nvecs < 0)
>  		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>  
> +	tp->features &= ~(RTL_FEATURE_MSIX | RTL_FEATURE_MSI);
> +
> +	if (nvecs > 0) {
> +		tp->irq_nvecs = nvecs;
> +		tp->irq = pci_irq_vector(pdev, 0);
> +		if (nvecs > 1)
> +			tp->features |= RTL_FEATURE_MSIX;
> +		else if (pci_dev_msi_enabled(pdev))
> +			tp->features |= RTL_FEATURE_MSI;
> +		return 0;

Such feature flags, especially for MSI/MSIX, are ugly.
Why don't you leave the interrupt type selection to PCI core?
This needs at least an explanation.

> +	}
> +
>  	tp->irq = pdev->irq;
>  	tp->irq_nvecs = 1;
>  
> @@ -6087,6 +6167,52 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
> +	struct net_device *dev = tp->dev;
> +	const int message_id = r8169_napi->index;
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
> +
> +	if (tx_ring_idx >= 0 && tx_ring_idx < tp->num_tx_rings)
> +		work_done += rtl_tx(dev, tp, &tp->tx_ring[tx_ring_idx], budget);
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
>  
>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
> @@ -6095,6 +6221,20 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>  		int (*poll)(struct napi_struct *napi, int budget);
>  
>  		poll = rtl8169_poll;
> +		if (tp->features & RTL_FEATURE_MSIX) {
> +			switch (tp->HwCurrIsrVer) {
> +			case 6:
> +				if (i < R8127_MAX_RX_QUEUES)
> +					poll = rtl8169_poll_msix_rx;
> +				else if (i > 7 && i < 16)
> +					poll = rtl8169_poll_msix_tx;
> +				else
> +					poll = rtl8169_poll_msix_other;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
>  		netif_napi_add(tp->dev, &r8169napi->napi, poll);
>  		r8169napi->priv = tp;
>  		r8169napi->index = i;


