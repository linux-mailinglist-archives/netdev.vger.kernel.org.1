Return-Path: <netdev+bounces-262085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGpFH4yIomkd3wQAu9opvQ
	(envelope-from <netdev+bounces-262085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:17:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382631C0852
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0CD030151D1
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA7331A53;
	Sat, 28 Feb 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTFf7dsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F923176E0
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259431; cv=pass; b=V4jHX7VI90Chh5/6hxelk1RCXEGf48D/5h06et1Ls0+mvEvputzvo0T9fUECjf3shflHM9lhABx+b1McDUahXAsHXwaJarKNQq3f36l3RkPnLMZ3DwKgCINvN+bMKESDQIR+ZYMVQLS47PCJOSfDJUr0We4qTmgmEk2Sa3nQH4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259431; c=relaxed/simple;
	bh=Pkpj4HbkFMotK8I4xPmcAoR30bgwmypSjnl8MO59Eug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHPGTCp39QGgROTjSc8zdzTqG1ZNzlPt7sltX9qHpTQKcsXTWBZjPf+X2BVgHzD8i6VYR54tNpdbL7v+2DPuJjYp/ubkKjMnnmL671XMzi6qmlyA5rZx8V1XduuSs8PcY3fOiqIANlDxd/OPlgFwiVmUEuBiaSTMCeHR8gYXpXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTFf7dsc; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-389e139ee5eso37751821fa.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772259429; cv=none;
        d=google.com; s=arc-20240605;
        b=NwvMJagJeX18BHU0AAoaLl/R7I/5H9AS9EnN6p2WNAN9V3b9l/wMBnOnilUZ4KH0d7
         OyRUTgVjLxdEVF+P8Y0u/dJehkXBw7wg+7fZ+wT+VxrRDIpkNzAod6nBIQzlg0OoSvBe
         p2xPwoT0AC/nAFTGkRbD9qCZEA7MhZx1wIeSkZViDJ9QjV6KTAT+bAWRodDHs7J6QYzH
         RXTe27fvl6/jRjtBFvylhqrgEnDwOTxzftqmU/RVrNXUmBeQ2zcVqgrmaNy1/dteA6eK
         h0g5HPGtxAVx2/9ExqBulGTHDvfbCVtmfCdt5DzxJGnW3wUooY9nzawVzaA7x2j0d936
         CwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oeRlvqpds2atM/soIMS81zbOQD/yUki0VXg5EGmEj1A=;
        fh=eWq335HgoE9wufq8cJAqTeKde+wizbm17azVCD5tdSc=;
        b=Cz0lfFYbGjGMdQh+dCO8gw14yl2g9c6MbuC+ZWc9lR9OmuV50QrJ+uH9ATliOJ13E2
         lCOQJrmUMD2xmVLkdjmPV6UodrpCWi6+XSCdHtD2fRk3flmYiD5DSIuIu0Im+uO21uG0
         NyRZoyf2HRFpi/TgUBD6O1uvEEBVG6EA1zSQ5favvJHTDiHv6hITUdqM63TleqDk8ntv
         Y3s/RsU7k8WmxPpwZSWPuIQdu/0ZCPau0RQQH9pAvABRW1sQ35cB0FZyN70VePwWHwak
         RQ9iIuR47bXNpvzdCbq2D2cpZcHxwMsGArMTkqWpaDnNlZJ1Q6C8liNsArC8MzwnrOaj
         x/2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772259429; x=1772864229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeRlvqpds2atM/soIMS81zbOQD/yUki0VXg5EGmEj1A=;
        b=YTFf7dscI1I/uQ4yud+6mjEcuXHEW9N1XGHNc0t5KrVJYCR3OuVmfWJPwmwAJa4jQA
         S4ctpkOgv0yuPpQM9BLH7HRyyYFnv78CWjlRmQXS2LTAAEqujP5FTpddLs2v3hNmW53E
         uUj6rPKYjqXP/U6Uz/2vwcrkYv+6JGpPL12vAjtYPg6/kbz1Sp4CE6PVgDZWX0U9Rzti
         +77OAyuB1ZBCa97Uo2INXOxf0tRn44BzP+uRbFK3N30Q7Npg2z8WUq0fL3yZv6aeHva0
         c/G7FQ+2oLfMRTaeqRiegYJoSFfIm3GBly+H21WBOECpV0YOO/kQIUHQMiMa2xBooWO+
         gQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772259429; x=1772864229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeRlvqpds2atM/soIMS81zbOQD/yUki0VXg5EGmEj1A=;
        b=V6s0ZdqKwHPfomK8vw0VfrtH1SH+XgLk6M8XqX3R26FPAbWA6ir+R3Mmo62AOJ66xa
         WXQxP2/ld6Q63meGlIIhFw5cZeFqhHphfCg9sRA3dOEJDagC64cZwdkLvJgrRxI+4WDF
         quLdLxTcWqBfaEnO0eX/QlKifHHSCcTCniPih6IuH+3BPJFkkbQuDdOV2RFb5HpmtKEW
         1f0jZOv75pPT5/X9C0QcnPuqik3A+L3eSVjH6ffiQccrMuGdeoxTjJr+1LmHxYXg1ZT6
         r3WYHoi5B+4x5B1FQlwpKk0euAopfpZ9KLTX7PQym6+3JMiUvZa06OCuJgNwxpaurkNs
         qeCg==
X-Gm-Message-State: AOJu0YxnogZUNefbcWaU3SmZyUm0PwGBkjyuxpdsaUxwVLTsAAuKHU2k
	EB+HCKnGSckc53QWH34H0iwUbWwu+IHBaCuGyPjT6Kjv/0IEr4MjwwYNfYd2JylMkkXtNLl+dlM
	t4/wT72BNE6a0jl+fqLhYsiPF7GJ0YzM=
X-Gm-Gg: ATEYQzwo2gInRAjESjYVWiqbhUHTpPE/r5pgFmg/PrsaQwW7JWMk8cSJfpd/DGJhLw3
	nSzCSzbGXQvRLjJhjioNrkV/S9/rt5+ARLuJvIBmT86r4YERh86aOguvXPliyUrpvFFmLEWN6Ax
	fiQNygzil8DAD3bbIx+7xe2HdL4RBGF3OZzicw8vLCxjb4FoKmmyXXb9HmykokAdf1m3hq9lwkR
	nlAZj+TXVQoOAJDY0bwcYMBvZK3RxuyPj1AzJU8bcoXIS/mNRzPAs5HQuASX9ozM0ipiWqOEOFS
	Z6oRk92Q
X-Received: by 2002:a2e:9e81:0:b0:383:1d89:8d0c with SMTP id
 38308e7fff4ca-389ff137ea1mr28249491fa.15.1772259428376; Fri, 27 Feb 2026
 22:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227150949.13089-1-minhquangbui99@gmail.com>
 <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com> <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
In-Reply-To: <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 28 Feb 2026 14:16:30 +0800
X-Gm-Features: AaiRm50hAty-9UFJICMMw6r0XvXAs1z_2STWM9epUEykww4BmxZrz84SC04ahM4
Message-ID: <CAL+tcoAy7YjkODWp=nCagEJwOzhqt_BL4kcfxpj=FSiAXP_+qg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262085-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 382631C0852
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 1:03=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> Hi Jason,
>
> On 2/28/26 10:49, Jason Xing wrote:
> > Hi Bui,
> >
> > On Fri, Feb 27, 2026 at 11:20=E2=80=AFPM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buff=
er
> >> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> >> wasting CPU cycles on polling. Users will be notified and they need to
> >> make a wakeup call after refilling the ring.
> >>
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
> >>   1 file changed, 30 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index db88dcaefb20..494acc904b2c 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtn=
et_info *vi, struct receive_queue
> >>          xsk_buffs =3D rq->xsk_buffs;
> >>
> >>          num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_fre=
e);
> >> -       if (!num)
> >> +       if (!num) {
> >> +               if (xsk_uses_need_wakeup(pool)) {
> >> +                       xsk_set_rx_need_wakeup(pool);
> >> +                       /* Return 0 instead of -ENOMEM so that NAPI is
> >> +                        * descheduled.
> >> +                        */
> >> +                       return 0;
> >> +               }
> >> +
> >>                  return -ENOMEM;
> >> +       } else {
> >> +               xsk_clear_rx_need_wakeup(pool);
> >> +       }
> >>
> >>          len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> >>
> >> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue=
 *sq, struct xsk_buff_pool *pool,
