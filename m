Return-Path: <netdev+bounces-14003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1046D73E56A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483D0280E37
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0CBA37;
	Mon, 26 Jun 2023 16:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE0A944
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:42:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E5E48
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687797730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asxiZidzTKqbTTIG034hchvV0jRmIRYObF5XRhg78do=;
	b=SN5N32gUrmJKnmc6W8NfyMq6rCL136KhWaT3tHVBGUdNZ/lGRj7hEumCqHkGuFtmh+2VWb
	E5EGNJxw85RDSHCrjuRqan4sDHL/QZebaTJKcLjKznN52MFWaeWyNgstgHIJbczYKBlVEd
	ZO934cWR3EEyFsURCqpSd/mPgppd2xo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-N-PS_gVkNyyTD5yb8dv-Ag-1; Mon, 26 Jun 2023 12:42:08 -0400
X-MC-Unique: N-PS_gVkNyyTD5yb8dv-Ag-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-401df9d2dc4so1419161cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797728; x=1690389728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asxiZidzTKqbTTIG034hchvV0jRmIRYObF5XRhg78do=;
        b=ldXuJy8ev0qjk2FlhDj0LFWXBvtyS8VLVnYqO/0BpENGHeOIO8j4FQ2brw+SaNWI6u
         rmz0FuY9X+MbRQuFJdQjznW77y0qQSb42vb0zFc5BRcTGO9qc5CxihxmaJqOiOI98IEV
         fsNi381Ny5KBZLNMKi0Vj7RnkK7wp6wzu9OcsyJ9dESoTmCe0enzpsVA72I+jF4G4vle
         5T1ZCUm+Zw/cYLMo1lweyXhhqHl8HT3XvcjmF8mW+931SAOeHQg3MLPnjtkGV77ye1Ru
         XZ73SazLoMZRM8sGgxkWU2JKH2j0MGmXnt9BoR5Hp+Zz2sNjGaqMs7oWvdVpouHhS6Av
         IX2w==
X-Gm-Message-State: AC+VfDy75EKR96Ssl+TlNWt2tAyYRZhhmXh5DL7eiRLeyyh4Ttlrd7S6
	nLIeTcPEc1Y9Jw/wVdm5BoGO+mdy0XJEDIapGJlZp6OYApRsP9HF372O3rEqwPSriBB0tBlcYBz
	BaPD3DtIoHgu//a567IQvqdKc
X-Received: by 2002:a05:622a:130e:b0:400:9ac5:e16e with SMTP id v14-20020a05622a130e00b004009ac5e16emr8444126qtk.5.1687797728128;
        Mon, 26 Jun 2023 09:42:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5I3CAeI8ca2wi5jtMkoY6xwiJKbr/NuY1Vge9snGy8/6GCXsGn93S3NFzjf2ojjaf+RnFiRg==
X-Received: by 2002:a05:622a:130e:b0:400:9ac5:e16e with SMTP id v14-20020a05622a130e00b004009ac5e16emr8444115qtk.5.1687797727830;
        Mon, 26 Jun 2023 09:42:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id m25-20020aed27d9000000b003f364778b2bsm3296930qtg.4.2023.06.26.09.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:42:07 -0700 (PDT)
Message-ID: <a766b45e26b465224fa5f0be721af147a8599fa7.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From: Paolo Abeni <pabeni@redhat.com>
To: Ian Kumlien <ian.kumlien@gmail.com>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>
Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 26 Jun 2023 18:42:04 +0200
In-Reply-To: <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
References: 
	<CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
	 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
	 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
	 <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-06-26 at 16:25 +0200, Ian Kumlien wrote:
> On Mon, Jun 26, 2023 at 4:18=E2=80=AFPM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >=20
> > From: Ian Kumlien <ian.kumlien@gmail.com>
> > Date: Sun, 25 Jun 2023 12:59:54 +0200
> >=20
> > > It could actually be that it's related to: rx-gro-list but
> > > rx-udp-gro-forwarding makes it trigger quicker...  I have yet to
> > > trigger it on igb
> >=20
> > Hi, the rx-udp-gro-forwarding author here.
> >=20
> > (good thing this appeared on IWL, which I read time to time, but please
> >  Cc netdev next time)
> > (thus +Cc Jakub, Eric, and netdev)
>=20
> Well, two things, it seems like rx-udp-gro-forwarding accelerates it
> but the issue is actually in: rx-gro-list
>=20
> And since i've only been able to trigger it in ixgbe i thought it
> might be a driver issue =3D)
>=20
> > > On Sat, Jun 24, 2023 at 10:03=E2=80=AFPM Ian Kumlien <ian.kumlien@gma=
il.com> wrote:
> > > >=20
> > > > Hi again,
> > > >=20
> > > > I suspect that I have rounded this down to the rx-udp-gro-forwardin=
g
> > > > option... I know it's not on by default but....
> > > >=20
> > > > So, I have a machine with four nics, all using ixgbe, they are all:
> > > > 06:00.0 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > > 06:00.1 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > > 07:00.0 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > > 07:00.1 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > >=20
> > > > But I have been playing with various... currently i do:
> > > > for interface in eno1 eno2 eno3 eno4 ; do
> > > >   for offload in ntuple hw-tc-offload rx-gro-list ; do
> > > >     ethtool -K $interface $offload on > /dev/null
> > > >   done
> > > >   ethtool -G $interface rx 8192 tx 8192 > /devYnull
> > > > done
> > > >=20
> > > > And it all seems to work just fine for my little firewall
> > > >=20
> > > > However, enabling rx-udp-gro-forwarding results in the attached ooo=
ops
> > > > (sorry, can't see more, been recreating by watching shows on HBO
> > > > max... )
> >=20
> > Where's the mentioned oops? Where's the original message?
>=20
> Held by the mailing list since i can only get a screenshot of it...
> Will attach the latest one to this email

That image is not very useful/does not provide a lot of relevant
information. Could you please use kdump/crash to collect a (decoded)
full stack trace?

> (I wish that i could easily get a larger backtrace but i haven't
> looked in further atm)
>=20
> > Can't this be related to [0]?
>=20
> Don't know, my main test has been running video streams in the
> background - eventually they cause a oops (within 40 minutes or so)
> But i doubt it's counted as tunnel data ;)

I read the above as you don't have UDP tunnels in your setup. Am I
correct?

Thanks,

Paolo


