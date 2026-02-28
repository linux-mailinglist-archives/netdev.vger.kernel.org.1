Return-Path: <netdev+bounces-262071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBN8MfBlomnI2gQAu9opvQ
	(envelope-from <netdev+bounces-262071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:50:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EA1C0362
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCE4300BC99
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F433FE00;
	Sat, 28 Feb 2026 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG0x58gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570933F8A8
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250590; cv=pass; b=OmPszeVda0kZJJpuQjjVfC1BYJFI4znZJvW4D2oJ+QIOTsZ2Seoz0LdkCPSau4bc5v0zGgapvLZQVkQ+fJ+Nqaj96aG4yHCBja+6BzEOCXyeWIGGeD2fmlN2+e+6S4wGzFj4OJpSMQDJZfHQE4PELrl3SYYFVAG3NXyPekA6wUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250590; c=relaxed/simple;
	bh=EZa1kh9CK62/JXDCFyKF5ToCVB0A/vBhHQIAYBb+sew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHw++9UPXta4Ymne3Z2/rGXMb47zBqsunVA/aWBaswqOeLcQ0QJ1bXZuUSC2uca75fIUlufwMIzDT5uOKDjNoy/P8OcquD/iEuaZ91RyxpIoCL8TdUyYKy6OtFLXnKSbQY64hrmfYPSBW8upHX1Oh01iQ6PFmpQ3nC3T2dOEGeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG0x58gd; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-389fb626b67so33210831fa.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772250585; cv=none;
        d=google.com; s=arc-20240605;
        b=bODcBrhq46a2L12l27hSfNXZY5oV+9/H6ygZ5HeJkCdbdmkZ2XLUawzwihSsbrx2Ee
         Ry6FlPy/qgRjWONPLGYp9fKfnf7eyv4w9Bi6cfsvkxvO+Fp+Ehlqr8dGHYB4v1hvwEwt
         BSYiIgXbvnTdo5aSvIt4g8umRHsHg2udeiF/xbIHmmcBFyjUTrLFBDixLu5sFZKHSTkP
         CPsQLVzDwa+xE6Vc5stPCHsr1k1MT1oYSee9+6u9KlLW/IzpovMxcOhKATUKhoU/ZI2u
         ZcTBA2MlBDlSkRLtequuzA9atRSvzgNqy2BEzF7GpfSHzpP4LelL6yhdS4R7wMDBSGcr
         9OGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h+azeatVE+bg9NQS0j4OQgTTv+mlTqhdyDYGxIesJN4=;
        fh=eWq335HgoE9wufq8cJAqTeKde+wizbm17azVCD5tdSc=;
        b=HzleE0UQGwY/SUtk9gjb2Lk6/lg20uyIUwBAZakxhtnRA9PUUZ/1821W39TqQWVqBE
         O388MLT0pwKlyFS0GwC1qbePH4L0wHdpNPyemOM0whYovEsRL8OEMhrDQGzFeZ9ULjrt
         zUZiik7R4Cs9svYzY4xW/bzWbkHJ/RySTaBTUvebqkY160j2rwrImTdENQO4kVEwYO+0
         G0+kybTGs+oekcJbxaXfCPfhUrbhTFKoSNhVF8J5Hia8zJmeriS4s91XP0z4l10Qrais
         7Tbc8SuOMcJKHTWmzxlPoKRt5qf4+j9VPHG5w6rM+lOMP7Ln4el6bqFVsilp4z0GcWPq
         TPJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772250585; x=1772855385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+azeatVE+bg9NQS0j4OQgTTv+mlTqhdyDYGxIesJN4=;
        b=IG0x58gd9NIhzXY3VScYJdnlzg+HbXbpEuyNbbCUI6gEluaoeV40wB1BpyB1GOEUMR
         Ar+ublzeSQa2yHvOloTMd1aWGE/Ei9BtZP1CMfRro8T4MaOCV+IC7/0d8fpFKuVkmUas
         lD9hp8DsCZGabXAXUpyh6G/NKSQgyb8eTDSUAoYKua4YSJUIAPL9J7sWcMH6tuhjt/TO
         gM0KTlsT7Q62ai5l68N25dYepDfFAoN5Jpv+cMbxEmp5/Z5ETdW2kTQu04vx34gAMpUt
         zVOkARX5SyHfL5yyELYxaTMCkVmDgX7ByvLN8nmXvycAGEDmt7plDUyBR/dRkDd7X9wD
         Epvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772250585; x=1772855385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+azeatVE+bg9NQS0j4OQgTTv+mlTqhdyDYGxIesJN4=;
        b=asPIOKXLOdLDXCTQd7ZdwMoq95xtul288wesYi+UxrNA3LIqQNw1/fmMTdFYcvEEQX
         1HbPmqnqvLtpdu2ZjGtqf28yA4VPE+8PiE8rjrDnKcLWeg7Ab+hYa3FF+4Rj9t0WaD2/
         fdCd6sG8ugmea/Wl3kXGipY7XuX8zY0cQHd0RIxvnPtomj1lbTX+es3Oua3A6DzzCual
         sVkAwDXxSwM24siyD+MXSQwQyVAghbRn12RoIEG4JQrck3WP9eJRhsruboXrVAfmRInH
         m0Hie6HmOf3B/3RlQbUPK8UTJy7piqSLeRubPf1djHpHHi3w4oxblAX1NDYtfa6my4Uc
         JSug==
X-Gm-Message-State: AOJu0Yyz69xY1zQ1oRf5Xz5tEK//rWOj8ddaIll8U3BHFyG47OOfw4/D
	wnyb+yPberP6ktzM5aYzIPu5WpHJAkP+SMK2B0Kr1EELc7hZOMuzGOwXPJzCcd7obkE1zDoG7tG
	EcEiTjRNAFPznm/EBcq3/4v7hmJ0/f4Q=
X-Gm-Gg: ATEYQzyZSUQRhVJoc1BMWjFyr9BKqN3jO0WdRMOzdSTkXEW2rm7FX0Lzo/5MT0AxQDS
	NcoV3KTCJnA8UReE9Cqo6NcBsyV05ErjiaQfT61d+qx/7voWTFL4pUCaS9i5XNM6iGPPwudYN5w
	t5lx3yWOM5Dj3r8ztUBS53ZA1/mQvMikOAyPWmLamaw0xyA1Mn6P91WK64818azGIjaQAZQokxa
	w7toN7H3AfT00YkLHPajdaslapdB6SI2jjcN5DSzgzI/dCm1DnQ+kyFqJTSUpt2N1BhOObZh59Y
	L3l8dP8Q
X-Received: by 2002:a05:651c:110e:b0:383:1d66:c204 with SMTP id
 38308e7fff4ca-389ff36cf14mr26540711fa.38.1772250584982; Fri, 27 Feb 2026
 19:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227150949.13089-1-minhquangbui99@gmail.com>
In-Reply-To: <20260227150949.13089-1-minhquangbui99@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 28 Feb 2026 11:49:07 +0800
X-Gm-Features: AaiRm51f6hsgSdx76tSMlynHg4HKsjuSluFAz0ck0AkuBIp6rEBeo71YUrgL5A8
Message-ID: <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: xsk: Support wakeup on RX side
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262071-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 747EA1C0362
X-Rspamd-Action: no action

Hi Bui,

On Fri, Feb 27, 2026 at 11:20=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..494acc904b2c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_=
info *vi, struct receive_queue
>         xsk_buffs =3D rq->xsk_buffs;
>
>         num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> -       if (!num)
> +       if (!num) {
> +               if (xsk_uses_need_wakeup(pool)) {
> +                       xsk_set_rx_need_wakeup(pool);
> +                       /* Return 0 instead of -ENOMEM so that NAPI is
> +                        * descheduled.
> +                        */
> +                       return 0;
> +               }
> +
>                 return -ENOMEM;
> +       } else {
> +               xsk_clear_rx_need_wakeup(pool);
> +       }
>
>         len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>
> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *s=
q, struct xsk_buff_pool *pool,
>         return sent;
>  }
>
> -static void xsk_wakeup(struct send_queue *sq)
> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>  {
> -       if (napi_if_scheduled_mark_missed(&sq->napi))
> +       if (napi_if_scheduled_mark_missed(napi))
>                 return;
>
>         local_bh_disable();
> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
> +       virtqueue_napi_schedule(napi, vq);
>         local_bh_enable();
>  }
>
>  static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> -       struct send_queue *sq;
> +       struct napi_struct *napi;
> +       struct virtqueue *vq;
>
>         if (!netif_running(dev))
>                 return -ENETDOWN;
> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *d=
ev, u32 qid, u32 flag)
>         if (qid >=3D vi->curr_queue_pairs)
>                 return -EINVAL;
>
> -       sq =3D &vi->sq[qid];
> +       if (flag =3D=3D XDP_WAKEUP_TX) {

Better use &?

Thanks,
Jason

