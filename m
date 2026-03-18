Return-Path: <netdev+bounces-268879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDCyE/clumk3SAIAu9opvQ
	(envelope-from <netdev+bounces-268879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:11:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07B2B5B94
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71F3D3042476
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0533123B;
	Wed, 18 Mar 2026 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkUVbr1J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m5++giy4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D123243964
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773807092; cv=pass; b=sFqoQkDQaMCrenFRVYNdgm1qCZXTcc1OrckwnLtVaHg3nlr0zLDhT9CxCELuo2tras7a+RLi0QfNEE/pvyauAEIgmHogHZQdkeFnzTrdJre0oBURi28+WZwKaU/wnKHb74Te75i0Pus6/jxkJnQ57Yjk2o9NBrchWO/6uY/iA7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773807092; c=relaxed/simple;
	bh=I16d/i+5cZTSpwNVQ8yPPiVPaor5KtIBLcB+JXfORxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPV4TBI6htrhaEYk70nAGKxlKeUVduVPipXsywTvdLk2LjnqsqD4jNX7UutCWDN2LvAprFW3//proFeMEzmU4wuMtH9KRLWijtYPjCsSO5OcF7UN+U+S5zb8WIrbBsDjz+I4XBlwtZiL3ISRZUOs4Zz3Q+sWsexH3OrmvecBnZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkUVbr1J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m5++giy4; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773807090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbiVdPYlM03NvUDoJqWVfNiFst5daoPrM9XFKWYtY8M=;
	b=AkUVbr1J6ZJY2X55hbAKDKyuZRrTZWN0Hy8KYA8JIdNucFe+Vi1eg1x6YiyhM9O+rwNmA0
	o0kNjfUHMdNA+yL/85WzIiiqmvZtSCb0Hi9Zrn4vIU7M7i88Ln92s4LNVuM62RU89QNv7N
	LWmN6YPgv4xrkcGz2wO+jAmHUBvru8c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-DfR1KuzgMHmMIRYwC1reUA-1; Wed, 18 Mar 2026 00:11:28 -0400
X-MC-Unique: DfR1KuzgMHmMIRYwC1reUA-1
X-Mimecast-MFC-AGG-ID: DfR1KuzgMHmMIRYwC1reUA_1773807087
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aec784479cso392510345ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773807087; cv=none;
        d=google.com; s=arc-20240605;
        b=DiTzRnzswmLnQCzGnzWQ9wLOX+XltBSbYpACqMYaIWAeQXgiqgr9zaRNr+68MojQwl
         BSEdpWj4hTBM4xM7iMAeReVb5daQgEv8dXE3AO2DNTP2V3N19+aOteBqBdpyhjZhsdmj
         u1uy+AK8g+GNxG1pF6stkre1ChlpX+HGbSyTAwCAua+5t+1tHFAL0HEiRTdE5HDOBk+s
         /vKKzADU3Vn+DxwXOVU6MvmTHxtK4fKUkiJH7TlpVTFhwsOmX66GZ841ZZt8gKESgtWs
         wr9QC1VS9buOi9hu/bRbYxwHpVRniyvasP8nC15jQQ/449NQJN0OT/70t7dgWhq/cWBR
         E2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XbiVdPYlM03NvUDoJqWVfNiFst5daoPrM9XFKWYtY8M=;
        fh=LLqbKS3O/TWLpPiiyZepelxXjuLs+xOBTKZLLydgE2g=;
        b=crq4i6H1SDu1Qo8Z3Wq+XU687wc0LTRg/TL5vR8+kRXltks4L6H3trF9s38c+PUjab
         AwyZG0YcMEzk89ZDOeIjotZmkKLZKZOOVvYJURtOFsJdnuyVbU+EvcNyVjRlBmYkH+g7
         w/+KJBBQgEn3tOZlrrOJ2jaZWwpfHJriui5+hPATMGeoD/wqSV2Ii7s4F8vutOnw7uYo
         sVxu74nGuMyVfdha0wf1vx9gCDQdb/rZ+QLCInRhLl+5lrAfO83ncuY8SChQXmyM0pzK
         e0Bv5oOcws7UbaStQNFMYfQvgJbW4+N2IXc7vZvu0OYDCA04EqV6a7OnvOiPgIxEe+R0
         EEnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773807087; x=1774411887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbiVdPYlM03NvUDoJqWVfNiFst5daoPrM9XFKWYtY8M=;
        b=m5++giy4k0ToOw92/m3c2sJJA5VrcfE50KxRBGhS88JhZS0BzNbHTLg3Yn5iOpQh2d
         g25/10aLthVzpczWLr+yJ0nY1WiXT/Q+Rf0iUTsCO49FfoKob0v+ulQBRoTlbDc+zLtr
         jkiSbyGYuSkacbbnN6RUtHPeXWQ/rYosk/s22SJlARdn/Yap8wkze8IWj9lq07gRBr/A
         7ckHFKqNUR8LdxAjqllz9HEUzYI9iiWY7gfHqpfYLSvaPypfCYc0U2f3fNHDfaiisRPP
         WMosGuw3IvSsriR7YaHGSM/xSnnM8SkJQBxMC5yVhyVjkrKQdrE9JZKRrNoFF1b2BJYU
         JQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773807087; x=1774411887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XbiVdPYlM03NvUDoJqWVfNiFst5daoPrM9XFKWYtY8M=;
        b=pXuy/XNZGUaSaMEPJJQWOxFPX/mLcHea9T1DumHuMYCZtKOQYBLHZmS8L2gN7YIz3I
         Pr0PnkzAtg48DtLe7QhyCx3EO/FBghBzKsikCP245jB5Qthq5i6iSfX8PDX25OIhU9rA
         4w+r0ReXdbCnTUco5w9QPoe5PajZhU22ArH3K1n8ikIZmq4tOC4J5dkwsVoX9SDSKVmA
         uiB2FLBFH8vyxWvTsFQeh+4T5bbsNbwF3bgIi11dt2HWQSZZh8B2lAl/wFXhfe1Fwf/d
         TzFtGkmMYA4u26Bjxw/Tq7OuUQf5o+BL66pPZwE2Ac45+p8eDDi6Ttnq1vyZqp1ZGcE3
         1LTg==
X-Gm-Message-State: AOJu0YxhF3USm7FyFSyK7zD9ksjVWqByhPuQLyCBubDPZ1BUHuw3l0bq
	NuCTNdm2u1melAD2Q+MVty4DLAZ+kKq4auvdrAfKLW3oEQ6h6KtD92K4Ym43P+3wWzfvrTM0fIu
	DTpus4rfwa9qaDfx21nY8An6vKV9U7Yc/EsdHA2bRw2BZ03PKA87wO7t7b6hZ+4k9ZYBg7PCO/6
	zUx6DGCiwLH6yajq/2SVQwLkoKEr1emeIK
X-Gm-Gg: ATEYQzxkLErLitUUoM//B1dccWpTyHhqU6D9uhntCbdHq1+cQ3BxGFluab+hdMv3tQc
	NKvF+cC89dmOgd9w5jg/EPLmTmf+VI+gLivTAB3b/PzsZ9dbnlUbz/U4xfHfpYwEtUtuZWq2wNI
	koZ7VgXNj7zlfTFmelMD9kfsip9di82xc4yWYTzbef/qUCMMEtw+Jxd3YXUPorkMIiTuM4in1dA
	yNLPWc=
X-Received: by 2002:a17:903:41d2:b0:2b0:5cee:c405 with SMTP id d9443c01a7336-2b06e4420bemr18490245ad.52.1773807087385;
        Tue, 17 Mar 2026 21:11:27 -0700 (PDT)
X-Received: by 2002:a17:903:41d2:b0:2b0:5cee:c405 with SMTP id
 d9443c01a7336-2b06e4420bemr18490045ad.52.1773807086988; Tue, 17 Mar 2026
 21:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com> <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
In-Reply-To: <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Mar 2026 12:11:15 +0800
X-Gm-Features: AaiRm52-x9kX4d0uBozSKicaMMtLvo5jnpGEBBzaMIMSdMXnla2mqzEY4pPxfpM
Message-ID: <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268879-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,solid-run.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BC07B2B5B94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:07=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Mar 13, 2026 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header lengt=
h
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> >
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> >
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> >
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gu=
est feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/tun_vnet.h     |  2 +-
> >  drivers/net/virtio_net.c   |  6 +++++-
> >  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
> >  3 files changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index a5f93b6c4482..fa5cab9d3e55 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> >                                         tun_vnet_is_little_endian(flags=
),
> > -                                       vlan_hlen, true)) {
> > +                                       vlan_hlen, true, false)) {
> >                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hd=
r;
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 72d6a9c6a5a2..7106333ef904 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struc=
t sk_buff *skb, bool orphan)
> >         struct virtio_net_hdr_v1_hash_tunnel *hdr;
> >         int num_sg;
> >         unsigned hdr_len =3D vi->hdr_len;
> > +       bool feature_hdrlen;
> >         bool can_push;
> >
> > +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> > +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> > +
> >         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >
> >         /* Make sure it's safe to cast between formats */
> > @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> >                                         virtio_is_little_endian(vi->vde=
v), 0,
> > -                                       false))
> > +                                       false, feature_hdrlen))
> >                 return -EPROTO;
> >
> >         if (vi->mergeable_rx_bufs)
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 75dabb763c65..48de4a16a96a 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_=
buff *skb,
> >         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gs=
o_type);
> >  }
> >
> > +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> > +                                        struct virtio_net_hdr *hdr,
> > +                                        bool little_endian)
> > +{
> > +       u16 hdr_len;
> > +
> > +       hdr_len =3D skb_transport_offset(skb);
> > +
> > +       if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> > +               hdr_len +=3D sizeof(struct udphdr);
> > +       else
> > +               hdr_len +=3D tcp_hdrlen(skb);
>
> Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()
>
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
>                 else if (sinfo->gso_type & SKB_GSO_TCPV6)
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
>                 else if (sinfo->gso_type & SKB_GSO_UDP_L4)
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>         else
>                         return -EINVAL;
>
> To be more robust, I'd suggest moving it there.
>
> But I have another question, the logic above depends on the headlen is
> correctly set:
>
>                 /* This is a hint as to how much should be linear. */
>                 hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
>                                                  skb_headlen(skb));
>
> Is the headlen guaranteed to be correct in all cases (e.g for nested
> setups or dodgy packets?)

