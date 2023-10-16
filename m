Return-Path: <netdev+bounces-41238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678787CA480
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6751A1C20836
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62341CABB;
	Mon, 16 Oct 2023 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3QbdUPuD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3867B1C689
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:50:05 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A24AB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:50:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so10204a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697449802; x=1698054602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjnJw8OlCAnoosM6OkEJUyxS9OyyhM1fI6Yrf4GI46o=;
        b=3QbdUPuDO/6Vcl612tAWPNE6vksMOln4GOEZQ3lpjPoy647IC/6fxdYPyeqPP+f/ib
         baaoEopyHk7g8D9ME5rCzo2etFVHqpj07r3nTJupITjyTfJU/J05dfFlQ8ki/CL9luRQ
         cPhclZESzbVOtPhVzhj4F3y39YU/z/8o+sffbaFZPK+RcdGkIsJKoTkX02GSoPJ2hYcW
         WkzHnd/rdvdaoM61de0KAcESU1QgF5Kq2eNOQSrSIYKwxB4W4CLxF1g17LNBKXNHGFQF
         2lJ1+7VaY9Ftp9Oq4S60sdYpXrsaQ0Cy+ECfCEuRrUeG3RcIIGS3CZTGvd8A+W2HR9IW
         ZD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697449802; x=1698054602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjnJw8OlCAnoosM6OkEJUyxS9OyyhM1fI6Yrf4GI46o=;
        b=svgySgjzwKUiqZ13qvfJgTugeOpZtxgZIgXdrKQIxTXR4huUTojA+2Ya8keJttaydU
         GtlhXf8VdEYOWP8p5RBJd25ZOrIWFblCQ8RSYeqfMa1QzXrqOqxN8tZcS5pEH3tC3oBr
         Av8fa7M/PbjiwgODNE7Xg0EUl7XtEonQY55hNMHEg41ZPQX+ED3c+EaRE9730RYuHimv
         jGqjyiF7E+5UE++HhRhqYRnVkpaVxdoL0F4M3hc+4/tg9m2jXjViseZhmiY54nvE7M/a
         XIVvUcn0AH2sSBBhKeYRoV2DQ2zWjTvaD3G9WbKEDwhF1dtejafx4+/GkyOZzE9Y8Xn8
         hafQ==
X-Gm-Message-State: AOJu0YxWaQnk7S4jOqODpB37F9Zuii3TzYnyooSSzgqh0SEbo0u/18n5
	V8tYzmx2DzHsWPtB7j5NXDXNzi3dKi5uH8nmKp6JMg==
X-Google-Smtp-Source: AGHT+IGnpoWQRHQ0102CmB4Dma3FXV7uSUdqbHqiPOJXJoZIqgcbuJSh83u0mmjejd5rWngFo9XXl0Djon8VldLGyos=
X-Received: by 2002:aa7:d619:0:b0:53e:91c6:b6f5 with SMTP id
 c25-20020aa7d619000000b0053e91c6b6f5mr95573edr.4.1697449801567; Mon, 16 Oct
 2023 02:50:01 -0700 (PDT)
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
In-Reply-To: <a94b00d9-8bbc-4c54-b5c9-4a7902220312@gmx.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 11:49:47 +0200
Message-ID: <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
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

On Sun, Oct 15, 2023 at 12:23=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> w=
rote:
>
> Hi,
>
> Am 15.10.23 um 01:26 schrieb Stefan Wahren:
> > Hi Eric,
> >
> > Am 15.10.23 um 00:51 schrieb Eric Dumazet:
> >> On Sat, Oct 14, 2023 at 9:40=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com>
> >> wrote:
> ...
> >> Hmm, we receive ~3200 acks per second, I am not sure the
> >> tcp_tso_should_defer() logic
> >> would hurt ?
> >>
> >> Also the ss binary on the client seems very old, or its output has
> >> been mangled perhaps ?
> > this binary is from Yocto kirkstone:
> >
> > # ss --version
> > ss utility, iproute2-5.17.0
> >
> > This shouldn't be too old. Maybe some missing kernel settings?
> >
> i think i was able to fix the issue by enable the proper kernel
> settings. I rerun initial bad and good case again and overwrote the log
> files:
>
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/commit/93615c94ba1=
bf36bd47cc2b91dd44a3f58c601bc

Excellent, thanks.

I see your kernel uses HZ=3D100, have you tried HZ=3D1000 by any chance ?

CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000

I see that the bad run seems to be stuck for a while with cwnd=3D66, but
a smaller amount of packets in flight (26 in following ss extract)

ESTAB 0 315664 192.168.1.12:60542 192.168.1.129:5001
timer:(on,030ms,0) ino:13011 sk:2 <->
skmem:(r0,rb131072,t48488,tb295680,f3696,w319888,o0,bl0,d0) ts sack
cubic wscale:7,6 rto:210 rtt:3.418/1.117 mss:1448 pmtu:1500 rcvmss:536
advmss:1448 cwnd:66 ssthresh:20 bytes_sent:43874400
bytes_acked:43836753 segs_out:30302 segs_in:14110 data_segs_out:30300
send 223681685bps lastsnd:10 lastrcv:4310 pacing_rate 268408200bps
delivery_rate 46336000bps delivered:30275 busy:4310ms unacked:26
rcv_space:14480 rcv_ssthresh:64088 notsent:278016 minrtt:0.744

I wonder if fec pseudo-tso code is adding some kind of artifacts,
maybe with TCP small queue logic.
(TX completion might be delayed too much on fec driver side)

Can you try

ethtool -K eth0 tso off ?

Alternatively I think I mentioned earlier that you could try to reduce
gso_max_size on a 100Mbit link

ip link set dev eth0 gso_max_size 16384

(Presumably a driver could do this tuning automatically)

