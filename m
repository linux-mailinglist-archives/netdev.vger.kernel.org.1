Return-Path: <netdev+bounces-57270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E877812B16
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF971C21509
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C8725778;
	Thu, 14 Dec 2023 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoLj47Fg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08118A6
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:05:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso32155e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702544733; x=1703149533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K35UrsFmjEA54HLqYbO2yO0GuIFDpPBfbQdk4CaAnY=;
        b=PoLj47FgbB1H4s4qXwcGWYkPUM7gOslBVMk1xBT79PSQIiUnwTAYfcyUeR2+87da7D
         NicWmuejwxJgS0xH6N1WhMkul6JkQXYuYa6wJDJ/j6otF21WSda98w6xk2f28I+2CQ7X
         daEOxJIqiKfkzofqnxWwRvSbMf4Q0+WObuBPdh5flVBmVDeTY9+IV77Qq5bsh2phSVD8
         vDzud57gESlI//NUQXRsTKsLUwhmTZ+egrzDAOEgVfUzZAiIVEFS2k7OPwDiJr3zS7Rn
         KlNeXQlA7kHpTTW/7oRia6UXzrLabit7q8m6Fd/tWOCZvQNvaZV6mxuC/9KD4JcKKgOu
         Qr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544733; x=1703149533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K35UrsFmjEA54HLqYbO2yO0GuIFDpPBfbQdk4CaAnY=;
        b=ug73gUKQFFuBKeEBVhf0SSQ3R8kpYX7CNf8Bvoev8o0tZ33ln8waXPSRGS7I3ORAqp
         5U3LWmaaq7YV1HvO/A+gM0p7QM+aTyZpdcWz2ka8vEpc0JuGOTSj15wK0+h85DozhGwq
         aycHMwGvM7klm4+S1f/Cw1zb26cjaRddzbWJfsLAyiD1eaBGigWRUrUBeCVDUnWSEGyB
         T0rU9zoOnOTXxvG2tvtdJUGZVO77W8f0NyBCLQvfXp1lC8/t4l0/5CRDsPSMwbg9vGiJ
         ywk97r4ky7SyxEcLTqoje27HngC0oLQU++1T6pb/FTEnOuJu1Wamjxqenp6DreosvyWj
         Lgew==
X-Gm-Message-State: AOJu0YykuRtS8B7LOM0/Sr/KfIlBPQ2pyO81CtfcrzS2nNFYbcAO7eG5
	4DEh8RMoCeA8gfey59umk8TVsPphgPvdJX6lAHJb9g==
X-Google-Smtp-Source: AGHT+IHMoy6IDB7NcAFU7j963tbE/ygtg/DIhCD5p1cdhHewXBGOJtfir3YpjvFPaWj1V7LP1qsL+k9ZlxxqmAxVbd0=
X-Received: by 2002:a05:600c:600a:b0:40a:483f:f828 with SMTP id
 az10-20020a05600c600a00b0040a483ff828mr509961wmb.4.1702544733157; Thu, 14 Dec
 2023 01:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
 <20231213213006.89142-1-dipiets@amazon.com> <CANn89iJRHuFgPrsezhm2DuAw7JmLL2ZkPhZaf2Ymuq+STUm-8w@mail.gmail.com>
In-Reply-To: <CANn89iJRHuFgPrsezhm2DuAw7JmLL2ZkPhZaf2Ymuq+STUm-8w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 10:05:19 +0100
Message-ID: <CANn89iLJOi+qempjx0AtWWtbX94nd4Hi9zRyFsdgmcKiq==N7Q@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: alisaidi@amazon.com, benh@amazon.com, blakgeof@amazon.com, 
	davem@davemloft.net, dipietro.salvatore@gmail.com, dsahern@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Dec 13, 2023 at 10:30=E2=80=AFPM Salvatore Dipietro <dipiets@amaz=
