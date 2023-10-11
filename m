Return-Path: <netdev+bounces-40192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13607C6151
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9E51C209D2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162602B76C;
	Wed, 11 Oct 2023 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkqoYLUO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D9125CD
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:58:33 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E090
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:58:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so292511b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697068711; x=1697673511; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hRg8ZxkIUjT2EK7oL396Hp1NZsMoASIUGsLJZmTPGk=;
        b=TkqoYLUOS8ioDW05+hafUXfkjrt9xatXZk0/fNyX8MNJ44mrOZuGR1j+AOpuqprdxn
         ydz9ejBAwYGbwox1dUuRTPblfUXAz+xx/I55R9zeP23Ps9PW4gKpodcImO4H/WI0agwv
         NhfKTNSB6uq5iOiaph8eO8l74j4wSPEPkYLhHyFlwk4eX52bW6XOtPnbI9wGExcTzVT4
         3RY/YQtRMEYItBhGUU+gTEQ8FsIs902c04+DRU93LmyLwK25pOiAYVDO/O58MrPmj7+/
         GODkmEorcczIdbYm0pU40AxphZ8F1gfsNj8CVvgzRPnjBJbKuJ5YVCr+ogavuxNKKOB0
         63HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697068711; x=1697673511;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/hRg8ZxkIUjT2EK7oL396Hp1NZsMoASIUGsLJZmTPGk=;
        b=YE3gmrS8K+WIua0tNTL2qPTv49VT/ga+mcI5EBX9+7TiP5NxiAtr6Lepqc+GJj28e6
         lK1S+1cLQbUg+wlnZLZtI2Yxcw+IHroxpcdLVyAulS3vRWShc1AbXmPs9vTQVjujaFmi
         biNBdwqRJ1gu4Xa2gvBd9JyVGQHbZ8+4x2RPTwixA2XpMzDO3ofLbOM43FC8Wm/uHrIY
         HyswJt6p8zW8rcc2yXiCy7G1Rg8Fn8UoNDU3NctDpfmKGoDf8jO1jgPWnqDGi+vIJOHn
         fcZWCtpsL3Oh7ogu5nfQxzwzJnAh5cosH9pZJTsnUwV2UjWSibr45RWXINwuChCnc16+
         l5Kw==
X-Gm-Message-State: AOJu0YwAWz9wcgME20k6UvfL0QtHyByYc0pOckxPHD303GYXmTcXEGIe
	+mVAhcAGnpP7v8rdXXNDlCFWd4LW3Z8=
X-Google-Smtp-Source: AGHT+IFMhSUB3DaDhVpUqrto/9+xVWLL8NCblDVLKSApRq95P+e+ZuYb7CuuERGYUe7MQK6zB2z0rA==
X-Received: by 2002:a05:6a20:258e:b0:159:c24f:5fa4 with SMTP id k14-20020a056a20258e00b00159c24f5fa4mr23187384pzd.1.1697068711200;
        Wed, 11 Oct 2023 16:58:31 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
        by smtp.gmail.com with ESMTPSA id nr20-20020a17090b241400b0027d1366d113sm495364pjb.43.2023.10.11.16.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 16:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Oct 2023 09:58:26 +1000
Message-Id: <CW60NCQQA5FA.2PHGGAH6ED7UH@wheely>
Cc: "Eelco Chaudron" <echaudro@redhat.com>, <netdev@vger.kernel.org>,
 <dev@openvswitch.org>, "Ilya Maximets" <imaximet@redhat.com>, "Flavio
 Leitner" <fbl@redhat.com>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aaron Conole" <aconole@redhat.com>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <20230927001308.749910-5-npiggin@gmail.com> <f7tfs2ymi8y.fsf@redhat.com>
 <CVV7HCQYCVOP.2JVVJCKU57CAW@wheely>
 <34747C51-2F94-4B64-959B-BA4B0AA4224B@redhat.com>
 <CW04VKYCMTJE.ZX0TQ1Y6H6VB@wheely> <f7ty1g9cmf6.fsf@redhat.com>
