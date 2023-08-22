Return-Path: <netdev+bounces-29550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA419783B90
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36AE1C20A6E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598C8493;
	Tue, 22 Aug 2023 08:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11577EA8
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:16:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A321CC7
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692692213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zckv6oFww2IAYABuKXRpSyWhyYXXDqhNviwTg2vLyFU=;
	b=h3GUu6dWg9j4dB4AJGq6mMJGdmW/2QhGt7IoD7mOMZyB8uUMi3FF2Ku8pPLXPTKSWTehoe
	g6lxDrSyAfQ0SKdFc0V3EeTA8PaleEg2rpPQdBiJWqM8ZYPhZrYlAkWutcj2qPa/UPaIkC
	ZX6d9Ij9wQy7pYRRVteQfc4s6+QJmxk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-ycpW5acTOE6P8KQ3fhARTA-1; Tue, 22 Aug 2023 04:16:50 -0400
X-MC-Unique: ycpW5acTOE6P8KQ3fhARTA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5219df4e8c4so402938a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 01:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692209; x=1693297009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zckv6oFww2IAYABuKXRpSyWhyYXXDqhNviwTg2vLyFU=;
        b=jLjgn5r/BPDnUYCMNRB77zsIzqLHw/urrf3FsPG9xeCtwm503EJketRn44pLjYv25z
         qjy7Nw3T6Iz+dyPggIfDIhk64Mjn5aHtuf5wY2q+nLvA9yGvtGFSm/dw8VA0T7SLsEfE
         jeVK5EBzzvYHafG+Fv5DFqt4skY1hEZSEchqiU9ZYtbkCqr/T5OmOAM3+T3V5RcwPu+W
         Gp2anUWupyqtlLV1BgyjzTrHRvhuwhp2W1YbNz7BO3cAMXONAJXfYjHVoa6oRMdNQOio
         00jHaM9Z0Jx4+dzQAgrsQnKPh90b/7gwjL+kp+YpwGkXm3/yo+DekZy936ZvLX9HLPpi
         nr2g==
X-Gm-Message-State: AOJu0YzbhPsqKb09k5ne4fI/etf2+BJSlnWnt4+AgqvVs3ymCIV8Ik3Z
	JlM7K/4TbQnyIl/WH5Fi3563n8w2M1Q1+8O7OtIr7aFbf1VfhI1TTcoVo99uyR+8mBnDCJROVIb
	rv3s3REm8qdevgV5e
X-Received: by 2002:a05:6402:268e:b0:523:2e64:122b with SMTP id w14-20020a056402268e00b005232e64122bmr6755162edd.3.1692692209656;
        Tue, 22 Aug 2023 01:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLSFMBKhUwaZNzwUhuDk7yvXSZjSgwouQMRlutTKOK/6Gw8nbnhQGL5h8TQ+NkO3C5To+oqw==
X-Received: by 2002:a05:6402:268e:b0:523:2e64:122b with SMTP id w14-20020a056402268e00b005232e64122bmr6755152edd.3.1692692209318;
        Tue, 22 Aug 2023 01:16:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id m4-20020aa7c484000000b0052328d4268asm7109439edq.81.2023.08.22.01.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:16:48 -0700 (PDT)
Message-ID: <85ff931ea180e19ae3df83367cf1e7cac99fa0d8.camel@redhat.com>
Subject: Re: [PATCH net-next v6 2/4] vsock/virtio: support to send
 non-linear skb
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@sberdevices.ru,  oxffffaa@gmail.com
Date: Tue, 22 Aug 2023 10:16:47 +0200
In-Reply-To: <20230814212720.3679058-3-AVKrasnov@sberdevices.ru>
References: <20230814212720.3679058-1-AVKrasnov@sberdevices.ru>
	 <20230814212720.3679058-3-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I'm sorry for the long delay here. I was OoO in the past few weeks.

On Tue, 2023-08-15 at 00:27 +0300, Arseniy Krasnov wrote:
> For non-linear skb use its pages from fragment array as buffers in
> virtio tx queue. These pages are already pinned by 'get_user_pages()'
> during such skb creation.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  Changelog:
>  v2 -> v3:
>   * Comment about 'page_to_virt()' is updated. I don't remove R-b,
>     as this change is quiet small I guess.
>=20
>  net/vmw_vsock/virtio_transport.c | 41 +++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index e95df847176b..7bbcc8093e51 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *wo=
rk)
>  	vq =3D vsock->vqs[VSOCK_VQ_TX];
> =20
>  	for (;;) {
> -		struct scatterlist hdr, buf, *sgs[2];
> +		/* +1 is for packet header. */
> +		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
> +		struct scatterlist bufs[MAX_SKB_FRAGS + 1];

Note that MAX_SKB_FRAGS depends on a config knob (CONFIG_MAX_SKB_FRAGS)
and valid/reasonable values are up to 45. The total stack usage can be
pretty large (~700 bytes).

As this is under the vsk tx lock, have you considered moving such data
in the virtio_vsock struct?

>  		int ret, in_sg =3D 0, out_sg =3D 0;
>  		struct sk_buff *skb;
>  		bool reply;
> @@ -111,12 +113,39 @@ virtio_transport_send_pkt_work(struct work_struct *=
work)
> =20
>  		virtio_transport_deliver_tap_pkt(skb);
>  		reply =3D virtio_vsock_skb_reply(skb);
> +		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
> +			    sizeof(*virtio_vsock_hdr(skb)));
> +		sgs[out_sg] =3D &bufs[out_sg];
> +		out_sg++;
> +
> +		if (!skb_is_nonlinear(skb)) {
> +			if (skb->len > 0) {
> +				sg_init_one(&bufs[out_sg], skb->data, skb->len);
> +				sgs[out_sg] =3D &bufs[out_sg];
> +				out_sg++;
> +			}
> +		} else {
> +			struct skb_shared_info *si;
> +			int i;
> +
> +			si =3D skb_shinfo(skb);

This assumes that the paged skb does not carry any actual data in the
head buffer (only the header). Is that constraint enforced somewhere
else? Otherwise a

	WARN_ON_ONCE(skb_headlen(skb) > sizeof(*virtio_vsock_hdr(skb))

could be helpful to catch early possible bugs.

Thanks!

Paolo

> +
> +			for (i =3D 0; i < si->nr_frags; i++) {
> +				skb_frag_t *skb_frag =3D &si->frags[i];
> +				void *va;
> =20
> -		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)=
));
> -		sgs[out_sg++] =3D &hdr;
> -		if (skb->len > 0) {
> -			sg_init_one(&buf, skb->data, skb->len);
> -			sgs[out_sg++] =3D &buf;
> +				/* We will use 'page_to_virt()' for the userspace page
> +				 * here, because virtio or dma-mapping layers will call
> +				 * 'virt_to_phys()' later to fill the buffer descriptor.
> +				 * We don't touch memory at "virtual" address of this page.
> +				 */
> +				va =3D page_to_virt(skb_frag->bv_page);
> +				sg_init_one(&bufs[out_sg],
> +					    va + skb_frag->bv_offset,
> +					    skb_frag->bv_len);
> +				sgs[out_sg] =3D &bufs[out_sg];
> +				out_sg++;
> +			}
>  		}
> =20
>  		ret =3D virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);


