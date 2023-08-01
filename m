Return-Path: <netdev+bounces-23229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9EC76B5ED
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D41C203C1
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5021D5E;
	Tue,  1 Aug 2023 13:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C621E503
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:34:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3744A1982
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690896853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3EuGMRXqXwIjso57QFZOBRIJwj3UoGAkDVIx/t2tOw=;
	b=TnpUxnZvCk9mbJ4rn4MfsREhZv4SteSvZsDUTpnK8YvpCTXAv10JW7Zz9iicAzgMtK8F4J
	IYhdpvIQJaNLnXJF/nWNFcvBMLczR204tBh7nRc0iRCn2MZjWq6vKhEeQ/C8rGO8HMNwxb
	59BiD8Saow4SWgDgJqakA6V56bn4kQE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-ikMTVVjBOoqAIMNO07_vLA-1; Tue, 01 Aug 2023 09:34:11 -0400
X-MC-Unique: ikMTVVjBOoqAIMNO07_vLA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76cb9958d60so35646385a.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896851; x=1691501651;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3EuGMRXqXwIjso57QFZOBRIJwj3UoGAkDVIx/t2tOw=;
        b=EN6C5RhoGfvTMRs/2iVEcLrnyk/bu/y0UJnS8CUi5XiHLKRarXc3B57Jkl+LpYPsBK
         RBLjXZKR02JUtop2Bfqh0VuTFBCYdAM+PDmsUtX2D0FxavV0eo7FMkmp4CNqHj5S4jNt
         Vd3blAIo/4+xC+vJsLJBM/ycIygzWxBXhM9Nq8VUkynpbGpBLULgfU2iK6+/VfvrSCya
         CZm9841nLfRaMzmj8sxDIJYF7sB1bcKlU/+3weGwcbUUg78DQweV1D2rqWIUtvFYzzcI
         AxSNerbyzvjiTtJHeX3VUhl1EdVdxdxcA3UTwpmAP316qYMa+ByDvSS+uBYDg2kQxuAD
         NnvA==
X-Gm-Message-State: ABy/qLbgFvXMO1BJCIqvQs/kNW14PJJ/Ns+qLHPAJeSFxFnb6W0gWCeh
	FLOmbPm+b+8yc59X82Y+unjVpM+ZG4Uc8+oKmkgSCjCri66HTQt+rAPf94uD98pk3bznmKbpCk3
	2Gzyf5kuwghTXAojy
X-Received: by 2002:a05:620a:430a:b0:767:346c:4b37 with SMTP id u10-20020a05620a430a00b00767346c4b37mr11487670qko.7.1690896851427;
        Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2f6rViFVq6s9ZoHhoK5v+BjyA/rYc7oOn3EuiWdiJ1W4rbVP76VwVvUC5Ka+gXuoKt2VQqA==
X-Received: by 2002:a05:620a:430a:b0:767:346c:4b37 with SMTP id u10-20020a05620a430a00b00767346c4b37mr11487637qko.7.1690896851093;
        Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id op51-20020a05620a537300b00767dc4c539bsm4136811qkn.44.2023.08.01.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:34:10 -0700 (PDT)
Message-ID: <8a7772a50a16fbbcb82fc0c5e09f9e31f3427e3d.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] vsock/virtio: MSG_ZEROCOPY flag support
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@sberdevices.ru,  oxffffaa@gmail.com
Date: Tue, 01 Aug 2023 15:34:07 +0200
In-Reply-To: <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
References: <20230730085905.3420811-1-AVKrasnov@sberdevices.ru>
	 <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2023-07-30 at 11:59 +0300, Arseniy Krasnov wrote:
> +static int virtio_transport_fill_skb(struct sk_buff *skb,
> +				     struct virtio_vsock_pkt_info *info,
> +				     size_t len,
> +				     bool zcopy)
> +{
> +	if (zcopy) {
> +		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> +					      &info->msg->msg_iter,
> +					      len);
> +	} else {


No need for an else statement after 'return'

> +		void *payload;
> +		int err;
> +
> +		payload =3D skb_put(skb, len);
> +		err =3D memcpy_from_msg(payload, info->msg, len);
> +		if (err)
> +			return -1;
> +
> +		if (msg_data_left(info->msg))
> +			return 0;
> +

This path does not update truesize, evem if it increases the skb len...

> +		return 0;
> +	}
> +}

[...]

> @@ -214,6 +251,70 @@ static u16 virtio_transport_get_type(struct sock *sk=
)
>  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>  }
> =20
> +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk=
,
> +						  struct virtio_vsock_pkt_info *info,
> +						  size_t payload_len,
> +						  bool zcopy,
> +						  u32 src_cid,
> +						  u32 src_port,
> +						  u32 dst_cid,
> +						  u32 dst_port)
> +{
> +	struct sk_buff *skb;
> +	size_t skb_len;
> +
> +	skb_len =3D VIRTIO_VSOCK_SKB_HEADROOM;
> +
> +	if (!zcopy)
> +		skb_len +=3D payload_len;
> +
> +	skb =3D virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +
> +	virtio_transport_init_hdr(skb, info, src_cid, src_port,
> +				  dst_cid, dst_port,
> +				  payload_len);
> +
> +	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
> +	 * owner of skb without check to update 'sk_wmem_alloc'.
> +	 */
> +	if (vsk)
> +		skb_set_owner_w(skb, sk_vsock(vsk));

... which can lead to bad things(TM) if the skb goes trough some later
non trivial processing, due to the above skb_set_owner_w().

Additionally can be the following condition be true:

	vsk =3D=3D NULL && (info->msg && payload_len > 0) && zcopy

???

If so it looks like skb can go through __zerocopy_sg_from_iter() even
without a prior skb_set_owner_w()...


Cheers,

Paolo


