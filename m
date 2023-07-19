Return-Path: <netdev+bounces-18818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F9758BDE
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9191C20C07
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ABC17D5;
	Wed, 19 Jul 2023 03:11:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96917C4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:11:03 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F2E1BEB
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:10:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso10404680e87.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689736255; x=1692328255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k+f80g/qa55jsr4rgrUqG5cZ+hARQvulA1w2u6f+TY=;
        b=syt5zfnoox2jkZB906iiJ1thQa3JEHIhax3ryYcxhaZD+zaBTb+gORx2+VjIfU5Bgb
         ni+T949gMSpI8y27ohJabLm4j1tvONtHXc5/SD2PyynEpBk8G1Kj5FSFi3yLpxKQcuVm
         oC/6gTksUZb9kVBQGOiP0HC/Vrjnj1PbaCDy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689736255; x=1692328255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k+f80g/qa55jsr4rgrUqG5cZ+hARQvulA1w2u6f+TY=;
        b=RVgK4WAHGJAyI5HlcIotwrGtE7EM5MqU/44Wpzm+XnrY7szMQ3euE1CwG6k4SSLE63
         WUXzHNaQqBLK21DHrZUEtphH2jJXscBV1pm57KaWkqRLBEUmfscn6Vt4uhRYSnhx8Tg3
         dQtK2QCTPJ8gd15Ww74DA46mNRHZpMflEyHNKiTzegeSAa1Qf/OBoWBDa63GHGrZlp/8
         BYg6hqNhDcjQaKDnhjGkzncSFwdVCW7NcPvRqMr38qViYMgzBqVhH1jyu7epcE3YONex
         A+/lS7QlcflEYsibowZKI5eIYsJUBcykvSkJLkK0AINkokAuOYBZUA7kYZWdA7LGy0OM
         oRJg==
X-Gm-Message-State: ABy/qLZtbJ3cscRA90Cdd/CbPH8dBXko6s+5dwlEAAByh17k8Kq9db/A
	KT/Lt5ogM08jwZuMF2gDrSKEOEIiIjHvvEbI8kycVw==
X-Google-Smtp-Source: APBJJlE278DqaEIRP+Q5Ui2zRIbfuE2Vm23n7ikM2rGW1R8/E/nqS8IfdDJrUakCuQYfs/Xhwi78g+rPWjlWa7vIqgc=
X-Received: by 2002:ac2:5450:0:b0:4fb:8afa:4dc9 with SMTP id
 d16-20020ac25450000000b004fb8afa4dc9mr11060241lfn.49.1689736255186; Tue, 18
 Jul 2023 20:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
 <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org> <20230718153631.7a08a6ec@kernel.org>
In-Reply-To: <20230718153631.7a08a6ec@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 18 Jul 2023 22:10:44 -0500
Message-ID: <CAO3-Pbqo_bfYsstH47hgqx7GC0CUg1H0xUaewq=MkUvb2BzCZA@mail.gmail.com>
Subject: Re: Stacks leading into skb:kfree_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Ivan Babrou <ivan@cloudflare.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 5:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Jul 2023 18:54:14 -0600 David Ahern wrote:
> > > I made some aggregations for the stacks we see leading into
> > > skb:kfree_skb endpoint. There's a lot of data that is not easily
> > > digestible, so I lightly massaged the data and added flamegraphs in
> > > addition to raw stack counts. Here's the gist link:
> > >
> > > * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290
> >
> > I see a lot of packet_rcv as the tip before kfree_skb. How many packet
> > sockets do you have running on that box? Can you accumulate the total
> > packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remaining
> > stacktrace?
>
> On a quick look we have 3 branches which can get us to kfree_skb from
> packet_rcv:
>
>         if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
>                 goto drop;
> ...
>         if (!net_eq(dev_net(dev), sock_net(sk)))
>                 goto drop;
> ...
>         res =3D run_filter(skb, sk, snaplen);
>         if (!res)
>                 goto drop_n_restore;
>
> I'd guess is the last one? Which we should mark with the SOCKET_FILTER
> drop reason?

So we have multiple packet socket consumers on our edge:
* systemd-networkd: listens on ETH_P_LLDPD, which is the role model
that does not do excessive things
* lldpd: I am not sure why we needed this one in presence of
systemd-networkd, but it is running atm, which contributes to constant
packet_rcv calls. It listens on ETH_P_ALL because of
https://github.com/lldpd/lldpd/pull/414. But its filter is doing the
correct work, so packets hitting this one is mostly "consumed"

Now the bad kids:
* arping: listens on ETH_P_ALL. This one contributes all the
skb:kfree_skb spikes, and the reason is sk_rmem_alloc overflows
rcvbuf. I suspect it is due to a poorly constructed filter so too many
packets get queued too fast.
* conduit-watcher: a health checker, sending packets on ETH_P_IP in
non-init netns. Majority of packet_rcv on this one goes to direct drop
due to netns difference.

So to conclude, it might be useful to set a reason for rcvbuf related
drops at least. On the other hand, almost all packets entered
packet_rcv are shared, so clone failure probably can also be a thing
under memory pressure.


--=20

Yan

