Return-Path: <netdev+bounces-58936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130BB818A4F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA686B25710
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3F1B288;
	Tue, 19 Dec 2023 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUZtvFVB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DB1CAAB
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702996929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xZ8x5HEiP9rnV3cOMAgI1xej4iAn5FYMzmpVoA0UIc=;
	b=VUZtvFVBSJHkC5/eMM8P291E9yiWQNhQP5Mm55aeqp4f411oa3DxiDDkkKYofAQSQ2ZLHc
	rXaepyoqtUsDkLxIm0FMIahojhqu7ovhaCRxU0Ulo8A2boc/v5/kbWVmKYzRTCq/zbDOEE
	UgXPSiLWqfXtZrYOlZSex14i//kqvqQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ka-Gb4viO7CbhtnJ03q4iw-1; Tue, 19 Dec 2023 09:42:08 -0500
X-MC-Unique: ka-Gb4viO7CbhtnJ03q4iw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a232d6a33a3so38985966b.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 06:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996927; x=1703601727;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xZ8x5HEiP9rnV3cOMAgI1xej4iAn5FYMzmpVoA0UIc=;
        b=diKyAXP4q17FkXCSd3/ryYla9D1PDfv6zTVFOnTu07+4lrLs7zyIsZDwHjOHbYpuqc
         tMzf7wqlzewV4NJdMNOwQpIODzppsrXfpyQy4Gzr/RPgzGGQE3jDsdaBoX/mEfr//pgg
         /X9rRxoidnBoUrvBMXkLLJLUT43i4maXBZKDxH1/86yvhUoQfg2DrxWnBeDVqwoUaoK8
         AE8nG349gRaayjapI8PTfasT2lKmGvtQhZZuuaTF+L9OqBx5hXPGfPkfdJV2KG6ITdGL
         DRUdA6iFUUwGYr1qj82yhGueGdh7fPQx86i+eTs/uehPvPMGL45T7Xv2IOWqlXqj0uu3
         MVng==
X-Gm-Message-State: AOJu0Yz/jRA1oAJvbcysPylNYK2tHIKfg36H8AXsIGEOumm5TpH/PGtl
	5Y2mEq78somkhjjq1nKQlCiqDiK7nwEYDT6mLDSTswr/aMlSrbe+gv9eHZACvAvQlKWUg+jDx54
	ZRMXtmGn+K66gpz5/
X-Received: by 2002:a17:906:4a89:b0:a25:d0fa:4d60 with SMTP id x9-20020a1709064a8900b00a25d0fa4d60mr849060eju.3.1702996926923;
        Tue, 19 Dec 2023 06:42:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgEMG4C9U+UWyMlGR+RMp+a4lhsa197UMkRPvj85ccfXwLgVeymF8u3fxTCvnMdmYgPe0y+A==
X-Received: by 2002:a17:906:4a89:b0:a25:d0fa:4d60 with SMTP id x9-20020a1709064a8900b00a25d0fa4d60mr849042eju.3.1702996926506;
        Tue, 19 Dec 2023 06:42:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id vh6-20020a170907d38600b00a0180de2797sm15454019ejc.74.2023.12.19.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:42:06 -0800 (PST)
Message-ID: <21ccf1acce6f4a711f6323f9392c1254135999b8.camel@redhat.com>
Subject: Re: [PATCH net] net: check dev->gso_max_size in gso_features_check()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Date: Tue, 19 Dec 2023 15:42:04 +0100
In-Reply-To: <20231219125331.4127498-1-edumazet@google.com>
References: <20231219125331.4127498-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 12:53 +0000, Eric Dumazet wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0432b04cf9b000628497345d9ec0e8a141a617a3..b55d539dca153f921260346a4=
f23bcce0e888227 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3471,6 +3471,9 @@ static netdev_features_t gso_features_check(const s=
truct sk_buff *skb,
>  	if (gso_segs > READ_ONCE(dev->gso_max_segs))
>  		return features & ~NETIF_F_GSO_MASK;
> =20
> +	if (unlikely(skb->len >=3D READ_ONCE(dev->gso_max_size)))

Since we are checking vs the limit supported by the NIC, should the
above be 'tso_max_size'?

My understanding is that 'gso{,_ipv4}_max_size' is the max aggregate
size the device asks for, and 'tso_max_size' is the actual limit
supported by the NIC.

Thanks!

Paolo