on.com> wrote:
> >
> > > It looks like the above disables autocorking even after the userspace
> > > sets TCP_CORK. Am I reading it correctly? Is that expected?
> >
> > I have tested a new version of the patch which can target only TCP_NODE=
LAY.
> > Results using previous benchmark are identical. I will submit it in a n=
ew
> > patch version.
>
> Well, I do not think we will accept a patch there, because you
> basically are working around the root cause
> for a certain variety of workloads.
>
> Issue would still be there for applications not using TCP_NODELAY
>
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -716,7 +716,8 @@
> >
> >         tcp_mark_urg(tp, flags);
> >
> > -       if (tcp_should_autocork(sk, skb, size_goal)) {
> > +       if (!(nonagle & TCP_NAGLE_OFF) &&
> > +           tcp_should_autocork(sk, skb, size_goal)) {
> >
> >                 /* avoid atomic op if TSQ_THROTTLED bit is already set =
*/
> >                 if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
> >
> >
> >
> > > Also I wonder about these 40ms delays, TCP small queue handler should
> > > kick when the prior skb is TX completed.
> > >
> > > It seems the issue is on the driver side ?
> > >
> > > Salvatore, which driver are you using ?
> >
> > I am using ENA driver.
> >
> > Eric can you please clarify where do you think the problem is?
>
> The problem is that TSQ logic is not working properly, probably
> because the driver
> holds a packet that has been sent.
>
> TX completion seems to be delayed until the next transmit happens on
> the transmit queue.
>
> I suspect some kind of missed interrupt or a race.
>
> virtio_net is known to have a similar issue (not sure if this has been
> fixed lately)
>
> ena_io_poll() and ena_intr_msix_io() logic, playing with
> ena_napi->interrupts_masked seem
> convoluted/risky to me.
>
> ena_start_xmit() also seems to have bugs vs xmit_more logic, but this
> is orthogonal.
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index c44c44e26ddfe74a93b7f1fb3c3ca90f978909e2..5282e718699ba9e64765bea24=
35e1c5a55aaa89b
> 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -3235,6 +3235,8 @@ static netdev_tx_t ena_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>
>  error_drop_packet:
>         dev_kfree_skb(skb);
> +       /* Make sure to ring the doorbell. */
> +       ena_ring_tx_doorbell(tx_ring);
>         return NETDEV_TX_OK;
>  }

ena_io_poll() has a race against
u64_stats_update_begin(&tx_ring->syncp);/u64_stats_update_end(&tx_ring->syn=
cp);

This should be done by this thread, while it still owns the NAPI SCHED bit.

Doing anything that might be racy after napi_complete_done() is a bug.
In this case, this could brick foreverer ena_get_stats64().

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c44c44e26ddfe74a93b7f1fb3c3ca90f978909e2..e3464adfd0b791af621c92a6511=
25ced2ad2de8a
100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2017,7 +2017,6 @@ static int ena_io_poll(struct napi_struct *napi,
int budget)
        int tx_work_done;
        int rx_work_done =3D 0;
        int tx_budget;
-       int napi_comp_call =3D 0;
        int ret;

        tx_ring =3D ena_napi->tx_ring;
@@ -2038,6 +2037,11 @@ static int ena_io_poll(struct napi_struct
*napi, int budget)
        if (likely(budget))
                rx_work_done =3D ena_clean_rx_irq(rx_ring, napi, budget);

+       u64_stats_update_begin(&tx_ring->syncp);
+       tx_ring->tx_stats.tx_poll++;
+       u64_stats_update_end(&tx_ring->syncp);
+       WRITE_ONCE(tx_ring->tx_stats.last_napi_jiffies, jiffies);
+
        /* If the device is about to reset or down, avoid unmask
         * the interrupt and return 0 so NAPI won't reschedule
         */
@@ -2047,7 +2051,9 @@ static int ena_io_poll(struct napi_struct *napi,
int budget)
                ret =3D 0;

        } else if ((budget > rx_work_done) && (tx_budget > tx_work_done)) {
-               napi_comp_call =3D 1;
+               u64_stats_update_begin(&tx_ring->syncp);
+               tx_ring->tx_stats.napi_comp++;
+               u64_stats_update_end(&tx_ring->syncp);

                /* Update numa and unmask the interrupt only when schedule
                 * from the interrupt context (vs from sk_busy_loop)
@@ -2071,13 +2077,6 @@ static int ena_io_poll(struct napi_struct
*napi, int budget)
                ret =3D budget;
        }

-       u64_stats_update_begin(&tx_ring->syncp);
-       tx_ring->tx_stats.napi_comp +=3D napi_comp_call;
-       tx_ring->tx_stats.tx_poll++;
-       u64_stats_update_end(&tx_ring->syncp);
-
-       tx_ring->tx_stats.last_napi_jiffies =3D jiffies;
-
        return ret;
 }

@@ -3235,6 +3234,8 @@ static netdev_tx_t ena_start_xmit(struct sk_buff
*skb, struct net_device *dev)

 error_drop_packet:
        dev_kfree_skb(skb);
+       /* Make sure to ring the doorbell. */
+       ena_ring_tx_doorbell(tx_ring);
        return NETDEV_TX_OK;
 }

