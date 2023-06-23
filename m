Return-Path: <netdev+bounces-13452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ACB73BA49
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEA41C212F2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31EA23101;
	Fri, 23 Jun 2023 14:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A9A93B
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:35:54 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3207F269F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:35:44 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a9d57f8f9fso550873fac.3
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687530943; x=1690122943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SEBPStKVcWuK0U9+o4k9p1pZNT3HD7OxhCSF6G1cNQ=;
        b=lBwO2RYXA1FbofoshpI3lj93tY3ca60z4/PmDkydo4xoYcFMNeuPHdNBF1PhvE7mF5
         x+B9+fyQaWDspUByK4Dd38a763lzJM93zzmupkYVMv8Qtrs8STGdUMpu3gwqKlRdO4zf
         mDjg+/i0MeO7gX8VsR37GE7UxxozyYayG5JOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530943; x=1690122943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SEBPStKVcWuK0U9+o4k9p1pZNT3HD7OxhCSF6G1cNQ=;
        b=YaPHFqVZLW0FuX3A37vFhJ3BKDfz2abkNaTAtqdLJEE5TOBQ05j3NwymSU6XPOR1iz
         P9CWY1AWIEZXsWpX3H2hmGvA8slXe3kwyuafe8MmcrRqCPhw7vP1IBw1TgtYpuSDoq32
         /zjRSUQ2V+ruiqMNKtndpO5PcK5Y/EmbI5dXWoGtqwCbVabv/qUIX4SftXnUGcL8idbg
         agFpfVAhXmnxDtjhJ/5yr9++wMos87Oetug7ngShmVpJAyJ9f/jnGOYMVZ5AdTo9Dn9z
         VuPv+DYL4Xq9Xy7ALMIWEx8mgepmLoTipR0hQN1C9BHJt129qJn/UHW9ZYnDaZYZ1Bbr
         LgsA==
X-Gm-Message-State: AC+VfDz34B1bFBo+kOSst/wY3RDRoU5kanshp8TpHhIwhM9a6TcCY+Dy
	8fOQtDHQ47NZRl9f4ZKvY5cZuA+Fm1hZ/JDRUgdgxQ==
X-Google-Smtp-Source: ACHHUZ41ySHwYAnHtH61CA+4dnkZdBqUtd5tQsOOy4llzFrD6Whs2u9HXzuxuQst1L9jHxAm1lQplvzBBmykSYenq/w=
X-Received: by 2002:a05:6870:e896:b0:196:8dc3:4e16 with SMTP id
 q22-20020a056870e89600b001968dc34e16mr17947005oan.39.1687530943485; Fri, 23
 Jun 2023 07:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-13-konstantin.meskhidze@huawei.com>
 <ZH89Pi1QAqNW2QgG@google.com> <CABi2SkWqHeLkmqONbmavcp2SCiwe6YeH_3dkBLZwSsk7neyPMw@mail.gmail.com>
 <86108314-de87-5342-e0fb-a07feee457a5@huawei.com> <97c15e23-8a89-79f2-4413-580153827ade@digikod.net>
 <00a03f2c-892d-683e-96a0-c0ba8f293831@digikod.net>
