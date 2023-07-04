Return-Path: <netdev+bounces-15303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550FD746B49
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF11C209CA
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329981866;
	Tue,  4 Jul 2023 07:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7F17E6
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 07:56:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706EEE5F
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688457415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QwsYV+8KHzcasoXqD88czstNAhElxwaokiJev5S4tQ=;
	b=QRYrUwHv2iwC3V0iEpOR4BTO/mB6I2+YjLZC4S0mq6v/GoC70qe6I9muNHXshd6XcWsrey
	eEdbCq8RvTs/bhxE3iq8q+vaFAGxtiCI1YAMo7qkFz8ZEmfCzA9xzIZkCl3th5/EE+AxHw
	i+IQyhXFwGvlSja61cbHQwULWNBgbcw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-lLhZIAOfOz24xJnTBTpp6A-1; Tue, 04 Jul 2023 03:56:54 -0400
X-MC-Unique: lLhZIAOfOz24xJnTBTpp6A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6364867fa8aso8691716d6.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 00:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457414; x=1691049414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QwsYV+8KHzcasoXqD88czstNAhElxwaokiJev5S4tQ=;
        b=DQFKdj47ahHLFmt4wOr6RpeziwIPyHWUxGVYq4BMCTRUe2jDUeaGcDvUrrsv03QE0k
         rQcpoSQq/8QcuHgMT3OInkrr3dUYAmyNoUydugjbzGbPosdDTHFBMf7adHGpRb0OlItH
         xbBr40h+ORhF7b6CWf3dXn9JH2SeBjjT+iqnJ6TKGRPQsg3MqACQTgf7gGi4KMEW5q09
         MECEUmV7wFncOsCbzcT27gDUIpZXNfTROlOfk4W8uvJzaf0GJljgLLYrN93N9u3Mzy4I
         dcQmE2YPekTO4BLu3BkjTRELD/PHG2/rVHLiLhGkbNjTBbIGbQS5Re/LgRLTDkBDyvCV
         mmwg==
X-Gm-Message-State: ABy/qLZ5CAhUQ/X4fZaRn/56bv2M+7JSCeO+b6HxDt/IG5sosrM+HPGu
	1b7t8AmuK4i9lw8j0FsXfMHtdEBPeDJmVMpsQKfwt9VDrP34gkiZ8EPhIfdRu5Co+ffvyT/qxC8
	wK+BLAhopQ29fYc7U
X-Received: by 2002:a05:6214:4018:b0:635:ec47:bfa4 with SMTP id kd24-20020a056214401800b00635ec47bfa4mr14522707qvb.4.1688457414136;
        Tue, 04 Jul 2023 00:56:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsrSbYrFIjlPpDXHLxORCl46MfBXyKNAZB4pBK89BtTGL6AR9JTbBqa7MK387z/+I5RmdNDA==
X-Received: by 2002:a05:6214:4018:b0:635:ec47:bfa4 with SMTP id kd24-20020a056214401800b00635ec47bfa4mr14522702qvb.4.1688457413910;
        Tue, 04 Jul 2023 00:56:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id b7-20020a0cfb47000000b006365a41c354sm4859826qvq.132.2023.07.04.00.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:56:53 -0700 (PDT)
Message-ID: <b44b9fdeafc0fb94a1e38c18732138db3726dd10.camel@redhat.com>
Subject: Re: [PATCH 5/5] net/tls: implement ->read_sock()
From: Paolo Abeni <pabeni@redhat.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Boris Pismenny
 <boris.pismenny@gmail.com>
Date: Tue, 04 Jul 2023 09:56:49 +0200
In-Reply-To: <20230703090444.38734-6-hare@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
	 <20230703090444.38734-6-hare@suse.de>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-03 at 11:04 +0200, Hannes Reinecke wrote:
