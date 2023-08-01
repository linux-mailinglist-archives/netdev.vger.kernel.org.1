Return-Path: <netdev+bounces-23249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499F76B6BE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF7A1C203B3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2222F09;
	Tue,  1 Aug 2023 14:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442623BC0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:05:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D2630F4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690898703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrQZYdlPHfqAXUcA6lbzNx8CU3rrSsjWUivdGMgi/i8=;
	b=NFXl22Sti2EXVBSkq9jZkUZCHy0vnv81XCnjDanrW2/kD7xh4nmeZIFjGmP/xrsBTlfK4/
	j1ucvCJ2L/D8C0iPPE7MS4SGyGtS1kB+JpByz6EFZeiQrW1jL7uhxfE12ddVbOtBo0G1tb
	jO77bDQ9o8VJSyvqELrru0cdNIgoaVQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-u-3cgcy7PY-Taay3mvtuvg-1; Tue, 01 Aug 2023 10:05:00 -0400
X-MC-Unique: u-3cgcy7PY-Taay3mvtuvg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-56ce4f82d18so209004eaf.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898700; x=1691503500;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrQZYdlPHfqAXUcA6lbzNx8CU3rrSsjWUivdGMgi/i8=;
        b=lBFC0B+Twr758LagL5GXUC3rF3zJvAKgLg6CSlzIcs3fjS3T+sj8l5JWco/LgPZ4if
         BeakNarNzphrAYMkGvf08bf+JdWz6ELcS+6dNB+ruI2o8YZX6/WZxR31yL8xnCINyMt+
         AAtsJSFfiaSf+iyBDuBGnCacosnuDtkNV6fPgSdCyi+z1NxJcQRF1oSBmXkpu+Zk8Y6Y
         Fk+hu27Y9jXycH37oM8B9qqVhCjnJZ1pkp2euQKrnKSFCgVqGih49ACaTD0uA5L7V73u
         lUXflWl386njp8bTBCpaYLg8SAWaJoOd06sfNUzkPBxQjR59xnSnJtC1nbq45Ct6QT7L
         oxIg==
X-Gm-Message-State: ABy/qLakKshCF2Dx2FruihzMFvymZo8MLDijq4TpcrYrAeG9XmdY7Mz/
	vep35hXU/OV1wl4sXtXezcsUdwFWuM/kQcPNRzKZt+TMA/x+wI2h3r+xeBVYxZcBvpz+dAocWZZ
	u8ZKwGjcbdv24v2F5
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id d5-20020a4aa585000000b0056c484a923dmr7768050oom.1.1690898700140;
        Tue, 01 Aug 2023 07:05:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkYK567OZvBBNHPM2ndAyrlc5sazvLUju3ozUYOY4HGl86ZO4bap40IQmhQfYLniD5hAHXvA==
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id d5-20020a4aa585000000b0056c484a923dmr7768012oom.1.1690898699795;
        Tue, 01 Aug 2023 07:04:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id o2-20020a0ce402000000b0063d14bfa5absm4658714qvl.36.2023.08.01.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:04:59 -0700 (PDT)
Message-ID: <00f2b7bdb18e0eaa42f0cca542a9530564615475.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] vsock/virtio: MSG_ZEROCOPY flag support
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@sberdevices.ru,  oxffffaa@gmail.com
Date: Tue, 01 Aug 2023 16:04:55 +0200
In-Reply-To: <1c9f9851-2228-c92b-ce3d-6a84d44e6628@sberdevices.ru>
References: <20230730085905.3420811-1-AVKrasnov@sberdevices.ru>
	 <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
	 <8a7772a50a16fbbcb82fc0c5e09f9e31f3427e3d.camel@redhat.com>
	 <1c9f9851-2228-c92b-ce3d-6a84d44e6628@sberdevices.ru>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-08-01 at 16:36 +0300, Arseniy Krasnov wrote:
>=20
> On 01.08.2023 16:34, Paolo Abeni wrote:
> > On Sun, 2023-07-30 at 11:59 +0300, Arseniy Krasnov wrote:
> > > +static int virtio_transport_fill_skb(struct sk_buff *skb,
> > > +				     struct virtio_vsock_pkt_info *info,
> > > +				     size_t len,
> > > +				     bool zcopy)
> > > +{
> > > +	if (zcopy) {
> > > +		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> > > +					      &info->msg->msg_iter,
> > > +					      len);
> > > +	} else {
> >=20
> >=20
> > No need for an else statement after 'return'
> >=20
> > > +		void *payload;
> > > +		int err;
> > > +
> > > +		payload =3D skb_put(skb, len);
> > > +		err =3D memcpy_from_msg(payload, info->msg, len);
> > > +		if (err)
> > > +			return -1;
> > > +
> > > +		if (msg_data_left(info->msg))
> > > +			return 0;
> > > +
> >=20
> > This path does not update truesize, evem if it increases the skb len...
>=20
> Thanks, I'll fix it.
>=20
> >=20
> > > +		return 0;
> > > +	}
> > > +}
> >=20
> > [...]
> >=20
> > > @@ -214,6 +251,70 @@ static u16 virtio_transport_get_type(struct sock=
 *sk)
> > >  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> > >  }
> > > =20
> > > +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock =
*vsk,
> > > +						  struct virtio_vsock_pkt_info *info,
> > > +						  size_t payload_len,
> > > +						  bool zcopy,
> > > +						  u32 src_cid,
> > > +						  u32 src_port,
> > > +						  u32 dst_cid,
> > > +						  u32 dst_port)
> > > +{
> > > +	struct sk_buff *skb;
> > > +	size_t skb_len;
> > > +
> > > +	skb_len =3D VIRTIO_VSOCK_SKB_HEADROOM;
> > > +
> > > +	if (!zcopy)
> > > +		skb_len +=3D payload_len;
> > > +
> > > +	skb =3D virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> > > +	if (!skb)
> > > +		return NULL;
> > > +
> > > +	virtio_transport_init_hdr(skb, info, src_cid, src_port,
> > > +				  dst_cid, dst_port,
> > > +				  payload_len);
> > > +
> > > +	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
> > > +	 * owner of skb without check to update 'sk_wmem_alloc'.
> > > +	 */
> > > +	if (vsk)
> > > +		skb_set_owner_w(skb, sk_vsock(vsk));
> >=20
> > ... which can lead to bad things(TM) if the skb goes trough some later
> > non trivial processing, due to the above skb_set_owner_w().
> >=20
> > Additionally can be the following condition be true:
> >=20
> > 	vsk =3D=3D NULL && (info->msg && payload_len > 0) && zcopy
> >=20
> > ???
>=20
> No, vsk =3D=3D NULL only when we reset connection, in that case both info=
->msg =3D=3D NULL and payload_len =3D=3D 0,
> as this is control message without any data.

Perhaps a comment with possibly even a WARN_ON_ONCE(!<the above>) could
help ;)

Thanks!

Paolo


