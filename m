Return-Path: <netdev+bounces-270840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ1JHlPtwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:48:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8B300AEC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED8EF3021403
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8717748CFC;
	Tue, 24 Mar 2026 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxcSdB25";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCQ3z+Wo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E337AA8A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316879; cv=pass; b=knrlOzsQTcrX/mSFeFAMrVw/2lscXp9l7Wk0VEktLkzsHVVgxmBGMU7lhvFMgHME7LpvAbfPy2Mx+95LFQ2FT4rGJ4V0JbGh1geA8weP1lTZDhxuBq/eKRlGTvqHcHCmNL/zMxsR0iJlmGtMaEL3EgcGCc4ZtJUVVnSRHcmqmNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316879; c=relaxed/simple;
	bh=1L07aR3dyNbqvLj4qfcGbhsAv2cKMDPsFOknuyeD7BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEvQeMI97kHbQxNJo2ITdsvdtznD2rpfxMMJwrXw9HFlNnNyh+Zr7X5CvvT4mYSLpidF6QtrOq7CPIYv4ABv7d/LqtK/z2let3AlkxW3mcr927xXbympBeWTZdiqldZxu7oV6/oHCVh2VZxko5C/zXeetWT9CxPh6eKfpe4FeJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxcSdB25; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCQ3z+Wo; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774316876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
	b=dxcSdB25Hbv0n8kiHJGtg1EaO/uLZOjGenGjaHQPLjJYrJU+M/73MsSCaX3R6ZbMRITW+C
	XKfuaCAhhbfBBfIxfO8u4xnNTa+ifq+wJnXju7FYwh0PTvgKdCp21rI8A0r7ROlZ0Y5HD9
	k/WoU+8k+o8vGGFKONzlxJegtTKCEnU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-DrOoOcNdNxmypIoKVAH8Fg-1; Mon, 23 Mar 2026 21:47:55 -0400
