Return-Path: <netdev+bounces-261119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NC6CsOon2mddAQAu9opvQ
	(envelope-from <netdev+bounces-261119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:58:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE719FF6A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 441753015451
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111B73375AA;
	Thu, 26 Feb 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEhVtW+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2333993
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071104; cv=pass; b=i6fWbPJqq0wPedOonmgh6VP04g11VTTgHEX5YJw8T21oWX7oYdUmkJruE3LOob7blLfad+bPZU4o7X0e+tBaz3QZsx8mPTjZuauGA/PPXBdTIHXmJm3kjicsXNFUoKbBnYwE82Gp+5o/IoYFktUVKsBMlx3pJP9GI78rFVb7ozU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071104; c=relaxed/simple;
	bh=Hn/1O/R/KH4a9VIZTuwcXvNdjlGd5vLNQJV6ph2pShU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/eWWL1R4PebyjssE+av3iowTTLQTsurV4L98gp3I2hBDP23WHyWRgPPheL2pUlsOCi4AVD3o1plQ8BIpb3wkppNmbK5/AfGrn3AhpJrwmkJC5+dn4940gRl9fdY19JEbvKT1b0K4DobEi0MZ6G2I70AxU3jE1jFYTWNugthHBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEhVtW+W; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a019a7f3so4301521cf.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772071101; cv=none;
        d=google.com; s=arc-20240605;
        b=cO/JBeZzJeYvkb4SreCRr7EgW0XHIyok+PXuuRqhHzCZh7VAugyhYYtCYCrkcPxXhE
         9xe8DBRhlLmo9Vi3BUHx+X8gBTWgZVNnSf/DrQu7WKsCmUn4zxO79mfHdmVJzmVFfs+i
         1f1x2zlufyLtrLqM0AG6m96NyKJRxGS+5+A/jwAOYHBSY+Nl7OCuc4DOx3ZVhILBiFXR
         VDGX22BFKIpU/Km0jnxRak0X2jCJr8LTkWHT6MC/JOxLjx0fSYLQ1urp3UkeKs1jiZD4
         8wlLGG1P14p6XAkZF1aCisY9NHiZmt81PdVJe76AutKlhn/0iDG8lCkzJ/yd77jdWWa6
         nNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=beIDycu8cVd4wjWz6YtxrKzbU6jzNkiP+IjK2LQKFyg=;
        fh=7ydaQ9ymFSq3Qj7ComF7ttJTQSfmFe8O8iD2CDMmDc4=;
        b=j4Bv1eCzZu3s5apvXFPK1hlNDpV22zY4SjVus3Z9AXGJtyLxCE/TShDbwBRy0hHVJw
         8vi4ZE2hKHowuPF1CxphXxOiB6cwvP7JVFNI2cgDvG1HzlTFnKqzwee7Ry71Vc6Am4UT
         Y1F1yk3BK0nHk4251cOOU4UejGMVHIfwQ58DRFoLwbUXaaEO87riMTfJF0v+Dz9IS2/a
         CV+DbesHmQ4wJoBmsAZReArraytOgx56TbMQVqnauc4FuDpyjRmn6m0cm7YqBMaAcT9L
         MF2emg8z15YW94LHFdwgcr863JM1uSlC0XVYn95NZId+SaOADTAdoaPbLRQf0/BMM10E
         p3LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772071101; x=1772675901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beIDycu8cVd4wjWz6YtxrKzbU6jzNkiP+IjK2LQKFyg=;
        b=oEhVtW+W5oOau44cDq6EFfL6dRRxvCeNdPgcRKk8DHILP3r6n7zPsx0weqrukaRRwQ
         XsYMmwu7z8E/iFZFQeBZUXux3sUmxN/NctZZBYUNmgoy9eJ3UhW7CrO4bqc7QtExCof2
         UNx43F8UIu6QG6VmjjNJ/+jdJ9IWG/Ou/fnGZGyCbg+fi861BrQ5X8PBRFMpDmX7bY0D
         m3emkG9ssvHGw4BQvWp+BZge1ZZJ76qg3T4j7PvXFC0OhNzDO+mC7anDsKF8eBkVfi4D
         ZV7CmRE++00fKcpJT4/sY50p1av6IxQ8DswWXltWqH/T7+EjM5CHZmroQ746V3VHgnB4
         g8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772071101; x=1772675901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beIDycu8cVd4wjWz6YtxrKzbU6jzNkiP+IjK2LQKFyg=;
        b=oNMkaW63VQSNkmcQgFJHbNmBOyYOp2/bUAZRq1KoUStufheeSq21cY1loKZVaB6NQ+
         yN1AdPsYFJhlbgBz9nVjpfmf6Y9kFJwBOwXlWZzd6NkAUTv8j8iFpcLkjWwmYNl2E9Vs
         YdNL5cIE5b+Vr2ioqbEz8+f29bHLig7/3R9MYofNfcjgZS7BrxNzULUkhG1iGHSakcY/
         Y8LsHLx/SyYpWsbz0Vu7dQM4G0iYUcW1bBAxyHr6p6EZtbND0z3gwfAuDMqPjq05cU51
         6mrJHw/wAQ9e+bRpUPTvD8zVvFgFrFS28RuK7WFcWkDhwSXhL2tJOVd/RmxxepylJ8Z4
         yxFA==
X-Gm-Message-State: AOJu0Yyj3j0g7iJcU464rRF/CVHwG7A33g9miGlGiqlUKLq42HIh2jSM
	cKmmjRgnHxPFGfQf8JAUCwT6UmFrrywqfDXXuswx3uu6AnsixRv+ocih0A403aMalc24VPXPKgK
	yeXTsxOUjzghH/XILaDu8/U3h4XGPUF5Mrx6Mug7xFoiuXAdjg1HpFPfHLVs=
X-Gm-Gg: ATEYQzxgjhyKNBjzZbFzvrIIEVJfsD8WLWOcRHiaN2ORVddVKX75XvKNlXQmvLC/tB1
	18uBnS/RRCT6adrNhP1kf+wcRxgPd2ViohSCqYbS3Xqc9Im89vX6OqY0gJxJJpR2GbjscpKR1z8
	/mTgXFSO56TNakK+a5HX+uotu47FbiEAdcm7ysn5xBNr+nEFwdqc5BYT09+Lu2OVPWiL8GxGGIB
	Qtz+4YqXBfWSepbGHlBdi+c/DD2/uufILmXUsNys22lf35jsAgk1M6KImq9SM5BfwG0BRBCLcA7
	hV7yLA==
X-Received: by 2002:ac8:5d4a:0:b0:4ed:b441:d866 with SMTP id
 d75a77b69052e-50741fbd9ecmr37461321cf.65.1772071101092; Wed, 25 Feb 2026
 17:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225122355.585fd57b@kernel.org> <20260225134428.570bfbfd@kernel.org>
In-Reply-To: <20260225134428.570bfbfd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Feb 2026 02:58:09 +0100
X-Gm-Features: AaiRm50PEp46y_M_IrJOlgTOK-LMZjqWNH4yhD9WSOBb0KPIV0F-9cTYCvHO4As
Message-ID: <CANn89iLd5O16xxLAq-j2NqahikAytBgfmfR90ABZZO4tCYB4uw@mail.gmail.com>
Subject: Re: TCP OOM drops with the stricter rcvbuf checking
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-261119-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 78CE719FF6A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 25 Feb 2026 12:23:55 -0800 Jakub Kicinski wrote:
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 326b58ff1118..9f7ed76a97aa 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -3383,7 +3383,8 @@ u32 __tcp_select_window(struct sock *sk)
> >                  * Import case: prevent zero window announcement if
> >                  * 1<<rcv_wscale > mss.
> >                  */
> > -               window =3D ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
> > +               if (window < (1 << tp->rx_opt.rcv_wscale))
> > +                       window =3D ALIGN(window, (1 << tp->rx_opt.rcv_w=
scale));
> >         } else {
> >                 window =3D tp->rcv_wnd;
> >                 /* Get the largest window that is a nice multiple of ms=
s.
>
> Hm, reading thru __tcp_select_window() more carefully I guess there's
> already an attempt to solve this:
>
>         if (free_space < (full_space >> 1)) {
>                 ...
>                 /* free_space might become our new window, make sure we d=
on't
>                  * increase it due to wscale.
>                  */
>                 free_space =3D round_down(free_space, 1 << tp->rx_opt.rcv=
_wscale);
>
> the problem is that over loopback we can receive rather large skbs,
> so we don't hit this round_down(). The drops I see have < 64k inq,
> and the incoming skb is > 64k.
>
> Perhaps this condition should check if free_space < gro_ipv*_max_size
> as well (modulo gro_*_max_size vs tso_max_size on loopback)?

Given the amount of issues, maybe we can relax tcp_can_ingest()
until better days.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7b41abb82aad33d8cab4fcfa989cc4771149b41..de6ad26537232b46bee2e1f1681=
44e10faa4bf87
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5365,25 +5365,11 @@ static void tcp_ofo_queue(struct sock *sk)
 static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_=
skb);
 static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);

-/* Check if this incoming skb can be added to socket receive queues
- * while satisfying sk->sk_rcvbuf limit.
- *
- * In theory we should use skb->truesize, but this can cause problems
- * when applications use too small SO_RCVBUF values.
- * When LRO / hw gro is used, the socket might have a high tp->scaling_rat=
io,
- * allowing RWIN to be close to available space.
- * Whenever the receive queue gets full, we can receive a small packet
- * filling RWIN, but with a high skb->truesize, because most NIC use 4K pa=
ge
- * plus sk_buff metadata even when receiving less than 1500 bytes of paylo=
ad.
- *
- * Note that we use skb->len to decide to accept or drop this packet,
- * but sk->sk_rmem_alloc is the sum of all skb->truesize.
- */
 static bool tcp_can_ingest(const struct sock *sk, const struct sk_buff *sk=
b)
 {
        unsigned int rmem =3D atomic_read(&sk->sk_rmem_alloc);

-       return rmem + skb->len <=3D sk->sk_rcvbuf;
+       return rmem <=3D sk->sk_rcvbuf;
 }

 static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *sk=
b,

