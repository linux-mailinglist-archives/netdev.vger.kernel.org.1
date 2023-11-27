Return-Path: <netdev+bounces-51362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBDA7FA52C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EC628172F
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F934574;
	Mon, 27 Nov 2023 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WZFB1cPL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C692
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:51:00 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cce5075bd6so33601427b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701100259; x=1701705059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PLnRqse7dzqzCguN/k5o/fz5BK+XAqrgIVG7fZEaGU=;
        b=WZFB1cPLuGSvKCuzYVU9BlMN82WgdzdOEV1GBFqrTthomsmYT/63ajBSKyBLlm92Fm
         hMCQO4Qc6mxrsHl7uhLJ2KWM5Q1Gaz0EHJnytTPVYCgMhS8v77FX0oblS1luXQ3PwLmV
         KXeUMLbzlD8d205Bv1pX8dgVXpS2IuzLpRYRd22zyJIp8C14khSg26eQQxnObX2qC/jz
         4sWPWzGN3TagZwxsGA9QyOM+cOkseOYCXjc+e6etrMv/cZYjEQ23IhwvJfmHEgLTkMyF
         Oo2XOGVAGNzxnOQ/nXVaH2hi48dCqRSgfeVspP/bZe0+xqb/TfTKeUwoFhORUgt0dDwp
         ISMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100259; x=1701705059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PLnRqse7dzqzCguN/k5o/fz5BK+XAqrgIVG7fZEaGU=;
        b=pft86uAbu/ojhUtecbe8w/WR55ZrgIXx7uDQwTGXX2nlTZqfrSk9I1ORVIq6iNBAWv
         CEQyZbkrsPpPougXCGfH13eexSHpKDqQj4+KJwJn7KXwS4jSiNKIya6E4fkb2XV1S6DF
         RlQWEipdn9Gj8HCoqkcx4F9CKBr096yHyXdA+z9S4k5F2VvgDliw9fp/p6JzG2FwpBw7
         jqy73rMrN+vmx5y1KBWG9Ra9ZfUgyspbAe4c8Vs3aUfQfK9mvcrlv1ewcnjID0mEfxYv
         9HwWZ5RBA1Zfxc4OXSyd1CIXk7qKohverElgLyYl4gmOxJSFIhk1/S0AyIpK7PGHC+BT
         xhag==
X-Gm-Message-State: AOJu0Ywvc9l1GYPLtlmX2OR8+tn87TmP/zoSSf5vz7XZWC8ugWljY/zh
	E5sgC4ZnQ4MoVKu6E9MCsfNk236Ptq9D03gHok75Ng==
X-Google-Smtp-Source: AGHT+IGGT5NAb2toST4nDzXpKd2CchRkmeeOQKxZ67M9uKaBVk5gEDmacUTMGGmF97mX5UkUCq1zlGiTdHlVwmYHXss=
X-Received: by 2002:a0d:cc06:0:b0:5cb:79:ef12 with SMTP id o6-20020a0dcc06000000b005cb0079ef12mr13009532ywd.0.1701100259462;
 Mon, 27 Nov 2023 07:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110214618.1883611-1-victor@mojatatu.com> <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho> <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho> <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho> <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho>
In-Reply-To: <ZV+DPmXrANEh6gF8@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 27 Nov 2023 10:50:48 -0500
Message-ID: <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com, 
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 11:52=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Nov 23, 2023 at 05:21:51PM CET, hadi@mojatatu.com wrote:
> >On Thu, Nov 23, 2023 at 10:17=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
> >> >On Thu, Nov 23, 2023 at 9:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >> >>
> >> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
> >> >> >On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.=
us> wrote:
> >> >> >>
> >> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
> >> >> >> >This action takes advantage of the presence of tc block ports s=
et in the
> >> >> >> >datapath and multicasts a packet to ports on a block. By defaul=
t, it will
> >> >> >> >broadcast the packet to a block, that is send to all members of=
 the block except
> >> >> >> >the port in which the packet arrived on. However, the user may =
specify
> >> >> >> >the option "tx_type all", which will send the packet to all mem=
bers of the
> >> >> >> >block indiscriminately.
> >> >> >> >
> >> >> >> >Example usage:
> >> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
> >> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
> >> >> >> >
> >> >> >> >Now we can add a filter to broadcast packets to ports on ingres=
s block id 22:
> >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> >> >> >>
> >> >> >> Name the arg "block" so it is consistent with "filter add block"=
. Make
> >> >> >> sure this is aligned netlink-wise as well.
> >> >> >>
> >> >> >>
> >> >> >> >
> >> >> >> >Or if we wish to send to all ports in the block:
> >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_t=
ype all
> >> >> >>
> >> >> >> I read the discussion the the previous version again. I suggeste=
d this
> >> >> >> to be part of mirred. Why exactly that was not addressed?
> >> >> >>
> >> >> >
> >> >> >I am the one who pushed back (in that discussion). Actions should =
be
> >> >> >small and specific. Like i had said in that earlier discussion it =
was
> >> >> >a mistake to make mirred do both mirror and redirect - they should
> >> >>
> >> >> For mirror and redirect, I agree. For redirect and redirect, does n=
ot
> >> >> make much sense. It's just confusing for the user.
> >> >>
> >> >
> >> >Blockcast only emulates the mirror part. I agree redirect doesnt make
> >> >any sense because once you redirect the packet is gone.
> >>
> >> How is it mirror? It is redirect to multiple, isn't it?
> >>
> >>
> >> >
> >> >> >have been two actions. So i feel like adding a block to mirred is
> >> >> >adding more knobs. We are also going to add dev->group as a way to
> >> >> >select what devices to mirror to. Should that be in mirred as well=
?
> >> >>
> >> >> I need more details.
> >> >>
> >> >
> >> >You set any port you want to be mirrored to using ip link, example:
> >> >ip link set dev $DEV1 group 2
> >> >ip link set dev $DEV2 group 2
> >>
> >> That does not looks correct at all. Do tc stuff in tc, no?
> >>
> >>
> >> >...
> >> >
> >> >Then you can blockcast:
> >> >tc filter add devx protocol ip pref 25 \
> >> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
> >>
> >> "blockcasting" to something that is not a block anymore. Not nice.
> >>
> >
> >Sorry, missed this one. Yes blockcasting is no longer appropriate  -
> >perhaps a different action altogether.
>
> mirret redirect? :)
>
> With target of:
> 1) dev (the current one)
> 2) block
> 3) group
> ?

tbh, I dont like it - but we need to make progress. I will defer to Marcelo=
.

cheers,
jamal

>
> >
> >cheers,
> >jamal
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >>
> >> >> >
> >> >> >cheers,
> >> >> >jamal
> >> >> >
> >> >> >> Instead of:
> >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> >> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> >> >> >> You'd have:
> >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> >> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect blo=
ck 22
> >> >> >>
> >> >> >> I don't see why we need special action for this.
> >> >> >>
> >> >> >> Regarding "tx_type all":
> >> >> >> Do you expect to have another "tx_type"? Seems to me a bit odd. =
Why not
> >> >> >> to have this as "no_src_skip" or some other similar arg, without=
 value
> >> >> >> acting as a bool (flag) on netlink level.
> >> >> >>
> >> >> >>