Speak too fast, I miss

hdr_len =3D skb_transport_offset(skb);

This is probably another call to

1) Move virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb() or
2) call virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb().

Thanks

>
> Thanks
>
> > +
> > +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> > +}
> > +
> >  static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> >                                           struct virtio_net_hdr *hdr,
> >                                           bool little_endian,
> > @@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >                             bool tnl_hdr_negotiated,
> >                             bool little_endian,
> >                             int vlan_hlen,
> > -                           bool has_data_valid)
> > +                           bool has_data_valid,
> > +                           bool feature_hdrlen)
> >  {
> >         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
> >         unsigned int inner_nh, outer_th;
> > @@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *=
skb,
> >
> >         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNE=
L |
> >                                                     SKB_GSO_UDP_TUNNEL_=
CSUM);
> > -       if (!tnl_gso_type)
> > -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> > -                                              has_data_valid, vlan_hle=
n);
> > +       if (!tnl_gso_type) {
> > +               ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endian=
,
> > +                                             has_data_valid, vlan_hlen=
);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               if (feature_hdrlen && hdr->hdr_len)
> > +                       virtio_net_set_hdrlen(skb, hdr, little_endian);
> > +
> > +               return ret;
> > +       }
> >
> >         /* Tunnel support not negotiated but skb ask for it. */
> >         if (!tnl_hdr_negotiated)
> > --
> > 2.32.0.3.g01195cf9f
> >


