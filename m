Return-Path: <netdev+bounces-50666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB9F7F6921
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 23:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C328183D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB421E516;
	Thu, 23 Nov 2023 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVdZNdRK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA38D6C
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700780034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgkyQVWNEh0w8FRWOuAxuO8xPZdHyxrc2iTVyvbqtKU=;
	b=KVdZNdRKx4iLxGkcyZHEGRhbM/26qc2DXXubk7qShFJU3jFD0UhmLn00mr4mcRLMWJpIYU
	gkxfq0hQF93YZ3VdlVoZ9gK1iIKojry8n6uAt35Nr7aIwI9hHZBR2AB+8/BuYjhUbO3tyE
	vhB5qVaFlntto3vC7tnvUo2/6wJ5bY8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-wdJVMYx5OHqGbOePDcTQrw-1; Thu, 23 Nov 2023 17:53:53 -0500
X-MC-Unique: wdJVMYx5OHqGbOePDcTQrw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1f5ce492010so1777628fac.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 14:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700780013; x=1701384813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgkyQVWNEh0w8FRWOuAxuO8xPZdHyxrc2iTVyvbqtKU=;
        b=ktkC/LfjBpznKXbuOwgE9N2aEa1XrT0E87+0Hapt4eHFcLeKUlCPqeCayGqrsGQcys
         mTCthafkiuqd7hHPGjZNVjMchj2W9xH392TBWddw8OdxPD2NEK3Bh9VdJVcBkAWuOxti
         jKTQFZPAnkFLJO324kwvROXBYPPe+pg1iI/5r5wSH7yYv8A89OiU0rrtXw5Qc6XYOjzU
         +EHG9JRBDSWWtkPTJhUZF1nMBFT7bRUE0B0pehzgRfTnEjm9/hK5AMKvpZp6BuUxU17z
         Vr1laj8ZYIeB8R/A6KxlR8V58Zn66XI6vedUU5bdPMZ4vVJq1XqwDa7W7CVTMzeBRMNt
         8Uhw==
X-Gm-Message-State: AOJu0YzY1pOG+dT5T3PEyIOlDmcsBHd7XQZs/G6xQ7liEJtlIjuFAr8w
	rMeH7Kfr0vNq77aGn74r404Jlj/UPcYPVI01etX5/C7LPFmIHqNsYHOA9Spv3tP5tpL/xcWzWA+
	QoDAPA7jNX45rGjWES8qTUUytXqxhSpZd
X-Received: by 2002:a05:6870:ebca:b0:1ef:cedd:5c32 with SMTP id cr10-20020a056870ebca00b001efcedd5c32mr998594oab.3.1700780013307;
        Thu, 23 Nov 2023 14:53:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6HGCbuC2wuf4qW3jUuFH9NOq5sUWsl30jXSKTaMc3yOR1OB7UdxlczqfoO5wGGXUKu8ApVrKHNBUO0CwSip0=
X-Received: by 2002:a05:6870:ebca:b0:1ef:cedd:5c32 with SMTP id
 cr10-20020a056870ebca00b001efcedd5c32mr998579oab.3.1700780013047; Thu, 23 Nov
 2023 14:53:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123183835.635210-1-mkp@redhat.com> <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
From: Mike Pattrick <mkp@redhat.com>
Date: Thu, 23 Nov 2023 17:53:21 -0500
Message-ID: <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mike Pattrick wrote:
> > Af_packet provides checksum offload offsets to usermode applications
> > through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on the
> > socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
> > af_packet will include the link level header and so csum_start needs
> > to be adjusted accordingly.
>
> Is this patch based on observing an incorrect offset in a workload,
> or on code inspection?

Based on an incorrect offset in a workload. The setup involved sending
vxlan traffic though a veth interface configured with a vlan. The
vnet_hdr's csum_start value was off by 4, and this problem went away
when the vlan was removed.

I'll take another look at this patch.

