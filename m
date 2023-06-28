Return-Path: <netdev+bounces-14402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED567408E4
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 05:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA93C1C20B7B
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54443D74;
	Wed, 28 Jun 2023 03:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67511847
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 03:23:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCA12D58
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 20:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687922583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QpPswITkJ4C3apxiFR89/xuv4AUWgAAaidrhq6HUVc=;
	b=YseXOkM1ZNx21OsYY4TpwosM5rT8Gs2mb8yzzepMw7anYyC6mnYKoOqVBFNZq35FR77sFb
	aMWtVXrVmBTM2T6orZwSeY0DvgovqdIngEgENDLPb0Rnk40Ll/64U0cxkWVcXHJwLYGoJ6
	V+iynuGgywTW6TMhuKfgiE5fU8AL3Ns=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-af5rlKBTP-2r8MbCvIJCPg-1; Tue, 27 Jun 2023 23:23:01 -0400
X-MC-Unique: af5rlKBTP-2r8MbCvIJCPg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b698377ed7so32407441fa.3
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 20:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687922579; x=1690514579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QpPswITkJ4C3apxiFR89/xuv4AUWgAAaidrhq6HUVc=;
        b=Q1L+0LPZg3OgfEeYxrsVg26Pd3nezvNFOeyVvT25EKgH7k5sIla+RxBTujHduQ0ntm
         XIVYSsP7MzAsk5UxaygjboY7awMfmHLcjUHJo7G+wEFOCXyxb+L34jmeMUd82yNU3I1P
         oUmV3iBNIhUh0jF1TOYv56IQiWKSylaZG58zZhzrIwb61//BaWYT9fRtPYAp+GW/1OPn
         RV8+cEf9i1QVCGix1lJsf9DK3N+7NIe/1P8keI4Ninv4fkufzFa5XOL0JHZeuW+UUV/l
         gDVL+pSf3A14Uqer70JQV07dsZWi+dtkbMHHBVBud5i3KiqWcNKpdRCUGLZrElEKGmDQ
         Chpw==
X-Gm-Message-State: AC+VfDx7as4pbid0LGxlm0JRB76qDBLADpteWbgBLTDUcWsRGLoNxSj3
	gyuMrDnYPFvhW+NUH1hQwlEd8IKur9YvAQi4G5RUZjiIkkNxWJEwVmOzo21gSXSRpPkeWaMexwp
	YUVKkcm6AV2z7xXBK5xfF+E3vk4nzZAan
X-Received: by 2002:a2e:3a19:0:b0:2b4:73bc:da9a with SMTP id h25-20020a2e3a19000000b002b473bcda9amr18407094lja.27.1687922579516;
        Tue, 27 Jun 2023 20:22:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Ao2TJ5IPE0dY314BZiu9FcutjHYx3QN+u+PATISnMmpVcdMN8k+urgwTIRalKmgkzqbJhTHIMhrdPjjroUyg=
X-Received: by 2002:a2e:3a19:0:b0:2b4:73bc:da9a with SMTP id
 h25-20020a2e3a19000000b002b473bcda9amr18407074lja.27.1687922579104; Tue, 27
 Jun 2023 20:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628030506.2213-1-hengqi@linux.alibaba.com> <20230628030506.2213-2-hengqi@linux.alibaba.com>
