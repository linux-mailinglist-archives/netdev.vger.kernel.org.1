Return-Path: <netdev+bounces-26033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F57769B7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70091C21385
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661BA2453D;
	Wed,  9 Aug 2023 20:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7824528
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:18:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BAC10E9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691612318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZ/hAJigtNZkRkPpAn2IHk5mSzp9dipr9W9tKZ7Di2g=;
	b=gR0xZ4j5gyHsfqUdvMig3TpmxubzqRJeS9Q7nRqbMahcns9h9Dya+XN4lHKYxVbi0m4Tu8
	3oE6shZs/+fv4U2GQXh/funWH7No10k6zMyZmYDBqG3aRRTzNXmTfaSwa7hpKJ8mZa6mEm
	e4+glj+9DBeMIjP5ht9gx2jSLsPNTqU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-vr144P3yPXarmpuD7ryJlQ-1; Wed, 09 Aug 2023 16:18:37 -0400
X-MC-Unique: vr144P3yPXarmpuD7ryJlQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99cb1b83eacso34964566b.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 13:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612316; x=1692217116;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ/hAJigtNZkRkPpAn2IHk5mSzp9dipr9W9tKZ7Di2g=;
        b=eR879rZ1cr6gDkXRk4RXaqPbqtCcGFxxmqIItY98L5ZCWsL6MU2PjB9Y3GEIv4Ek7N
         IUp2zmsjWLW471cb1kMNhcl7yFShL9RYFIqDMqEQOjrhhJ4yncBNUS43hosnMSA3mxM6
         5yRBEYrm0GidNtiSi44SO4/x916I0zIKP1BV/MyEQaynCzU2ILW+Pn6Bz7YMmdt49mNi
         lg0LAnV6xKHG8TSOKfwTj4mU4vrL3Q2vLcXfR1czTSS8/HBKARJcZGRMeRp79RGkJ/qw
         6od+sHCwUXM9+OjBZ2keVVkayonUtps51jNKS7O5/ZpAgXIh5KTfdFpME6O/jQM+vBPf
         4LZg==
X-Gm-Message-State: AOJu0YxqjMb7xyRR3XvtMYqwObpmaR1Pb4/uxHVjGBHl1v/HUSs9grk3
	vAP4eGX4SjYjvNK1OONwXQRSgGdCDQeqSBjUBs1ouMhqr3ogWSNS5IPbKyVqIpsafPE+3/nZ2pi
	fORzhwuw7D6IJ1sPS
X-Received: by 2002:a17:907:75f3:b0:99b:ce6d:fc90 with SMTP id jz19-20020a17090775f300b0099bce6dfc90mr589914ejc.2.1691612316115;
        Wed, 09 Aug 2023 13:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3LI0N7KFW17e6anvDkx9Zt5ywf390HKMqsCts77xR6BfCUNzFMAFhHV0WcmRLMWxmz5meVA==
X-Received: by 2002:a17:907:75f3:b0:99b:ce6d:fc90 with SMTP id jz19-20020a17090775f300b0099bce6dfc90mr589884ejc.2.1691612315850;
        Wed, 09 Aug 2023 13:18:35 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906038300b0098e42bef732sm8374826eja.183.2023.08.09.13.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 13:18:35 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <23743395-5e9a-ec95-b685-e094777a1d4b@redhat.com>
Date: Wed, 9 Aug 2023 22:18:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com,
 dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] [PATCH bpf-next 2/9] xsk: add TX timestamp and TX
 checksum offload support
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230809165418.2831456-1-sdf@google.com>
 <20230809165418.2831456-3-sdf@google.com>
In-Reply-To: <20230809165418.2831456-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 09/08/2023 18.54, Stanislav Fomichev wrote:
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 1f6fc8c7a84c..e2558ac3e195 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -165,6 +165,14 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
>   	return xp_raw_get_data(pool, addr);
>   }
>   
> +static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> +{
> +	if (!pool->tx_metadata_len)
> +		return NULL;
> +
> +	return xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
> +}
> +
>   static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
>   {
>   	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
> @@ -324,6 +332,11 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
>   	return NULL;
>   }
>   
> +static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> +{
> +	return NULL;
> +}
> +
>   static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
>   {
>   }
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 9c31e8d1e198..3a559753e793 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -234,4 +234,9 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb)
>   	return xskb->orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
>   }
>   
> +static inline bool xp_tx_metadata_enabled(const xdp_buff_xsk *xskb)

Hmm, shouldn't this argument be "struct xsk_buff_pool *pool" ?!?

> +{
> +	return sq->xsk_pool->tx_metadata_len > 0;
> +}

Will this even compile?

--Jesper


