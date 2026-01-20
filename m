Return-Path: <netdev+bounces-251591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBLCNAPzb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:26:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399F4C3AD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB9A21243
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1CD46AF25;
	Tue, 20 Jan 2026 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnoAN5CK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BC423A64
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936226; cv=pass; b=Zf+8JEcjgxlyHYKVf+TtVNRqq4ufvtXY1nWB0bwNAfnBXa7hbS8Tuh3UVqBs2AkSHeTiLsaafFsgKPxWUnh51ljPz0NwCghhuG7dRwoLeau4SYlnzhaR/6GNGaqG+R8sLVbf0yz5o9nhQ7RTfcJ4Jb9g1+J4hC0pxe5+bRK5/Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936226; c=relaxed/simple;
	bh=RQ2JCHSug0z4VTY2t3zlvOkPl2dYMopfE1CEATGUSFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIs25MlY76qVdjPWrWAXer40bimez/Vm7wyhDEMGJv6Y8TkdDIdruofC3Hyu1iDFreCz+L12+FPeEmkXnXIMLdtmht9ZTtdukI6IQzLYXf5S95RDW21htgByEu0FeBDwJX3zN2S8bwxXxyJNkWQu9QLVpbX4O7HLrOYXVO3jay8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnoAN5CK; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65f59501dacso4072340eaf.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:10:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768936223; cv=none;
        d=google.com; s=arc-20240605;
        b=S/xzJKGVAXWQp1PKNFy/nLVfYI0EJVMnT/bJq8NbVD8eg5dk2RqFkGfzdBDiIcIOvg
         0SIjeo/s66gfmxdokRwr65fw53lrncEikYCQM9ltVKMFbq55xQdD44kq+ZUjiffXnpAo
         ukt2Sx4FRnic4f7XTuQ2QfyWUBQC5fe4PElJA3x/EzFRKvhzjBGRA7+DFyoOT2xhEZPo
         yUAL9dCG9rQ3kUgyraXvmChAwOzJ/w69QoAz4UU02btz1DEZxqqZwCOplpywFC5OeRd4
         F+F3P7LKBTFwlwPjIuOnLiB8mF3c1Y9Mz6qe8qmQk78ZT6T+iRmBb7m6m1eplSVn5n+h
         2vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Csf/X+A6Yj7XM/zwDG6j8QqnjMgcQ6DA65ZzCNcagU=;
        fh=/gGgJtzrP/fSON9itFOOjXTfQ8dw6O4zTTAnpv/wkBw=;
        b=ery7GtkPgFRsmYfeuW1Z0GjR6ibq0Qe/vJSg72Qkjtd/oXRFBhfaDDm4hQOyNHHT6c
         U1t9sfRrx7ZlyJ12BWinF6vv5Cel5btViTXj+tzdcHYKc4SLjpndRfV4qNXwsLXQz5xn
         9fvbFoAoAGBKtmhdc+9sgFC/XmqoQsyym1HxgRv+2okmMUstOdOUIIUddf+BtITOY4vy
         v6A1+ZmPtTBZO78Z2VHg0/V7/1M3rnm8PoTbaArERae07di6E9Rnkkua8INwIavDdzJ0
         2r9uSEKYBH7MXut1IG+wPC4CB6AIGoZVyUON3gRVdqViK5b9dNmxqAmkitWZpbSaHvwY
         bTqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768936223; x=1769541023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Csf/X+A6Yj7XM/zwDG6j8QqnjMgcQ6DA65ZzCNcagU=;
        b=lnoAN5CK7uP0U4jtz9xDfkdr03B/K4SdAW9hfWYU2OQHf8e3BWGTarGuppTgqdEilj
         mo9fZhN8EOPxA4OhUe2wkbUL0TJQ2nf3kRD6LxsnMbbLeCMTl78nKJ767O/QgyA5VgK9
         ORPN5NcvEJmirpQzM4PmD3FihQcp6qwiCHqxWaGNSYkWQJx7TAWEYxxYLlQypFPVBKRv
         fyiqBYSmZEXL3U8CCnNsCrRyGNUdVU5NHFyNHNLm0c6Tss40gSzBj6NUK2yJ8+cZr1kC
         wg4NCO6tUPG1R6E3K1zX9OAuKn90vVovVZV9DmAybSvIhC+kS2M+lgi20CLyq1zj54Ca
         T7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768936223; x=1769541023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Csf/X+A6Yj7XM/zwDG6j8QqnjMgcQ6DA65ZzCNcagU=;
        b=L+nvotqjksBpgqjP4JrslE9fUfH4lEKBfjtvvz8kRnJ5ckzSQqfqT8rXx/rnGwJV1A
         9U6idWNIfQcE8h3jTcQzW3SIoTAgeLWLx5flJHJXGzhbodh2USnkzAZGovt1uJukHZsg
         I4c0ApD3hAYq/mTyprflgtGTFXa1qEspCNdne/cfDM8VZH4P1gFwvp/SvoFvnuz0lXf3
         neA+1KgHn9M4xunu9VnW0mMvjwChWpj2vIddgJXgPcID/pivQ36GkysAyWkKA+kUGg1g
         Ob9SKHxTUvwOd4NAFvJZgLBALTh3dZtgLPqsERM21+C/jAGF0w19yrr7b6x+XjasD89O
         zdbQ==
