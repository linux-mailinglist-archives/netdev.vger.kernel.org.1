Return-Path: <netdev+bounces-23425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A1176BEF0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C9B1C21061
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DC263AE;
	Tue,  1 Aug 2023 21:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CAE4DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 21:05:04 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6965129
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:05:02 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-79acc14c09eso666376241.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690923902; x=1691528702;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=098hRtjKd+IMXRBg9bD56pZsXHP5BacbQRyV55lQ/n4=;
        b=U46oZyF2NGgOCj+FJFfWTWZZ55rviss3MR5EtFK2OEZZTDLCCZXSm75jFpakX8Zm4I
         MUWGuPjqkyWWIltbNRnxrQKak3O+b6V2QUljcQV/SgST2odUnl31MZa5DjbrbFRi42If
         z9qfD/39zNoFGx8vy7kqr6GAw4dleooPO1gR1fm+4KOIdIBDj+mDSRsasCcGW/PdLLjE
         esZlSzG0KbnabbAaWUicCwG7GKURsw2bnPy4yig/W6T4iRCHZ8MwcNiqbzTX1EII9EBW
         YR/xWsdeme2xstG6z499xPligaELLf8Kgstl163HZFokjYYiiN2rHhfWLA0qg64cqtpz
         KjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923902; x=1691528702;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=098hRtjKd+IMXRBg9bD56pZsXHP5BacbQRyV55lQ/n4=;
        b=KOrpmDeL9PBBmV1fFpY5MG6lvgi4k6o/fdAvE0BkxbfS/AJGKIZrX/gLTGYMLNlS6u
         Np0y7LJhwasSyVtFLW+S3oMeNFWZs7W20xLvjaxC8CikWbi9jpYHdKy7/a8JF/A1pHCO
         7Ptflf5gwzCDjVqaV9CNo1OE3pJrEr3t5XDsAyT5fiozlsV69mUyL+KV/BWfDbiAJEaP
         6Uu9r+12zNGuh9YUZDxPtSXHODaDVzLtqJ2EHdXytGe9uYD/ZnTowT5nT7YOvyewMG+o
         NPOoE/NdhfVIGDtqfvUex3FbcgFFGSOXgabRF3CKlJj/XIXkxTdpd3mkekISiAHtXLZZ
         5cXg==
X-Gm-Message-State: ABy/qLYfrF7ABE2cPinvdtdaHv/ICXopepLfOzLd0YaLt8xRK/LDrEQT
	j6pT9Nu86l4EJXQgnmEuhI4=
X-Google-Smtp-Source: APBJJlE0WbdYYWNYnRefg/xjMGxLjyKTN6UVdNu280zr/Hbe9LD3L/yicOIJDuYttdcsUPzxU7KD9Q==
X-Received: by 2002:a1f:3d4c:0:b0:481:372c:6ae4 with SMTP id k73-20020a1f3d4c000000b00481372c6ae4mr2744966vka.2.1690923901830;
        Tue, 01 Aug 2023 14:05:01 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id f2-20020ac840c2000000b00404f8e9902dsm2690832qtm.2.2023.08.01.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 14:05:01 -0700 (PDT)
Date: Tue, 01 Aug 2023 17:05:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Tahsin Erdogan <trdgn@amazon.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <64c9737d36571_1d4d6f294b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230801205254.400094-1-edumazet@google.com>
References: <20230801205254.400094-1-edumazet@google.com>
Subject: RE: [PATCH v2 net-next 0/4] net: extend alloc_skb_with_frags() max
 size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> alloc_skb_with_frags(), while being able to use high order allocations,
> limits the payload size to PAGE_SIZE * MAX_SKB_FRAGS
> 
> Reviewing Tahsin Erdogan patch [1], it was clear to me we need
> to remove this limitation.
> 
> [1] https://lore.kernel.org/netdev/20230731230736.109216-1-trdgn@amazon.com/
> 
> v2: Addressed Willem feedback on 1st patch.
> 
> Eric Dumazet (4):
>   net: allow alloc_skb_with_frags() to allocate bigger packets
>   net: tun: change tun_alloc_skb() to allow bigger paged allocations
>   net/packet: change packet_alloc_skb() to allow bigger paged
>     allocations
>   net: tap: change tap_alloc_skb() to allow bigger paged allocations
> 
>  drivers/net/tap.c      |  4 ++-
>  drivers/net/tun.c      |  4 ++-
>  net/core/skbuff.c      | 56 +++++++++++++++++++-----------------------
>  net/packet/af_packet.c |  4 ++-
>  4 files changed, 34 insertions(+), 34 deletions(-)

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks Eric