In-Reply-To: <00a03f2c-892d-683e-96a0-c0ba8f293831@digikod.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 23 Jun 2023 07:35:33 -0700
Message-ID: <CABi2SkWJT5xmjBvudEc725uN8iAMCKf5BBOppzgmRJRc2M4nrg@mail.gmail.com>
Subject: Re: [PATCH v11 12/12] landlock: Document Landlock's network support
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 9:50=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
>
> On 13/06/2023 22:12, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> > On 13/06/2023 12:13, Konstantin Meskhidze (A) wrote:
> >>
> >>
> >> 6/7/2023 8:46 AM, Jeff Xu =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Tue, Jun 6, 2023 at 7:09=E2=80=AFAM G=C3=BCnther Noack <gnoack@goo=
gle.com> wrote:
> >>>>
> >>>> On Tue, May 16, 2023 at 12:13:39AM +0800, Konstantin Meskhidze wrote=
:
> >>>>> Describe network access rules for TCP sockets. Add network access
> >>>>> example in the tutorial. Add kernel configuration support for netwo=
rk.
> >>>>>
> >>>>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.co=
m>
>
> [...]
>
> >>>>> @@ -28,20 +28,24 @@ appropriately <kernel_support>`.
> >>>>>    Landlock rules
> >>>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>> -A Landlock rule describes an action on an object.  An object is cu=
rrently a
> >>>>> -file hierarchy, and the related filesystem actions are defined wit=
h `access
> >>>>> -rights`_.  A set of rules is aggregated in a ruleset, which can th=
en restrict
> >>>>> -the thread enforcing it, and its future children.
> >>>>> +A Landlock rule describes an action on a kernel object.  Filesyste=
m
> >>>>> +objects can be defined with a file hierarchy.  Since the fourth AB=
I
> >>>>> +version, TCP ports enable to identify inbound or outbound connecti=
ons.
> >>>>> +Actions on these kernel objects are defined according to `access
> >>>>> +rights`_.  A set of rules is aggregated in a ruleset, which
> >>>>> +can then restrict the thread enforcing it, and its future children=
.
> >>>>
> >>>> I feel that this paragraph is a bit long-winded to read when the
> >>>> additional networking aspect is added on top as well.  Maybe it woul=
d
> >>>> be clearer if we spelled it out in a more structured way, splitting =
up
> >>>> the filesystem/networking aspects?
> >>>>
> >>>> Suggestion:
> >>>>
> >>>>     A Landlock rule describes an action on an object which the proce=
ss
> >>>>     intends to perform.  A set of rules is aggregated in a ruleset,
> >>>>     which can then restrict the thread enforcing it, and its future
> >>>>     children.
> >>>>
> >>>>     The two existing types of rules are:
> >>>>
> >>>>     Filesystem rules
> >>>>         For these rules, the object is a file hierarchy,
> >>>>         and the related filesystem actions are defined with
> >>>>         `filesystem access rights`.
> >>>>
> >>>>     Network rules (since ABI v4)
> >>>>         For these rules, the object is currently a TCP port,
> >>> Remote port or local port ?
> >>>
> >>      Both ports - remote or local.
> >
> > Hmm, at first I didn't think it was worth talking about remote or local=
,
> > but I now think it could be less confusing to specify a bit:
> > "For these rules, the object is the socket identified with a TCP (bind
> > or connect) port according to the related `network access rights`."
> >
> > A port is not a kernel object per see, so I tried to tweak a bit the
> > sentence. I'm not sure such detail (object vs. data) would not confuse
> > users. Any thought?
>
> Well, here is a more accurate and generic definition (using "scope"):
>
> A Landlock rule describes a set of actions intended by a task on a scope
> of objects.  A set of rules is aggregated in a ruleset, which can then
> restrict the thread enforcing it, and its future children.
>
> The two existing types of rules are:
>
> Filesystem rules
>      For these rules, the scope of objects is a file hierarchy,
>      and the related filesystem actions are defined with
>      `filesystem access rights`.
>
> Network rules (since ABI v4)
>      For these rules, the scope of objects is the sockets identified
>      with a TCP (bind or connect) port according to the related
>      `network access rights`.
>
>
> What do you think?
>
I found this is clearer to me (mention of bind/connect port).

In networking, "5-tuple" is a well-known term for connection, which is
src/dest ip, src/dest port, protocol. That is why I asked about
src/dest port.  It seems that we only support src/dest port at this
moment, right ?

Another feature we could consider is restricting a process to "no
network access, allow out-going , allow incoming", this might overlap
with seccomp, but I think it is convenient to have it in Landlock.

Adding protocol restriction is a low hanging fruit also, for example,
a process might be restricted to UDP only (for RTP packet), and
another process for TCP (for signaling) , etc.

Thanks!
-Jeff Xu

>
> >>>
> >>>>         and the related actions are defined with `network access rig=
hts`.