> >>          return sent;
> >>   }
> >>
> >> -static void xsk_wakeup(struct send_queue *sq)
> >> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq=
)
> >>   {
> >> -       if (napi_if_scheduled_mark_missed(&sq->napi))
> >> +       if (napi_if_scheduled_mark_missed(napi))
> >>                  return;
> >>
> >>          local_bh_disable();
> >> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
> >> +       virtqueue_napi_schedule(napi, vq);
> >>          local_bh_enable();
> >>   }
> >>
> >>   static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 f=
lag)
> >>   {
> >>          struct virtnet_info *vi =3D netdev_priv(dev);
> >> -       struct send_queue *sq;
> >> +       struct napi_struct *napi;
> >> +       struct virtqueue *vq;
> >>
> >>          if (!netif_running(dev))
> >>                  return -ENETDOWN;
> >> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device=
 *dev, u32 qid, u32 flag)
> >>          if (qid >=3D vi->curr_queue_pairs)
> >>                  return -EINVAL;
> >>
> >> -       sq =3D &vi->sq[qid];
> >> +       if (flag =3D=3D XDP_WAKEUP_TX) {
> > Better use &?
>
> Sorry, I don't get your point. Can you elaborate more?

Oh, I meant using 'flag & XDP_WAKEUP_TX' is preferrable. IIUC, since
this patch provides a way to enable the RX flag, for virtio_net, this
flag can be set by TX and RX altogether? Please see this call trace:
xsk_poll()->xsk_wakeup(xs, pool->cached_need_wakeup).

Thanks,
Jason

