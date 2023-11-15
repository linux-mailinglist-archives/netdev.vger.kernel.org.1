Return-Path: <netdev+bounces-47919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A269C7EBF2C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC621C2095B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E35239;
	Wed, 15 Nov 2023 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIm7mVE3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301664687
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:10:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2042BC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700039444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhNKtWr/R4f0Z9uldzH0z+w6k8AhKTTjD0E4Fhplsu4=;
	b=TIm7mVE3Jjrbdg45xxxkHJiahu8mT2ueRpLro+i0bLuPFa6ldCcUQttANYb9x+/FyjwK7h
	hYQ23ovT5K6hTDDWdrot53LdiR4D94B4zsBgZUpxzQagsqafL74o2/SxRPS4YWbhgfIPGK
	JDfCf0XexA+JC+7fia/b8v6hX7niRdI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-LGcIEl4WP_W9-vS38W0hgA-1; Wed, 15 Nov 2023 04:10:42 -0500
X-MC-Unique: LGcIEl4WP_W9-vS38W0hgA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5094bb86ebfso979156e87.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700039441; x=1700644241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhNKtWr/R4f0Z9uldzH0z+w6k8AhKTTjD0E4Fhplsu4=;
        b=AFu7n1s17i+JgL0DDbX7MybKLjoF0mN8egXiGysueb+AKK33zoiChv7VCSVtsDCh9M
         UHfgD1Y7mlUdA+MbE6gZ6opppmC0xi5JNIhDMjX/AaeFZSXllK8YxpyscH78WTw/7a4w
         eKhk9shfhhQYrxTWcGvImS2l2764lT11wzcWpYp/rMgr+oA95C1G5Gwaveatp98WXSrU
         OAtNkArmPVv6MN5sIrvqTmmDuqV1aNLZ1Fz0gRHPU8DuZKl5aS5ZaFI1jOIIamuafE8j
         bCEv/8qv3SInT5T38q2Xu8OHBijrPUMCkdZXXuMI/6tg2PySWjli+z+clvMC45nllNVe
         QaqA==
X-Gm-Message-State: AOJu0Yx+33xLOVIPfSSughYY721lloRz2bvCjmtkxcGD0No/Zb7JfXKt
	2Tqiq+3Fy39FE9q2TQzvNecERo+fSvznS858rq6ktmauv+gkssE8CS+xTj5XBHLoU5vdhe6RTpZ
	knZIh6BnA+hhylAux
X-Received: by 2002:a19:6758:0:b0:508:1a11:16e6 with SMTP id e24-20020a196758000000b005081a1116e6mr2887762lfj.2.1700039440846;
        Wed, 15 Nov 2023 01:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq41xkzafKskY1OuxVN1/vGSU0FM52TefwJcq2REEFlTdcsyIytHhamn6adHtjCAfVt8+VGQ==
X-Received: by 2002:a19:6758:0:b0:508:1a11:16e6 with SMTP id e24-20020a196758000000b005081a1116e6mr2887742lfj.2.1700039440367;
        Wed, 15 Nov 2023 01:10:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-35.dyn.eolo.it. [146.241.232.35])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709066d5700b009737b8d47b6sm6687112ejt.203.2023.11.15.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 01:10:39 -0800 (PST)
Message-ID: <8093c847a556cf38c40f5e9329b087ea34f59e29.camel@redhat.com>
Subject: Re: [Discuss] Seeking advice on net selftests netns naming method
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Shuah Khan
 <shuah@kernel.org>,  David Ahern <dsahern@kernel.org>,
 linux-kselftest@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>, 
 Guillaume Nault <gnault@redhat.com>
Date: Wed, 15 Nov 2023 10:10:38 +0100
In-Reply-To: <ZVR4j+ZYQmb68/V9@Laptop-X1>
References: <ZVND+e6RKLFudYQA@Laptop-X1>
	 <7b2d70645fecf83f30d71c44ae0071da1b3be67c.camel@redhat.com>
	 <ZVR4j+ZYQmb68/V9@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-15 at 15:51 +0800, Hangbin Liu wrote:
> On Tue, Nov 14, 2023 at 12:02:00PM +0100, Paolo Abeni wrote:
> > I personally would like sort of both :) e.g. lib function(s) to
> > automatically create and dispose netns, and retain a script-
> > specific/related name prefix.=C2=A0
> >=20
> > The library function could optionally set  the newly created namespaces
> > name in global variables provided by the caller, e.g.:
> >=20
> > # create 3 namespaces:
> > netns_init 3=20
> >=20
> > # create 3 namespaces and set the global variables:
> > # $remote, $local $me=C2=A0
> > # to their respective names
> > netns_init 3 remote local me
> >=20
> > The trick to do such assignment would be using the 'eval' statement,
> > something alike
> >=20
> > netns_init()
> > {
> > 	# create the netns
> >=20
> > 	shift
> > 	while [ -n "$1" ]; do
> > 		eval $1=3D$NETNS_NAMES[0]
> > 		shift
> > 	done
> > }
> >=20
> > While at that, it would be useful to package some common helper e.g. to
> > wait for a (tcp) listener to be created (available) on a given port.
> >=20
> > WDYT?
>=20
> Thanks, this is a good idea. I reviewed all the test cases and it should =
works
> for most of them. Only the SRv6 tests are a little complex as they use 2 =
id
> number for netns name. e.g. the setup_hs() in
> srv6_end_dt46_l3vpn_test.sh. I plan to add the tmp string between the hs/=
rt and
> ids. e.g. hs-xxxxxx-t100-1, rt-xxxxxx-1. I will have a try first.

Supposing netns_init() creates a namespace named <unique>, I think the
following (very hackish thing) would work:

# create an alias for the namespace
ln -s /var/run/netns/<unique> /var/run/netns/hs-t${tid}-${hs}

# using the alias should work
ip -n hs-t${tid}-${hs} link

#delete the alias at exit time
rm -f /var/run/netns/hs-t${tid}-${hs}

The troublesome part is that the '/var/run/netns/' prefix could be
configured to something else at iproute build time.

@David, @Stephen: I'm wondering if it would make sense adding a new=C2=A0
'ip netns' sub-command to implement the 'alias' feature above?

Cheers,

Paolo


