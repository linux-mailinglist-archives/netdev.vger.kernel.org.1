Return-Path: <netdev+bounces-284427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNl+Epr9+WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:24:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66424CF55C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D865C309C30E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCD624C06A;
	Tue,  5 May 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ksi3C2L9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52431716E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990491; cv=pass; b=tC64HpivOonrVRRSKscBjS1qvcQ739FDlaWdAa6W0XWfkRTyvKcq4Lma20wbjr/mOTEHs/60uyRnqZleNRnbbTRaKJQwwDlKZbcb1dmbGZCN/NDd62JdzqkG9me8/3iWXG7lYJuHcMutFMEwze5d7s5YJx32mpGN2snO0BgP0/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990491; c=relaxed/simple;
	bh=MnAAO4w1VfmrD02ylbi+VLyroPBD+EN8jrV6PBVFQ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow0ZWQaNucBDICyj0kbI2meOu1wCS0vrtvEIG92bT+NnJWCE7wHY+/4GbBwjlj7QT6aVzndN1XTwtsyHw9EY5ZbUcjJRMQJLE+9X+8vSlMwwa3dvBW1AoQGgDBKZA5AvJRk9Qc13YcEDPqpgUgLcmgRbdxrHl5ILDEabMlABFs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ksi3C2L9; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50fb1932b62so40431631cf.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 07:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777990489; cv=none;
        d=google.com; s=arc-20240605;
        b=F9wGlcUMElDOWAoiFRRpE4SXijK6XzAFe0ruFgYZoOBNDx869dnXFk8FQsxp6V/W2K
         iqPf+Q4AjvmdCwvihkCLqKg3ExAKvY3I/kJc/onVmqtaHIFuJX6+qq6i7WM5x2yTeHA/
         yK3GK/E3SJBCql5dtFJGN074yYOv9QlcCN4Kzc3prF/xkJ5RaIFHZwEgnCjwATNvFhdT
         ba/O0UvNK9l4rlqNnjamv80vQjXozynxXdROFE0vZux3C965f6V7+zdId0jGLWBOWOVM
         +0U7rNicu/+MZcjXj2+ArN4sfpmYkUuV79LsZ2xz3I7prtT/tU64qvLTWETL9mOsESl9
         ad4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        fh=GJqn/wpfFF+13AHzKJSreiLLrfUHJERTPTNiUAdrrGQ=;
        b=OTXsspWJt1A6cr7eA15RYZCJYGkGgqEkTvec9A14SsJi+oOr8i+avdn3MhROm9E+d6
         UHxpZ2MMMEEdbAQJtu7luvMGVHEfBPRfdSfrfAFoRyrcwz6P5ElyHr7XtUh6yImN+PxZ
         9FF1yCZT9dLz49pOT8eTOeg+BDl21q86Pjkq8Yz7Qrd9QNuRKT6srUopJl4mTsYTeKHv
         LmcTDKG6pXOI17F1v5BhyUjEwSO7bdDm60zfnyh0KUDugToJlWE2+RSd8tVKH9cbTTaD
         GgxYAuQoLXxoZCZ/1SgzKeqIQuVpc7LyTH0jnGjQxddHsp2nPLbjsyUGo1PL/+u/vW+R
         Qv7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777990489; x=1778595289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        b=Ksi3C2L9ttBJn9Sa/0LCRG2B9dbjILuemw/L11glQyg+RUpdTs49KRZbGlGD898wb/
         8J9Rt8WszvxU5q0RJSXPJdBCZepMCzqri8yPSp+92b1Z4r3G2jgxyBpoRYm39O+w5Jld
         4cHH6+vMMlM4/fnVHKx94pMgkqrbZ9dc2wUq/BuGHSqdz3dC0V1og1Hs3GioelpjlxJN
         7jsNVSG1l28DlECqoljLqnZFBjbvwO5ZVyw2U4080sFt61jZ0fmkHDU2WTUdezHS/T4J
         2nR4vpIbODkv/hf5CiddcAQIpbIxXMoIsK07eEl9nH+C+PckGxdmpZ9sikI8jWv5+TZl
         Dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990489; x=1778595289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        b=V8lS9mwoBPNQtOkK4QezlLzZfDZ83G6v3ynEgQLZWvVRA5k9jjLcIUxNPOZ8lqI1rw
         fyDcJvqsCr9tDhNd+8u5lKE7H1wsfvTnyeGxVG5Ut7bEFO22pHlLSkyxwWfN8kdrWAlj
         RlHUmHKBdMf9uSUlo4sPWMgJoQLWdNC3z3gZXFRP1KAIIUolBr9GSfVxfskdk3UOCxdM
         iMAtFeJQmYhKvaUxPCfrHycNc5vmpgi4JeXnLgw2leuMYgV5EcdcQEwj+shAUac+m9O8
         GNQOaHfvRW2pi7rkAOOhfWukX4yN7f5Qvhw3OCjJKZBj8V07TvH+9X1Vgm47jpTDQqoA
         4n/g==
