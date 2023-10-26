Return-Path: <netdev+bounces-44453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5F7D8050
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE1E1C20E4B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007E1A281;
	Thu, 26 Oct 2023 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgFnjlNA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA12D780
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:12:28 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E7195
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 03:12:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so8038a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698315145; x=1698919945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjRZZh1QVfy5RBgk1z412HX2EJnJj6EDiwejECWvHFs=;
        b=ZgFnjlNAeWVK0d4FUq03PvLnRjFET9kRCAAKv9zYfVFi7G4auRXtn67uEWb52RwaXf
         1M7om651JW3V5MCW1RMLR4wC7CY+EPxJIrGN9ZWt5+lpL1NtwbDqC8Ok5paKZdse9HVT
         zh9uUwb2lCjopG7AyatfZo+ehUy7jCNxcukXj7UgTZvf+nzERpwmFWGddMKgPDj8Nqkj
         /aFfQFqGH+N48llMG46VlsZ55lRYVNgI9HWOZe0iTzc5QJKDABItEtMIJ0F+sKsVhGQG
         1CJfoUc31FylB9vr+X5Hv/disWWaRmk+aAj4iiDI25mkQ+Ozn8Z+ZPSJN6+A8RmUfKM/
         5oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315145; x=1698919945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjRZZh1QVfy5RBgk1z412HX2EJnJj6EDiwejECWvHFs=;
        b=oG4cRBB2llyl1mQ88tirU5MizgCrFeIatMnm/HR1Hi2FT3zS1C0fr0LfFXFdRsjoUP
         yxr48tijw5uYCctoTIOWwxFOjZVwhDQztGaNgWHYWh//SxIPjyeCqIq7kO6Tx/TFtdJb
         7n1wn9HNXfbZrKXem5itpgIVau05n+XR0ZuABHyc1gvrv/uu4Ya5qp4N4VO5KdXsdwd1
         /0DOgNwPpPaNb/D7VaIGizEjgTSwNmkiTSEeminR6egpz3OVVlNqx3s2KNnLOWpEZ/e5
         yxeNqKz3G42CjJqYIkATSW5n67O5u5CajpdaNpmnxPKXAtypIENK+1+KyBhCKeWSg+0B
         +Tug==
X-Gm-Message-State: AOJu0YyqAChu/Pw0cRP1oFp6LcphL9rIUQlrfZ2ABgfiJTmw7cK9/+Qw
	GurVqSRTTHJgXQklDjUJnGxruex5ESSOexjxDtudbg==
X-Google-Smtp-Source: AGHT+IFVvJ3sY43DcKKpQj7YFO2BEM9vPdoCKKGUV7IEbAvf1Y5W2akmOHooLM0WsMw+4FHJI21IkjMdfaX1CQtFaDw=
X-Received: by 2002:a50:9b58:0:b0:53f:91cb:6904 with SMTP id
 a24-20020a509b58000000b0053f91cb6904mr275519edj.4.1698315145350; Thu, 26 Oct
 2023 03:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com> <20231026081959.3477034-7-lixiaoyan@google.com>
In-Reply-To: <20231026081959.3477034-7-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Oct 2023 12:12:11 +0200
Message-ID: <CANn89iKKS5j8tttrnky4Pmqk31dRMQ4t-jCP=GeU3JYQoRdxtg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 6/6] tcp: reorganize tcp_sock fast path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:20=E2=80=AFAM Coco Li <lixiaoyan@google.com> wro=
te:
>
> The variables are organized according in the following way:
>
> - TX read-mostly hotpath cache lines
> - TXRX read-mostly hotpath cache lines
> - RX read-mostly hotpath cache lines
> - TX read-write hotpath cache line
> - TXRX read-write hotpath cache line
> - RX read-write hotpath cache line
>
> Fastpath cachelines end after rcvq_space.
>
> Cache line boundaries are enfored only between read-mostly and
> read-write. That is, if read-mostly tx cachelines bleed into
> read-mostly txrx cachelines, we do not care. We care about the
> boundaries between read and write cachelines because we want
> to prevent false sharing.
>
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 8
>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
>  include/linux/tcp.h | 240 +++++++++++++++++++++++---------------------
>  net/ipv4/tcp.c      |  85 ++++++++++++++++
>  2 files changed, 211 insertions(+), 114 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6df715b6e51d4..67b00ee0248f8 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -176,23 +176,113 @@ static inline struct tcp_request_sock *tcp_rsk(con=
st struct request_sock *req)
>  #define TCP_RMEM_TO_WIN_SCALE 8
>
>  struct tcp_sock {
> +       /* Cacheline organization can be found documented in
> +        * Documentation/networking/net_cachelines/tcp_sock.rst.
> +        * Please update the document when adding new fields.
> +        */
> +
>         /* inet_connection_sock has to be the first member of tcp_sock */
>         struct inet_connection_sock     inet_conn;
> -       u16     tcp_header_len; /* Bytes of tcp header to send          *=
/
> +
> +       __cacheline_group_begin(tcp_sock_read);

Same remarks here.
In __cacheline_group_begin(NAME), NAME should reflect the intent,
which you documented as "TX read-mostly hotpath cache lines *

NAME should therefore be tx_hotpath or something similar.

> +       /* TX read-mostly hotpath cache lines */
> +       /* timestamp of last sent data packet (for restart window) */
> +       u32     max_window;     /* Maximal window ever seen from peer   *=
/
> +       u32     rcv_ssthresh;   /* Current window clamp                 *=
/
> +       u32     reordering;     /* Packet reordering metric.            *=
/
> +       u32     notsent_lowat;  /* TCP_NOTSENT_LOWAT */
>         u16     gso_segs;       /* Max number of segs per GSO packet    *=
/
> +       /* from STCP, retrans queue hinting */
> +       struct sk_buff *lost_skb_hint;
> +       struct sk_buff *retransmit_skb_hint;
> +
> +       /* TXRX read-mostly hotpath cache lines */
> +       u32     tsoffset;       /* timestamp offset */
> +       u32     snd_wnd;        /* The window we expect to receive      *=
/
> +       u32     mss_cache;      /* Cached effective mss, not including SA=
CKS */
> +       u32     snd_cwnd;       /* Sending congestion window            *=
/
> +       u32     prr_out;        /* Total number of pkts sent during Recov=
ery. */
> +       u32     lost_out;       /* Lost packets                 */
> +       u32     sacked_out;     /* SACK'd packets                       *=
/
> +       u16     tcp_header_len; /* Bytes of tcp header to send          *=
/
> +       u8      chrono_type : 2,        /* current chronograph type */
> +               repair      : 1,
> +               is_sack_reneg:1,    /* in recovery from loss with SACK re=
neg? */
> +               is_cwnd_limited:1;/* forward progress limited by snd_cwnd=
? */
> +

And of course, prior group should end here, and a new group should begin.


We identified 6 groups, so please use 6 groups :)

