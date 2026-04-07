Return-Path: <netdev+bounces-276182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHXKKMJ71WlU6wcAu9opvQ
	(envelope-from <netdev+bounces-276182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:48:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628B3B51DD
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8391D300A3BE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C64037E2E1;
	Tue,  7 Apr 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPtDt96p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCA33ADAB
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598524; cv=pass; b=fve9Rs7hP8dqrLRbolvWhrYAyYcJJkHdHZ7oFXEjkgmcco0M0ITLCbphyEnYMnEWYnBQe5+cxRt9XwTbCvTDFRkclvYGwjgclJLzgt9XDJg3aRry/HtQA0z+0xcNtTpVg1PJwD3vsFDALBVrY9g1mFGkYfRRf9mOXgI7SFGbdI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598524; c=relaxed/simple;
	bh=l9hu1CsON+YjBetskChKGjv2kXUxebMstlid3QvraZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChSvayIaycBLVJHYzcb7EASu7gs0/njoMgvR+SR216MxZs5t3OkHeWlw+Uxu8/r/MeHk7nFePI3HRjY+LOyDU0kUE62dsyUMUO3onZOIB/9J5TsjX0GVimYV9YU9ejc8kdW2LuU5D7uMGTJzK4TsTe+q1pl7j0RlPqMrlVs1WD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPtDt96p; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d6b393d60so101031cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775598520; cv=none;
        d=google.com; s=arc-20240605;
        b=KriCmLjaEPqTiVDgp+3W+j5PqFXrjHQq+F/I5nje+KhsY0ReG0DH0x2wq/0O42wqgO
         6JhZ8GcTqf1WdAeI+H74e9VjdYBv62FfP2io7Q1bHcXlqf02SxoYqLWA96zZYW7uEzg2
         YWkmjvxMRPh/hRYQQU8ZQ0Sn564KZkFeeh+o5i+HywNu0YdbWK8T5VSWnvDBeqSKOhhS
         iwaze3xegtL9KVJiLSvcwbQ0OM8rBCcmB2DSO9xqlZUhfWdiIGInSWYtPG9JCnhoyrUB
         YD8DhbJACJHcT8cYH5GStBZyEjHhxkCJPPw/tk/i1XN4BC5dNIOfyf/Nf1slm+try57B
         WjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jS8uYkGxF9Hcs87iz1Wm8b6CGLU/T6WPLau2g7lys0g=;
        fh=io13mgLD7FlVfAVYwjJfscs1TGDHV2h/MASOrvm+DLk=;
        b=LUshsMsjK0I1vofFFA7rXnna/+lkmv3wf/5djcgKrYrYPPJQLn/SmCeqSAkDhvCX8J
         LLDBLECDVvr4MT/ehAQpxcGwfx1OvTjPaeszJ9G2KEvwiRiwd77JMGsPlLZJ7IrxQGF7
         NBkiW+WLVrTMcKnEWGIAl1tTC00RhvvS2GRvdZBG3UTraHRIm2Ndyvf0aIvRSEDtVJf5
         DaiL/Vvt1NthNG9tiuM60TC4wza6kOGvv5D48kBBBlxx+oX5PVC0cn85zIs4O8kCgA47
         BVybYAmkoI0LEK9ZzHN4zhi8B3M0pZVFmHR43/jL/QpbnYULZde94u6fmSN9hVRx760Z
         DQ+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775598520; x=1776203320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS8uYkGxF9Hcs87iz1Wm8b6CGLU/T6WPLau2g7lys0g=;
        b=fPtDt96pqiIBSOmWhsAGMkNlGBKiWHvPCJ0e+4ZC+Dq5vySQbBD6aWxJMGbyUzDpff
         0GP5+65I5YoRAobiMY/QYbQjxnLmb7fzsmtRR9j/ND6n+UxB3kMxAVxrT+iNj3EjF5XR
         oYiyxyh056K3UQqa9BmVtTmXVVMyBRVMngBb8gzQ/iC8TTwp7UX1+3bFfEDfH7ZSjHuy
         iJuk/fDSYWXvwQi3Dg+ioOqiToKudpxHn/osp+JPISdIAkO8VTp2hlRrETALvusYzk0a
         VfHTkhgIt99opeL4Iso9vL1/U48SbcHaaW0v5j9aCpWVqE3iavkY7hDOEuGqz9isUeNu
         JkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598520; x=1776203320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jS8uYkGxF9Hcs87iz1Wm8b6CGLU/T6WPLau2g7lys0g=;
        b=OCdJMZw1rDW19j+35U0+vl3tc0ZDaDZ/ye6EoVg2L/0yZZEoaHhryYaP5HrfJ2cVKZ
         HRU4s0cAKrAQgK6q6Arv8RPNZcKcUN6c4RknhF3woNeg6yutMtNebuwcmGaiRoHKWoTA
         72iPXj2a3prWDyfkJb3pQPlCcVqbK2H8MfbWodEH+x+2XUpMUOOdKgI3EwzZ51xJckGq
         uwQm1HLQ6pXr4m8G4WzzvXUVe6z4eq5y99/TzHb9W67iM4dWLlWFDeMJ0D2fxZ2/OwbG
         8N3007vtDFH7GCzk26+C60PA1BXnXlIcmSvg9QVrYg6RinzhHbE5Td8UQWiiMsh5uaEm
         efxA==
X-Forwarded-Encrypted: i=1; AJvYcCWU02oQZ0DdFovDTya8oAeFWCf4TKwiraji1s6a+YwADhNB6m70Vdar65i+vDBxTQ0dPHf0r2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLVpdymM18y3OZHVkfu1e/iBkHZcD/Hn3seVNFq3STfLUAKH7
	Futz5hD8BZmWWzYya2ZfvUKmZN2OLPhUva+eqe6+eDzYFPBVu/AoKxiIy0avDc4nFnB5dBE8tQr
	ne3Blrrrkm+DUF6ewpFL3nf51N12O7Ka4h3XahH6s
X-Gm-Gg: AeBDietg7ElJG36/MG4r1pjBlSYJDlNzz/yajh5Bp4kcGLVm7cbuOSI3Mv0E5KGUZ7K
	fPC3W4EBqiogX7lsXX3xUVbtWWUNnSPwuRP+0p4lPQNaDeecAmBPPQseFPdMyI8gstXSwHq1xCQ
	Mtib6bwdJW9wnhdDbOLJWmJOySziECq/JpRAdi8t7T2Pje0hUUHTuxlMQFWfWc259/rsLXe45ip
	XMo37FUsSfupfEgL8Adkln04MiWYcQPFxdJ6nR3qGE7mB4gjYIgEPA+3xQ7bDQhao33UwbFyPSJ
	H7q9es0vbhICIey2vjjNa8AWo7fLmma34k+iU+yj9CCZh+fxEHygFJ85uGQ+1c2FcEwccPj/W8U
	smhLB
X-Received: by 2002:a05:622a:4d45:b0:50b:71e4:878c with SMTP id
 d75a77b69052e-50db3fc0420mr799811cf.15.1775598519488; Tue, 07 Apr 2026
 14:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adIUY2N6HOKZNzSJ@volt-roccet-vm>
In-Reply-To: <adIUY2N6HOKZNzSJ@volt-roccet-vm>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 7 Apr 2026 17:48:22 -0400
X-Gm-Features: AQROBzBKGg7tsXhaEyVZEYlaZSaqEhgKPTyTjxoxDXUkqHoXqR0HYih4oP0Xql0
Message-ID: <CADVnQymmsispHew4-frsuBBfObZHdSbH+jfP-9aSW1HguK_N4A@mail.gmail.com>
Subject: Re: [PATCH,net-next] tcp: Add TCP ROCCET congestion control module.
To: Tim Fuechsel <t.fuechsel@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276182-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1628B3B51DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 5, 2026 at 3:51=E2=80=AFAM Tim Fuechsel <t.fuechsel@gmx.de> wro=
te:
>
> TCP ROCCET is an extension of TCP CUBIC that improves its overall
> performance. By its mode of function, CUBIC causes bufferbloat while
> it tries to detect the available throughput of a network path. This is
> particularly a problem with large buffers in mobile networks. A more
> detailed description and analysis of this problem caused by TCP CUBIC
> can be found in [1].

Thanks for posting this patch. I agree that improving the bufferbloat
caused by CUBIC and similar algorithms is an important area for work.

> TCP ROCCET addresses this problem by adding two
> additional metrics to detect congestion (queueing and bufferbloat)
> on a network path.

Normally I think of bufferbloat as excessive queuing. Thus normally I
would think of queuing and bufferbloat as essentially the same metric.
So it seems confusing for this sentence to claim that these are two
additional metrics rather than one.

Furthermore, these mentions of "queueing" and "bufferbloat" are the
last time those words appear in the entire patch. It's unclear to the
reader how your high-level description in this sentence connects with
the algorithm or the code.

Please clarify in the commit description what you mean by "two
additional metrics to detect congestion (queueing and bufferbloat)",
how you define "queueing", how you define "bufferbloat", and how the
algorithm measures and uses these metrics.

> TCP ROCCET achieves better performance than CUBIC
> and BBRv3, by maintaining similar throughput while reducing the latency.

Please reference figures in the paper and mention specific concrete
numerical examples of latency reductions to quantify these statements.

> In addition, TCP ROCCET does not have fairness issues when sharing a
> link with TCP CUBIC and BBRv3.

Can you please elaborate on this statement here? AFAICT from figures 7
and 8 in https://arxiv.org/pdf/2510.25281 it seems ROCCET is
essentially starved by CUBIC when sharing a bottleneck with CUBIC when
the bottleneck has 2*BDP or more of buffering. AFAICT it sounds like
ROCCET does have "fairness issues when sharing a link with TCP CUBIC"?

> A paper that evaluates the performance
> and function of TCP ROCCET has already been peer-reviewed and will be
> presented at the WONS 2026 conference. A draft of this paper can be
> found here [2].
>
> [1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
> [2] https://arxiv.org/abs/2510.25281

Thanks for the links to the paper on ROCCET. This is very helpful.

> Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
> Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>
> ---
>  net/ipv4/Kconfig      |  11 +
>  net/ipv4/Makefile     |   1 +
>  net/ipv4/tcp_roccet.c | 686 ++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_roccet.h |  60 ++++
>  4 files changed, 758 insertions(+)
>  create mode 100644 net/ipv4/tcp_roccet.c
>  create mode 100644 net/ipv4/tcp_roccet.h
>
> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index 21e5164e30db..33625111c7f0 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -663,6 +663,17 @@ config TCP_CONG_CDG
>             delay gradients." In Networking 2011. Preprint:
>             http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg=
-preprint.pdf
>
> +config TCP_CONG_ROCCET
> +       tristate "ROCCET TCP"
> +       default n
> +       help
> +      TCP ROCCET is a sender-side only modification of the TCP CUBIC
> +      protocol stack that optimizes the performance of TCP congestion

s/TCP CUBIC protocol stack/TCP CUBIC congestion control algorithm/

> +      control. Especially for networks with large buffers (wireless,
> +      cellular networks), TCP ROCCET has improved performance by maintai=
ning
> +      similar throughput as CUBIC while reducing the latency.
> +       For more information, see: https://arxiv.org/abs/2510.25281

nit: AFAICT there's an extra space in front of the word "For".

> +
>  config TCP_CONG_BBR
>         tristate "BBR TCP"
>         default n
> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index 7f9f98813986..82ed7989dcb3 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_INET_TCP_DIAG) +=3D tcp_diag.o
>  obj-$(CONFIG_INET_UDP_DIAG) +=3D udp_diag.o
>  obj-$(CONFIG_INET_RAW_DIAG) +=3D raw_diag.o
>  obj-$(CONFIG_TCP_CONG_BBR) +=3D tcp_bbr.o
> +obj-$(CONFIG_TCP_CONG_ROCCET) +=3D tcp_roccet.o
>  obj-$(CONFIG_TCP_CONG_BIC) +=3D tcp_bic.o
>  obj-$(CONFIG_TCP_CONG_CDG) +=3D tcp_cdg.o
>  obj-$(CONFIG_TCP_CONG_CUBIC) +=3D tcp_cubic.o
> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 000000000000..b0ec3053182f
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,686 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
> + * Extension for 5G and Beyond Networks
> + *
> + * TCP ROCCET is a new TCP congestion control
> + * algorithm suited for current cellular 5G NR beyond networks.
> + * It extends the kernel default congestion control CUBIC
> + * and improves its performance, and additionally solves an
> + * unwanted side effects of CUBIC=E2=80=99s implementation.

Please specify what side effect or side effects ROCCET is claiming to
solve (presumably bufferbloat?).

> + * ROCCET uses its own Slow Start, called LAUNCH, where loss
> + * is not considered as a congestion event.

Expressed in isolation like this, that sounds potentially dangerous.
Please mention what signal(s) ROCCET uses to exit slow start if it's
not using loss.

In addition, from reading the code AFAICT the connection does use loss
to exit slow start (see my remarks below in this message). So AFAICT
this summary seems inaccurate, or at least misleading?

> +static __always_inline void update_min_rtt(struct sock *sk)
> +{
> +       struct roccettcp *ca =3D inet_csk_ca(sk);
> +       u32 now =3D jiffies_to_usecs(tcp_jiffies32);
> +
> +       if (now - ca->curr_min_rtt_timed.time >
> +                   ROCCET_RTT_LOOKBACK_S * USEC_PER_SEC &&
> +           calculate_min_rtt) {
> +               u32 new_min_rtt =3D max(ca->curr_rtt, 1);
> +               u32 old_min_rtt =3D ca->curr_min_rtt_timed.rtt;
> +
> +               u32 interpolated_min_rtt =3D
> +                       (new_min_rtt * roccet_min_rtt_interpolation_facto=
r +
> +                        old_min_rtt *
> +                                (100 - roccet_min_rtt_interpolation_fact=
or)) /
> +                       100;
> +
> +               ca->curr_min_rtt_timed.rtt =3D interpolated_min_rtt;
> +               ca->curr_min_rtt_timed.time =3D now;
> +       }

If no lower RTT is found for 10 seconds, the algorithm interpolates
the `min_rtt` upwards towards the current RTT.

+  If the path is persistently congested (e.g., a large buffer is
constantly full), the `min_rtt` baseline will drift up.

+  This makes the algorithm less sensitive to queueing delay over
time, potentially defeating the purpose of reducing bufferbloat in the
long run. Contrast this with BBR, which actively drains the queue
(using the ProbeRTT mechanism) to try to find the true physical
minimum RTT.

Can you please add a comment explaining why the ROCCET algorithm takes
this approach, and how the algorithm expects to avoid queues that
ratchet ever higher?

> +/* Update ack rate sampled by 100ms.
> + */
> +static __always_inline void update_ack_rate(struct sock *sk)
> +{
> +       struct roccettcp *ca =3D inet_csk_ca(sk);
> +       u32 now =3D jiffies_to_usecs(tcp_jiffies32);
> +       u32 interval =3D USEC_PER_MSEC * 100;
> +
> +       if ((u32)(now - ca->ack_rate.last_rate_time) >=3D interval) {
> +               ca->ack_rate.last_rate_time =3D now;
> +               ca->ack_rate.last_rate =3D ca->ack_rate.curr_rate;
> +               ca->ack_rate.curr_rate =3D ca->ack_rate.cnt;
> +               ca->ack_rate.cnt =3D 0;
> +       } else {
> +               ca->ack_rate.cnt +=3D 1;
> +       }

Here, `cnt` is incremented by `1` on every call, regardless of the
`acked` value (number of packets ACKed in this event).

+   This measures ACK frequency rather than data delivery rate.

+   This approach is highly sensitive to receiver behavior like
Delayed ACKs, LRO (Large Receive Offload), or GRO (Generic Receive
Offload), where one ACK event might acknowledge many packets.

+  To measure rate, I would suggest accumulating bytes ACKed (or
packets ACKed) rather than just counting the number of ACK events.


> +       if (ca->bw_limit.next_check =3D=3D 0)
> +               ca->bw_limit.next_check =3D now + 5 * ca->curr_rtt;
> +
> +       ca->bw_limit.sum_cwnd +=3D tcp_snd_cwnd(tp);
> +       ca->bw_limit.sum_acked +=3D acked;
> +
> +       if (ca->bw_limit.next_check < now) {

This comparison (ca->bw_limit.next_check < now) does not properly
handle wrapping of the 32-bit timestamps. You probably want to
subtract the two numbers and look at the result, since subtraction
will handle the wrapping. Please see how tcp_cubic uses tcp_jiffies32
for examples of how to do this.

> +               /* We send more data as we got acked in the last 5 RTTs *=
/

This seems to have a typo and seems to intend to say: "We sent
significantly more data than we got acked in the last 5 RTTs".

> +               if ((ca->bw_limit.sum_cwnd * 100) / ca->bw_limit.sum_acke=
d >=3D
> +                   ack_rate_diff_ca)
> +                       bw_limit_detect =3D 1;

AFAICT this logic for updating and using ca->bw_limit.sum_cwnd appears
to be mathematically flawed for its stated purpose:

+   `sum_cwnd` is accumulated on every ACK event. Over a period of 5
RTTs, if we assume continuous sending at window size $W$, the number
of ACK events is roughly proportional to $W$. Thus, `sum_cwnd` will be
roughly $5 * num_acks_per_round * W$.

+  `sum_acked` accumulates the number of packets ACKed (`acked`). Over
5 RTTs of continuous sending, this will simply be roughly the number
of packets ACKed, which is roughly $5 * W$ (if the flow is not
application-limited).

+ The quantity `sum_cwnd * 100 / sum_acked` will therefore be roughly
$(5 * num_acks_per_round * W) * 100/ (5 * W) =3D num_acks_per_round *
100 $, not a measure of bandwidth limitation (it does not tell you if
you are really sending more data than is being ACKed).

+  With the default `ack_rate_diff_ca` of `200`, this condition will
become true for $sum_cwnd * 100 / sum_acked >=3D 200$, i.e.
$num_acks_per_round * 100 >=3D 200$. So AFAICT we expect this condition
to be true if there are 2 or more ACKs in a round trip. This makes
`bw_limit_detect` effectively a no-op or always-on trigger rather than
a true detector of queue growth or bandwidth limits.

If you want to really check whether the connection is sending
significantly more data than is being ACKed, then AFAICT you need to
address the following issues:

+ A cwnd is a per-round-trip number, not a per-ACK number (as it is
treated here).

+ Application-limited flows do not always send a full cwnd worth of
data (as the flow is assumed to do here).

+ Data sent is out of phase by one round trip with data ACKed, so if a
connection is growing its sending rate by a factor of X per round trip
then we expect the data sent in a round trip to be X times greater
than the data ACKed in that round trip even if the bottleneck
bandwidth is not saturated yet. So if you want to compare data sent vs
data ACKed, you need to keep this in mind.

Furthermore, AFAICT the ack_rate_diff_ca parameter used by this
algorithm differs massively from the value described in the paper. The
paper says: "If the amount of incoming ACKs over 5 RTTs deviates more
than 20 % from the cum_cwnd over the same time period".  AFAICT
ack_rate_diff_ca is 200, thus this code checks for a 200% deviation,
not a 20% deviation.

Did the experiments in the paper use the approach documented in the
paper, or the approach documented in this code? They are very
different, AFAICT.


> +
> +               /* reset struct and set next end of period */
> +               ca->bw_limit.sum_cwnd =3D 1;
> +
> +               /* set to 1 to avoid division by zero */
> +               ca->bw_limit.sum_acked =3D 1;

Both of these are incorrect ways to reset these fields. Sums should be
reset to 0. To avoid division by zero, check for a denominator of 0
before the division.

> +__bpf_kfunc static u32 roccettcp_recalc_ssthresh(struct sock *sk)
> +{
> +       const struct tcp_sock *tp =3D tcp_sk(sk);
> +       struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +       if (ignore_loss)
> +               return tcp_snd_cwnd(tp);

Having a module parameter to ignore loss in this way makes it too easy
for users to cause excessive congestion. I would urge you to remove
that module parameter. Researchers can add that sort of mechanism in
their own code for research.

> +
> +       /* Don't exit slow start if loss occurs. */
> +       if (tcp_in_slow_start(tp))
> +               return tcp_snd_cwnd(tp);

This comment seems incorrect. If roccettcp_recalc_ssthresh() is called
from tcp_init_cwnd_reduction() then AFAICT ssthresh will be set to
cwnd. This should cause tcp_in_slow_start()  (return tcp_snd_cwnd(tp)
< tp->snd_ssthresh) to return false. So the flow should no longer be
in slow start. So AFAICT the flow has actually exited slow start.

AFAICT what the comment means to say is something like: "When loss
occurs in slow start, exit slow start but do not decrease cwnd." Is
that what you mean to say?

If so, that sounds dangerous, by itself in isolation.

+ In general, in a loss-based algorithm like CUBIC, ignoring loss in
Slow Start is extremely dangerous. Slow Start is designed to probe
capacity exponentially; if it causes losses, it usually means it has
significantly overshot the available bandwidth.

+ By returning the current `cwnd` as the new `ssthresh`, the algorithm
will not back off properly on loss during Slow Start, potentially
causing massive congestion or severe unfairness to other flows.

Can you please add a comment explaining why you feel this
roccettcp_recalc_ssthresh() behavior is safe, and what it is trying to
achieve, at a high level?

Thanks,
neal