X-Gm-Message-State: AOJu0YyyN16CLxLcrJcQ6mduWYEUvwRTuAOQK5HL5JrQmW9hlS7Fz3sO
	keJ/qgnqJ75Ju5KjKgzlAdGgzlRxrl5XnwMbneXe6bFiphyGTxlu5w4c2DdojeMpAYIrvshv4dm
	MrihPh0rH81Ib5K0rzQllg4zUJtZQxJ8=
X-Gm-Gg: AY/fxX5/7hEaBgQ26pS95DSEghVx/OldKFErt6bqePfiJBo4eqypiswn1W3xxvPsNJB
	kegjM8x+ynmTOsBRblgTXo5OSIWieO3jZneWa+/vlYqmXNprgmIXgy6SyZkWZ8613oxNkuIGQFz
	RQSga3Y8jjGX5ZleLCgSOtRe3kpAGEjUUt+PFGXBwd8myO101o+YA9hTXRmNFXeZh9+fGHLl5f2
	fFYHlc6yHv2b98sSCQNn6zAVVUf3CHlfhKcY/K9UG1F3NgJc0i5S43zDo7zIKbKf960gEaBJUjN
	YKS5p1ur/XMJcwysCMXb5ZETm3IO/QIilgOcBB55BvfIJKp5DHWcqLy/C6I6
X-Received: by 2002:a05:6820:f00a:b0:65f:6a70:2324 with SMTP id
 006d021491bc7-662b00940c8mr1223440eaf.56.1768936223274; Tue, 20 Jan 2026
 11:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119162720.1463859-1-mmyangfl@gmail.com> <8cfba7ca-03d0-46fe-92fa-5d4a119fc31e@molgen.mpg.de>
In-Reply-To: <8cfba7ca-03d0-46fe-92fa-5d4a119fc31e@molgen.mpg.de>
From: Yangfl <mmyangfl@gmail.com>
Date: Wed, 21 Jan 2026 03:09:47 +0800
X-Gm-Features: AZwV_QjxhMmCVLVMg326Zu3TrNeYwemKLCUFGwJp4YRXr5m1z-pDq9pWaByfCFQ
Message-ID: <CAAXyoMPxG5DbfMoLztWL3W78Xf3TMMVvkKJFD8L3Dup2-hMyyA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: Fix data race in idpf_net_dim
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phani Burra <phani.r.burra@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251591-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,mpg.de:email]
X-Rspamd-Queue-Id: 4399F4C3AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 12:50=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear David,
>
>
> Thank you for your patch.
>
> Am 19.01.26 um 17:27 schrieb David Yang:
> > In idpf_net_dim(), some statistics protected by u64_stats_sync, are rea=
d
> > and accumulated in ignorance of possible u64_stats_fetch_retry() events=
.
> > The correct way to copy statistics is already illustrated by
> > idpf_add_queue_stats(). Fix this by reading them into temporary variabl=
es
> > first.
>
> It=E2=80=99d be great if you also documented a test case.
>

Sorry, I didn't get what "documente a test case" means. Triggering the
bug would require precise timing between the writer and reader. If
u64_stats_fetch_retry() returns true you already know the previous
critical section was invalid, which is documented in u64_stats_sync.h.

> > Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> > Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 16 +++++++++++-----
> >   1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/=
ethernet/intel/idpf/idpf_txrx.c
> > index 97a5fe766b6b..66ba645e8b90 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -3956,7 +3956,7 @@ static void idpf_update_dim_sample(struct idpf_q_=
vector *q_vector,
> >   static void idpf_net_dim(struct idpf_q_vector *q_vector)
> >   {
> >       struct dim_sample dim_sample =3D { };
> > -     u64 packets, bytes;
> > +     u64 packets, bytes, pkts, bts;
>
> The new variable names are ambiguous. Would _tmp or so be better?
>
> >       u32 i;
> >
> >       if (!IDPF_ITR_IS_DYNAMIC(q_vector->tx_intr_mode))
> > @@ -3968,9 +3968,12 @@ static void idpf_net_dim(struct idpf_q_vector *q=
_vector)
> >
> >               do {
> >                       start =3D u64_stats_fetch_begin(&txq->stats_sync)=
;
> > -                     packets +=3D u64_stats_read(&txq->q_stats.packets=
);
> > -                     bytes +=3D u64_stats_read(&txq->q_stats.bytes);
> > +                     pkts =3D u64_stats_read(&txq->q_stats.packets);
> > +                     bts =3D u64_stats_read(&txq->q_stats.bytes);
> >               } while (u64_stats_fetch_retry(&txq->stats_sync, start));
> > +
> > +             packets +=3D pkts;
> > +             bytes +=3D bts;
> >       }
> >
> >       idpf_update_dim_sample(q_vector, &dim_sample, &q_vector->tx_dim,
> > @@ -3987,9 +3990,12 @@ static void idpf_net_dim(struct idpf_q_vector *q=
_vector)
> >
> >               do {
> >                       start =3D u64_stats_fetch_begin(&rxq->stats_sync)=
;
> > -                     packets +=3D u64_stats_read(&rxq->q_stats.packets=
);
> > -                     bytes +=3D u64_stats_read(&rxq->q_stats.bytes);
> > +                     pkts =3D u64_stats_read(&rxq->q_stats.packets);
> > +                     bts =3D u64_stats_read(&rxq->q_stats.bytes);
> >               } while (u64_stats_fetch_retry(&rxq->stats_sync, start));
> > +
> > +             packets +=3D pkts;
> > +             bytes +=3D bts;
> >       }
> >
> >       idpf_update_dim_sample(q_vector, &dim_sample, &q_vector->rx_dim,
>
>
> Kind regards,
>
> Paul

