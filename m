Return-Path: <netdev+bounces-263022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJtBHnlSpmkbOAAAu9opvQ
	(envelope-from <netdev+bounces-263022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:16:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B83CB1E863D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3220E308384E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E741FECBA;
	Tue,  3 Mar 2026 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhT5bPm8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mHFYtBDS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DF37CD56
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507733; cv=pass; b=s5YBXwcntJcIa6BxD7YWFthUDAnSP9Numjcdlu7RQJDEb0fATAYAmnRcEfcr7+hPes4+0CEk2KQvQJCN2QkyHX+IQLURfHm8tPNeRNDDT7MEIYHBvWLCLw5Tih3fq86Cg+OhEl0vHCTURmyWgfeODj+hrJzafaUuFqm+T31usnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507733; c=relaxed/simple;
	bh=IwizxpPURzX2jD0W5Du6Tyf/56Go3Y/S4srRiey9Raw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS2yNrK4kj7zboGpWFHvMjaybUhkFXvYtEr7OupVQPfR/JbmXKEEFcVA0NPe0eGEusEJ2NYXbmBoznbA+omisio0YIt2n/v1sab5LZT8JqJVbnzjJxmy1hjThP0YTEtfDjahcPJeT8puokhje2JCTX0toJ6M1R+uzd/IJe2oHg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhT5bPm8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mHFYtBDS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772507730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Bf79Q/NnXmzYDVVSgb0Zw9SZSCpomlBP1E9IJmLB3s=;
	b=hhT5bPm8n1Y6mu5qEBRBstQHFkOqhA3pIlZo9ww3YpP3M3q9tbkLqFVKyLginKp5BVIEcf
	5ps322U/EgU7/XG/lt5wwHAisALmaGInzGTHpQZJ5uOp41Vsi9JC285zVQTE/3Jb2wG9QI
	hIw1OkR8jL0ZBv1J6hQzItPRRZy64uk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-xrtZYjnDO6ORa7qq0eOpaQ-1; Mon, 02 Mar 2026 22:15:29 -0500
X-MC-Unique: xrtZYjnDO6ORa7qq0eOpaQ-1
X-Mimecast-MFC-AGG-ID: xrtZYjnDO6ORa7qq0eOpaQ_1772507728
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aadeb3dee4so317124175ad.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 19:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772507728; cv=none;
        d=google.com; s=arc-20240605;
        b=BmT0hgSiD8fB/PygFlXKtFgMKRx4OSqYOxTHi7kBKmxAVGjZH41qsHqzbCEdSelHbr
         Muy68Ui1iTQDP87wGgJT2eod7fUIkaYTY0VAszruRvU21Xl/mDUeYl8rqzibIJvvvXQ4
         hXll9kc9n2fsk022Wib0DQa56Wl4uxOutpWSPH31XStzhBUj8ytUwOfNX1Wy0k7VOb0B
         3XdLaLj4pmypMkJxTUawKKlBwxdqDKf5jPxJw1c3XOaC5bR1j9NhsEoF0/9PA0i5YuhZ
         y76PwyvmYgvwSVCXQNrvSTzhgfE9yBYiPFwymJsElx0BvHHxyJ/epeTf+pAji52aWM4D
         yp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Bf79Q/NnXmzYDVVSgb0Zw9SZSCpomlBP1E9IJmLB3s=;
        fh=LLqbKS3O/TWLpPiiyZepelxXjuLs+xOBTKZLLydgE2g=;
        b=gnGdxIfvBVYaJc1hzyXHByXYFFyIaTotSeGbjLfvmb8elFLQGpdipNF/cEC2EIIYG3
         UimCBey0/HpHmfvdrIhBISNL1duPB4/SfIKleiID5zkKdqtJDReBv58uMpv+e4BDjzJD
         nkMpe9V6/cuIEU5PfhMjC0mQ004/X1Bi3+iZ4/lioQbe7ydRpPWY5+1Lgdik+MfKCCcY
         TdWOrTq1OtBlY4AnEnV3hvcO3nKM98/4gREMLTprpbW8YaPtYLwOIw4cx8xYDgkrMEgp
         wPoMGgolCTex5Uu+N/vcUUQzoGpCb4I5ryWU9LZM8NGVnG41d1o8L5uSOZnBZTpd0vYX
         U1pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772507728; x=1773112528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bf79Q/NnXmzYDVVSgb0Zw9SZSCpomlBP1E9IJmLB3s=;
        b=mHFYtBDSHhG6iBkwgaeuCbZBFu2Pmep2BVMQM6lBReXhU170r5l67kV4+sNF/XtUL0
         XuS1dHApJZAKxutgkNRJXN5ofBZnmriA/6zuVEPKpT6o6L5RfiotPBNpU9+WAICSF9kc
         hwvGLOW6hVrVCoNiuGbFjzGxskrsnUY9IpYTFfO9GD6ZdiMpD0x1gIlfX5cCH6Ypp2Gc
         sMek9aKCO4FNQ8mrKzyDDEfBZCHD3MdRxpS7l8XX2GfdcKvlpR7dQvoDzqtiij2RUyE5
         1G8gh6j4wK+ZBZUPqQ60ZuwywO7hHlFLv4CHNioqKdl14TqHe63UCPfNsUk1BMPuGQM2
         Ry7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772507728; x=1773112528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Bf79Q/NnXmzYDVVSgb0Zw9SZSCpomlBP1E9IJmLB3s=;
        b=RHDxIG1SI7R2G6EswZtYM+A+STY5hht+NZPH1vZzD/QH7qB38wrGdUC3SS4JHa3REO
         w2kFEwBekt0pLqdlajEg6EE5t20ARQY3s0AP5x28G99iK/WL2++1ol8uH0e5HCfP+6RY
         UjL11jpqQ3Sn2/l2FAUaYMNKytrSoIwbyLgxAOoSkmvfXdDGyzHAG7lCbzVAmpQcKPA9
         CT5q5oYmXj/3FZk0DYZHKbj2pfZcvOP7tUrCIveYLp24eQyLT6/H43NVxkfNv6jcuokm
         SF67IEjAOdcOGilQj2eT5844F1aLK3zJFuibgfPea/0dvGi6QFOU/qM4kt3nvnnkfZTx
         qR5Q==
X-Gm-Message-State: AOJu0YzPdhzzKfrbHa4mjxaFbMpkHCaGYnI/JokFfFYcf0BZxZt+rL0I
	fQ6XMDYCAOPoqSh8TIVR1JlSXogPyexPIQz5gxdmPvo+tdY5BGjQ0Ov0uwapJvTVSCZ16hZhQ0S
	Ft2VVCkw12iuEIjBNh5gz288dwlq6lVzpQDUzLC811jO5WOQrUPsQY+6mg5ePBLqZ0V+dxRpGEV
	IH+rxTALTXWQH7jnZZf1qwRYEb0UvAUNua
X-Gm-Gg: ATEYQzz5J9vRu7h14ki3EwwT2JY1vO0vCVg6z6MURwIzvhznVQUm5oRcGDOz4RB1JFq
	eBrtb8EOqFR3lhtPnwgFHrpQZJUBfdEv6MxRxcNci/C/ZXFVy+uu25hGxwCjCaSQ9co0gvHRLwQ
	9mK33lBqV39jU6TYw01OJEOAf2LHbhLPtipbzqxjr5WkDz5Gagb6GD8Tp2wasI7jUqfsWICwVlp
	6Mxp8qE
X-Received: by 2002:a17:902:f789:b0:2ae:4cd9:7196 with SMTP id d9443c01a7336-2ae4cd97478mr70431825ad.29.1772507728302;
        Mon, 02 Mar 2026 19:15:28 -0800 (PST)
X-Received: by 2002:a17:902:f789:b0:2ae:4cd9:7196 with SMTP id
 d9443c01a7336-2ae4cd97478mr70431505ad.29.1772507727825; Mon, 02 Mar 2026
 19:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302090413.86471-1-xuanzhuo@linux.alibaba.com> <20260302090413.86471-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260302090413.86471-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 11:15:16 +0800
X-Gm-Features: AaiRm50IOXUFT0FltUxfUjfp32u-c2Q-Y6q5lunuZueLNIghUQnp7TWKeqIlzWo
Message-ID: <CACGkMEtnOKxJVY2qrbFsTwR9c=e34HU7z6Mdhyj3kPGf867F-g@mail.gmail.com>
Subject: Re: [PATCH net v7 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B83CB1E863D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263022-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
>
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
>
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  8 +++--
>  include/linux/virtio_net.h | 61 ++++++++++++++++++++++++++++++--------
>  3 files changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index a5f93b6c4482..fa5cab9d3e55 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>
>         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>                                         tun_vnet_is_little_endian(flags),
> -                                       vlan_hlen, true)) {
> +                                       vlan_hlen, true, false)) {
>                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hdr;
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..1800058c8072 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3265,9 +3265,13 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>         const unsigned char *dest =3D ((struct ethhdr *)skb->data)->h_des=
t;
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         struct virtio_net_hdr_v1_hash_tunnel *hdr;
> -       int num_sg;
>         unsigned hdr_len =3D vi->hdr_len;
> +       bool feature_hdrlen;
>         bool can_push;
> +       int num_sg;

nit: the change to num_sg seems to be unnecessary.

> +
> +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> +                                           VIRTIO_NET_F_GUEST_HDRLEN);
>
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
> @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb, bool orphan)
>
>         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>                                         virtio_is_little_endian(vi->vdev)=
, 0,
> -                                       false))
> +                                       false, feature_hdrlen))
>                 return -EPROTO;
>
>         if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..d31c9af1f3d6 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
>  }
>
> -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> -                                         struct virtio_net_hdr *hdr,
> -                                         bool little_endian,
> -                                         bool has_data_valid,
> -                                         int vlan_hlen)
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +                                        struct virtio_net_hdr *hdr,
> +                                        bool little_endian,
> +                                        bool feature_hdrlen)
> +{
> +       u16 hdr_len;
> +
> +       if (feature_hdrlen) {
> +               hdr_len =3D skb_transport_offset(skb);
> +
> +               if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> +                       hdr_len +=3D sizeof(struct udphdr);
> +               else
> +                       hdr_len +=3D tcp_hdrlen(skb);
> +       } else {
> +               /* This is a hint as to how much should be linear. */
> +               hdr_len =3D skb_headlen(skb);
> +       }
> +
> +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> +}
> +
> +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                           struct virtio_net_hdr *hdr,
> +                                           bool little_endian,
> +                                           bool has_data_valid,
> +                                           bool feature_hdrlen,
> +                                           int vlan_hlen)
>  {
>         memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>                 else
>                         return -EINVAL;
> +
> +               virtio_net_set_hdrlen(skb, hdr, little_endian,
> +                                     feature_hdrlen);
> +
>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>         return 0;
>  }
>
> +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                         struct virtio_net_hdr *hdr,
> +                                         bool little_endian,
> +                                         bool has_data_valid,
> +                                         int vlan_hlen)
> +{
> +       return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                        has_data_valid, false, vlan_hlen=
);
> +}
> +
>  static inline unsigned int virtio_l3min(bool is_ipv6)
>  {
>         return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> @@ -385,7 +419,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>                             bool tnl_hdr_negotiated,
>                             bool little_endian,
>                             int vlan_hlen,
> -                           bool has_data_valid)
> +                           bool has_data_valid,
> +                           bool feature_hdrlen)
>  {
>         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
>         unsigned int inner_nh, outer_th;
> @@ -395,8 +430,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL =
|
>                                                     SKB_GSO_UDP_TUNNEL_CS=
UM);
>         if (!tnl_gso_type)
> -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> -                                              has_data_valid, vlan_hlen)=
;
> +               return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                                has_data_valid,
> +                                                feature_hdrlen, vlan_hle=
n);
>
>         /* Tunnel support not negotiated but skb ask for it. */
>         if (!tnl_hdr_negotiated)
> @@ -409,7 +445,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>
>         /* Let the basic parsing deal with plain GSO features. */
>         skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
> -       ret =3D virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen)=
;
> +       ret =3D __virtio_net_hdr_from_skb(skb, hdr, true, false,
> +                                       feature_hdrlen, vlan_hlen);

This seems to be incorrect as tnl_gso_type is masked so
__virtio_net_hdr_from_skb() can only see UDP packet for tunnel gso
packet?

(And it seems to be fixed in next patch, could we simply squash them)

Thanks


>         skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
>         if (ret)
>                 return ret;
> --
> 2.32.0.3.g01195cf9f
>