> Implement ->read_sock() function for use with nvme-tcp.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Cc: Boris Pismenny <boris.pismenny@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>  net/tls/tls.h      |  2 ++
>  net/tls/tls_main.c |  2 ++
>  net/tls/tls_sw.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>=20
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 86cef1c68e03..7e4d45537deb 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -110,6 +110,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
>  ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
>  			   struct pipe_inode_info *pipe,
>  			   size_t len, unsigned int flags);
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor);
> =20
>  int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)=
;
>  void tls_device_splice_eof(struct socket *sock);
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index b6896126bb92..7dbb8cd8f809 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -962,10 +962,12 @@ static void build_proto_ops(struct proto_ops ops[TL=
S_NUM_CONFIG][TLS_NUM_CONFIG]
>  	ops[TLS_BASE][TLS_SW  ] =3D ops[TLS_BASE][TLS_BASE];
>  	ops[TLS_BASE][TLS_SW  ].splice_read	=3D tls_sw_splice_read;
>  	ops[TLS_BASE][TLS_SW  ].poll		=3D tls_sk_poll;
> +	ops[TLS_BASE][TLS_SW  ].read_sock	=3D tls_sw_read_sock;
> =20
>  	ops[TLS_SW  ][TLS_SW  ] =3D ops[TLS_SW  ][TLS_BASE];
>  	ops[TLS_SW  ][TLS_SW  ].splice_read	=3D tls_sw_splice_read;
>  	ops[TLS_SW  ][TLS_SW  ].poll		=3D tls_sk_poll;
> +	ops[TLS_SW  ][TLS_SW  ].read_sock	=3D tls_sw_read_sock;
> =20
>  #ifdef CONFIG_TLS_DEVICE
>  	ops[TLS_HW  ][TLS_BASE] =3D ops[TLS_BASE][TLS_BASE];
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d0636ea13009..dbf1c8a71f61 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2202,6 +2202,84 @@ ssize_t tls_sw_splice_read(struct socket *sock,  l=
off_t *ppos,
>  	goto splice_read_end;
>  }
> =20
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor)
> +{
> +	struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx =3D tls_sw_ctx_rx(tls_ctx);
> +	struct strp_msg *rxm =3D NULL;
> +	struct tls_msg *tlm;
> +	struct sk_buff *skb;
> +	ssize_t copied =3D 0;
> +	int err, used;
> +
> +	err =3D tls_rx_reader_acquire(sk, ctx, true);
> +	if (err < 0)
> +		return err;
> +	if (!skb_queue_empty(&ctx->rx_list)) {
> +		skb =3D __skb_dequeue(&ctx->rx_list);
> +	} else {
> +		struct tls_decrypt_arg darg;
> +
> +		err =3D tls_rx_rec_wait(sk, NULL, true, true);
> +		if (err <=3D 0) {
> +			tls_rx_reader_release(sk, ctx);
> +			return err;

You can replace the 2 lines above with:

			goto read_sock_end;

> +		}
> +
> +		memset(&darg.inargs, 0, sizeof(darg.inargs));
> +
> +		err =3D tls_rx_one_record(sk, NULL, &darg);
> +		if (err < 0) {
> +			tls_err_abort(sk, -EBADMSG);
> +			tls_rx_reader_release(sk, ctx);
> +			return err;

Same here.

> +		}
> +
> +		tls_rx_rec_done(ctx);
> +		skb =3D darg.skb;
> +	}
> +
> +	do {
> +		rxm =3D strp_msg(skb);
> +		tlm =3D tls_msg(skb);
> +
> +		/* read_sock does not support reading control messages */
> +		if (tlm->control !=3D TLS_RECORD_TYPE_DATA) {
> +			err =3D -EINVAL;
> +			goto read_sock_requeue;
> +		}
> +
> +		used =3D read_actor(desc, skb, rxm->offset, rxm->full_len);
> +		if (used <=3D 0) {
> +			err =3D used;
> +			goto read_sock_end;
> +		}
> +
> +		copied +=3D used;
> +		if (used < rxm->full_len) {
> +			rxm->offset +=3D used;
> +			rxm->full_len -=3D used;
> +			if (!desc->count)
> +				goto read_sock_requeue;
> +		} else {
> +			consume_skb(skb);
> +			if (desc->count && !skb_queue_empty(&ctx->rx_list))
> +				skb =3D __skb_dequeue(&ctx->rx_list);
> +			else
> +				skb =3D NULL;
> +		}
> +	} while (skb);
> +
> +read_sock_end:
> +	tls_rx_reader_release(sk, ctx);
> +	return copied ? : err;

WRT the return value, I think you should look at tcp_read_sock() as the
reference. The above LGTM. Some ->read_sock() callers ignore the =20
return value due to the specific 'read_actor' callback used.

WRT the deadlock you see, try to run your tests with lockdep enabled,
it should provide valuable information on the deadlock cause, if any.

Cheers,

Paolo


