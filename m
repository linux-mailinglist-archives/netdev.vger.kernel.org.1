Return-Path: <netdev+bounces-13812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086D73D0F1
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 14:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26EE1C208F0
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7006620F6;
	Sun, 25 Jun 2023 12:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AD1104
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 12:35:02 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D31E7;
	Sun, 25 Jun 2023 05:35:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98e39784a85so87724966b.1;
        Sun, 25 Jun 2023 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687696499; x=1690288499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnTM6AH2QXF2gOF8mDFwaIyALk1zi2atW6weIU7EpDk=;
        b=qFIX6t2djOPZ3NFLEEsWh6kVaD6cm1PqqOZB43uvYQtB5FCIFt1MLynosh38SZn6a+
         nhuZmKYbdzDSJk4+eyBR5rHzn6xJFUofmi9IVSoYk/vGPIi3N0OpCm39foIfQaadO1CP
         z6ypR6oH5OE7LXfQHJTlnyQSiR1DU4LSWA3qobpWXR0NmKzvFBrQiWwLgwRAP9lrxDg7
         b9gVil1hvTLGYONUJovI7F+s+FIRB6bh/Ba78lhpdd5/sAuly6PbxuKn4gWAH+BBT1uG
         J93qqgCZ9J9x5tZmdcPi2cmRE6/WlD11lJgi5ei9dYsk9ZG3WHqurlZ31eEwc2WX8PTW
         V9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687696499; x=1690288499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnTM6AH2QXF2gOF8mDFwaIyALk1zi2atW6weIU7EpDk=;
        b=ArZOLco//BjVUZdlIlLcWW3SQ0MZCDcxirVfSa6pwGugpqPL+ImDmyswWeLpTxb2ux
         7kQqnC9YkAVo2SjdvSzakg6vtD+RpKfBmxWcRtXhHlzQyqoTznvM/MwOt+/6xFVxZPTM
         8DiLJ2n126+CUVGT2FmGII4NJqK4PU8+FphR5qOo6K67heh00Xqy6xYZbN8wqW64ByDA
         FCVaiu22YyPNEyKVNjq69lGMLUNL8GnRqtlSvlCNdQm+DcHJc39CIOOjuifblwU0HALC
         98AyD9PtQxIxeFoFqHymbR/qbi6s8v3N5/y7VdifHDVgmzNi7GhPa+uimybOhdxQWbtv
         NWvg==
X-Gm-Message-State: AC+VfDzOgSJJiLrflHzd+JnnlrU1hDgdHtt53RK7syNSAmDKzm+ZvMm/
	ArHvkHmZnREidatK8dBzCUaJAy/3VEl6SRzHzBk=
X-Google-Smtp-Source: ACHHUZ4Nd6vLIj3xJTixgektcZuykdsnE4als2ZZkaqjSlSc82/AQVEifoR+5LZ+d971Eya9AkiGpbVc22+tDb1da6M=
X-Received: by 2002:a17:907:1ca8:b0:973:84b0:b077 with SMTP id
 nb40-20020a1709071ca800b0097384b0b077mr25773762ejc.33.1687696498611; Sun, 25
 Jun 2023 05:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-5-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-5-dhowells@redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 25 Jun 2023 14:34:46 +0200
Message-ID: <CAOi1vP_Bn918j24S94MuGyn+Gxk212btw7yWeDrRcW1U8pc_BA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/16] ceph: Use sendmsg(MSG_SPLICE_PAGES)
 rather than sendpage()
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 12:55=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Use sendmsg() and MSG_SPLICE_PAGES rather than sendpage in ceph when
> transmitting data.  For the moment, this can only transmit one page at a
> time because of the architecture of net/ceph/, but if
> write_partial_message_data() can be given a bvec[] at a time by the

Hi David,

write_partial_message_data() is net/ceph/messenger_v1.c specific, so it
doesn't apply here.  I would suggest squashing the two net/ceph patches
into one since even the titles are the same.

Also, we tend to use "libceph: " prefix for net/ceph changes.

