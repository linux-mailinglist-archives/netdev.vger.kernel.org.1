Return-Path: <netdev+bounces-51417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70D7FA94A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE7CB20E94
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D237165;
	Mon, 27 Nov 2023 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2ZwuV9Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A46D51
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701111153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MILEvU+X3NI9nnSDtMAxlfdReHgMu/FRMncbS4soFho=;
	b=L2ZwuV9ZVtp3B6EiBNvrwvRi4uAIx9t5Zwng/UBQmiKIOfBw9610in9sxNTTvO1uEkwlBQ
	bHDZPVe3XTTtOYcd3TKQvxz3pDG/iz0MeWyS6e49mpuOWHt4Vx59GKdNWyb8DVWSYshO85
	yc7cUy5RH6ZvYIQ57+qRfKRJd6PQgWY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-DIHRlkQSNaanosW4tYl7RQ-1; Mon, 27 Nov 2023 13:52:32 -0500
X-MC-Unique: DIHRlkQSNaanosW4tYl7RQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c89230b1fdso52156171fa.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 10:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111150; x=1701715950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MILEvU+X3NI9nnSDtMAxlfdReHgMu/FRMncbS4soFho=;
        b=elw7pHtfLKHtOL+C2Y85JggQiCbxsaJfZqRJ07wOWpX/PPjfTyQqnGU68Cq35LIvCQ
         Kt3xOsZIhHAi6mS3XjxQI4NE3GTF3BB+rnifQ8SzFvvvl/fMSAwIqb/UjSK0Ph9VgPic
         0cBnlcviwU2icF7D0GWafjDXAwq3SODvkg6sYIbSKK8WOwMMZovTmzFaXKM8V1rtPUM7
         5+IJmxV79gKmfl/UNoZH8VpYK+b+S3JTHgpnvYR1O+7xs1eEtsPlJLh+GkLYG0l7nOgd
         9+l8JLYpY4/kN3qypHN5ygorx2C4ilhOgDFJNA7EsOkJ/Y6apkEOEWdAPqlr+8W/im/r
         Kegg==
X-Gm-Message-State: AOJu0Yza1Vr1lRH7VWlagl1tyb+O2sAmD3MDtB/CFN3MMYw2V2Yczyc6
	3dnqurpjE4OtaIB9GSXdEZHH1117aHoJWUZu5jaY5ZRqUwmrreN1bKcWW4sNnPQFfR4DwS36ZWc
	Sv1Nkzih+NAmViyHViGBmklDvasf11PV9
X-Received: by 2002:a19:e011:0:b0:50b:a78c:7e79 with SMTP id x17-20020a19e011000000b0050ba78c7e79mr6215042lfg.56.1701111150455;
        Mon, 27 Nov 2023 10:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcc3Ipc618ZYk8bswoU6FZ49BKXJsFo8ggo5TMXK7lmR/P3KVhgupRftzNUzI7tikygHXEmJNiJAlZiu6/FHk=
X-Received: by 2002:a19:e011:0:b0:50b:a78c:7e79 with SMTP id
 x17-20020a19e011000000b0050ba78c7e79mr6215022lfg.56.1701111150118; Mon, 27
 Nov 2023 10:52:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Nov 2023 10:52:28 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231110214618.1883611-1-victor@mojatatu.com> <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho> <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho> <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho> <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho> <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
Date: Mon, 27 Nov 2023 10:52:28 -0800
Message-ID: <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 10:50:48AM -0500, Jamal Hadi Salim wrote:
> On Thu, Nov 23, 2023 at 11:52=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >
> > Thu, Nov 23, 2023 at 05:21:51PM CET, hadi@mojatatu.com wrote:
> > >On Thu, Nov 23, 2023 at 10:17=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> > >>
> > >> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
> > >> >On Thu, Nov 23, 2023 at 9:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> > >> >>
> > >> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
> > >> >> >On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@resnull=
i.us> wrote:
> > >> >> >>
> > >> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote=
:
> > >> >> >> >This action takes advantage of the presence of tc block ports=
 set in the
