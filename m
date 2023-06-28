Return-Path: <netdev+bounces-14462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D5741B42
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7344E1C2083E
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB11119C;
	Wed, 28 Jun 2023 21:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D723107B1
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 21:57:01 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DFC210E
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 14:56:59 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-565bf0183c9so19154eaf.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687989419; x=1690581419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVNaY1PkrDCLUbKLctmii1e+XYZxv3OOcSq6XrzK1MM=;
        b=hvTbu8TIovKcYE3p7tIvCkJOS+A8l9AAVTGwVE4icy0bcAt6IRvcx/bo4zV5sC3Wcv
         NSUOw8OHQncjcaeIbkKsDpB5uVKK8Z97lDzGSBzBWJY5GBlmV+/Qyv2gOZQW6HLigVxx
         s479svxgY//DEJP8ODxrPYatrrI0SlwOvWqvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989419; x=1690581419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVNaY1PkrDCLUbKLctmii1e+XYZxv3OOcSq6XrzK1MM=;
        b=K/rlTEmIBUNHo1QcX980NJ7n64NEkcba9zgMlkeaSuJhtyAph5RooakX/h6ZoKWay7
         dXNKLQsDfG8uzWTy2K5yi3JXTdXg7xnenSsh2y2a79NC0kHpoGbGCMQohvGtjO+wSFFK
         UPcgrE7e3Cym6IYnI33G0O8cQgigaIDIQyt8ATAkucPnVoQBTxVDbiaf323V05H0Sta6
         BspVWLaccRH/1r0SktWXL1p3tXu0YBQvX6n7vRJYStfHc+L6KDv7h3lRh2eDhpfBqiJH
         +cy+tdEMBV6ipI9n9uryqAfRg+GlRXNlf0pL0JQNM3/3ntYq2hYJ5nLBbc5Cmv0QtU80
         tLvA==
X-Gm-Message-State: AC+VfDzZVhHan4Pn3xeLR67K1DvnbsprJe+f6Nn8tbOQ/krVQ9u17Dy/
	M4QWY3Zcd8+ZWbCmZxvYVK2wpPEOC/RZE2+xKcX8gw==
X-Google-Smtp-Source: ACHHUZ43sp8ZFu5BzqH28HI8+C9YFLmuV9a8GJJMI6fP+Qnf+nFbusxqHK2wBEW1XAmdFa5ESrWpV8+kCJY5Ld+FhC8=
X-Received: by 2002:a4a:a581:0:b0:565:8648:9cf1 with SMTP id
 d1-20020a4aa581000000b0056586489cf1mr4692412oom.0.1687989418853; Wed, 28 Jun
 2023 14:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230116085818.165539-1-konstantin.meskhidze@huawei.com>
 <Y/fl5iEbkL5Pj5cJ@galopp> <c20fc9eb-518e-84b4-0dd5-7b97c0825259@huawei.com>
 <3e113e1c-4c7b-af91-14c2-11b6ffb4d3ef@digikod.net> <b8a2045a-e7e8-d141-7c01-bf47874c7930@digikod.net>
 <CABi2SkXgTv8Bz62hwkymz2msvNXZQUWM1acT-_Lcq2=Mb-BD6w@mail.gmail.com> <a6318388-e28a-e96f-b1ae-51948c13de4d@digikod.net>
In-Reply-To: <a6318388-e28a-e96f-b1ae-51948c13de4d@digikod.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 28 Jun 2023 14:56:48 -0700
Message-ID: <CABi2SkVWU=Wxb2y3fP702twyHBD3kVoySPGSz2X22VckvcHeXw@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Network support for Landlock - allowed list of protocols
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	willemdebruijn.kernel@gmail.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 12:03=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
>
> On 28/06/2023 04:33, Jeff Xu wrote:
> > On Mon, Jun 26, 2023 at 8:29=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> >>
> >> Reviving G=C3=BCnther's suggestion to deny a set of network protocols:
> >>
> >> On 14/03/2023 14:28, Micka=C3=ABl Sala=C3=BCn wrote:
> >>>
> >>> On 13/03/2023 18:16, Konstantin Meskhidze (A) wrote:
> >>>>
> >>>>
> >>>> 2/24/2023 1:17 AM, G=C3=BCnther Noack =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> >>
> >> [...]
> >>
> >>>>>
> >>>>> * Given the list of obscure network protocols listed in the socket(=
2)
> >>>>>       man page, I find it slightly weird to have rules for the use =
of TCP,
> >>>>>       but to leave less prominent protocols unrestricted.
> >>>>>
> >>>>>       For example, a process with an enabled Landlock network rules=
et may
> >>>>>       connect only to certain TCP ports, but at the same time it ca=
n
> >>>>>       happily use Bluetooth/CAN bus/DECnet/IPX or other protocols?
> >>>>
> >>>>          We also have started a discussion about UDP protocol, but i=
t's
> >>>> more complicated since UDP sockets does not establish connections
> >>>> between each other. There is a performance problem on the first plac=
e here.
> >>>>
> >>>> I'm not familiar with Bluetooth/CAN bus/DECnet/IPX but let's discuss=
 it.
