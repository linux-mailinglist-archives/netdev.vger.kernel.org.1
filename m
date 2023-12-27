Return-Path: <netdev+bounces-60415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D78581F1EA
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9201F21926
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC647F54;
	Wed, 27 Dec 2023 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Ft/MWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0C47F53
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9aa51571fso2491798b3a.3
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 12:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703709566; x=1704314366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcylBWxF6VNktpQzlFRNppQwL1uogEJMB+I++B99UlU=;
        b=i/Ft/MWviAZ47ejx+t/nCGxX7W3RsQ9sGgE4yCFVqrVv/PBQ4FRgGTXsGezP5OY52Y
         zCznxiXTkQsB5hxhzHPOOwGHpqpBGTm35X/5iRIcOgk2hYM+linoqSzV/5dEeOurgv8o
         uPNIZTmqPiKgRwO2v/+RaARosbPmvX84T0ukiL084zoIaHBsp+PsIaXkOacVWUnODihk
         vFRd/aeiJiI0ky3Bab3brfglFc2YMZCNLvp8NO3J1etxs9i1LM449OQ/yLKjIadfjHOD
         BPuPIAT8LYy/9uW67Xg3hAPrVCV3bjbiK3Kiv7n03d3QmjXYab/Eq4t0T+07TJDrdslY
         6Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703709566; x=1704314366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcylBWxF6VNktpQzlFRNppQwL1uogEJMB+I++B99UlU=;
        b=rdBpyMEcNndLUHsf7iIsX6CLzLIeT8xUeH+WHaNm80eezTmieVksp4fl6qCEUSjmyj
         fLEjD4QLlitdgetBIafs35tI6Y4OPZwbSnXS3Uwho2g6bqXm/XAIxmiwh5/AIoMUIc9z
         EfXP7iMkL9gy7LTPsSFfeodifIpWcDkDtK/410hpAJj1Tv+wn8/NV1T7dE43wazc3RBO
         grUm/sVxIMjNBYcnG26uo4lx9KZigfmLgpd7RlAax/OlHI3zmfiLNDvLhNLF3aZgsE+K
         ltQw7tY8n0zUjqpwPXPx+aqa/3alX6GBhKkKjWbRyzLKtaBcc6vsoqc3PCnir7+JhIhJ
         iLog==
X-Gm-Message-State: AOJu0Yz09+/RZSNdhQ+BW7Lw7+vl7PBrd19kW45dfQWWPD1GMGvkpTr7
	yMfMkGgIl5R6f1KVajOK3Xc=
X-Google-Smtp-Source: AGHT+IGYEpv/pNua3H6V4s8DfCTPna3he0TPLcw10hlrEKb5VMEeuqzD8gtLk+nkdaM9Q39ZJtTlpw==
X-Received: by 2002:a05:6a21:6d96:b0:196:3126:bc59 with SMTP id wl22-20020a056a216d9600b001963126bc59mr1051373pzb.15.1703709565820;
        Wed, 27 Dec 2023 12:39:25 -0800 (PST)
Received: from [10.69.66.162] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w10-20020a63f50a000000b005b18c53d73csm11439133pgh.16.2023.12.27.12.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 12:39:25 -0800 (PST)
Message-ID: <4b3d4c59-70d8-41b7-954e-8f7294026516@gmail.com>
Date: Wed, 27 Dec 2023 12:39:21 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: bcmgenet: Fix FCS generation for fragmented
 skbuffs
To: Adrian Cinal <adriancinal1@gmail.com>, netdev@vger.kernel.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com
References: <55c522f9-503e-4adf-84cc-1ccc1fb45a9b@broadcom.com>
 <20231227120601.735527-1-adriancinal1@gmail.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20231227120601.735527-1-adriancinal1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/27/2023 4:04 AM, Adrian Cinal wrote:
> The flag DMA_TX_APPEND_CRC was written to the first (instead of the last)
> DMA descriptor in the TX path, with each descriptor corresponding to a
> single skbuff fragment (or the skbuff head). This led to packets with no
> FCS appearing on the wire if the kernel allocated the packet in fragments,
> which would always happen when using PACKET_MMAP/TPACKET
> (cf. tpacket_fill_skb() in af_packet.c).
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Signed-off-by: Adrian Cinal <adriancinal1@gmail.com>
> ---
>   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 1174684a7f23..df4b0e557c76 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2137,16 +2137,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>   		len_stat = (size << DMA_BUFLENGTH_SHIFT) |
>   			   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT);
>   
> -		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
> -		 * will need to restore software padding of "runt" packets
> -		 */
>   		if (!i) {
> -			len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
> +			len_stat |= DMA_SOP;
>   			if (skb->ip_summed == CHECKSUM_PARTIAL)
>   				len_stat |= DMA_TX_DO_CSUM;
>   		}
> +		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
> +		 * will need to restore software padding of "runt" packets
> +		 */
>   		if (i == nr_frags)
> -			len_stat |= DMA_EOP;
> +			len_stat |= DMA_TX_APPEND_CRC | DMA_EOP;
>   
>   		dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
>   	}
Hmm... this is a little surprising since the documentation is actually 
pretty specific that the hardware signal derived from this flag be set 
along with the SOP signal.

Based on that I think I would prefer the flag to be set for all 
descriptors of a packet rather than just the last, but let me look into 
this a little further.

Thanks for bringing this to my attention,
     Doug