X-MC-Unique: DrOoOcNdNxmypIoKVAH8Fg-1
X-Mimecast-MFC-AGG-ID: DrOoOcNdNxmypIoKVAH8Fg_1774316874
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b04db6c138so66090355ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316874; cv=none;
        d=google.com; s=arc-20240605;
        b=g59IHerURHv7rNHykAQcBpsHv4QmywyByhAKyCkHDe4EMrgQFwYgg+sPbhOmihdvIq
         YT6Ekr8cfjIbvxLcuRPzqictf19dlBwCpKcVD2tKcx5rl8e25uNJnkMCwUKNdNrjOT3g
         oXWaC/VTqTDnrscDhrFoy/SNWfMc+9ts7zMvd5Ln7fv3SN91R6BzH6S5cfER/bCU90Ch
         E2UX2TLMXIzG1ON9SqEWrRlfYSvBliwBI0oN6KIvwIH5IyLoKwqcalBlB4CE49udPpzv
         tuHc1qt/lF9Z4tVtdxvL9OBJEJ2ScFxRLY2i1oFzzqB9BTtOI+nEdISq9E8h95VXz75b
         NP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
        fh=q1j5Zjbe8G8j7yKqMjBhVUToXpGWkhTgUteMbbDZa+Q=;
        b=TTIeDiD56rv/QDJiJegmMMgTmBik1CDYGOg4ozWd8tn1uX4U+IT7NjvLPP0NhDKf+C
         UAdWiYIg8Ga2eZpziuGdckN5wvwrCg3cA8LQc2V0bwDcmAvXETx6vWARqh+lkFdf8uuY
         XqyJBwiwbs3HJIDkYTteaNHG6Jmjw/S6fi8Tk6vOLzGA8RKN9oO0Elst/PwNnNn8nl0o
         EB81wR4HJ5RIgcHY17fMzamiKks+Luge6wrpCVK0qbAxnfIZ48wWX+uYvj8Jc4m8L96X
         3onEpveTgnX0NK7EH8e0oJWjLKsUH0fDkTd+eizcECIBgFIoA5FrBEUeF3Z2zLQd9sn4
         jxYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774316874; x=1774921674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
        b=hCQ3z+WogmblH/QccdqTYTEOSZ00a9uS//I0pYiiDhPMtFBpqJ4D7pjHqpEv4zoKDo
         i7I1MRPn+YBODnieECQQiH0egzWLdkAxVDsxPveMMgCnOk3zw4fDcU8oOAeV0iVF8jNK
         4ykQEuqozRNCE0kCbAETlgSndlAiN410dsHvRPJ3snVJd9T+apTngZ03WKBvyzuKji7M
         mqWf5Xh8/2k8t8mlXGvcUJQnvxbH865lkQTl/BMSl7TlgOyL0tgjybIpjjFCmcwtrJXk
         Ip8YJu/quhv1U8j8SUfspF8pLE190+uyiU+bRQhEb5qzhoBmp+200AREbLyH0DcOEGyD
         DPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316874; x=1774921674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
        b=szYeSiqMvQ4SzCftLTdPyAQczJGwgdTxJHZs3kDnegh6+iOdwMdJVMXYbTe1Ig63qN
         vRNDrDHlsRc72Eb/PL1Ue/fHoEgPNeXub7x8eCh6qnVvze13vgRr85Hs4coCLGbEnBHm
         303i76KMCF626R85zBDEF3DNqoeM3nU5rd6PdskRf9iQ23fRZtuo+a8MpiINhkNwwOWH
         GIj+mT6RqttLnzMDbEeTbVXgenSBdcVdOQeNKBVeWkw3oiUyKwtKNSmfQ5IGhMttQ0gk
         8OnlKeGzTmywvxmeQZ1JJOdlNW2FUq9Dat2JCc4L+oi5uCT/lIdBkwaGhjyImWbrdbV+
         cGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJk0X41famwWOnAwwf9AvZj+wwZbESvHyicGIIcr9x7mgSX8A4x5OT6iYRYuRuMc4ymQBR+JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qJiIA3TXc8SNqLfLEoN88TT0x88+fQHOW6LJSejGWUQZ0Ak0
	SGwRfNj7yg0iPVGf4PcWcQ6p2YN4JFVNSwkzGlmbV6f56GYJtzfgPAqAU/g7OalBtEwqkcuGHEL
	q9ZX8xTnzkUbR1RPrF9s/hTw+xe5EV9pEmGGQca2FPf9N8chmnsS3JMK3EsM99OGCyCUlUS5ssO
	XTO87XaXGOUyeJ+nIRKPg1l8Nxf/U93CHL
X-Gm-Gg: ATEYQzyysxpPosQvWAdO41takovrYttmI+eiRWz19bpWlRdFH/iLXki/XmTVJKQLyoP
	KO4MK8Ac9BtftW6nbw9LUKg8j6WuOIdfnbXu/JFBsy2zdzjimZHt+4fgXE+Ag/3zDrBrjve9kJP
	po8rIKLUEUSbLxvKErTFDcvml2DuN1ri6OIToD5h+NTsyJEECLcgXfWBC0LAAAZplqbO0BdMfro
	KduXkY=
X-Received: by 2002:a17:902:e541:b0:2ae:cb0e:fd60 with SMTP id d9443c01a7336-2b08270e18fmr130322625ad.5.1774316874162;
        Mon, 23 Mar 2026 18:47:54 -0700 (PDT)
X-Received: by 2002:a17:902:e541:b0:2ae:cb0e:fd60 with SMTP id
 d9443c01a7336-2b08270e18fmr130322365ad.5.1774316873607; Mon, 23 Mar 2026
 18:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 09:47:41 +0800
