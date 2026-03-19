Return-Path: <netdev+bounces-269661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCuVM6JpvGlQyQIAu9opvQ
	(envelope-from <netdev+bounces-269661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:24:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56D2D2A4D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 758ED3190771
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F08402B99;
	Thu, 19 Mar 2026 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cV5HyhMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC33402B9F
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955391; cv=none; b=Gp1EnMSXTcYa6G2WQ5w8C2bkHIQ78QVbT0QdG/HkSEElEKEhVG/4wYpdVVlQbeLohtuv3u/6/CeDO7Yo3Z3DHqA1EtA0ktE73tntKD5OPPSzCX265w2cy3pARcULRB+OmnyeqKIwU+HSAAhFoLG5AtFraInrvaqCM23oH/xzfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955391; c=relaxed/simple;
	bh=K/XCPyc+m/DfZ3quCRmYqnABbbUHxG9UCrCKRvbCQf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRy3uNS9/jW/LEwDu+zS/GI6JBvZCQR5E+jaEwu7fZQkaPKIvO7XJMfsIppYP/AsSabKIgrGc67eRdtzDaL1bFJTtWVSFcaapZWM3LwaJuWN+wHb1WxoJ4H0/IKkMW/fnNjfv0QCgISKnvzTfLO2y4bME3r9zrdhdbVFNanM6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cV5HyhMp; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56b65ffbda3so889014e0c.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955387; x=1774560187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XCD7P77uKOJaU71jQh2aYICC6t2lNxcd5cbzp78RBM=;
        b=OT6oXLc4MiVaFwmp0sD0kLJf9NjeID1W4jDsoyuleXvfWd1hzRp8aWqcqYFwHmpPKZ
         tbn+XWk0of/QoTY0LAniGOIaRKkhlfzzwyBltKMZ8hXDx67D4fnnwo5eG4oyEpzdiybX
         819z3M50ERvKkbcXp3eGOt5o4v/LO6zH1UvLMKpYXkjp9ePDzzN36XDg6AXH+5Yd1AyS
         oZZjwsoa/+ajm0j+3yM6QjPW64RnT0uVRjzPPvAXgEAOAmLyLCuvMC5uTPkyMgVze8gE
         sbwIamkYTdnv9g/P3qSqkjYC1SuQe2TZ24XgQDnuLfhs9aaVrlXDfoQyOegry7wwOwZM
         00Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW71OcwzEGNQBZp4GpQ5O5DUas1hYIoAbLXN6eu1DRYOgr5U1MH5Pb4DCDLexbpJYB4nkja6fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWHQKt4MQ8af31CsAEZxhxsN2UvqgDdcpus+BzsE792/l4/n8
	bMIE2qK0XXtPlNjc7mgkPNUCkBqc/xClfutRKQ2nFulE85y/Hl1Hagfmi8w7pFAIM4k/VJFKVN8
	NOvNuK+dUPWjdLFGN3dL8D2HJXf00IIhHNj3BGTemdNWAPjNm808BoH8S/VukA9oafYaTsZEgFL
	3XyDRQ4Mt5urmFnViwkp/y1JBAeZdGxi/Mzih07Sfq7fnHzkslw12gkrjdOeVbL3iO77UDt9yMI
	VHA2SXMSA==
X-Gm-Gg: ATEYQzw0f2WPH4eq/ireJZyBhYIxY3aucI1jni68GY+pnt4Ch0FD00mSr4H6XADzRvw
	nb2fAM/2HjtNBxDvcXeeHPIl8E2fkyxYkpAAVveCZJjFC+iS8SaVbP1ZCbLoXsMljpi6h/ZVoF4
	Q0WBKsfMPbYluQxWh9jEHbxJ2fNi7rhn/Tkl/nMy+02xPmmofwG/HO0/PWybr+pfT/Lvb8W4k0Y
	YhYJfx8ADYjfsJDdqaGHLzTUO8ivuMCBPfDloQhJqVpW++uSX/xh3HWXvdu4GCiItvNG3zx+sAs
	dJMgifQcVEDxUVX/f7uRIC7URbTpcoavSETLnQlLzfqZNV9rsKwSan8xJxSUAyZ+SPf+ooXZqgK
	BRMx6o5ldrwH1/ArTEFpRh/trI6Z+/crkSkHNlKzS3Z5KJmDjOec8TteetrmtZw8ACYtBIENvhb
	/SIx4/Ta4tcCjoE4f2meCrjyhRB5x87h/hYAY7AAvTPhkIPV+g26fwylg=
X-Received: by 2002:a05:6123:82:b0:56c:d77b:582e with SMTP id 71dfb90a1353d-56cde34e630mr387397e0c.7.1773955386724;
        Thu, 19 Mar 2026 14:23:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56cddc4c063sm90699e0c.4.2026.03.19.14.23.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:23:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c1030ca85eso7093395eec.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773955385; x=1774560185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XCD7P77uKOJaU71jQh2aYICC6t2lNxcd5cbzp78RBM=;
        b=cV5HyhMpbeNi0pftRvm/737kp5kHS5QB2fsD5b9BaI3k4ooWRdAHBX+W9HJ+j8Nl4w
         vxN+r9BT8Z06nrIdrkRa8P4GgGRp8LHT1dijJZk5ODrPAsVKMpACX4lWjLWGk/eVpdGg
         OgzLOvGJmftvUt6IcQzRPYeG2pfmqFKsoEfG0=
X-Forwarded-Encrypted: i=1; AJvYcCVqwHrsCCBR1zUW6t3/04o9WDC9ANbI15vqVFeGFZzEcCpaerIOAOIkKEi66kFLMhzyXOUM1WI=@vger.kernel.org
X-Received: by 2002:a05:7300:6423:b0:2c0:d9e6:7eb0 with SMTP id 5a478bee46e88-2c109712f8dmr558415eec.16.1773955385431;
        Thu, 19 Mar 2026 14:23:05 -0700 (PDT)
X-Received: by 2002:a05:7300:6423:b0:2c0:d9e6:7eb0 with SMTP id 5a478bee46e88-2c109712f8dmr558392eec.16.1773955384705;
        Thu, 19 Mar 2026 14:23:04 -0700 (PDT)
Received: from [10.14.5.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm657777eec.10.2026.03.19.14.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:23:04 -0700 (PDT)
Message-ID: <e5ca230b-f288-4583-ab52-22d1c73fa5eb@broadcom.com>
Date: Thu, 19 Mar 2026 14:23:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-4-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260319115402.353509-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269661-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B56D2D2A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/26 4:53 AM, Nicolai Buchwitz wrote:
> Add XDP program attachment via ndo_bpf and execute XDP programs in the
> RX path. XDP_PASS builds an SKB from the xdp_buff (handling
> xdp_adjust_head/tail), XDP_DROP returns the page to page_pool without
> SKB allocation.
> 
> XDP_TX and XDP_REDIRECT are not yet supported and return XDP_ABORTED.
> 
> Advertise NETDEV_XDP_ACT_BASIC in xdp_features.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 147 +++++++++++++++---
>   .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +
>   2 files changed, 133 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 6e610e73e12f..e8f90d6b16a2 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -35,6 +35,8 @@
>   #include <linux/ip.h>
>   #include <linux/ipv6.h>
>   #include <linux/phy.h>
> +#include <linux/bpf_trace.h>
> +#include <linux/filter.h>
>   
>   #include <linux/unaligned.h>
>   
> @@ -2274,6 +2276,53 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
>   	return 0;
>   }
>   
> +static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
> +					      struct xdp_buff *xdp,
> +					      struct page *rx_page)
> +{
> +	unsigned int metasize;
> +	struct sk_buff *skb;
> +
> +	skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb_mark_for_recycle(skb);
> +
> +	metasize = xdp->data - xdp->data_meta;
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	__skb_put(skb, xdp->data_end - xdp->data);
> +
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
> +
> +	return skb;
> +}
> +
> +static unsigned int

