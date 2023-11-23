Return-Path: <netdev+bounces-50588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B77F63D0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140A9B20EA0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED23C088;
	Thu, 23 Nov 2023 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ur08NYuD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C8E1A4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:20:39 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so1037041b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700756438; x=1701361238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2KoRo0/XYXAleMHfOZ9agr7EvwhTuJ4lu6/uOU5obU=;
        b=ur08NYuDozCV4RY/zBTr4EGfKYR4awFwXCZOavw0uA238qfwk4Quy+4po9pWbSRIsI
         eoC1H9B/NHKnIhFq1g5yglDJqE0CjODm07/Ayh/6ZmL0CyxHFyd96LDRvF2hBMiJSaxI
         7FETE1xEvFm8LYKtIe3Cc7COjK6tLUOcP8BYKO+Zq7lm1lXK5UR/jn4+mQReSoOlmTWu
         8yaDayLgsB7iwEwLUNVr3bNo2fACXGpUOTDK8LDtX12E2aVwySHmjyMtriDwqFxfOUkX
         BRYFS4r5EwUhzOW2//TWurek28sfpW3GyV2w3rdfoF+mR8gkKmApvGYzzwQ4rn7/ESV/
         qG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756438; x=1701361238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2KoRo0/XYXAleMHfOZ9agr7EvwhTuJ4lu6/uOU5obU=;
        b=E6avfV9B31yXWAh18y9Pakv0JGGoa3PM1bkU1WuaCkq317s29ieY9FmImR0eus6AvL
         LFXNK9Sk8C+6YkJzV/m253vKAsNKUKGWwD/wH+puIm4YaonDhidMkzZBclNPqhBpJGZW
         iUiWT5EmrXTzS3rLiNVDB62jleHrE4353+O5ekO/JOCC21IL+kMp1ErAMQ7Y5OEuSWur
         miidMFiM7+u7h5hNeh0+ofcBRvD01a8k8OEd8uz0wwJDIeMakMVifRYqFrMYXWv6L/1e
         NyombjARycTkzkHiS2rbBRHIxVBBV/cbdpQzOK5vLEbhBKyenzCayVlqzCTpi0qrrzvt
         j8Tw==
X-Gm-Message-State: AOJu0YwBLVIRDQZnWbkZrPgIq/9Ce1NS0YTJ0THo7zboufBU2jKGMvxV
	CxNSXXZZnThBhAvtRP8fjvZ2WdC7DOQALUMuW+q2lw==
X-Google-Smtp-Source: AGHT+IETENxH7cDDcip7ziq+BWrmoWNCx+vdekD2xENmR1y8xU0nhjFdFYk98pomhb4mFW9UqxAwOG7wbUH6GWw2tG8=
X-Received: by 2002:a17:90b:3e83:b0:280:c4be:3c8e with SMTP id
 rj3-20020a17090b3e8300b00280c4be3c8emr5853371pjb.48.1700756438374; Thu, 23
 Nov 2023 08:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110214618.1883611-1-victor@mojatatu.com> <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho> <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho> <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho>
In-Reply-To: <ZV9tCT9d7dm7dOeA@nanopsycho>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Thu, 23 Nov 2023 11:20:27 -0500
Message-ID: <CAAFAkD8G+m6foAjyc==njMw6zzCyRcQKwWaPnhnudVcWBGP0HQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com, 
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 10:17=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
> >On Thu, Nov 23, 2023 at 9:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
> >> >On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >> >>
> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
> >> >> >This action takes advantage of the presence of tc block ports set =
in the
> >> >> >datapath and multicasts a packet to ports on a block. By default, =
it will
> >> >> >broadcast the packet to a block, that is send to all members of th=
e block except
> >> >> >the port in which the packet arrived on. However, the user may spe=
cify
> >> >> >the option "tx_type all", which will send the packet to all member=
s of the
> >> >> >block indiscriminately.
> >> >> >
> >> >> >Example usage:
> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
> >> >> >
> >> >> >Now we can add a filter to broadcast packets to ports on ingress b=
lock id 22:
> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> >> >>
> >> >> Name the arg "block" so it is consistent with "filter add block". M=
ake
> >> >> sure this is aligned netlink-wise as well.
> >> >>
> >> >>
> >> >> >
> >> >> >Or if we wish to send to all ports in the block:
> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type=
 all
> >> >>
> >> >> I read the discussion the the previous version again. I suggested t=
his
> >> >> to be part of mirred. Why exactly that was not addressed?
> >> >>
> >> >
> >> >I am the one who pushed back (in that discussion). Actions should be
> >> >small and specific. Like i had said in that earlier discussion it was
> >> >a mistake to make mirred do both mirror and redirect - they should
> >>
> >> For mirror and redirect, I agree. For redirect and redirect, does not
> >> make much sense. It's just confusing for the user.
> >>
> >
> >Blockcast only emulates the mirror part. I agree redirect doesnt make
> >any sense because once you redirect the packet is gone.
>
> How is it mirror? It is redirect to multiple, isn't it?

mirror has been used (so far in mirred action and i believe in the
industry in general) to mean  "send a copy of the packet" - meaning
you can send to many ports and even when you are done sending to all
those ports the packet is still in the pipeline and you can continue
to execute other action on it. Whereas redirect means the packet is
stolen from the pipeline i.e if you redirect to a port the packet is
not available to redirect to the next port or for any other action
after that.
You could argue a loose interpretation of redirect to a block to mean
"mirror to all ports on the block but on the last port redirect".

>
> >
> >> >have been two actions. So i feel like adding a block to mirred is
> >> >adding more knobs. We are also going to add dev->group as a way to
> >> >select what devices to mirror to. Should that be in mirred as well?
> >>
> >> I need more details.
> >>
> >
> >You set any port you want to be mirrored to using ip link, example:
> >ip link set dev $DEV1 group 2
> >ip link set dev $DEV2 group 2
>
> That does not looks correct at all. Do tc stuff in tc, no?
>

We could certainly annotate the dev group via tc but it seems odd ....

cheers,
jamal
>
> >...
> >
> >Then you can blockcast:
> >tc filter add devx protocol ip pref 25 \
> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
>
> "blockcasting" to something that is not a block anymore. Not nice.
>
> >
> >cheers,
> >jamal
> >
> >>
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >> Instead of:
> >> >> $ tc filter add block 22 protocol ip pref 25 \
> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> >> >> You'd have:
> >> >> $ tc filter add block 22 protocol ip pref 25 \
> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block =
22
> >> >>
> >> >> I don't see why we need special action for this.
> >> >>
> >> >> Regarding "tx_type all":
> >> >> Do you expect to have another "tx_type"? Seems to me a bit odd. Why=
 not
> >> >> to have this as "no_src_skip" or some other similar arg, without va=
lue
> >> >> acting as a bool (flag) on netlink level.
> >> >>
> >> >>

