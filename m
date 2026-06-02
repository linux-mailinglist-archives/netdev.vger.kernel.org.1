Return-Path: <netdev+bounces-294420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mMZZNl1KH2qvjgAAu9opvQ
	(envelope-from <netdev+bounces-294420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:25:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40632632121
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:25:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="WrZk/VIg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294420-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294420-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D73305F084
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEDD399D0C;
	Tue,  2 Jun 2026 21:23:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCC237180
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435390; cv=none; b=KTt73xI0Q7awG2u/yTTF/zymaY1b4cVrvMhbPkGVhXvGnjSTi0qIn9gnqQRdrjz8HvW/sBev5PBm4PJm9TJaGtygsPl0DsDv1OlJ2pgiL/f9dOCwmuaW2bYz8sJvfE0WmYQPznOYByek22/Q7CNdoIdFHw2Nr9x8D5ap3b166E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435390; c=relaxed/simple;
	bh=z5Aqy8y8/gAablVII3KpXjyzawsafBBcYtKVS7GNpDk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GZw9hpdddHULgsGZF01tqXv/vOqSQvV+wf4XoTZMheWmCi97/tc8VFSHawM3+rP4e0mipN7XYm8CEmkpC1G5k13nLfKLTbo9Ob+qDig5hz6bzytN2VHPkm8B0Xuzvcihqq9wTvCaHYZRERI4fqLz2KYlMPQPkHMlcD1Cf5889qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrZk/VIg; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490afc47455so10037795e9.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780435387; x=1781040187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3dRFdE5udSr8rlKm+jlouII2mlA29PWptN2wl7njtk=;
        b=WrZk/VIgrLDz789wo4+Lzez4x7sqrEa8ITExAs+/o2b/g0je9wVPlf4f03cOVqdlts
         OANue8BqVRPZq3ZSdYT3+y6PgogbigdetfQGeU4uzHhXV1PJbl7t+Coy7oRGoNnG2RFP
         hmQUGkaENocWWm9qPLgcgZ2MyWCI9WaudSox4Ix/367Sk5DdoS5dqkDVw+Ll/YtYFPgr
         hVqDBBpZBxHW6Y2MgNSvWLbQIdo+MMkL6oPCR2UBoOijM3nNKfNBSGLso7bM6gaGbfB/
         h0h/rV6O6IzOqDvEz8nlCNBmEiWUTwkivBp1rvIUK5OZV+2l2RgDrJfzFbi/Z6TIIxLL
         hPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780435387; x=1781040187;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3dRFdE5udSr8rlKm+jlouII2mlA29PWptN2wl7njtk=;
        b=koKp2B6y5kLTiG8T55hqA5+EdH30kgrndhBHQ9s4yEJ8KYWlXADQQ5bA4lwk+6x4+l
         u4ysjN+hfV+Kj+KsGiCi0vNlikzqBE+8Amm4tR2IOTzHd7EaH3FP5MqAO0/4lvoVcRCd
         H4F179IHG3vQgcNNHhZlqSBD7RTOGGHPCePA8ULtWviSecTBRys32fBm+t/QJ/U131QU
         h3CCNf9kDkqML/dkuvzdB4R5uwc9LALoa5Wy1SFLAv/XnXoWjsNZ3RbmJkAg3/c1mO05
         eCW+0ESRmFEQx305265pJjKVTs5MlleqNd/LWTattuYcd2TxEuF3NIkZk0L2fVoJz5UY
         SctQ==
X-Gm-Message-State: AOJu0Yx2yl686V5fRGCxvaOjFYMZ1wpkR+VCiCs/RX2PZZ5OzVQ++Aaa
	3unBVicuXMCrxBq9T9IMvvGKYpW7QmAU+wwSqO8o1EJDe+hr4PcluKkB
X-Gm-Gg: Acq92OF6p7TYP28mftk5A0f7kj2PFj8XKX3F2KbjjBTNVKO5f2Vk/99uZ2XAljUrsg7
	RtXU3xiehTjQW1gucJYZKWxwlP2RNFfQ7sfcIB/KePKsqXmtSB70XiLUlQJWof+R3R0ysKmBhxu
	wjbaFKM8a6/uwVxD3aaMZvN25cmHhojg+j/vEp2xsE/CZ5Skn5ELQnWdiYr31TgWd4gl23LHeFq
	4BKGA7wlrd5rW/V2O8d9bkZd96HypL/CvwPkjs6sS1qSug385SXUJQV5VKWe85xrfQPYe7td5Kt
	WWxQBtauqAru/Zyt6LEWKHSIjcT+au6foc5Gbyt6hfYmn3iBxOjPoLz99lZRk3N9FGey1B38Ypf
	MD+9AGJpD4H5cjmrie5/QjYLPIal1S5XfC+43/tqim6PHpmVJsw74wz8Kez5DtoEgsdmlT3MKT0
	Ttl+Xly+qXo0GPWbVjsPwpSyxowFyZvz09YULn1/iL/4xUKX7UG321mW2dj0eKqil7AtUE6eD/K
	izfLCRUZWoHJH9TMyghQ0Nl1SwPQK/ERWt7BBqJVmZCKiPFXlZGJVV/CPvvwmfJmBuHZQC+OZMH
X-Received: by 2002:a05:600c:5288:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490b5ecbd41mr8540765e9.18.1780435386797;
        Tue, 02 Jun 2026 14:23:06 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f35:a100:65ef:a45f:1f40:5f43? (p200300ea8f35a10065efa45f1f405f43.dip0.t-ipconnect.de. [2003:ea:8f35:a100:65ef:a45f:1f40:5f43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b444f4fesm36906265e9.12.2026.06.02.14.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 14:23:06 -0700 (PDT)
Message-ID: <c52f0c89-b47c-4e24-bed1-6ee95bb31053@gmail.com>
Date: Tue, 2 Jun 2026 23:23:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v6 3/7] r8169: add support for new interrupt
 mapping
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
 <20260526081117.173-4-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260526081117.173-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40632632121

On 26.05.2026 10:11, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.
> ISR_VER_MAP_REG is the hardware register to indicate interrupt status.
> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes
> 
> Changes in v3:
>  - init index in napi_struct and get message_id from index
>  - move rtl8169_disable_hw_interrupt_msix directly before the call to
>    napi_schedule()
>  - change the condition in rtl8169_request_irq when RTL_VEC_MAP_ENABLE
>    enabled, use rtl8169_interrupt_msix
> 
> Changes in v4:
>  - remove flag tp->feature, replace tp->features & RTL_VEC_MAP_ENABLE
>    with tp->irq_nvecs > 1, they are equivalent.
>  - follow reverse xmas tree, in rtl8169_interrupt_msix(),
>    rtl8169_poll_msix_rx(), rtl8169_poll_msix_tx(),
>    rtl8169_poll_msix_other()
>  - use napi->index in rtl8169_poll_msix_other()
>  - add a comment to describe RTL8127 MSI-X vector layout
>  - simplify r8169_init_napi()
> 
> Changes in v5:
>  - replace magic number in rtl8169_poll_msix_tx()
> 
> Changes in v6:
>  - when irq_nvecs <= 1, use register IntrMask_8125, else using vec map
>  - fix irq sequence in rtl8169_interrupt_msix(), disable interrupts
>    before clean it
>  - remove dead code in rtl8169_poll_msix_tx()
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 166 +++++++++++++++++++---
>  1 file changed, 150 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 62bf77aa1ec8..951d2046a81b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -79,6 +79,7 @@
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
>  #define R8169_MAX_RX_QUEUES	8
>  #define R8127_MAX_RX_QUEUES	8
> +#define R8127_MAX_TX_QUEUES	8
>  #define R8169_DEFAULT_RX_QUEUES	1
>  #define R8169_MAX_TX_QUEUES	1
>  
> @@ -449,8 +450,12 @@ enum rtl8125_registers {
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
> +	ISR_VEC_MAP_REG		= 0x0d04,
> +	IMR_SET_VEC_MAP_REG	= 0x0d0c,
>  };
>  
> +#define MSIX_ID_VEC_MAP_LINKCHG	29
>  #define LEDSEL_MASK_8125	0x23f
>  
>  #define RX_VLAN_INNER_8125	BIT(22)
> @@ -581,6 +586,9 @@ enum rtl_register_content {
>  
>  	/* magic enable v2 */
>  	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
> +#define	ISRIMR_LINKCHG	BIT(29)
> +#define	ISRIMR_TOK_Q0	BIT(8)
> +#define	ISRIMR_ROK_Q0	BIT(0)
>  };
>  
>  enum rtl_desc_bit {
> @@ -1664,26 +1672,38 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
>  
>  static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
>  {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrStatus_8125, bits);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->irq_nvecs > 1)
> +			RTL_W32(tp, ISR_VEC_MAP_REG, bits);
> +		else
> +			RTL_W32(tp, IntrStatus_8125, bits);
> +	} else {
>  		RTL_W16(tp, IntrStatus, bits);
> +	}
>  }
>  
>  static void rtl_irq_disable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrMask_8125, 0);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->irq_nvecs > 1)
> +			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
> +		else
> +			RTL_W32(tp, IntrMask_8125, 0);
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
> +		if (tp->irq_nvecs > 1)
> +			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
> +		else
> +			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> +	} else {
>  		RTL_W16(tp, IntrMask, tp->irq_mask);
> +	}
>  }
>  
>  static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
> @@ -5062,6 +5082,45 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_SET_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
> +{
> +	struct napi_struct *napi = dev_instance;
> +	struct net_device *dev = napi->dev;
> +	int message_id = napi->index;
> +	struct rtl8169_private *tp;
> +
> +	tp = netdev_priv(dev);
> +
> +	if (message_id == MSIX_ID_VEC_MAP_LINKCHG) {
> +		rtl8169_clear_hw_isr(tp, message_id);
> +		phy_mac_interrupt(tp->phydev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	rtl8169_disable_hw_interrupt_msix(tp, message_id);
> +	rtl8169_clear_hw_isr(tp, message_id);
> +
> +	tp->recheck_desc_ownbit = true;
> +	napi_schedule(napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int rtl8169_request_irq(struct rtl8169_private *tp)
>  {
>  	struct net_device *dev = tp->dev;
> @@ -5070,8 +5129,12 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>  
>  	for (i = 0; i < tp->irq_nvecs; i++) {
>  		napi = &tp->rtl8169_napi[i];
> -		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> -				     NULL, napi, "%s-%d", dev->name, i);
> +		if (tp->irq_nvecs > 1)
> +			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt_msix,
> +					     NULL, napi, "%s-%d", dev->name, i);
> +		else
> +			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> +					     NULL, napi, "%s-%d", dev->name, i);
>  		if (rc)
>  			goto free_irq;
>  	}
> @@ -5517,10 +5580,16 @@ static const struct net_device_ops rtl_netdev_ops = {
>  
>  static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->irq_nvecs > 1) {
> +		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
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
>  }
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
> @@ -5825,10 +5894,75 @@ static void r8169_del_napi_action(void *data)
>  		netif_napi_del(&tp->rtl8169_napi[i]);
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	const int message_id = napi->index;
> +	struct rtl8169_private *tp;
> +	int work_done = 0;
> +
> +	tp = netdev_priv(dev);
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
> +	struct net_device *dev = napi->dev;
> +	const int message_id = napi->index;
> +	struct rtl8169_private *tp;
> +
> +	tp = netdev_priv(dev);
> +
> +	rtl_tx(dev, tp, budget);
> +
> +	if (napi_complete_done(napi, 0))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return 0;
> +}
> +
> +static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	const int message_id = napi->index;

This variable is used only once, I don't really see a benefit.

> +	struct rtl8169_private *tp;
> +
> +	tp = netdev_priv(dev);
> +
> +	if (napi_complete_done(napi, 0))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return 0;
> +}
> +
> +/* RTL8127 MSI-X vector layout:
> + * Vectors 0 .. (RxQs - 1)		: Rx Queues
> + * Vectors RxQs .. (RxQs + TxQs - 1)	: Tx Queues
> + * Vector (RxQs + TxQs) and up		: Other events (Link status(29), etc.)
> + */
>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> -		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
> +
> +		if (tp->irq_nvecs > 1) {
> +			if (i < R8127_MAX_RX_QUEUES)
> +				poll_fn = rtl8169_poll_msix_rx;
> +			else if (i < R8127_MAX_RX_QUEUES + R8127_MAX_TX_QUEUES)
> +				poll_fn = rtl8169_poll_msix_tx;
> +			else
> +				poll_fn = rtl8169_poll_msix_other;
> +		}
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);
> +		tp->rtl8169_napi[i].index = i;
> +	}
>  	devm_add_action_or_reset(&tp->pci_dev->dev, r8169_del_napi_action, tp);
>  }
>  


