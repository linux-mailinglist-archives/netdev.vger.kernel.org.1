Return-Path: <netdev+bounces-21719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8978376466C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ACA1C214E0
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC20A941;
	Thu, 27 Jul 2023 06:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AFA93C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:07:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB97510FC
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690438073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKhfa5geZjKIfZjztjHk2uQ3PoNr/mdgmW/R/LWd24U=;
	b=JjvTkOXzjWsZ8pHdAEqsYUMnD47wkxIvqnnBelEjue23AIFXG1cOAI7CZPXzIuIskthQJd
	i6hTclbvyrvorSrFDIrCYVVhMojZAxlWMA9mhonNn+ULR0DWyIbsMJINAUHl/wWFLkem+7
	LjJI5K1WeQ5gXjNQSMylXnnt7/K6NvE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-jIR4Q6GoPbqVSmBZ64yHIA-1; Thu, 27 Jul 2023 02:07:51 -0400
X-MC-Unique: jIR4Q6GoPbqVSmBZ64yHIA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b8405aace3so5021911fa.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690438070; x=1691042870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKhfa5geZjKIfZjztjHk2uQ3PoNr/mdgmW/R/LWd24U=;
        b=Hh+6ye9ed+7KJdKnIJsLbHytjXyzWZ0ZvF1+4rjutfWwWzvg7XZh3Ba7CEJGxi+zOK
         v3Nie+n52dAnZ99qZuHdpHeXSP6fVGtSpyRgtGwjFGDyF0iLOJu4gfguHzz8CDSuqYNM
         oKsEiKrQdvg8IQ2fTZI6QW+XW+VQAOdJa4ogk8XMcgD+OFMr75g7/Sb9Tm15wMr8mh7A
         2C4OUAK8BGyQHkK6t6FK4VDVszKNxIUBJ7OVpomj72E3BVkXKyg7AstA68Np8aqARMlm
         kkTaNc1RrEkr7kgEjWAehdxy0oZVnz9JOgwEt8A8ThSVVptTyPJ/SVtHQNYKUKTfvAdd
         QKeQ==
X-Gm-Message-State: ABy/qLbHQ9G5LKMM8igjf3P+jG5YnJjx+tvoflepIsLQMsmRomVXEX7c
	TMD9kyy6oN202XlckU89zxuJqFbQWWAwe/jR5PeVYmxiOMUZkm+JlRbqZpo7ld65LCLVV0pSwLl
	qYnNrUCc+u4wzJ/2+eBvqUIeEIP+ye+vf
X-Received: by 2002:a2e:3812:0:b0:2b7:3b73:2589 with SMTP id f18-20020a2e3812000000b002b73b732589mr895697lja.32.1690438070199;
        Wed, 26 Jul 2023 23:07:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhLW0YWxwG/nhKIg4TI3VlNVlEPvQjoVNWQ3o+mluSfSG1OIO7xuG9XQONNUkjDZfZnn1ooiv1FXY+Mm9NyQs=
X-Received: by 2002:a2e:3812:0:b0:2b7:3b73:2589 with SMTP id
 f18-20020a2e3812000000b002b73b732589mr895672lja.32.1690438069811; Wed, 26 Jul
 2023 23:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725155403.796-1-andrew.kanner@gmail.com> <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com> <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
 <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
In-Reply-To: <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Jul 2023 14:07:38 +0800
Message-ID: <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
To: David Ahern <dsahern@gmail.com>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, Andrew Kanner <andrew.kanner@gmail.com>, brouer@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 8:27=E2=80=AFAM David Ahern <dsahern@gmail.com> wro=
te:
>
> On 7/26/23 1:37 PM, David Ahern wrote:
> > On 7/26/23 3:02 AM, Jesper Dangaard Brouer wrote:
> >> Cc. John and Ahern
> >>
> >> On 26/07/2023 04.09, Jason Wang wrote:
> >>> On Tue, Jul 25, 2023 at 11:54=E2=80=AFPM Andrew Kanner
> >>> <andrew.kanner@gmail.com> wrote:
> >>>>
> >>>> Syzkaller reported the following issue:
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> Too BIG xdp->frame_sz =3D 131072
> >>
> >> Is this a contiguous physical memory allocation?
> >>
> >> 131072 bytes equal order 5 page.
> >>
> >> Looking at tun.c code I cannot find a code path that could create
> >> order-5 skb->data, but only SKB with order-0 fragments.  But I guess i=
t
> >> is the netif_receive_generic_xdp() what will realloc to make this line=
ar
> >> (via skb_linearize())
> >
> >
> > get_tun_user is passed an iov_iter with a single segment of 65007
> > total_len. The alloc_skb path is hit with an align size of only 64. Tha=
t
> > is insufficient for XDP so the netif_receive_generic_xdp hits the
> > pskb_expand_head path. Something is off in the math in
> > netif_receive_generic_xdp resulting in the skb markers being off. That
> > causes bpf_prog_run_generic_xdp to compute the wrong frame_sz.
>
>
> BTW, it is pskb_expand_head that turns it from a 64kB to a 128 kB
> allocation. But the 128kB part is not relevant to the "bug" here really.
>
> The warn on getting tripped in bpf_xdp_adjust_tail is because xdp
> generic path is skb based and can have a frame_sz > 4kB. That's what the
> splat is about.

Other possibility:

tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM this may end up
with producing a frame_sz which is greater than PAGE_SIZE as well in
tun_build_skb().

And rethink this patch, it looks wrong since it basically drops all
packets whose buflen is greater than PAGE_SIZE since it can't fall
back to tun_alloc_skb().

>
> Perhaps the solution is to remove the WARN_ON.

Yes, that is what I'm asking if this warning still makes sense in V1.

Thanks

>
>


