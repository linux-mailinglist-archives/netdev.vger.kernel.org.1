Return-Path: <netdev+bounces-36305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032787AEDB1
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 15:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 59042B2098D
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD728DC6;
	Tue, 26 Sep 2023 13:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839C27728
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 13:07:56 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FECF3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 06:07:54 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c215f2f4aso110413817b3.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695733674; x=1696338474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STzkpTihUSsK4S1IuyYW/bDSRvCYFws7CAN2/ipeZ/U=;
        b=IyWZSZboBtyv5dvVI8Nx9G3L4n/BDRvUj2B43mdHb1Zf34toHkgJNE0XVaXEJIVClT
         Uhmj5xIGIRkA5jFJI7wrKFZ+o/Yb0KY6iyurrA7Z+O7w+9yLyNn07s4C1I0gIgknMfbL
         6rSwOR9ynDa3qzfckGaxJBHTVjrFRiw4xYBq9hVIhimxmGWyQK55KvnVxXNHk9nZid3D
         uvDKm4Z2uk2e8/c0L2+nI70HIfBJNgLcgz74ZQ4NpAGS1Ht1pSxwMh2GnPq3M+4Xd5X3
         aCP3H39TrtqCcD1cKBwRWCdj1ACWGwazrs0Nbhhq60PXgrtVSmRjJ1Tc4LbTT3il4E4Q
         NK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733674; x=1696338474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STzkpTihUSsK4S1IuyYW/bDSRvCYFws7CAN2/ipeZ/U=;
        b=jN1ODsp2FkIBJQhot8crZ4s9gNAAj5UbG/uREjG5bYISKT5/eJD42eFkkwo/oDKLte
         He+Q5Yy9Hu4wh8mbL06Bspm0aPeQJjdbcBqyxQ3kfE8IdTqfOVWZa88c2/1LDUqTVNU7
         mp6DSUEuEekYhATTO8+XnuEBIOagOtfVfooEAMlDNHB+zbyjFzOmNKzxgYTFFEvyHuQm
         6lrk6NFIYftaZfE2ZpSHuvyydk0GN4vIvTw3pjz/C5My/Skw/2SXBVdfMvrggmJy6i5j
         WxJ/K4ABB0gxHvxT6aTRfsteKEz8+5cdAcbeercF6xkOC8lBX7aLc8T5fNoxGtrYgzB7
         CgCA==
X-Gm-Message-State: AOJu0YytZBrAC5lx1khRmjChKP9su+KbftvAafb2hO61wrIWehoh339x
	o6MorMqn17PJuoeDOLhnT2UUTIDlSfE0pIbdzEM=
X-Google-Smtp-Source: AGHT+IHA4haT8jMg977z27B59vKYYMFtK58m9F5yR9T60/CB8+JKZkmgbU/HTjYc1ADgJ6w+JFPoTfc5/c/RdNkUft0=
X-Received: by 2002:a25:cfc4:0:b0:d85:a707:c9d4 with SMTP id
 f187-20020a25cfc4000000b00d85a707c9d4mr10149507ybg.55.1695733673858; Tue, 26
 Sep 2023 06:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1695722426.git.antony.antony@secunet.com>
In-Reply-To: <cover.1695722426.git.antony.antony@secunet.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 26 Sep 2023 16:07:41 +0300
Message-ID: <CAHsH6GvCW+eOsxtpfwCEXZCRGiS-7jkyf6ropfMBfH3dQ8LgOw@mail.gmail.com>
Subject: Re: [PATCH v5 ipsec-next 0/3] xfrm: Support GRO decapsulation for ESP
 in UDP encapsulation
To: antony.antony@secunet.com
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Antony,

On Tue, Sep 26, 2023 at 1:14=E2=80=AFPM Antony Antony <antony.antony@secune=
t.com> wrote:
>
> Hi,
>
> I have rebased the patch set to latest ipsec-next. There was a big change=
 to udp socket encapsulation data structure.
>
> Eyal, would please review patch set quickly? focus specifically chages du=
e to
>
> 70a36f571362 ("udp: annotate data-races around udp->encap_type")
> ac9a7f4ce5dd ("udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO")
> I hope I incorprated these changes correctly.

LGTM.

I think a cover letter explaining the feature, usage, performance,
caveats etc, would be helpful.

For the series:

Reviewed-by: Eyal Birger <eyal.birger@gmail.com>

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
> v5->v6 rebased to ipsec-next chages due lockless scket udp
>        encapsulation options
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

