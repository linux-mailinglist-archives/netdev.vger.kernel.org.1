Return-Path: <netdev+bounces-20414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89875F5A9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 14:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0761C20B3A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6C63CB;
	Mon, 24 Jul 2023 12:07:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC14C9E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 12:07:22 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576601A1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 05:07:20 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40540a8a3bbso484651cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690200439; x=1690805239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3rGNS8zl7X4x6HbiNcU0aEpmc1xWYqSsp3mkN+kKus=;
        b=dabs9DfNi792a3Uj+c+N8u/w8dMhmTNKu08BlrDsiWZJT+KvA3+YiJEgtBQ1DnXspS
         yID8CDFpAdfwUL/Xd31S/YlrkiVKrNesFNSGSVjGxhfgJ0EAr8o8FWd7MAmXH2VXkJsi
         SS36x68Y6fPnvM67yeHonTwJrtRAm2tuSVKAzA8Hnv20Qvmau9DrVXa2DhlwlUtFEtWz
         AWK5qyqxvsifzya/yObVcf+0LWWahu0UQNPvpO2Pfy0BTCAHeRRRmyVCQkJl8CMh+HjS
         R50Yjn3SLE/Ts+LUGSBrCDDmOgzKydo3w8+7itkAPmiNYDlhOrKpa0Z/RMQ0x2kJC/UZ
         sBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690200439; x=1690805239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3rGNS8zl7X4x6HbiNcU0aEpmc1xWYqSsp3mkN+kKus=;
        b=kUTCUYuctFKurI2MYbQFuP42KzeY36t2m9IaoZEi2qet9eLrZ5nGsKYF0DXLEWhOZR
         TetsWgwTIyYlgGnETSS+FPIk6FG/q3KTa9JxQdgka/W2Py8xSCeBt9ievhLpfyW+/Tc0
         x6mSb6/KWBuuhEmE31fZqSAxPlMBfcQ4L+PNDTgaCWJq3mi0iHG15vx8G0Ly4Bb2F11P
         khlxh8glghxcJVnX9vvm8CJ1c5kYLLzor5LA1NwKCcLVKh7TUEWluMS2UM04rzh+dWnA
         yQPeqPr0gW+OVLQ+Dhlo+kaBULU0w5e8K9g8RSOFqlYlXuzAqAKZoTYnFhUkEVKbSV1Y
         fLWw==
X-Gm-Message-State: ABy/qLYGX7yBjunmKcmBrdRSPbPe8PYuLMpoVcyJ7wlzH+qolg2+he/P
	7f9WSzVnFZ5LpMX0n+I327SqdKJdeA79ctq/n2quAAaI161dAXgFQX0=
X-Google-Smtp-Source: APBJJlH3xYwB0ieZeQ1oe8fa56XE14AZAOcEofnkCt/+MTyFRmsiMAjfb8qcmg+s1vCY44NDn22JPhTnjBN5dWdeIvM=
X-Received: by 2002:a05:622a:170e:b0:403:e1d1:8b63 with SMTP id
 h14-20020a05622a170e00b00403e1d18b63mr522415qtk.24.1690200439365; Mon, 24 Jul
 2023 05:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
 <20230720160022.1887942-1-maze@google.com> <20230720093423.5fe02118@kernel.org>
 <CANP3RGexoRnp6PRX6OG8obxPhdTt74J-8yjr_hNJOhzHnv1Xsw@mail.gmail.com>
In-Reply-To: <CANP3RGexoRnp6PRX6OG8obxPhdTt74J-8yjr_hNJOhzHnv1Xsw@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 24 Jul 2023 14:07:06 +0200
Message-ID: <CANP3RGfsp3eHmSabzwsvHJbc6mb6QGgfPmoEF3B0t03SHwNkFA@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Thomas Haller <thaller@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Xiao Ma <xiaom@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I see this is once again marked as changes requested.
Ok, I get it, you win.

On Thu, Jul 20, 2023 at 6:52=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> On Thu, Jul 20, 2023 at 9:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 20 Jul 2023 09:00:22 -0700 Maciej =C5=BBenczykowski wrote:
> > > currently on 6.4 net/main:
> > >
> > >   # ip link add dummy1 type dummy
> > >   # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
> > >   # ip link set dummy1 up
> > >   # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
> > >   # ip -6 addr show dev dummy1
> >
> > FTR resending the patch as part of the same thread is really counter
> > productive for the maintainers. We review patches in order, no MUA
> > I know can be told to order things correctly when new versions are sent
> > in reply.
>
> Sorry, but I'm afraid as a non-maintainer I have no idea what your
> work flows are like.
> (and it shows up just fine on patchwork.kernel.org which is what I
> thought you all used now...)
>
> > Don't try too hard, be normal, please.
>
> What's considered 'normal' seems to depend on the list.
>
> I'm pretty sure I've been told to do --in-reply follow ups previously
> when I didn't
> (though it might not have been on netdev...).
>
> Email is really a very poor medium for code reviews in general.Maciej =C5=
=BBenczykowski, Kernel Networking Developer @ Google

