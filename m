Return-Path: <netdev+bounces-26137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC19776EA1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 05:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E409E281ECF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7FA54;
	Thu, 10 Aug 2023 03:37:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A2A51
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:37:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D11FF7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691638669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSXOWT6dcdztqmjZzbfXKd/Gq/opxoDLOcxehy7PRw0=;
	b=UucR7XVtWug/HHaJE6SoV1x5jRRfVrCiRGLiGv7/oBV3uRlccqgrL2T7LgJZ1HgutpgmFV
	JZLFeNcjxtcrbRuWeoWZftPsV8ROtaxj+awbqjVqBx/u4gxU4WwEyttKH3pHuS36aeBA69
	u0DY1LysGaXUCAq8GmwCj4t0G6T/IB8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-O9AQfUHtNjWuhMHKWV7oYw-1; Wed, 09 Aug 2023 23:37:48 -0400
X-MC-Unique: O9AQfUHtNjWuhMHKWV7oYw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9ce397ef1so5005131fa.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 20:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691638666; x=1692243466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSXOWT6dcdztqmjZzbfXKd/Gq/opxoDLOcxehy7PRw0=;
        b=dogRZb3fzaIEJKfSP30VVR9Ptwvh8jWyrvBTMRX9j073miMdIGX/Z0bTXE3eu6qCC8
         ie4NBgEV4GmDOny/iAftwSSdQlPYijYq1hUjmxPvND/CLnQjWK2NEjpHqmy08MRLiP3h
         3Xld7c4bj+AQWNJwS8IUZliMPVKjkMC+i019hNcTxeO/EL6h0+rRcatmYiI4P7nZ3xUz
         3JfAFgvJ/QP0TGLX6k3YY/HFyEyavzIqqV64cOXYkay1jI7zyKXlC6g2z5xjkaSzWw45
         0apDiFO4qdGp+cHfsBgx9r3CFYRlTzLa4Nk3xT/EAcDJcSumfXUHJJjJA7zSrucMyFes
         m8gw==
X-Gm-Message-State: AOJu0YyuagvjKvN0hSALoNZ7rHuGX/RYLdIB5tQsEOzLfoQ1fRb7I26n
	aZAg9rQsvm3AHD/7NFLemaDWrKC2MVfdn2+E7gcSPrPlyMAdciAe/PNLnzH9M8L+zf3QrMmDTZh
	T4QJeKwjsZr7TouMOvX/yj+e5w3BejYhe
X-Received: by 2002:a2e:9447:0:b0:2b6:cd6a:17f7 with SMTP id o7-20020a2e9447000000b002b6cd6a17f7mr782538ljh.20.1691638666801;
        Wed, 09 Aug 2023 20:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEewlMoMiXrQySS2PN2O/NVdVgzNVNBbaX/UNMdkpWnE72zb71JfMWUaEcEFr8F2RrqQ+ZaZi/ZseR6/KLEkFA=
X-Received: by 2002:a2e:9447:0:b0:2b6:cd6a:17f7 with SMTP id
 o7-20020a2e9447000000b002b6cd6a17f7mr782529ljh.20.1691638666517; Wed, 09 Aug
 2023 20:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809164753.2247594-1-trdgn@amazon.com>
In-Reply-To: <20230809164753.2247594-1-trdgn@amazon.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 11:37:35 +0800
Message-ID: <CACGkMEuuEngqX6eKvRLvBm7_gGipVjfbkQ+JaXsE903CEkNfvA@mail.gmail.com>
Subject: Re: [PATCH v4] tun: avoid high-order page allocation for packet header
To: Tahsin Erdogan <trdgn@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 12:48=E2=80=AFAM Tahsin Erdogan <trdgn@amazon.com> =
wrote:
>
> When gso.hdr_len is zero and a packet is transmitted via write() or
> writev(), all payload is treated as header which requires a contiguous
> memory allocation. This allocation request is harder to satisfy, and may
> even fail if there is enough fragmentation.
>
> Note that sendmsg() code path limits the linear copy length, so this chan=
ge
> makes write()/writev() and sendmsg() paths more consistent.
>
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> ---
> v4: updated commit message address comments from Willem
> v3: rebase to latest net-next
> v2: replace linear =3D=3D 0 with !linear
> v1: https://lore.kernel.org/all/20230726030936.1587269-1-trdgn@amazon.com=
/

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


