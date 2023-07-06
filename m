Return-Path: <netdev+bounces-15679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269CD749303
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 03:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A9C28116F
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6F805;
	Thu,  6 Jul 2023 01:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147037F
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 01:19:14 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBC51982
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 18:19:12 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso70911241.3
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688606351; x=1691198351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG5qEwxagC4+ySUQRGnCqzQVgx8YJDmgKYEwBwBbHi8=;
        b=WMb9JUkj68NIqA151cJeWq+K4uPDzjvVMzwUNQ7V4uLik7F/mwPqb/9E7uaaVRzJL0
         0M3W+l5Wpg0NYKNut4knANvMOjAKPnUYPjvDyDIHQFnFHedjDJQwlvzVdCtfTKIXcA0G
         cFwY++6voTGFWrrbQDYteX0eT/EnnSZjfyyd3g6fjfrkkXoYRonL+Da3UeqGgWhFXHYg
         oW1v42NaF0AE5lnAh7MhvFF9ChNcLvl9h2zEoae33BSI4GvprdIhWxlQzumISRkjVFJ3
         kugXVSyaSsJBiJzwPFA2NFjjIoo85T3VCqcRJB1qMAYJ6Py2B6ZA5ytZTNSXX4WAKvsA
         +KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606351; x=1691198351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG5qEwxagC4+ySUQRGnCqzQVgx8YJDmgKYEwBwBbHi8=;
        b=CaXWrRgtf8Xh0P4K12jFHy36u4wIx/nZDMSZUHe4zMKf6lbdKfwsPQkBwY6IuJpgiE
         1Qyb3K9pHPTjwISkCIfKROXrieMc7+ETaemfVCC2PQoxsnyyp2h2QhrV6NIoZ3le9w65
         nc3wI0meMB4gRalx7nQVX36APrFLZD+UqLFEsqAj2sGME1IrVozrPoSyCXnBs/ydR93k
         iveF0hXQT+IoLr0/dzg+l8d+N0Pf+OcOB3YTq8NmCsMvtPa7D6V27W9CE3MfOasg7f9B
         Jc5gUT4wJ7Q75sAdoJoCickYfFoHlnsKZQX6vpTl8wNI+egg5yJAl9uC+pKHNf7QHZNa
         MALA==
X-Gm-Message-State: ABy/qLZ57CRIOcBDhb4izvVrUtscZLOyhsWaIeK9VRX2qd2gV4dI/WAx
	oRiw0DjCYhuaYe2Fv6lZ6rcgcOib6nen0p6HqAJrRA==
X-Google-Smtp-Source: APBJJlHTpxzJQ8qMkls8/kIG3QOBs1ceFkXZ5NSrihcQZjqbTz7tGm96dN/xChDtfBDJkv3zbfLFcn2Iuq8tSQKFcC4=
X-Received: by 2002:a67:e989:0:b0:443:90ff:c691 with SMTP id
 b9-20020a67e989000000b0044390ffc691mr600930vso.13.1688606351586; Wed, 05 Jul
 2023 18:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612130256.4572-1-linyunsheng@huawei.com> <20230612130256.4572-5-linyunsheng@huawei.com>
 <20230614101954.30112d6e@kernel.org> <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
 <20230615095100.35c5eb10@kernel.org> <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com> <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com> <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com> <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org> <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <47b79e77-461b-8fe9-41fb-b69a6b205ef2@kernel.org> <CANn89iKAvrf92Fy8a_M+V9eya6OHokey2_yxQ3JiCT87fKND_w@mail.gmail.com>
 <011d3204-5c33-782c-41d1-53bf9bd2e095@kernel.org>
In-Reply-To: <011d3204-5c33-782c-41d1-53bf9bd2e095@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Jul 2023 18:19:00 -0700
Message-ID: <CAHS8izPF7WjMKLA82fy5LjE9XzUWNVMgs9tD7JM5UY3xfw93Yw@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
	Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 3, 2023 at 10:23=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 7/3/23 11:13 AM, Eric Dumazet wrote:
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index a2dbeb264f260e5b8923ece9aac99fe19ddfeb62..aa4133d1b1e0676e408499e=
a4534b51262394432
> > 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2152,7 +2152,7 @@ static int packet_rcv(struct sk_buff *skb,
> > struct net_device *dev,
> >                 }
> >         }
> >
> > -       snaplen =3D skb->len;
> > +       snaplen =3D skb->devmem ? skb_headlen(skb) : skb->len;
> >
>
> Ok, so you expect a flag on the skb noting the use of 'untouchable'
> memory. That aligns with my expectations based on POCs.
>
> Based on the above: 1) skb->head is expected to be host memory, and 2)
> the flag is a global for all frags, so no mix and match.

Yes, both are correct (i.e. what I plan to propose).

--=20
Thanks,
Mina