Perfer to not have a newline here. To match the formatting of the rest 
of the driver.

Thanks,
Justin

> +bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
> +		 struct xdp_buff *xdp, struct page *rx_page)
> +{
> +	unsigned int act;
> +
> +	act = bpf_prog_run_xdp(prog, xdp);
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		return XDP_PASS;
> +	case XDP_DROP:
> +		page_pool_put_full_page(ring->page_pool, rx_page, true);
> +		return XDP_DROP;
> +	default:
> +		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(ring->priv->dev, prog, act);
> +		page_pool_put_full_page(ring->page_pool, rx_page, true);
> +		return XDP_ABORTED;
> +	}
> +}
> +
>   /* bcmgenet_desc_rx - descriptor based rx process.
>    * this could be called from bottom half, or from NAPI polling method.
>    */
> @@ -2283,6 +2332,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   	struct bcmgenet_rx_stats64 *stats = &ring->stats64;
>   	struct bcmgenet_priv *priv = ring->priv;
>   	struct net_device *dev = priv->dev;
> +	struct bpf_prog *xdp_prog;
>   	struct enet_cb *cb;
>   	struct sk_buff *skb;
>   	u32 dma_length_status;
> @@ -2293,6 +2343,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   	unsigned int p_index, mask;
>   	unsigned int discards;
>   
> +	xdp_prog = READ_ONCE(priv->xdp_prog);
> +
>   	/* Clear status before servicing to reduce spurious interrupts */
>   	mask = 1 << (UMAC_IRQ1_RX_INTR_SHIFT + ring->index);
>   	bcmgenet_intrl2_1_writel(priv, mask, INTRL2_CPU_CLEAR);
> @@ -2403,26 +2455,52 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   			goto next;
>   		} /* error packet */
>   
> -		/* Build SKB from the page - data starts at hard_start,
> -		 * frame begins after RSB(64) + pad(2) = 66 bytes.
> -		 */
> -		skb = napi_build_skb(hard_start, PAGE_SIZE - GENET_XDP_HEADROOM);
> -		if (unlikely(!skb)) {
> -			BCMGENET_STATS64_INC(stats, dropped);
> -			page_pool_put_full_page(ring->page_pool, rx_page,
> -						true);
> -			goto next;
> -		}
> -
> -		skb_mark_for_recycle(skb);
> +		/* XDP: frame data starts after RSB + pad */
> +		if (xdp_prog) {
> +			struct xdp_buff xdp;
> +			unsigned int xdp_act;
> +			int pkt_len;
> +
> +			pkt_len = len - GENET_RSB_PAD;
> +			if (priv->crc_fwd_en)
> +				pkt_len -= ETH_FCS_LEN;
> +
> +			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
> +			xdp_prepare_buff(&xdp, page_address(rx_page),
> +					 GENET_RX_HEADROOM, pkt_len, true);
> +
> +			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
> +						   rx_page);
> +			if (xdp_act != XDP_PASS)
> +				goto next;
> +
> +			/* XDP_PASS: build SKB from (possibly modified) xdp */
> +			skb = bcmgenet_xdp_build_skb(ring, &xdp, rx_page);
> +			if (unlikely(!skb)) {
> +				BCMGENET_STATS64_INC(stats, dropped);
> +				page_pool_put_full_page(ring->page_pool,
> +							rx_page, true);
> +				goto next;
> +			}
> +		} else {
> +			/* Build SKB from the page - data starts at
> +			 * hard_start, frame begins after RSB(64) + pad(2).
> +			 */
> +			skb = napi_build_skb(hard_start,
> +					     PAGE_SIZE - GENET_XDP_HEADROOM);
> +			if (unlikely(!skb)) {
> +				BCMGENET_STATS64_INC(stats, dropped);
> +				page_pool_put_full_page(ring->page_pool,
> +							rx_page, true);
> +				goto next;
> +			}
>   
> -		/* Reserve the RSB + pad, then set the data length */
> -		skb_reserve(skb, GENET_RSB_PAD);
> -		__skb_put(skb, len - GENET_RSB_PAD);
> +			skb_mark_for_recycle(skb);
> +			skb_reserve(skb, GENET_RSB_PAD);
> +			__skb_put(skb, len - GENET_RSB_PAD);
>   
> -		if (priv->crc_fwd_en) {
> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
> -			len -= ETH_FCS_LEN;
> +			if (priv->crc_fwd_en)
> +				skb_trim(skb, skb->len - ETH_FCS_LEN);
>   		}
>   
>   		/* Set up checksum offload */
> @@ -3743,6 +3821,37 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
>   	return 0;
>   }
>   
> +static int bcmgenet_xdp_setup(struct net_device *dev,
> +			      struct netdev_bpf *xdp)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bpf_prog *old_prog;
> +	struct bpf_prog *prog = xdp->prog;
> +
> +	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> +				   "MTU too large for single-page XDP buffer");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	old_prog = xchg(&priv->xdp_prog, prog);
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	return 0;
> +}
> +
> +static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	switch (xdp->command) {
> +	case XDP_SETUP_PROG:
> +		return bcmgenet_xdp_setup(dev, xdp);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_open		= bcmgenet_open,
>   	.ndo_stop		= bcmgenet_close,
> @@ -3754,6 +3863,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_set_features	= bcmgenet_set_features,
>   	.ndo_get_stats64	= bcmgenet_get_stats64,
>   	.ndo_change_carrier	= bcmgenet_change_carrier,
> +	.ndo_bpf		= bcmgenet_xdp,
>   };
>   
>   /* GENET hardware parameters/characteristics */
> @@ -4056,6 +4166,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>   			 NETIF_F_RXCSUM;
>   	dev->hw_features |= dev->features;
>   	dev->vlan_features |= dev->features;
> +	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
>   
>   	netdev_sw_irq_coalesce_default_on(dev);
>   
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 82a6d29f481d..1459473ac1b0 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -16,6 +16,7 @@
>   #include <linux/dim.h>
>   #include <linux/ethtool.h>
>   #include <net/page_pool/helpers.h>
> +#include <linux/bpf.h>
>   #include <net/xdp.h>
>   
>   #include "../unimac.h"
> @@ -671,6 +672,9 @@ struct bcmgenet_priv {
>   	u8 sopass[SOPASS_MAX];
>   
>   	struct bcmgenet_mib_counters mib;
> +
> +	/* XDP */
> +	struct bpf_prog *xdp_prog;
>   };
>   
>   static inline bool bcmgenet_has_40bits(struct bcmgenet_priv *priv)


