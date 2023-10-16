Return-Path: <netdev+bounces-41251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0597CA58A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 12:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D84281569
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E00168C0;
	Mon, 16 Oct 2023 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBMyf8pb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0B20B21
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:36:02 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744BC5
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 03:35:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so10407a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697452555; x=1698057355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKAYPMn/8y6j0J05WVUd7e3cO5276iPo6Gh9fjjbNWQ=;
        b=wBMyf8pbXzx0AOhs3u2Wrd+HHJp0f7YUKwtHr1r5d0gj/AcgEEfwjreiy46mUl+tsT
         uoGVZX4etJn0mFvGCkWK3JL7xg/MX8FKVqr3wspYUIrXZWWr1pYp9RZ707EaiIYtWqTH
         3qTK/iJ1NjH6KenSxHSyJXnOfBPbrqgB0j6LSIedXBLoTb1WOdnWdODRas7hBcjtPgaj
         iLlxEvlXtKXSXvXNbtd9yKCGNarPmyBILTYlbhrfT/Ly2Dt6Sel+WC/4ZDmcKi2R6s/R
         kOpzRIrirAgWSbsdIqFDcnaPrnExspiIIqvbUvnjCfW4fiwVKTPWB4NhDPJZ8upP6K5a
         tolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452555; x=1698057355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKAYPMn/8y6j0J05WVUd7e3cO5276iPo6Gh9fjjbNWQ=;
        b=wqZ2iREjGd3gMsbWnlclAFtDe/hoXz298rpX/+NpNLcQ9DMfO5nKtuImVDZ4mk/Tu1
         QT2wD+zDU+fm8tv7+nRJjC1Fvx2ZW/aOx3r3hhCxhNFw9ILCD4rwOWsJpGwTDV2IVQ4d
         4buRVqd7YeHtyYTGdtJs77G08CNmkWIwiLc9qj/t0eNZahkiKcDg5E/AbhJzi9R6GjRk
         2MqNwLuPdNn5cDEGJRVfnPytKG+vBSNRxLFmf362AgpPsKfYzXrtG5iiYW1nvAk+vCEx
         VfdCoJLPJXAURMbUkViEYyVRaZhpU6bPwWIB6dVXntNdryo1XxCdbuZPwoivMRQcfYUc
         kPzQ==
X-Gm-Message-State: AOJu0YzgdXqr3cF12ZJoZA9pIyS0A8tjsVlM1m9Que6MCO/gHwwp0lgB
	HYnTTZyEK7DcLt2DbQsnN5uaTanr1YiMeYZu3Z9mVA==
X-Google-Smtp-Source: AGHT+IFsLwy0ddLS2TGyueNYicMDj3W9oqU2sWztFFYcmWSypyUOlzNwL86beDt56d4PjtB8tGll09YaAz1rNCf4GXQ=
X-Received: by 2002:aa7:c70a:0:b0:53e:e94c:2891 with SMTP id
 i10-20020aa7c70a000000b0053ee94c2891mr43477edq.3.1697452555032; Mon, 16 Oct
 2023 03:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net> <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net> <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
 <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net> <a94b00d9-8bbc-4c54-b5c9-4a7902220312@gmx.net>
 <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
In-Reply-To: <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 12:35:40 +0200
Message-ID: <CANn89iJUBujG2AOBYsr0V7qyC5WTgzx0GucO=2ES69tTDJRziw@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:49=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sun, Oct 15, 2023 at 12:23=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
> >
> > Hi,
> >
> > Am 15.10.23 um 01:26 schrieb Stefan Wahren:
> > > Hi Eric,
> > >
> > > Am 15.10.23 um 00:51 schrieb Eric Dumazet:
> > >> On Sat, Oct 14, 2023 at 9:40=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com>
> > >> wrote:
> > ...
> > >> Hmm, we receive ~3200 acks per second, I am not sure the
> > >> tcp_tso_should_defer() logic
> > >> would hurt ?
> > >>
> > >> Also the ss binary on the client seems very old, or its output has
> > >> been mangled perhaps ?
> > > this binary is from Yocto kirkstone:
> > >
> > > # ss --version
> > > ss utility, iproute2-5.17.0
> > >
> > > This shouldn't be too old. Maybe some missing kernel settings?
> > >
> > i think i was able to fix the issue by enable the proper kernel
> > settings. I rerun initial bad and good case again and overwrote the log
> > files:
> >
> > https://github.com/lategoodbye/tcp_tso_rtt_log_regress/commit/93615c94b=
a1bf36bd47cc2b91dd44a3f58c601bc
>
> Excellent, thanks.
>
> I see your kernel uses HZ=3D100, have you tried HZ=3D1000 by any chance ?
>
> CONFIG_HZ_1000=3Dy
> CONFIG_HZ=3D1000
>
> I see that the bad run seems to be stuck for a while with cwnd=3D66, but
> a smaller amount of packets in flight (26 in following ss extract)
>
> ESTAB 0 315664 192.168.1.12:60542 192.168.1.129:5001
> timer:(on,030ms,0) ino:13011 sk:2 <->
> skmem:(r0,rb131072,t48488,tb295680,f3696,w319888,o0,bl0,d0) ts sack
> cubic wscale:7,6 rto:210 rtt:3.418/1.117 mss:1448 pmtu:1500 rcvmss:536
> advmss:1448 cwnd:66 ssthresh:20 bytes_sent:43874400
> bytes_acked:43836753 segs_out:30302 segs_in:14110 data_segs_out:30300
> send 223681685bps lastsnd:10 lastrcv:4310 pacing_rate 268408200bps
> delivery_rate 46336000bps delivered:30275 busy:4310ms unacked:26
> rcv_space:14480 rcv_ssthresh:64088 notsent:278016 minrtt:0.744
>
> I wonder if fec pseudo-tso code is adding some kind of artifacts,
> maybe with TCP small queue logic.
> (TX completion might be delayed too much on fec driver side)

Speaking of TSQ, it seems an old change (commit 75eefc6c59fd "tcp:
tsq: add a shortcut in tcp_small_queue_check()")
has been accidentally removed in 2017 (75c119afe14f "tcp: implement
rb-tree based retransmit queue")

Could you try this fix:

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9c8c42c280b7638f0f4d94d68cd2c73e3c6c2bcc..e61a3a381d51b554ec8440928e2=
2a290712f0b6b
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2542,6 +2542,18 @@ static bool tcp_pacing_check(struct sock *sk)
        return true;
 }

+static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
+{
+       const struct rb_node *node =3D sk->tcp_rtx_queue.rb_node;
+
+       /* No skb in the rtx queue. */
+       if (!node)
+               return true;
+
+       /* Only one skb in rtx queue. */
+       return !node->rb_left && !node->rb_right;
+}
+
 /* TCP Small Queues :
  * Control number of packets in qdisc/devices to two packets / or ~1 ms.
  * (These limits are doubled for retransmits)
@@ -2579,12 +2591,12 @@ static bool tcp_small_queue_check(struct sock
*sk, const struct sk_buff *skb,
                limit +=3D extra_bytes;
        }
        if (refcount_read(&sk->sk_wmem_alloc) > limit) {
-               /* Always send skb if rtx queue is empty.
+               /* Always send skb if rtx queue is empty or has one skb.
                 * No need to wait for TX completion to call us back,
                 * after softirq/tasklet schedule.
                 * This helps when TX completions are delayed too much.
                 */
-               if (tcp_rtx_queue_empty(sk))
+               if (tcp_rtx_queue_empty_or_single_skb(sk))
                        return false;

                set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);

