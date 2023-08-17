Return-Path: <netdev+bounces-28410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C794977F5B4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E403B281EBD
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C213ACF;
	Thu, 17 Aug 2023 11:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95F12B8E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:52:36 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D46E2102
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 04:52:25 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a02252eb5dso137550241.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273144; x=1692877944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30lZ/j/UehqABFnVx4q78oypgSoqqD7E1umCvbgICwU=;
        b=HU6MVTMFvOegUm4FI0LPo2GWxkJop3539HSuLINszI4ljQ4fVGWGJMx1p4X5zgRBwV
         CvFSdSsjGUWdFjBqMSXCWYryuwXPOmAo4bMyf8q3jG+1N4K+K0HIsDK0u0Z6VQ84/m8F
         2HDaYKT3mjmTjyQEbXTY2W71TMuSRmobHn7Zbj4mESPn+ZM3bpnJxyR3IJxI7+1kiWBW
         iYWSzQ4xnr6RMYsRCj9Zne+VolcU1DI9ABCV0zS1s7fc8e3/r1MY0zThzU/46tL2NbYi
         giSw5xys21ZXjZwZywRHFNKjoEgyX/8uf8kRZLLzi+JNujHjGtfO18FeVmPnGhTF0UCs
         tb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273144; x=1692877944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30lZ/j/UehqABFnVx4q78oypgSoqqD7E1umCvbgICwU=;
        b=fWuJ75sYNA98tm5VcKja+27M6qZ53xWs63IoOqgEu3t4j9cVveEXO7H3+Iu3aQjskO
         b4/OReTzjTXEzI3lzYVv+CeohrSgiVH9U/H8BYbPh9ieMat7eh2RroI9qntlYB6bbJsz
         lHHB2Gf2POSlbiBMdZX9GU4IqgE4W2C+EjK00dyL4tVxmZXSlVwn0J10p/jAVq3AQyzl
         T6ApM9Xw1KGZe2aTajt/9YKGTeTx3wSKXpXPwa/GEeGWYKAklqzIhLqTw0J7SXVYJUQE
         igF6ksGEryjf54unsZ3VYJ5Fn+Xhnc7T7E3oZkaloEHoVN4/G2k41kcTv+jcUkexVGQL
         YyUg==
X-Gm-Message-State: AOJu0YxAOj1HtJC1AM/Uqio5w9X64dPlSjxxdufnqqbEIEzDV8GP6U+C
	J/+O0lRUJkKmeutdXsR6FLzRqG/S+6+lppAJExHMxZI30zPn8g==
X-Google-Smtp-Source: AGHT+IFImmeVh3YiSTbNCXgpET1H+OpNz2C4pdWui779GuBL6mR7eUrOCq/t0gPa4A/pdj4p8v8hW6LnKToPQclC6lM=
X-Received: by 2002:a67:fa8f:0:b0:445:20ba:fb16 with SMTP id
 f15-20020a67fa8f000000b0044520bafb16mr2900514vsq.25.1692273144248; Thu, 17
 Aug 2023 04:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1692191034.git.antony.antony@secunet.com>
In-Reply-To: <cover.1692191034.git.antony.antony@secunet.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 17 Aug 2023 14:52:12 +0300
Message-ID: <CAHsH6GsEEQ-NdnLzac_882os9K41meQsvXBw0_CCoXWKBVJAwQ@mail.gmail.com>
Subject: Re: [PATCH v5 ipsec-next 0/3] xfrm: Support GRO decapsulation for ESP
 in UDP encapsulation
To: antony.antony@secunet.com
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	devel@linux-ipsec.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Antony,

On Wed, Aug 16, 2023 at 4:12=E2=80=AFPM Antony Antony <antony.antony@secune=
t.com> wrote:
>
> Hi,
> Here I re-worked this patch set and here is v5 based of feed back from Ey=
al.

I think the cover letter should include a little more information :)

Specifically I think it would be useful to add performance numbers, usage,
and the relevant caveats - especially the fact that UDP encapsulated flows
will no longer be connection tracked or protected by netfilter.

For the series itself:

Reviewed-by: Eyal Birger <eyal.birger@gmail.com>

>
>
> v1->v2 fixed error path added skb_push
>         use is_fou instead of holding sk in skb.
>         user configurable option to enable GRO; using UDP_GRO
>
> v2->v3 only support GRO for UDP_ENCAP_ESPINUDP and not
>         UDP_ENCAP_ESPINUDP_NON_IKE. The _NON_IKE is an IETF early draft
>         version and not widly used.
>
> v3->v4 removed refactoring since refactored function is only used once
>         removed refcount on sk, sk is not used any more.
>         fixed encap_type as Eyal recommended.
>         removed un-necessary else since there is a goto before that.
>
> v4->v5 removed extra code/checks that accidently got added.
>
>
> Steffen Klassert (3):
>   xfrm: Use the XFRM_GRO to indicate a GRO call on input
>   xfrm: Support GRO for IPv4 ESP in UDP encapsulation
>   xfrm: Support GRO for IPv6 ESP in UDP encapsulation
>
>  include/net/gro.h        |  2 +-
>  include/net/ipv6_stubs.h |  3 ++
>  include/net/xfrm.h       |  4 ++
>  net/ipv4/esp4_offload.c  |  6 ++-
>  net/ipv4/udp.c           | 16 +++++++
>  net/ipv4/xfrm4_input.c   | 94 ++++++++++++++++++++++++++++++++--------
>  net/ipv6/af_inet6.c      |  1 +
>  net/ipv6/esp6_offload.c  | 10 ++++-
>  net/ipv6/xfrm6_input.c   | 94 ++++++++++++++++++++++++++++++++--------
>  net/xfrm/xfrm_input.c    |  6 +--
>  10 files changed, 192 insertions(+), 44 deletions(-)
>
> --
> 2.30.2
>

