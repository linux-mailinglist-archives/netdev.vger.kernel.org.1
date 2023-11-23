Return-Path: <netdev+bounces-50590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70F7F63D4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90C21C20DF3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360853FB14;
	Thu, 23 Nov 2023 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PhQDfURz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6961892
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:22:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc2575dfc7so7930025ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700756523; x=1701361323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s69Rqe9k2IXTXCDhRYdNVSFp8/kOsEPt2LaCLCcgL5Q=;
        b=PhQDfURzZ/uqgjVG1XVex+MXorOjMr+MFOs4+MGmeD+tidi4oH+72s8B6UnLWjGOR/
         irOpmkj2YpU4+pGWn2K7oT1mDmHsGJhYAnBuOxw9C7Adj9+OYUDnNR40bHVwaD2b6ILQ
         8lSAP0GEpmdhoxzUksaOLa0bvilBzOuj7ODhLChEfRYxlxNLiGwNh67H7qcnPJ/qGeiZ
         633x3JiS1XcXMVBbRzy68ilMMkvw34aX1216C+5lkcdUXt08lo5cv5yftqUH9RtEqUqA
         tXems29SJ+P1DqONle6KMrhaSxgIgrlkW23oyf3cpfId2xaTW2PKQDAgI/UE66LbupwC
         3osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756523; x=1701361323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s69Rqe9k2IXTXCDhRYdNVSFp8/kOsEPt2LaCLCcgL5Q=;
        b=Pf19rBWygRWz4rjzT99WcqBGK3+ocTQTtoL3m7TfD4L7Xptm3z7ry+AnyP2qnEPsx8
         MIyVX4aUrLEvQlnU2g3S+NX3CQAX8ryRAEce2DRv2r56JyL/1n2eViKVz+6mOBWFWDgE
         AwKwwE/DqRbYpcuGbUkjfs/lvz1GDZ9br8wUeUmvhEiDcA/IPl5pX3NyH1ral4210T/6
         rPBa5RLltFOaC39d4p4geAeKDXsz59opql6GRVZuwq3R3XX/X2hr/Hiz/RSq1LcpTA81
         spvQ1hCSrRzyUpYuYGXAG/5ISTqVMsHdGSsFq5C/nbzkSIOlSaF99L29e/QNCaGG+6gJ
         yIpQ==
X-Gm-Message-State: AOJu0Yw7N5C++ZPgfxtsCxPajXFtO9QNPdORSWnYk4NdibzMYsj0ZpaS
	3gg8GO6TtT/IDQ1aNgYvyk3VVFPQyegsb6Pn88xg/Q==
X-Google-Smtp-Source: AGHT+IHEBZzdeskBGrPkl9y2lJ1E2zm58mcPoySV6X+vcwkeNqditVDfNL89ZBFxdWDGlT3vBcwA2HTgnn/PRWSsCs0=
X-Received: by 2002:a17:90b:33cf:b0:27d:166b:40f6 with SMTP id
 lk15-20020a17090b33cf00b0027d166b40f6mr6079888pjb.41.1700756522841; Thu, 23
 Nov 2023 08:22:02 -0800 (PST)
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
Date: Thu, 23 Nov 2023 11:21:51 -0500
Message-ID: <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
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
>
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
>
> >...
> >
> >Then you can blockcast:
> >tc filter add devx protocol ip pref 25 \
> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
>
> "blockcasting" to something that is not a block anymore. Not nice.
>

Sorry, missed this one. Yes blockcasting is no longer appropriate  -
perhaps a different action altogether.

cheers,
jamal
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