> iteration code, this would allow pages to be sent in a batch.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: ceph-devel@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  net/ceph/messenger_v2.c | 91 +++++++++--------------------------------
>  1 file changed, 19 insertions(+), 72 deletions(-)
>
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index 301a991dc6a6..87ac97073e75 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -117,91 +117,38 @@ static int ceph_tcp_recv(struct ceph_connection *co=
n)
>         return ret;
>  }
>
> -static int do_sendmsg(struct socket *sock, struct iov_iter *it)
> -{
> -       struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
> -       int ret;
> -
> -       msg.msg_iter =3D *it;
> -       while (iov_iter_count(it)) {
> -               ret =3D sock_sendmsg(sock, &msg);
> -               if (ret <=3D 0) {
> -                       if (ret =3D=3D -EAGAIN)
> -                               ret =3D 0;
> -                       return ret;
> -               }
> -
> -               iov_iter_advance(it, ret);
> -       }
> -
> -       WARN_ON(msg_data_left(&msg));
> -       return 1;
> -}
> -
> -static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
> -{
> -       struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
> -       struct bio_vec bv;
> -       int ret;
> -
> -       if (WARN_ON(!iov_iter_is_bvec(it)))
> -               return -EINVAL;
> -
> -       while (iov_iter_count(it)) {
> -               /* iov_iter_iovec() for ITER_BVEC */
> -               bvec_set_page(&bv, it->bvec->bv_page,
> -                             min(iov_iter_count(it),
> -                                 it->bvec->bv_len - it->iov_offset),
> -                             it->bvec->bv_offset + it->iov_offset);
> -
> -               /*
> -                * sendpage cannot properly handle pages with
> -                * page_count =3D=3D 0, we need to fall back to sendmsg i=
f
> -                * that's the case.
> -                *
> -                * Same goes for slab pages: skb_can_coalesce() allows
> -                * coalescing neighboring slab objects into a single frag
> -                * which triggers one of hardened usercopy checks.
> -                */
> -               if (sendpage_ok(bv.bv_page)) {
> -                       ret =3D sock->ops->sendpage(sock, bv.bv_page,
> -                                                 bv.bv_offset, bv.bv_len=
,
> -                                                 CEPH_MSG_FLAGS);
> -               } else {
> -                       iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1,=
 bv.bv_len);
> -                       ret =3D sock_sendmsg(sock, &msg);
> -               }
> -               if (ret <=3D 0) {
> -                       if (ret =3D=3D -EAGAIN)
> -                               ret =3D 0;
> -                       return ret;
> -               }
> -
> -               iov_iter_advance(it, ret);
> -       }
> -
> -       return 1;
> -}
> -
>  /*
>   * Write as much as possible.  The socket is expected to be corked,
> - * so we don't bother with MSG_MORE/MSG_SENDPAGE_NOTLAST here.
> + * so we don't bother with MSG_MORE here.
>   *
>   * Return:
> - *   1 - done, nothing (else) to write
> + *  >0 - done, nothing (else) to write

It would be nice to avoid making tweaks like this to the outer
interface as part of switching to a new internal API.

>   *   0 - socket is full, need to wait
>   *  <0 - error
>   */
>  static int ceph_tcp_send(struct ceph_connection *con)
>  {
> +       struct msghdr msg =3D {
> +               .msg_iter       =3D con->v2.out_iter,
> +               .msg_flags      =3D CEPH_MSG_FLAGS,
> +       };
>         int ret;
>
> +       if (WARN_ON(!iov_iter_is_bvec(&con->v2.out_iter)))
> +               return -EINVAL;

Previously, this WARN_ON + error applied only to the "try sendpage"
path.  There is a ton of kvec usage in net/ceph/messenger_v2.c, so I'm
pretty sure that placing it here breaks everything.

> +
> +       if (con->v2.out_iter_sendpage)
> +               msg.msg_flags |=3D MSG_SPLICE_PAGES;
> +
>         dout("%s con %p have %zu try_sendpage %d\n", __func__, con,
>              iov_iter_count(&con->v2.out_iter), con->v2.out_iter_sendpage=
);
> -       if (con->v2.out_iter_sendpage)
> -               ret =3D do_try_sendpage(con->sock, &con->v2.out_iter);
> -       else
> -               ret =3D do_sendmsg(con->sock, &con->v2.out_iter);
> +
> +       ret =3D sock_sendmsg(con->sock, &msg);
> +       if (ret > 0)
> +               iov_iter_advance(&con->v2.out_iter, ret);
> +       else if (ret =3D=3D -EAGAIN)
> +               ret =3D 0;

Hrm, is sock_sendmsg() now guaranteed to exhaust the iterator (i.e.
a "short write" is no longer possible)?  Unless that is the case, this
is not an equivalent transformation.

This is actually the reason for

>   * Return:
>   *   1 - done, nothing (else) to write

specification which you also tweaked.  It doesn't make sense for
ceph_tcp_send() to return the number of bytes sent because the caller
expects everything to be sent when a positive number is returned.

Thanks,

                Ilya