X-Forwarded-Encrypted: i=1; AFNElJ/hwmvcw/OYvFAUkblEhYDoStSqWEapbyIs6vBlXk+a5apEKGrtsFr6vwvYf/K6lCyje2aaUaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcnCyI+btveo6CUjMpbXwpIHUhxUhhLjWslOWe+OUrRcmL5XI
	vVBy4n/ReRbJT2GioB74xRDEE5dBUveiboxPA9ifds/Po8+dt4Yb0iKNXsgSBnTR/6I/zosLq+U
	F0JCVkpKm1oV2Fixc5ZvLzBkX0q3j0gGZ43ZiG0tb
X-Gm-Gg: AeBDievirzo/ESyP0uGvQ+jkfixKkgE1lubfd5Nuwcts21T0QDRqq+A6kBAovHmp3yB
	dNS3fDHEd7CzzGn8VPpv5tsFymY+EaP6pxJhEPB8kxsUXKXNRRFE8HJlQvXMrkJHw3xp60heIWt
	RR2uZI8JRDnzlXKfrL34ZtZ3X6O3sSiGwvb46ifb40eL5Bf4ciYAFYCXy7MzfQdr3GRvqNsSvVh
	0s5wzfDi1t633LZG5wcMNCzWKEGKf+Jpqg832oK6GHqu2SWX+OPo74MfnXF4p1xcLpFICEhDIBM
	6E4Y7MLxzOgSd/z4/4p5CCOKJ2f9y+g87JalBR2JHxX6kxVl1C/SyB7zAjI/DAISfVE90Xh/pfI
	9bGgxNLegsoW259jTlKqDRLTZ2WAhVaIzyiqgg1p03XleCmWwjQ==
X-Received: by 2002:a05:622a:2304:b0:50e:5cc3:6f42 with SMTP id
 d75a77b69052e-5104c033490mr204851261cf.59.1777990488136; Tue, 05 May 2026
 07:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
In-Reply-To: <afn0ZdvZWswBuDMm@sgarzare-redhat>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 May 2026 07:14:36 -0700
X-Gm-Features: AVHnY4LCs_m-4d1LFjbzwKLOUUlRczsxD4uzf7jMKren00MMyTffvChvT5hoQlU
Message-ID: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A66424CF55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,linux.dev:server fail,sberdevices.ru:server fail,mail.gmail.com:server fail,alibaba.com:server fail,oasis-open.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284427-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,alibaba.com:email,sberdevices.ru:email]

On Tue, May 5, 2026 at 6:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_allo=
c.
> >
> >virtio_transport_recv_enqueue() skips coalescing for packets
> >with VIRTIO_VSOCK_SEQ_EOM.
> >
> >If fed with packets with len =3D=3D 0 and VIRTIO_VSOCK_SEQ_EOM,
> >a very large number of packets can be queued
> >because vvs->rx_bytes stays at 0.
> >
> >Fix this by estimating the skb metadata size:
> >
> >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> >
> >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account cr=
edit")
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >Cc: Stefano Garzarella <sgarzare@redhat.com>
> >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >Cc: Jason Wang <jasowang@redhat.com>
> >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> >Cc: kvm@vger.kernel.org
> >Cc: virtualization@lists.linux.dev
> >---
> > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae18463=
5fbba4dfee58bd64 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >                                       u32 len)
> > {
> >-      if (vvs->buf_used + len > vvs->buf_alloc)
> >+      u64 skb_overhead =3D (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TR=
UESIZE(0);
> >+
> >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> >               return false;
>
> I'm not sure about this fix, I mean that maybe this is incomplete.
> In virtio-vsock, there is a credit mechanism between the two peers:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.ht=
ml#x1-4850003
>
> This takes only the payload into account, so it=E2=80=99s true that this =
problem
> exists; however, perhaps we should also inform the other peer of a lower
> credit balance, otherwise the other peer will believe it has much more
> credit than it actually does, send a large payload, and then the packet
> will be discarded and the data lost (there are no retransmissions,
> etc.).

I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
state to account credit")
and find a better fix then?

There is always a discrepancy between skb->len and skb->truesize.
You will not be able to announce a 1MB window, and accept one milliion
skb of 1-byte each.

This kind of contract is broken.