X-Gm-Features: AaiRm5055yjwQj85B9qlGmz19tgY1mSWOMYoiCzZMRlFulSK7W_m9HQa_Y7M5ps
Message-ID: <CACGkMEuea9iPKojWqa0oJQWLMrqKtF+mQ6Aqm8D1XceWe6oveA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/4] vhost-net: wake queue of tun/tap after
 ptr_ring consume
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270840-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EE8B300AEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
> function validates that the file belongs to a tun/tap device,
> dereferences the tun_struct under RCU, and delegates to
> __tun_wake_queue().
>
> vhost_net_buf_produce() now calls tun_wake_queue() after a successful
> batched consume of the ring to allow the netdev subqueue to be woken up.
>
> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes a slight throughput regression for a
> tap+vhost-net setup sending to a qemu VM:
> 3.948 Mpps to 3.888 Mpps (-1.5%).
>
> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
> threads, XDP drop program active in VM, pktgen sender; Avg over
> 20 runs @ 100,000,000 packets. SRSO and spectre v2 mitigations disabled.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c      | 21 +++++++++++++++++++++
>  drivers/vhost/net.c    | 15 +++++++++++----
>  include/linux/if_tun.h |  3 +++
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a82d665dab5f..b86582cc6cb6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3760,6 +3760,27 @@ struct ptr_ring *tun_get_tx_ring(struct file *file=
)
>  }
>  EXPORT_SYMBOL_GPL(tun_get_tx_ring);
>
> +void tun_wake_queue(struct file *file)
> +{
> +       struct tun_file *tfile;
> +       struct tun_struct *tun;
> +
> +       if (file->f_op !=3D &tun_fops)
> +               return;
> +       tfile =3D file->private_data;
> +       if (!tfile)
> +               return;
> +
> +       rcu_read_lock();
> +
> +       tun =3D rcu_dereference(tfile->tun);
> +       if (tun)
> +               __tun_wake_queue(tun, tfile);
> +
> +       rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tun_wake_queue);
> +
>  module_init(tun_init);
>  module_exit(tun_cleanup);
>  MODULE_DESCRIPTION(DRV_DESCRIPTION);
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c8ef804ef28c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -176,13 +176,19 @@ static void *vhost_net_buf_consume(struct vhost_net=
_buf *rxq)
>         return ret;
>  }
>
> -static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_produce(struct sock *sk,
> +                                struct vhost_net_virtqueue *nvq)
>  {
> +       struct file *file =3D sk->sk_socket->file;
>         struct vhost_net_buf *rxq =3D &nvq->rxq;
>
>         rxq->head =3D 0;
>         rxq->tail =3D ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
>                                               VHOST_NET_BATCH);
> +
> +       if (rxq->tail)
> +               tun_wake_queue(file);
> +
>         return rxq->tail;
>  }
>
> @@ -209,14 +215,15 @@ static int vhost_net_buf_peek_len(void *ptr)
>         return __skb_array_len_with_tag(ptr);
>  }
>
> -static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_peek(struct sock *sk,
> +                             struct vhost_net_virtqueue *nvq)
>  {
>         struct vhost_net_buf *rxq =3D &nvq->rxq;
>
>         if (!vhost_net_buf_is_empty(rxq))
>                 goto out;
>
> -       if (!vhost_net_buf_produce(nvq))
> +       if (!vhost_net_buf_produce(sk, nvq))
>                 return 0;
>
>  out:
> @@ -995,7 +1002,7 @@ static int peek_head_len(struct vhost_net_virtqueue =
*rvq, struct sock *sk)
>         unsigned long flags;
>
>         if (rvq->rx_ring)
> -               return vhost_net_buf_peek(rvq);
> +               return vhost_net_buf_peek(sk, rvq);
>
>         spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
>         head =3D skb_peek(&sk->sk_receive_queue);
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 80166eb62f41..ab3b4ebca059 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -22,6 +22,7 @@ struct tun_msg_ctl {
>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> +void tun_wake_queue(struct file *file);
>
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> @@ -55,6 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct f=
ile *f)
>         return ERR_PTR(-EINVAL);
>  }
>
> +static inline void tun_wake_queue(struct file *f) {}
> +
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
>         return false;
> --
> 2.43.0
>


