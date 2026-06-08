Return-Path: <netdev+bounces-296475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ROIyJ1qgJmpXaAIAu9opvQ
	(envelope-from <netdev+bounces-296475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:58:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F134F65565B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:58:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="YQ8/0O/n";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296475-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296475-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73283170C68
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88633254B3;
	Mon,  8 Jun 2026 10:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA766336891
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:27:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914435; cv=pass; b=r8mubOmoFyy92NzlyrtOaS0WstMVjomQVNYWegncPTN1DhtfNH9FnCDw7OfCXnai9GZEFHVI5fFGsr2LjG8txEeyOAQlPwWWX3C7Lb/uZPXKOYDW2MaaT2w4D/uBQygJ6+igbJSukCeRMSeHVR30h1O2brsijGsC5Ki6Q+1e0MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914435; c=relaxed/simple;
	bh=EZYl7fs6jkwcsaoNiJ5IHkHBN71MQGlj8eWuFL2j6GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRj3v1Okr7ly84yHzRLkevs7Tk2BbAIIPb5/JrNuCJxn8xC0DJEYELt8Vk9M2npFVE2urYjTwuxghiwOypsvm0SJi2zzYPU8llYHd9J30JjIYZYG07s2XIM1cjDQIetATvx+T8D43HLxBGKi/LBVM1h1HLre+G8ynVSOL+rLFDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ8/0O/n; arc=pass smtp.client-ip=209.85.167.54
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa7a7c9711so4602861e87.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 03:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780914432; cv=none;
        d=google.com; s=arc-20240605;
        b=Lsf+OP1bhWN06CXRYGEK+pBLI7+Klet5aVQhSd5l3EgrNfgriymtyxMNpogpvhHXOY
         QHqxf5f9XJEs3HI/WbbRPUxlW0jGxwpB0EAouA6L0iQkKgctro32GejXoMwnnuCBRrO3
         nN6sjeHhfmprmj5tvU1niVNS+3c7ICNCf9LD6eZCo9r8zkDrfFjNvd9IsPFv0SwVhCgR
         ClGGaalx+aNfYurM7x9kXCTiMnUM/KXMXWJDl57kC4l6R+D0irNkYlveCRtbAhV8thSw
         nO3DLOsfynwxhpkQj1z2brMa+X7rh5ypFR2G/l4s4LDLBYAhZ/8Q1PFZysvlcgHyOzvz
         sehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lORtD1/sQQLshXBPpMvv71qB76B2AIPABPdp1R3L8x4=;
        fh=abqtvnnBHwV92Gr/XstcSP+vtGX9VRg/vx7fZtUEw3w=;
        b=Y4ZxzM+AXRYlL7eUBhUQig1+vBFhKXyqW7CJYR4yr5hClhwlc7K5k2Jyv3xJiEfv6r
         G0jNoO5qfq3oy4EpQzxFD73u5Pp4E1uTrMl3dcj2TGFkkl9ZDBS9JgpBxS5ORim1rYeS
         pfWqAFDFxzUpnLrs0/ybej1auxatnA2wbjMkRoWVl2KQO1QfVkmDC1CG6ceoh/y3+bCX
         9HUGRl24SFrBsqbyZIq9ud3CXQaiF5O2J5yf+iQhPzNS8WfSHmW9BO+0osSqpwcJXusT
         FbJK5kJlkbaQfmducKEuPGbm6Lx6pjMg7bTPF9YMWTBNq8g89V2it2xmf8fM8Ur8x1SB
         PljA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780914432; x=1781519232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lORtD1/sQQLshXBPpMvv71qB76B2AIPABPdp1R3L8x4=;
        b=YQ8/0O/nvwdb/3Z715DLNcL5QD2uotDXYdtbjHVnqYpYu3Wgb155TStR8pJSO9lfpb
         F1QCVkzszTUP1e19QMnEHF2FMk0h8Zfn4TYWN2pxcJEcXT0C1FIrCYsfgz3Hn+QG9eEj
         w+AX3vXuyYQWIapoInScN5DU78Bi1OTdZCntCAPU/VQpWbcAG27qoa3OWDfyWs9iLuVK
         cl5HZf/q2snf/pj/3qT7NoQU612LeNzxvat6fbImsMVsk8VKxILcxKJzNtqTXlJ/lPU3
         YMq5OkacGOQxQRQP/qJqeesP/zVmRe6aZIlcbpjvY8dxJ3WA7G97bQnAowmyR+/SyeIj
         ve3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780914432; x=1781519232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lORtD1/sQQLshXBPpMvv71qB76B2AIPABPdp1R3L8x4=;
        b=fe2K+BPcvx4MObe4v4WAAig96P1Yupa5VlHjGXwdCRoFYmGEP4zpytNf1kh30UxYJp
         ZWTRRkUlqb8h/3429T4TRtjb8mSINNYnswYdalapybtt81lNpnZTj23jX6xcL9oGno+b
         J2jDxkjveKumBtwzmc5AjvPyXRJus2aGjhSTxUhXhl616hcrWzs6LdO3rUnOl1DjfUBz
         0shYQFlomINMDkjox4qzFtuTq0f5QZ68vH0lM7aiGRsvtyWTq6fnD1OrVQ8XYFdGc7W9
         m6BKE8n5SepEEmpOVlFGnKFnK1qK6qee/mS/KX0PgyOHklNlJ0Bu0rV/fzQDyXbogLsP
         M3Pg==
X-Gm-Message-State: AOJu0YyjGE2Yj3kxc4XWlV8nPuYZ9zzlqFk1uaTSw7YpFORtLWZ3GypR
	4PC4OAmkJeGeRAk6XbmgPBBPmqlkHuKSs9xfRITvmH6H35uXID23+Rse5rTebZ7wveZcNAY02OP
	NA85XvIK4DuSr80XnWi5w/JcGEG4oJ2I=
X-Gm-Gg: Acq92OH7GxUdgJElI0OxcseoWZW0UqA2+lDitzWmtV4Hj7KMsjfEhpgAR1BwV330nyF
	iHKFBcIW73B504LH20/6Bt2Y2p8/pC7CUQQnZhX0fdJmCjJrHhx/Ojhne3f1g6NCPF178N4KS0D
	YZiToiRO8uEuHJvEZ5EhtHNEydRWclpyRV49LsC6WIDk8x/8thzCaYZXB7csO1ePLNqDqjo3Jzd
	orrARplKmIvVogoW3TaP7M0nueiih9FARjuH/zQjwBzGTyqlJInd0g0fHGKDweqHo3jnEx9ifM5
	udIvF1qHCz8n5EhWEWn1auOAXh0Bcytnb8OzE2EsPJUFZaEK
X-Received: by 2002:a05:6512:3ca9:b0:5aa:702e:395b with SMTP id
 2adb3069b0e04-5aa886c1fcfmr2779270e87.16.1780914431749; Mon, 08 Jun 2026
 03:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607021819.49698-1-kylebot@openai.com>
In-Reply-To: <20260607021819.49698-1-kylebot@openai.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 8 Jun 2026 17:26:31 +0700
X-Gm-Features: AVVi8CcE7HJRuLbQcfw1oeyqbHm_HmvPprX2bgSHd0hIyYK7sukbI8RzAGevO7Y
Message-ID: <CAL+tcoDg71WOyv6ce-b++rakmSbPVtvTGaGt1bQZLT=dHaRy=g@mail.gmail.com>
Subject: Re: [PATCH net] net: guard timestamp cmsgs to real error queue skbs
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, uniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:netdev@vger.kernel.org,m:kuniyu@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296475-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F134F65565B

On Sun, Jun 7, 2026 at 9:29=E2=80=AFAM Kyle Zeng <kylebot@openai.com> wrote=
:
>
> skb_is_err_queue() treats PACKET_OUTGOING as the sole marker for an skb
> from sk_error_queue. That assumption is not true for AF_PACKET sockets:
> outgoing packet taps are also delivered to packet sockets with
> skb->pkt_type =3D=3D PACKET_OUTGOING, but their skb->cb is owned by AF_PA=
CKET
> instead of struct sock_exterr_skb.
>
> If such an skb is received with timestamping enabled, the generic
> timestamp cmsg path can read AF_PACKET control-buffer state as
> sock_exterr_skb::opt_stats. With SO_RXQ_OVFL enabled, the packet drop
> counter overlaps opt_stats. An odd drop count makes the path emit
> SCM_TIMESTAMPING_OPT_STATS with skb->len and skb->data. For non-linear
> skbs this copies past the linear head and can trigger hardened usercopy o=
r
> disclose adjacent heap contents.
>
> Keep skb_is_err_queue() local to net/socket.c, but make it verify that
> the PACKET_OUTGOING marker is paired with the sock_rmem_free destructor
> installed by sock_queue_err_skb(). AF_PACKET receive skbs use normal
> receive ownership and no longer pass as error-queue skbs, while legitimat=
e
> sk_error_queue entries keep the PACKET_OUTGOING marker and sock_rmem_free
> ownership.
>
> Fixes: 8605330aac5a ("tcp: fix SCM_TIMESTAMPING_OPT_STATS for normal skbs=
")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Thanks for the fix.

Using sock_rmem_free() is a bit tricky here, especially in the general
path, so I think it would be better to get rid of this unreliable way
of checking.

My take on this is: since it's only caused in the AF_PACKET scenario,
how about only handling this like removing the ongoing flag in the
packet_rcv() path instead of touching the general function (which is
skb_is_err_queue())?

Thanks,
Jason

> ---
>  include/net/sock.h   |  1 +
>  net/core/skbuff.c    |  6 +++---
>  net/socket.c         | 11 ++++++-----
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index dccd3738c368..95e157eee8d9 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1856,6 +1856,7 @@ struct sk_buff *sock_omalloc(struct sock *sk, unsig=
ned long size,
>                              gfp_t priority);
>  void skb_orphan_partial(struct sk_buff *skb);
>  void sock_rfree(struct sk_buff *skb);
> +void sock_rmem_free(struct sk_buff *skb);
>  void sock_efree(struct sk_buff *skb);
>  #ifdef CONFIG_INET
>  void sock_edemux(struct sk_buff *skb);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c02f0a507ba8..8eab8eb5006a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5450,7 +5450,7 @@ int skb_cow_data(struct sk_buff *skb, int tailbits,=
 struct sk_buff **trailer)
>  }
>  EXPORT_SYMBOL_GPL(skb_cow_data);
>
> -static void sock_rmem_free(struct sk_buff *skb)
> +void sock_rmem_free(struct sk_buff *skb)
>  {
>         struct sock *sk =3D skb->sk;
>
> @@ -5459,8 +5459,8 @@ static void sock_rmem_free(struct sk_buff *skb)
>
>  static void skb_set_err_queue(struct sk_buff *skb)
>  {
> -       /* pkt_type of skbs received on local sockets is never PACKET_OUT=
GOING.
> -        * So, it is safe to (mis)use it to mark skbs on the error queue.
> +       /* The error-queue test in skb_is_err_queue() matches this marker
> +        * with the sock_rmem_free destructor installed by sock_queue_err=
_skb().
>          */
>         skb->pkt_type =3D PACKET_OUTGOING;
>         BUILD_BUG_ON(PACKET_OUTGOING =3D=3D 0);
> diff --git a/net/socket.c b/net/socket.c
> index 22a412fdec07..c2698a1441a7 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -852,12 +852,13 @@ EXPORT_SYMBOL(kernel_sendmsg);
>
>  static bool skb_is_err_queue(const struct sk_buff *skb)
>  {
> -       /* pkt_type of skbs enqueued on the error queue are set to
> -        * PACKET_OUTGOING in skb_set_err_queue(). This is only safe to d=
o
> -        * in recvmsg, since skbs received on a local socket will never
> -        * have a pkt_type of PACKET_OUTGOING.
> +       /* Error-queue skbs are marked as PACKET_OUTGOING in
> +        * skb_set_err_queue() and use the destructor installed by
> +        * sock_queue_err_skb(). PACKET_OUTGOING alone is not unique:
> +        * AF_PACKET outgoing taps use the same pkt_type.
>          */
> -       return skb->pkt_type =3D=3D PACKET_OUTGOING;
> +       return skb->pkt_type =3D=3D PACKET_OUTGOING &&
> +              skb->destructor =3D=3D sock_rmem_free;
>  }
>
>  /* On transmit, software and hardware timestamps are returned independen=
tly.
> --
> 2.43.0
>

