Return-Path: <netdev+bounces-269659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMGvEWdovGlQyQIAu9opvQ
	(envelope-from <netdev+bounces-269659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:19:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DA2D299A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7576930CBD23
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A523ACA68;
	Thu, 19 Mar 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OCyZFqkm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEC30F53C
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955131; cv=none; b=mS9Kk62UfWiw/8KoeK35PSY8U8RLoSNTGK6C7hHHTBOkGR8lLx0EEXjTPkcOiNulbwO2+S8O/k8YyN7Diy/fODfYg/cZD94s/ioq/E6iPnsh0khQWrqow1wPLTiCv9yyrg2IFrjpi+p/tkaqoJGoQCaYrly26E2HLrCUzqRsqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955131; c=relaxed/simple;
	bh=JMzLFbl/OhviIhCtefUkTX8+jfOgmHMWoaLX2EUjHmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+12TraFlhd5X1epgwCEJtT49oafSj99ZQ+b2re2IFkX4hCq5nRTm1L/fEiATHzKZdwANPCTZdQmOGj9OobB9Scsz95rfPlm7buljKYUwWZ87ElyWdTHw3iwDn6h7bV/YJIrDVxFD49vfi0HoCuvlsBNB0LP427eKoSnRTfPlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OCyZFqkm; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-79a62a2bb8cso15903587b3.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955129; x=1774559929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh4ELn+KVUmnhuFnvz3rcSxyHtgDapB59qby14b5LnI=;
        b=PJdqyokGZOJ4YguqY2z6+O/0QdA4CKdbcyzDcEvT1aJyQjkJi7RYJuK8wj1wcWJrhH
         k0JWaYHNjnUKVbLFHvZIOkRZjnL/Eq4NFb1wkHkV/ly+7qVrHuy846cbDt7/F9JkxgF1
         N5aTYjclzKQmw+0BeTDVt9VvnrRKbOisPIjOq4lujFLG7qHomckzmj4erBvkA2xIrjXc
         Qs3qT+KoAdPvLESUik7IHMkksCYV9WlesrdoCmJ7hi/qpDpOTVLhENkZrdDth0Xa2aU4
         jRhG1EfnjtdoJlkTnms6W77yaZx6U82GhOppufMa6sa0Gs+IxtYaaJGm07EG5RiVsUXI
         d+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVwkBWtl2vJh4683la6tDQ2CysjZiZArfLhd7QkfX7XJ37f6+4Fn+ZY6DFxIhsPZMWYmPUWh08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDv6vuhoFMpo7AX/ukRauGMDS2e6zpYh2NCHRanvu8v7J947s
	GH5EPig2zWbZ4nM+XlzN1IWQjwPlCHL+3i3HSbjqWqM8HTFB0IyHbYt0nN1P55mtscoKulHn1To
	dkdvkAyjt5Cz8hZIRALaZVEu2oBpb4olSLcJlzXsBrGaJcj6+pxU8vsv0GNrdIJL1zaPzymIazL
	f9KaylMaCcMZg3JNd226ix20gPUeG2pDyZVsb2IjwcLhrAqPbKe+S3DS5wiu3xxBpak21UrwXdT
	VZw34oxmw==
X-Gm-Gg: ATEYQzzbwX9yzBgDyJUOpXpYUMC3M/XE8JUyuoMeo92Mt4qN+omN4DXDo07Tf9KXw5O
	/OO0+z6Ko/ZqQSKRnm5hxKBwjagmEF8/Umnzm3Sy7lqtFaUHSqKDdasJ7LJGTgBPNylIM0C9dd0
	1y4lbldIvcBzn7Dp9+2jzL5tLik5foHpQeRDB3LmqrQCPmWSDk1PbsEOzBPYfP3zij662WfhDWm
	/AOBTkd2ovAn9asqC0Yl1BsM9OB8YHboHzXxY4jnTcjuwmAjONmCdJNAfN/7uI8K/OWYWA684f9
	r68hgSDDxFnkFKdMSG80pBO/Ivah9/fp0lH14DlW8QMal/Sg1VsPr2Sr5lDlhKhFovNlDc/+nny
	eCaI/cX826aRL3skpFqRqePym5AY90iOCH57bxnWfYcoRwt7l9oK2tns3pISLIDGbvW+fGsmug7
	/ka8L4KZtX4dLkX9sUoPgdlyC82HMPwlCC3DPgCRyyrfG282oXnzVnG+M=
X-Received: by 2002:a05:690c:e4d5:b0:79a:55f5:a422 with SMTP id 00721157ae682-79a90aeaea8mr6604997b3.22.1773955129507;
        Thu, 19 Mar 2026 14:18:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79a9056b30bsm470197b3.23.2026.03.19.14.18.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:18:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1225801eec.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773955128; x=1774559928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wh4ELn+KVUmnhuFnvz3rcSxyHtgDapB59qby14b5LnI=;
        b=OCyZFqkmoHoWuLKiWhRC1et6cYf0UdgcJKjabEOek1+WvYdA/1K1lgKQMPM5UzcMKy
         pILUjgzuStiTmAcnpA2JQNzDXDrqxdsCgr9cj2z7DsEK+LL5fUkFTWFtPS8jBQTbdtFO
         4+TxVUAb38zUnZ+YIzd32d8ITwEoTL7cfBnCo=
X-Forwarded-Encrypted: i=1; AJvYcCUeG37JnsvwGFr5O7+GdKXN5g14EbvAHKyj0EW4zG4dBNWjHiurxrJOhPS7BnwlQ4aT6/8GzJg=@vger.kernel.org
X-Received: by 2002:a05:7300:50e:b0:2c0:ffe7:318d with SMTP id 5a478bee46e88-2c1097d7856mr381819eec.30.1773955128001;
        Thu, 19 Mar 2026 14:18:48 -0700 (PDT)
X-Received: by 2002:a05:7300:50e:b0:2c0:ffe7:318d with SMTP id 5a478bee46e88-2c1097d7856mr381809eec.30.1773955127301;
        Thu, 19 Mar 2026 14:18:47 -0700 (PDT)
Received: from [10.14.5.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1a88e5sm537846eec.13.2026.03.19.14.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:18:46 -0700 (PDT)
Message-ID: <2ccfaa48-7aad-49e8-bdfa-82ca9b6ebcc6@broadcom.com>
Date: Thu, 19 Mar 2026 14:18:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] net: bcmgenet: register xdp_rxq_info for
 each RX ring
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
 <20260319115402.353509-3-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260319115402.353509-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269659-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B70DA2D299A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/26 4:53 AM, Nicolai Buchwitz wrote:
> Register an xdp_rxq_info per RX ring and associate it with the ring's
> page_pool via MEM_TYPE_PAGE_POOL. This is required infrastructure for
> XDP program execution: the XDP framework needs to know the memory model
> backing each RX queue for correct page lifecycle management.
> 
> No functional change - XDP programs are not yet attached or executed.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 +++++++++++++++++--
>   .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 ++
>   2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 7410034d9bdc..6e610e73e12f 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2771,16 +2771,32 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
>   		.offset = GENET_XDP_HEADROOM,
>   		.max_len = RX_BUF_LENGTH,
>   	};
> +	int err;
>   
>   	ring->page_pool = page_pool_create(&pp_params);
>   	if (IS_ERR(ring->page_pool)) {
> -		int err = PTR_ERR(ring->page_pool);
> -
> +		err = PTR_ERR(ring->page_pool);

This should go in the patch before this.

>   		ring->page_pool = NULL;
>   		return err;
>   	}
>   
> +	err = xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, ring->index, 0);
> +	if (err)
> +		goto err_free_pp;
> +
> +	err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq, MEM_TYPE_PAGE_POOL,
> +					 ring->page_pool);
> +	if (err)
> +		goto err_unreg_rxq;
> +
>   	return 0;
> +
> +err_unreg_rxq:
> +	xdp_rxq_info_unreg(&ring->xdp_rxq);
> +err_free_pp:
> +	page_pool_destroy(ring->page_pool);
> +	ring->page_pool = NULL;
> +	return err;
>   }
>   
>   /* Initialize a RDMA ring */
> @@ -2807,6 +2823,7 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
>   
>   	ret = bcmgenet_alloc_rx_buffers(priv, ring);
>   	if (ret) {
> +		xdp_rxq_info_unreg(&ring->xdp_rxq);
>   		page_pool_destroy(ring->page_pool);
>   		ring->page_pool = NULL;
>   		return ret;
> @@ -3012,6 +3029,7 @@ static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
>   	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
>   		ring = &priv->rx_rings[i];
>   		if (ring->page_pool) {
> +			xdp_rxq_info_unreg(&ring->xdp_rxq);
>   			page_pool_destroy(ring->page_pool);
>   			ring->page_pool = NULL;
>   		}
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 11a0ec563a89..82a6d29f481d 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -16,6 +16,7 @@
>   #include <linux/dim.h>
>   #include <linux/ethtool.h>
>   #include <net/page_pool/helpers.h>
> +#include <net/xdp.h>
>   
>   #include "../unimac.h"
>   
> @@ -579,6 +580,7 @@ struct bcmgenet_rx_ring {
>   	u32		rx_max_coalesced_frames;
>   	u32		rx_coalesce_usecs;
>   	struct page_pool *page_pool;
> +	struct xdp_rxq_info xdp_rxq;
>   	struct bcmgenet_priv *priv;
>   };
>   