> >>>> Any ideas here?
> >>>
> >>> All these protocols should be handled one way or another someday. ;)
> >>>
> >>>
> >>>>
> >>>>>
> >>>>>       I'm mentioning these more obscure protocols, because I doubt =
that
> >>>>>       Landlock will grow more sophisticated support for them anytim=
e soon,
> >>>>>       so maybe the best option would be to just make it possible to
> >>>>>       disable these?  Is that also part of the plan?
> >>>>>
> >>>>>       (I think there would be a lot of value in restricting network
> >>>>>       access, even when it's done very broadly.  There are many pro=
grams
> >>>>>       that don't need network at all, and among those that do need
> >>>>>       network, most only require IP networking.
> >>>
> >>> Indeed, protocols that nobody care to make Landlock supports them wil=
l
> >>> probably not have fine-grained control. We could extend the ruleset
> >>> attributes to disable the use (i.e. not only the creation of new rela=
ted
> >>> sockets/resources) of network protocol families, in a way that would
> >>> make sandboxes simulate a kernel without such protocol support. In th=
is
> >>> case, this should be an allowed list of protocols, and everything not=
 in
> >>> that list should be denied. This approach could be used for other ker=
nel
> >>> features (unrelated to network).
> >>>
> >>>
> >>>>>
> >>>>>       Btw, the argument for more broad disabling of network access =
was
> >>>>>       already made at https://cr.yp.to/unix/disablenetwork.html in =
the
> >>>>>       past.)
> >>>
> >>> This is interesting but scoped to a single use case. As specified at =
the
> >>> beginning of this linked page, there must be exceptions, not only wit=
h
> >>> AF_UNIX but also for (the newer) AF_VSOCK, and probably future ones.
> >>> This is why I don't think a binary approach is a good one for Linux.
> >>> Users should be able to specify what they need, and block the rest.
> >>
> >> Here is a design to be able to only allow a set of network protocols a=
nd
> >> deny everything else. This would be complementary to Konstantin's patc=
h
> >> series which addresses fine-grained access control.
> >>
> >> First, I want to remind that Landlock follows an allowed list approach
> >> with a set of (growing) supported actions (for compatibility reasons),
> >> which is kind of an allow-list-on-a-deny-list. But with this proposal,
> >> we want to be able to deny everything, which means: supported, not
> >> supported, known and unknown protocols.
> >>
> > I think this makes sense.  ChomeOS can use it at the process level:
> > disable network, allow VSOCK only, allow TCP only, etc.
> >
> >> We could add a new "handled_access_socket" field to the landlock_rules=
et
> >> struct, which could contain a LANDLOCK_ACCESS_SOCKET_CREATE flag.
> >>
> >> If this field is set, users could add a new type of rules:
> >> struct landlock_socket_attr {
> >>       __u64 allowed_access;
> >>       int domain; // see socket(2)
>
> I guess "family" would also make sense. It's the name used in the
> kernel, the "AF" prefixes, and address_families(7). I'm not sure why
> "domain" was chosen for socket(2).
>
Agree also.

>
> >>       int type; // see socket(2)
> >> }
> >>
> > Do you want to add "int protocol" ? which is the third parameter of soc=
ket(2)
> > According to protocols(5), the protocols are defined in:
> > https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtm=
l
> >
> > It is part of IPv4/IPV6 header:
> > https://www.rfc-editor.org/rfc/rfc791.html#section-3.1
> > https://www.rfc-editor.org/rfc/rfc8200.html#section-3
>
> I understand the rationale but I'm not sure if this would be useful. Do
> you have use cases?
>
I agree this field is not commonly used, so might not be that useful.
In most cases, the protocol field will just be 0.

One case I thought of previously is building an icmp or DHCP packet
with raw socket,  but now I'm not sure what kind of support/enforce
the kernel has for the protocol field with raw socket.

We can drop this for now, if there is a clearer requirement in future,
it is easy to add a new rule.

>
> >
> >> The allowed_access field would only contain
> >> LANDLOCK_ACCESS_SOCKET_CREATE at first, but it could grow with other
> >> actions (which cannot be handled with seccomp):
> >> - use: walk through all opened FDs and mark them as allowed or denied
> >> - receive: hook on received FDs
> >> - send: hook on sent FDs
> >>
> > also bind, connect, accept.
>
> I don't think "accept" would be useful, and I'm not sure if "bind" and
> "connect" would not be redundant with LANDLOCK_ACCESS_NET_{CONNECT,BIND}_=
TCP
> Bind and connect for a datagram socket is optional, so this might lead
> to a false sense of security. If we want to support protocols other than
> TCP to restrict bind/connect, then they deserve to be controlled
> according to a port (or similar).
>
> >
> >> We might also use the same approach for non-socket objects that can be
> >> identified with some meaningful properties.
> >>
> >> What do you think?
> >
> > -Jeff