>
> As the referenced patch mentions, VLAN_HLEN adjustment is needed
> in macvtap because it pulls the vlan header from skb->vlan_tci. At
> which point skb->csum_start is wrong.
>
> "Commit f09e2249c4f5 ("macvtap: restore vlan header on user read")
>  added this feature to macvtap. Commit 3ce9b20f1971 ("macvtap: Fix
>  csum_start when VLAN tags are present") then fixed up csum_start."
>
> But the commit also mentions "Virtio, packet and uml do not insert
> the vlan header in the user buffer.". This situation has not changed.
>
> Packet sockets may receive packets with VLAN headers present, but
> unless they were inserted manually before passing to user, as macvtap
> does, this does not affect csum_start.
>
> Packet sockets support reading those skb->vlan_tci stored VLAN
> headers using AUXDATA.
>
> > Fixes: fd3a88625844 ("net: in virtio_net_hdr only add VLAN_HLEN to csum=
_start if payload holds vlan")
>
> The fix should target net, not net-next.
>
> > Signed-off-by: Mike Pattrick <mkp@redhat.com>
> > ---
> >  net/packet/af_packet.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index a84e00b5904b..f6b602ffe383 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2092,15 +2092,23 @@ static unsigned int run_filter(struct sk_buff *=
skb,
> >  }
> >
> >  static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *s=
kb,
> > -                        size_t *len, int vnet_hdr_sz)
> > +                        size_t *len, int vnet_hdr_sz,
> > +                        const struct sock *sk)
> >  {
> >       struct virtio_net_hdr_mrg_rxbuf vnet_hdr =3D { .num_buffers =3D 0=
 };
> > +     int vlan_hlen;
> >
> >       if (*len < vnet_hdr_sz)
> >               return -EINVAL;
> >       *len -=3D vnet_hdr_sz;
> >
> > -     if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_h=
dr, vio_le(), true, 0))
> > +     if (sk->sk_type =3D=3D SOCK_RAW && skb_vlan_tag_present(skb))
> > +             vlan_hlen =3D VLAN_HLEN;
> > +     else
> > +             vlan_hlen =3D 0;
> > +
> > +     if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_h=
dr,
> > +                                 vio_le(), true, vlan_hlen))
> >               return -EINVAL;
> >
> >       return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
> > @@ -2368,13 +2376,21 @@ static int tpacket_rcv(struct sk_buff *skb, str=
uct net_device *dev,
> >               __set_bit(slot_id, po->rx_ring.rx_owner_map);
> >       }
> >
> > -     if (vnet_hdr_sz &&
> > -         virtio_net_hdr_from_skb(skb, h.raw + macoff -
> > -                                 sizeof(struct virtio_net_hdr),
> > -                                 vio_le(), true, 0)) {
> > -             if (po->tp_version =3D=3D TPACKET_V3)
> > -                     prb_clear_blk_fill_status(&po->rx_ring);
> > -             goto drop_n_account;
> > +     if (vnet_hdr_sz) {
> > +             int vlan_hlen;
> > +
> > +             if (sk->sk_type =3D=3D SOCK_RAW && skb_vlan_tag_present(s=
kb))
> > +                     vlan_hlen =3D VLAN_HLEN;
> > +             else
> > +                     vlan_hlen =3D 0;
> > +
> > +             if (virtio_net_hdr_from_skb(skb, h.raw + macoff -
> > +                                         sizeof(struct virtio_net_hdr)=
,
> > +                                         vio_le(), true, vlan_hlen)) {
> > +                     if (po->tp_version =3D=3D TPACKET_V3)
> > +                             prb_clear_blk_fill_status(&po->rx_ring);
> > +                     goto drop_n_account;
> > +             }
> >       }
> >
> >       if (po->tp_version <=3D TPACKET_V2) {
> > @@ -3464,7 +3480,7 @@ static int packet_recvmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len,
> >       packet_rcv_try_clear_pressure(pkt_sk(sk));
> >
> >       if (vnet_hdr_len) {
> > -             err =3D packet_rcv_vnet(msg, skb, &len, vnet_hdr_len);
> > +             err =3D packet_rcv_vnet(msg, skb, &len, vnet_hdr_len, sk)=
;
> >               if (err)
> >                       goto out_free;
> >       }
> > --
> > 2.40.1
> >
>
>


