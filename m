Return-Path: <netdev+bounces-38845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C675A7BCC1A
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3544A2818F7
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 04:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482C10E6;
	Sun,  8 Oct 2023 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqenPu+d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F7630
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 04:37:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A017BF
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696739835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvtyRRz+nwNRt7FvkUoa8BCNkTJILEam9tMkM/HCha0=;
	b=GqenPu+dl1ud/IxCDURRYbNVjTgPCujCHHXdSDZd37ePVwRBPQH+e+lQIvHXclmWTfiFRn
	j08r00G7lFrM64wh7Vp5Zp7NMUoSATufx4oxnDMG6Jii5JskukYP2hlM2f8x/CveqT1Px7
	7rvJPsNEga3Wed0/lC3rLF8pqvzW+iI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-BBWjlrkfP9CBZThhFix8vw-1; Sun, 08 Oct 2023 00:37:13 -0400
X-MC-Unique: BBWjlrkfP9CBZThhFix8vw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50433961a36so3017114e87.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 21:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696739832; x=1697344632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvtyRRz+nwNRt7FvkUoa8BCNkTJILEam9tMkM/HCha0=;
        b=agqjQZ/CoPW5smq5FG08C9qS5hsLwZBp9Bbq4/GITAr1tdWe3AvMF9Te7xwH6dNBya
         nUUkZMBByRZmKOJp32fPy44D2FVRTtbIE/C7lbzur8S+1MBuNlUOQ5HhovxRK5M+rCS3
         P/tlKXqXb3FVscdEOzbUePiRsoL5dABRBFK7cibo4HDnFG9GRJX5u9sndXRMV+cmcDSL
         rq6s46ahxxlL2tBaUQrF5ldI0bc4pOAgWqshMbo/teY6RhqAN4aUPFTcl2l0/fCqszt8
         QE1uDbTC6JCHbXI5ZKK6WQg74aOCETn02xvRng+rk+mW2vvvkx0slmqYn4G8MIGpkH4G
         XBGQ==
X-Gm-Message-State: AOJu0Yxrrmxe48QGTVYjO7oGAh1uxqIyMMwiDr7d/USoQ4H4d0VlxZ8p
	J1LcgZA+ulY9RRY8D0rt5cZv53SwLH5s1i1m1nu0I5IDb7jlvEsDybK4iYLiLF9c1VoEyAXXvYv
	5pEAxXRm1vOL+6qNFdgiCFy6wOnV4wCJQxOD6K55ndLgCMA==
X-Received: by 2002:ac2:4c9b:0:b0:500:9a15:9054 with SMTP id d27-20020ac24c9b000000b005009a159054mr8820042lfl.20.1696739831933;
        Sat, 07 Oct 2023 21:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbwdFniTDysoOdy55vJ9mvDY2iLbB22GYbgOhSxJ2xBXcK3O2G6gfgJld3IG0br8gYtQV4XFjb14Blx0X7c18=
X-Received: by 2002:ac2:4c9b:0:b0:500:9a15:9054 with SMTP id
 d27-20020ac24c9b000000b005009a159054mr8820036lfl.20.1696739831548; Sat, 07
 Oct 2023 21:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20230926050021.717-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:37:00 +0800
Message-ID: <CACGkMEtF7hZ8kGYi8rF68SzZqdYJ6i1SeuVU2hiBTY-FLapSBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/virtio: Add dma sync api for virtio test
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 398776277@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 1:00=E2=80=AFPM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Fixes: 8bd2f71054bd ("virtio_ring: introduce dma sync api for virtqueue")
> also add dma sync api for virtio test.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  tools/virtio/linux/dma-mapping.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-ma=
pping.h
> index 834a90bd3270..822ecaa8e4df 100644
> --- a/tools/virtio/linux/dma-mapping.h
> +++ b/tools/virtio/linux/dma-mapping.h
> @@ -24,11 +24,23 @@ enum dma_data_direction {
>  #define dma_map_page(d, p, o, s, dir) (page_to_phys(p) + (o))
>
>  #define dma_map_single(d, p, s, dir) (virt_to_phys(p))
> +#define dma_map_single_attrs(d, p, s, dir, a) (virt_to_phys(p))
>  #define dma_mapping_error(...) (0)
>
>  #define dma_unmap_single(d, a, s, r) do { (void)(d); (void)(a); (void)(s=
); (void)(r); } while (0)
>  #define dma_unmap_page(d, a, s, r) do { (void)(d); (void)(a); (void)(s);=
 (void)(r); } while (0)
>
> +#define sg_dma_address(sg) (0)
> +#define dma_need_sync(v, a) (0)
> +#define dma_unmap_single_attrs(d, a, s, r, t) do { \
> +       (void)(d); (void)(a); (void)(s); (void)(r); (void)(t); \
> +} while (0)
> +#define dma_sync_single_range_for_cpu(d, a, o, s, r) do { \
> +       (void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> +} while (0)
> +#define dma_sync_single_range_for_device(d, a, o, s, r) do { \
> +       (void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> +} while (0)
>  #define dma_max_mapping_size(...) SIZE_MAX
>
>  #endif
> --
> 2.34.1
>