In-Reply-To: <f7ty1g9cmf6.fsf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Oct 11, 2023 at 11:34 PM AEST, Aaron Conole wrote:
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
> > On Fri Sep 29, 2023 at 6:38 PM AEST, Eelco Chaudron wrote:
> >>
> >>
> >> On 29 Sep 2023, at 9:00, Nicholas Piggin wrote:
> >>
> >> > On Fri Sep 29, 2023 at 1:26 AM AEST, Aaron Conole wrote:
> >> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >> >>
> >> >>> Dynamically allocating the sw_flow_key reduces stack usage of
> >> >>> ovs_vport_receive from 544 bytes to 64 bytes at the cost of
> >> >>> another GFP_ATOMIC allocation in the receive path.
> >> >>>
> >> >>> XXX: is this a problem with memory reserves if ovs is in a
> >> >>> memory reclaim path, or since we have a skb allocated, is it
> >> >>> okay to use some GFP_ATOMIC reserves?
> >> >>>
> >> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> >>> ---
> >> >>
> >> >> This represents a fairly large performance hit.  Just my own quick
> >> >> testing on a system using two netns, iperf3, and simple forwarding =
rules
> >> >> shows between 2.5% and 4% performance reduction on x86-64.  Note th=
at it
> >> >> is a simple case, and doesn't involve a more involved scenario like
> >> >> multiple bridges, tunnels, and internal ports.  I suspect such case=
s
> >> >> will see even bigger hit.
> >> >>
> >> >> I don't know the impact of the other changes, but just an FYI that =
the
> >> >> performance impact of this change is extremely noticeable on x86
> >> >> platform.
> >> >
> >> > Thanks for the numbers. This patch is probably the biggest perf cost=
,
> >> > but unfortunately it's also about the biggest saving. I might have a=
n
> >> > idea to improve it.
> >>
> >> Also, were you able to figure out why we do not see this problem on
> >> x86 and arm64? Is the stack usage so much larger, or is there some
> >> other root cause? Is there a simple replicator, as this might help
> >> you profile the differences between the architectures?
> >
> > I found some snippets of equivalent call chain (this is for 4.18 RHEL8
> > kernels, but it's just to give a general idea of stack overhead
> > differences in C code). Frame size annotated on the right hand side:
> >
> > [c0000007ffdba980] do_execute_actions     496
> > [c0000007ffdbab70] ovs_execute_actions    128
> > [c0000007ffdbabf0] ovs_dp_process_packet  208
> > [c0000007ffdbacc0] clone_execute          176
> > [c0000007ffdbad70] do_execute_actions     496
> > [c0000007ffdbaf60] ovs_execute_actions    128
> > [c0000007ffdbafe0] ovs_dp_process_packet  208
> > [c0000007ffdbb0b0] ovs_vport_receive      528
> > [c0000007ffdbb2c0] internal_dev_xmit
> >                                  total =3D 2368
> > [ff49b6d4065a3628] do_execute_actions     416
> > [ff49b6d4065a37c8] ovs_execute_actions     48
> > [ff49b6d4065a37f8] ovs_dp_process_packet  112
> > [ff49b6d4065a3868] clone_execute           64
> > [ff49b6d4065a38a8] do_execute_actions     416
> > [ff49b6d4065a3a48] ovs_execute_actions     48
> > [ff49b6d4065a3a78] ovs_dp_process_packet  112
> > [ff49b6d4065a3ae8] ovs_vport_receive      496
> > [ff49b6d4065a3cd8] netdev_frame_hook
> >                                  total =3D 1712
> >
> > That's more significant than I thought, nearly 40% more stack usage for
> > ppc even with 3 frames having large local variables that can't be
> > avoided for either arch.
> >
> > So, x86_64 could be quite safe with its 16kB stack for the same
> > workload, explaining why same overflow has not been seen there.
>
> This is interesting - is it possible that we could resolve this without
> needing to change the kernel - or at least without changing how OVS
> works?

Not really.

To be clear I don't say ovs is the one and only problem, so it could be
resolved if stack was larger or if other things did not use so much,
etc.

Maybe other things could be changed too, but ovs uses several K of stack
that it doesn't need to, and since it is also causing recursion it needs
to be as tight as possible with its stack use.

> Why are these so different?  Maybe there's some bloat in some of
> the ppc data structures that can be addressed?  For example,
> ovs_execute_actions shouldn't really be that different, but I wonder if
> the way the per-cpu infra works, or the deferred action processing gets
> inlined would be causing stack bloat?

Most other stack usage is not due to Linux powerpc arch defining certain
types and structures to be larger (most are the same size as other
64-bit archs). Rather due to C and GCC. I have asked powerpc GCC people
about stack size and no easy option to reduce it, if it were possible to
improve in new version of GCC then we still need to deal with old.

Powerpc has a larger minimum stack frame size (32 bytes) and larger
alignment (32 bytes vs 16 IIRC). It also has more non-volatile registers
and probably uses them more which requires saving to stack. So some of
it is fundamental.

In some cases I can't really see why GCC on ppc uses so much. AFAIKS
ovs_execute_actions could be using 96 bytes, but it's possible I miss
an alignment requirement.

Thanks,
Nick


