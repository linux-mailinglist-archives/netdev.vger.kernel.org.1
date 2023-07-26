Return-Path: <netdev+bounces-21434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D97763986
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913611C212BB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487111DA3D;
	Wed, 26 Jul 2023 14:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52C1DA2E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:48:43 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A762136
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:48:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40540a8a3bbso289671cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690382920; x=1690987720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd8rriezwX4e6SuyDOFseqPtwBlBV/Ir+7t5aixv67I=;
        b=5ejaB5UXJ+x/mlJPap88JGhKeRKbpgA/NjAPGFU83QlaujazP/9IEAYAFxKaSzxBp7
         0PU6jHx4gdhfYYYKmPUCWx3hSh7l1mxjAJkPAvlnElYt1mWO8j7yCySmdgzutngGeh2i
         NjnO8GkpVzyWg15b9EZVJzy07lvLGZGHmj5KwV/o6kCY/HCZYxsQemAIzbEP/91CPIUA
         UyXTk8pMwS/XSB1J4slfCIYXQW/MnDvsmR18pMHcW7F+ltbiizGup7bQ1o+rRA5CaRGE
         3LhQonUwiWbc8z9fmNWNFc9FjmHkFzET2VRPFwvj8/uBtrFJjPJZNOdzTYW7Ddl+k47p
         Lbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382920; x=1690987720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd8rriezwX4e6SuyDOFseqPtwBlBV/Ir+7t5aixv67I=;
        b=VLmPm4AP7YsL0vbXf/lGV2az+jJc3y6fvbmZb5CEZ0WrCLRYFIG3mVMLMgY9X9Tagk
         4fHrlhOS3epcNn+1zd47imb27xLv2t5Ir9tM9j2Cr50NPoGjQLE/9N8ccggO//2OFcK1
         lm5fcHta8DEm5jjiSKkRvIYSZIo42uP69JXO+dGt66UEF4jAKy/9wodF+kT9J2FNDaqN
         ZE5wbvGv2IkSjwbcOICQfMxln4bgK8H3/6EyRftSgCiqr8S0PmXK4pouWICtrCKeOkDY
         FSy3ztKn5doxQxre+X75wvuWL7jg+3YFrPgGbSZDoxSfM0gCFH95PpoML3URm5RPZVzM
         NLWg==
X-Gm-Message-State: ABy/qLZTskVFVO2gwNYMDwJRC3+BfrHHTkHk+QUnJUc8AqdbHfV02QSM
	eWUz+e+oFS8GWRCiiGa3pJ2IjUDMYQdLcba2GNOcLQ==
X-Google-Smtp-Source: APBJJlH+tnfOu04+RHW5TlWRsbO7bbD5HBFzvrTqhr/hct4tOIHo5FEwrFGrGDpIAhBJOeEZPH53sNVcxkpAHp5kgEA=
X-Received: by 2002:a05:622a:118a:b0:403:aee3:64f7 with SMTP id
 m10-20020a05622a118a00b00403aee364f7mr570476qtk.6.1690382920004; Wed, 26 Jul
 2023 07:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
 <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com> <CANn89iKTC29of9bkVKWcLv0W27JFvkub7fuBMeK_J3a3Q-B1Cg@mail.gmail.com>
 <fc241086b32944ecae4f467cb5b0c6c7@AcuMS.aculab.com> <CANn89iLRDpAmaJVYCf+-F7mTTVkxSJMKfxZ+QhB8ATzYEi4X8g@mail.gmail.com>
 <badeae889d4743fb8eb99b85d69b714a@AcuMS.aculab.com>
In-Reply-To: <badeae889d4743fb8eb99b85d69b714a@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jul 2023 16:48:29 +0200
Message-ID: <CANn89iKs7e71dCFnKr-3NM8N7BAfRUa0VrOLhYrATVR-DzgWqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Rescan the hash2 list if the hash chains have got cross-linked.
To: David Laight <David.Laight@aculab.com>
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:39=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Eric Dumazet
> > Sent: 26 July 2023 15:22
> ...
> > Can you describe what user space operation is done by your precious app=
lication,
> > triggering a rehash in the first place ?
>
> We've no idea what is causing the rehash.
> There are a lot of sockets that are receiving RTP audio.
> But they are only created, bound and then deleted.
>
> The 'best guess' is something to do with ipsec tunnels
> being created, deleted or rehashed.
>
> >
> > Maybe we can think of something less disruptive in the kernel.
> > (For instance, you could have a second socket, insert it in the new buc=
ket,
> > then remove the old socket)
> >
> > > The problem is that a single 'port unreachable' can be treated
> > > as a fatal error by the receiving application.
> > > So you really don't want to be sending them.
> >
> > Well, if your application needs to run with old kernels, and or
> > transient netfilter changes (some firewall setups do not use
> > iptables-restore)
> > better be more resilient to transient ICMP messages anyway.
>
> This is being done for the specific pair of sockets that caused grief.
> For this setup they were on 127.0.0.1 but that isn't always true.
> But they would be expected to be on a local network.
>
> Reading between the lines of the comment in ipv4/icmp.c
> it is reasonable to assume that ICMP_PORT_UNREACH be treated
> as a fatal error (ie not a transient one).
> So really the Linux kernel ought to try quite hard to not
> generate them when the port exists.

Sure, then please add the synchronize_rcu() call, because it won't affect y=
ou.

You could add a probe to try to identify what is causing a rehash.

perf probe -a udp_lib_rehash
perf record -a -g -e probe:udp_lib_rehash sleep 60
...
perf script

