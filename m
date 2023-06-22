Return-Path: <netdev+bounces-13155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A373A847
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E661C21097
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835320695;
	Thu, 22 Jun 2023 18:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1611F182
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:29:34 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C47FE;
	Thu, 22 Jun 2023 11:29:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66615629689so6157632b3a.2;
        Thu, 22 Jun 2023 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687458573; x=1690050573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+efte1YTdBvlCQmmBAcoCvTSuRZC5725VwKAKXACJmU=;
        b=f9WJGnOG5TWAXhkZnWiFgOETThzXsDSZ0L1DR1cjig1UrNiqbX/YkCFauiL1CfFUNa
         K/RrPM2m2UaVqArI8ThJ4AM13iq+7RBRqJUVS/OgF8R2daOi+Pk1qrh9stF2eDfhS8sd
         UXq9W/0ez1aBFtcKfj99q8aAl2RjXiUoV6qLhyU5eF9AxOBeAmEDALdFuDEiVOP7k6ed
         pe0nxuR3zg+3TSPMAjwRgWNz9f0vo4IRC0ZSUeldL6LPKi0UI3Kpz04qtY/8isTbI82z
         pj3BAgD/yZkpDGGOc+0ETyP92e+F7OL0i8PDu+lUpABDOMQPw+BKpXPpxnH6spwfzON6
         NF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458573; x=1690050573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+efte1YTdBvlCQmmBAcoCvTSuRZC5725VwKAKXACJmU=;
        b=FpQRDFql8vUl2oOT6Il1a9nGFTAkijCgrqBtJXiqs5vLzbHqXrt0ht00FY20rbYsbe
         Hk0pa0PMLRScVDoxzjMl3Wvl4msFinurg/faCizZr1YILbHVa1wA78QSgqed49sDJp19
         CJbHZ1yCH8Yy20QZigfj0mcLaeoukEnOvyyY5soKuNFAFxqaJ71AI0tEbf7RbOsEf8XH
         WtzUXQhbLE8VkfC4lKf2LVDWCDoD0F4rHbWaOeOVDR2Lc7Hde1HBY4jIKEtZhWe2KCbW
         F7Ue/w4vGjux5q6866rGV2cvpok6/lYe9uFI4Z/HeTGL0a+oIYtxBckqEPwqWnvqPcYd
         LDVQ==
X-Gm-Message-State: AC+VfDx9DGWKuyqo5pHzrIsrM5xB7iaB91Qjypvz6hUsu+k3tv/agU2p
	BekK5ROoADBk810OE/WSXvInCc1QiGUpdcQeu7M=
X-Google-Smtp-Source: ACHHUZ6Jh/3GORtdYloq0XZbEwztSaBRTUjvf9o00KaaibeC/JoMJG2IfYrkit8m2CaLu62e+8ZU02YnIrZtMkSTuo0=
X-Received: by 2002:a05:6a00:1950:b0:64f:52c9:ddd5 with SMTP id
 s16-20020a056a00195000b0064f52c9ddd5mr24639023pfk.34.1687458572689; Thu, 22
 Jun 2023 11:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-2-dhowells@redhat.com>
 <20230622111234.23aadd87@kernel.org>
In-Reply-To: <20230622111234.23aadd87@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 22 Jun 2023 11:28:56 -0700
Message-ID: <CAKgT0Ucp-62cOA_r1p=QwmSZvtVijW=9EEEgWYSp88=79wVfgA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 11:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 20 Jun 2023 15:53:20 +0100 David Howells wrote:
> > If sendmsg() is passed MSG_SPLICE_PAGES and is given a buffer that cont=
ains
> > some data that's resident in the slab, copy it rather than returning EI=
O.
>
> How did that happen? I thought MSG_SPLICE_PAGES comes from former
> sendpage users and sendpage can't operate on slab pages.
>
> > This can be made use of by a number of drivers in the kernel, including=
:
> > iwarp, ceph/rds, dlm, nvme, ocfs2, drdb.  It could also be used by iscs=
i,
> > rxrpc, sunrpc, cifs and probably others.
> >
> > skb_splice_from_iter() is given it's own fragment allocator as
> > page_frag_alloc_align() can't be used because it does no locking to pre=
vent
> > parallel callers from racing.
>
> The locking is to local_bh_disable(). Does the milliont^w new frag
> allocator have any additional benefits?

Actually I would be concerned about it causing confusion since it is
called out as being how we do it for sockets but we already have
several different socket based setups using skb_page_frag_refill() and
the like.

