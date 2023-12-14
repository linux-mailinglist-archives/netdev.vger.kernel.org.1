Return-Path: <netdev+bounces-57258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC76812A8D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2066C1F21835
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290C225DB;
	Thu, 14 Dec 2023 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGfCebId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283610F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:40:25 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso6126a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543223; x=1703148023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBIs2p5i0dC78gln62RZo6Q5p05h8YSs+k5M+Yr+nyQ=;
        b=oGfCebId+PLQz5GoJZ2Q7SWjHXPttK4tYgyOJMrUvF2p25V0sAxMfJ2xsFqs8RvPmO
         1Itowy8wqF79gQ19Det+4XZXrPNIbrYRioCrOXlpDqX1i/z1AbDN39Bm4FDrdJVmYIfS
         QAk3gj/+y8LxSFdM2WFdkF2fKCCoUgWuKo13kyUgHUkUSfguMYEydNT7n0AgGYm+Pl5R
         hrQukMmU/38wW+khuDcWVOXuJNoTuKF70RVIxL/UTBIeOHZ/YrbIIHoG7ejYEHQFYUfG
         5hQHZ25vOmQz0vR7Tzp4Gk74EmT/OqnG8hrtADORrXEn4x9IoHs+fNvPuIyWTGYf1rN9
         ln3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543223; x=1703148023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBIs2p5i0dC78gln62RZo6Q5p05h8YSs+k5M+Yr+nyQ=;
        b=nmN/Xc9FddAQe+fS+rpm4tcTMxMCgi9Wc9jXkRCsiTmJipb5O771pS6mVbZ6VQxb7N
         SIzBWGfmFcgmMPVT3Ve648cI0ZTHhX1fnVg2C21NQbk1w4Vk19STBOCcxyXiz9pC2+uT
         rMEeUMO1q0jTt8iLTbB6pmY4LES5z3zRy5OpGSeZAUygV6ekpijcto+vMcoGkBWYorGO
         oktaRnQh2cuCRTwrRkFiGEvwIcAPmSNTNVq6/6Q/pgZZLZmUgDG/7tbPEOJjwtXtA7Tu
         wSkw/Uk+4eU6KTquXsT55cwPU3DK8k63M+Nf27ZexGXRPpk2V9nY9S6FnnAkCM9Lg8pq
         UYVA==
X-Gm-Message-State: AOJu0YxwmGjg2/2eApSr6YN6oi4xwju1uWA0UgRKKV2pRL8owgJDANOd
	C0DYVCfHmvMBTnsneofEEh1lH4AD+YR+LNDFSmGlgA==
X-Google-Smtp-Source: AGHT+IGxJQlIU2kgpKW5uy/8NArSZeLw8QAZgNLOVOAGjrMJh2LeW1rzdcW5LoBTEwyxUgF8hLmtjspDfAyeL39QA60=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr603334edj.0.1702543223088; Thu, 14 Dec
 2023 00:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
 <20231213213006.89142-1-dipiets@amazon.com>
In-Reply-To: <20231213213006.89142-1-dipiets@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 09:40:09 +0100
Message-ID: <CANn89iJRHuFgPrsezhm2DuAw7JmLL2ZkPhZaf2Ymuq+STUm-8w@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: alisaidi@amazon.com, benh@amazon.com, blakgeof@amazon.com, 
	davem@davemloft.net, dipietro.salvatore@gmail.com, dsahern@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:30=E2=80=AFPM Salvatore Dipietro <dipiets@amazon=
.com> wrote:
>
> > It looks like the above disables autocorking even after the userspace
> > sets TCP_CORK. Am I reading it correctly? Is that expected?
>
> I have tested a new version of the patch which can target only TCP_NODELA=
Y.
> Results using previous benchmark are identical. I will submit it in a new
> patch version.

Well, I do not think we will accept a patch there, because you
basically are working around the root cause
for a certain variety of workloads.

Issue would still be there for applications not using TCP_NODELAY

>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -716,7 +716,8 @@
>
>         tcp_mark_urg(tp, flags);
>
> -       if (tcp_should_autocork(sk, skb, size_goal)) {
> +       if (!(nonagle & TCP_NAGLE_OFF) &&
> +           tcp_should_autocork(sk, skb, size_goal)) {
>
>                 /* avoid atomic op if TSQ_THROTTLED bit is already set */
>                 if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
>
>
>
> > Also I wonder about these 40ms delays, TCP small queue handler should
> > kick when the prior skb is TX completed.
> >
> > It seems the issue is on the driver side ?
> >
> > Salvatore, which driver are you using ?
>
> I am using ENA driver.
>
> Eric can you please clarify where do you think the problem is?

The problem is that TSQ logic is not working properly, probably
because the driver
holds a packet that has been sent.

TX completion seems to be delayed until the next transmit happens on
the transmit queue.

I suspect some kind of missed interrupt or a race.

virtio_net is known to have a similar issue (not sure if this has been
fixed lately)

ena_io_poll() and ena_intr_msix_io() logic, playing with
ena_napi->interrupts_masked seem
convoluted/risky to me.

ena_start_xmit() also seems to have bugs vs xmit_more logic, but this
is orthogonal.

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c44c44e26ddfe74a93b7f1fb3c3ca90f978909e2..5282e718699ba9e64765bea2435=
e1c5a55aaa89b
100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3235,6 +3235,8 @@ static netdev_tx_t ena_start_xmit(struct sk_buff
*skb, struct net_device *dev)

 error_drop_packet:
        dev_kfree_skb(skb);
+       /* Make sure to ring the doorbell. */
+       ena_ring_tx_doorbell(tx_ring);
        return NETDEV_TX_OK;
 }