> > >> >> >> >datapath and multicasts a packet to ports on a block. By defa=
ult, it will
> > >> >> >> >broadcast the packet to a block, that is send to all members =
of the block except
> > >> >> >> >the port in which the packet arrived on. However, the user ma=
y specify
> > >> >> >> >the option "tx_type all", which will send the packet to all m=
embers of the
> > >> >> >> >block indiscriminately.
> > >> >> >> >
> > >> >> >> >Example usage:
> > >> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
> > >> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
> > >> >> >> >
> > >> >> >> >Now we can add a filter to broadcast packets to ports on ingr=
ess block id 22:
> > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> > >> >> >>
> > >> >> >> Name the arg "block" so it is consistent with "filter add bloc=
k". Make
> > >> >> >> sure this is aligned netlink-wise as well.
> > >> >> >>
> > >> >> >>
> > >> >> >> >
> > >> >> >> >Or if we wish to send to all ports in the block:
> > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx=
_type all
> > >> >> >>
> > >> >> >> I read the discussion the the previous version again. I sugges=
ted this
> > >> >> >> to be part of mirred. Why exactly that was not addressed?
> > >> >> >>
> > >> >> >
> > >> >> >I am the one who pushed back (in that discussion). Actions shoul=
d be
> > >> >> >small and specific. Like i had said in that earlier discussion i=
t was
> > >> >> >a mistake to make mirred do both mirror and redirect - they shou=
ld
> > >> >>
> > >> >> For mirror and redirect, I agree. For redirect and redirect, does=
 not
> > >> >> make much sense. It's just confusing for the user.
> > >> >>
> > >> >
> > >> >Blockcast only emulates the mirror part. I agree redirect doesnt ma=
ke
> > >> >any sense because once you redirect the packet is gone.
> > >>
> > >> How is it mirror? It is redirect to multiple, isn't it?
> > >>
> > >>
> > >> >
> > >> >> >have been two actions. So i feel like adding a block to mirred i=
s
> > >> >> >adding more knobs. We are also going to add dev->group as a way =
to
> > >> >> >select what devices to mirror to. Should that be in mirred as we=
ll?
> > >> >>
> > >> >> I need more details.
> > >> >>
> > >> >
> > >> >You set any port you want to be mirrored to using ip link, example:
> > >> >ip link set dev $DEV1 group 2
> > >> >ip link set dev $DEV2 group 2
> > >>
> > >> That does not looks correct at all. Do tc stuff in tc, no?
> > >>
> > >>
> > >> >...
> > >> >
> > >> >Then you can blockcast:
> > >> >tc filter add devx protocol ip pref 25 \
> > >> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
> > >>
> > >> "blockcasting" to something that is not a block anymore. Not nice.

+1

> > >>
> > >
> > >Sorry, missed this one. Yes blockcasting is no longer appropriate  -
> > >perhaps a different action altogether.
> >
> > mirret redirect? :)
> >
> > With target of:
> > 1) dev (the current one)
> > 2) block
> > 3) group
> > ?
>
> tbh, I dont like it - but we need to make progress. I will defer to Marce=
lo.

With the addition of a new output type that I didn't foresee, that
AFAICS will use the same parameters as the block output, creating a
new action for it is a lot of boilerplate for just having a different
name. If these new two actions can share parsing code and everything,
then it's not too far for mirred also use. And if we stick to the
concept of one single action for outputting to multiple interfaces,
even just deciding on the new name became quite challenging now.
"groupcast" is misleading. "multicast" no good, "multimirred" not
intuitive, "supermirred" what? and so on..

I still think that it will become a very complex action, but well,
hopefully the man page can be updated in a way to minimize the
confusion.

Cheers,
Marcelo

>
> cheers,
> jamal
>
> >
> > >
> > >cheers,
> > >jamal
> > >> >
> > >> >cheers,
> > >> >jamal
> > >> >
> > >> >>
> > >> >> >
> > >> >> >cheers,
> > >> >> >jamal
> > >> >> >
> > >> >> >> Instead of:
> > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> > >> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> > >> >> >> You'd have:
> > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> > >> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect b=
lock 22
> > >> >> >>
> > >> >> >> I don't see why we need special action for this.
> > >> >> >>
> > >> >> >> Regarding "tx_type all":
> > >> >> >> Do you expect to have another "tx_type"? Seems to me a bit odd=
. Why not
> > >> >> >> to have this as "no_src_skip" or some other similar arg, witho=
ut value
> > >> >> >> acting as a bool (flag) on netlink level.
> > >> >> >>
> > >> >> >>
>