In-Reply-To: <20230628030506.2213-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 11:22:48 +0800
Message-ID: <CACGkMEv7aVH0dgdd6N3RMH+57BWuxnq9NR8sPzD9wRQZ5TZRFQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] virtio-net: support coexistence of XDP
 and GUEST_CSUM
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
> We are now re-probing the csum related fields and trying
> to have XDP and RX hw checksum capabilities coexist on the
> XDP path. For the benefit of:
> 1. RX hw checksum capability can be used if XDP is loaded.
> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v3->v4:
>   - Rewrite some comments.
>
> v2->v3:
>   - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp().
>     Essentially equivalent.
>
>  drivers/net/virtio_net.c | 82 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 69 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5a7f7a76b920..a47342f972b5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1568,6 +1568,41 @@ static void virtio_skb_set_hash(const struct virti=
o_net_hdr_v1_hash *hdr_hash,
>         skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_t=
ype);
>  }
>
> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> +                                     struct sk_buff *skb,
> +                                     __u8 flags)
> +{
> +       int err =3D 0;
> +
> +       /* When XDP program is loaded, the vm-vm scenario on the same hos=
t,
> +        * packets marked VIRTIO_NET_HDR_F_NEEDS_CSUM without a complete =
checksum
> +        * will travel. Although these packets are safe from the point of
> +        * view of the vm, in order to be successfully forwarded on the u=
pper
> +        * layer and to avoid packet loss caused by XDP modification,
> +        * we re-probe the necessary checksum related information:
> +        * skb->csum_{start, offset}, pseudo-header checksum.
> +        *
> +        * If the received packet is marked VIRTIO_NET_HDR_F_DATA_VALID:
> +        * when _F_GUEST_CSUM is negotiated, the device validates the che=
cksum
> +        * and virtio-net sets skb->ip_summed to CHECKSUM_UNNECESSARY;
> +        * otherwise, virtio-net hands over to the stack to validate the =
checksum.
> +        */
> +       if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> +               /* No need to care about SCTP because virtio-net currentl=
y doesn't
> +                * support SCTP CRC checksum offloading, that is, SCTP pa=
ckets have
> +                * complete checksums.
> +                */
> +               err =3D skb_checksum_setup(skb, true);

A second thought, any reason why a checksum is a must here. Could we simply=
:

1) probe the csum_start/offset
2) leave it as CHECKSUM_PARTIAL

?

> +       } else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> +               /* XDP guarantees that packets marked as VIRTIO_NET_HDR_F=
_DATA_VALID
> +                * still have correct checksum after they are processed.
> +                */

Do you mean it's the charge of the XDP program to calculate the csum
in this case? Seems strange.

Thanks

> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +       }
> +
> +       return err;
> +}
> +
>  static void receive_buf(struct virtnet_info *vi, struct receive_queue *r=
q,
>                         void *buf, unsigned int len, void **ctx,
>                         unsigned int *xdp_xmit,
> @@ -1576,6 +1611,7 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>         struct net_device *dev =3D vi->dev;
>         struct sk_buff *skb;
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       __u8 flags;
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1584,6 +1620,12 @@ static void receive_buf(struct virtnet_info *vi, s=
truct receive_queue *rq,
>                 return;
>         }
>
> +       /* XDP may modify/overwrite the packet, including the virtnet hdr=
,
> +        * so save the flags of the virtnet hdr before XDP processing.
> +        */
> +       if (unlikely(vi->xdp_enabled))
> +               flags =3D ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.f=
lags;
> +
>         if (vi->mergeable_rx_bufs)
>                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, xdp=
_xmit,
>                                         stats);
> @@ -1595,23 +1637,37 @@ static void receive_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
>         if (unlikely(!skb))
>                 return;
>
> -       hdr =3D skb_vnet_hdr(skb);
> -       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash =
*)hdr, skb);
> -
> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +       if (unlikely(vi->xdp_enabled)) {
> +               /* Required to do this before re-probing and calculating
> +                * the pseudo-header checksum.
> +                */
> +               skb->protocol =3D eth_type_trans(skb, dev);
> +               skb_reset_network_header(skb);
> +               if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
> +                       pr_debug("%s: errors occurred in setting partial =
csum",
> +                                dev->name);
> +                       goto frame_err;
> +               }
> +       } else {
> +               hdr =3D skb_vnet_hdr(skb);
> +               if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_re=
port)
> +                       virtio_skb_set_hash((const struct virtio_net_hdr_=
v1_hash *)hdr, skb);
> +
> +               if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> +                       skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +
> +               if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> +                                         virtio_is_little_endian(vi->vde=
v))) {
> +                       net_warn_ratelimited("%s: bad gso: type: %u, size=
: %u\n",
> +                                            dev->name, hdr->hdr.gso_type=
,
> +                                            hdr->hdr.gso_size);
> +                       goto frame_err;
> +               }
>
> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> -                                 virtio_is_little_endian(vi->vdev))) {
> -               net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> -                                    dev->name, hdr->hdr.gso_type,
> -                                    hdr->hdr.gso_size);
> -               goto frame_err;
> +               skb->protocol =3D eth_type_trans(skb, dev);
>         }
>
>         skb_record_rx_queue(skb, vq2rxq(rq->vq));
> -       skb->protocol =3D eth_type_trans(skb, dev);
>         pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
>                  ntohs(skb->protocol), skb->len, skb->pkt_type);
>
> --
> 2.19.1.6.gb485710b
>


