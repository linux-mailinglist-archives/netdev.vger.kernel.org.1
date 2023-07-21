Return-Path: <netdev+bounces-19741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E575BF60
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404691C2160B
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821F1FDA;
	Fri, 21 Jul 2023 07:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A791FA4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:14:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8FE2710
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689923664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AnczGmBaDpEC/mrw6DL/jbYDlBQdesMdQKC85X6GUc=;
	b=BPRJ1eUiMBOl0C4x4NKHXdOuXrLfOhqY60jpqXpbeP3NK1MKlPuEs5aGRq9Pgp7I8ZrYWE
	I6rbVhVHTYmmBHeu0jXrMfOeH1pBU0OLTKTvUfmWlvLViFA7UltBtMafwtSvLj26RDGbCQ
	//mTFz0q1Z1U30pAgkQF4Uz7R1BW/GY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-l8bgjS7mOqa0cNV5pmH4IQ-1; Fri, 21 Jul 2023 03:14:21 -0400
X-MC-Unique: l8bgjS7mOqa0cNV5pmH4IQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4053d3613f9so4227911cf.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 00:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689923661; x=1690528461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AnczGmBaDpEC/mrw6DL/jbYDlBQdesMdQKC85X6GUc=;
        b=d/B0RmHNe4JAlolFoyLA0dpW3SM0eN0Rrg2nFJkI9YQX586/FLUkU12CcWv0BiLxcd
         SOKvXs1ORHRmZAKku3Ie0aWf0/xvHprOZ4/ejA41Pe0HNoN9tBXJcNcEBuZ0T9KdGac9
         f33SNpakVv75SQoF1N+3TEP7ij2k679AvsZFywRAbgp56QKo/R/jT8K0jssa/0OZZ0M4
         chFQITZCUDjq/GErNYs9gcJst+dsoqsB924h5wWHnW7Swyr8IVCP10Ccdv34ab27mk5n
         Nh5tW6ilfvl2W7Wxssrqktzlnaq+wIe2XZyNrkpZu09MFlc611+auz0jqV8vr52zWu8I
         mprA==
X-Gm-Message-State: ABy/qLa4dSXX/WLTL03bdkuln28AKznRM3BgKCoMNN4UblobWN2+1/x7
	+QwAmUkA3CoXc0I7qrNrWOEVL6ZbIHkU0zPl81zMj4V/dMvOveW7mE2Ynk/xuIqLbmNgo9KwShN
	yl7ArApxOGKBkCZFI
X-Received: by 2002:a05:622a:5ca:b0:400:84a9:a09c with SMTP id d10-20020a05622a05ca00b0040084a9a09cmr1387875qtb.6.1689923661026;
        Fri, 21 Jul 2023 00:14:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcTxMfWh8U3TsW7FsJDZOOjuyLUm4Si+u2u3TyBdTWKcmvonYzga5+n5XqWXo9H/pbuU6L/A==
X-Received: by 2002:a05:622a:5ca:b0:400:84a9:a09c with SMTP id d10-20020a05622a05ca00b0040084a9a09cmr1387868qtb.6.1689923660714;
        Fri, 21 Jul 2023 00:14:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id y7-20020ac87087000000b00400aa16bf38sm1009635qto.82.2023.07.21.00.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:14:20 -0700 (PDT)
Message-ID: <239ca679597a10b6bc00245c66419f4bdedaff83.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add a test case
 for IPv6 garbage collection
From: Paolo Abeni <pabeni@redhat.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Date: Fri, 21 Jul 2023 09:14:16 +0200
In-Reply-To: <3057afe9-ac48-84e2-bd39-b227d2dcbc2f@gmail.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
	 <20230718180321.294721-3-kuifeng@meta.com>
	 <9743a6cc267276bfeba5b0fdcf7ba9a4077c67e1.camel@redhat.com>
	 <3057afe9-ac48-84e2-bd39-b227d2dcbc2f@gmail.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-20 at 14:36 -0700, Kui-Feng Lee wrote:
>=20
> On 7/20/23 02:32, Paolo Abeni wrote:
> > On Tue, 2023-07-18 at 11:03 -0700, Kui-Feng Lee wrote:
> > > Add 10 IPv6 routes with expiration time.  Wait for a few seconds
> > > to make sure they are removed correctly.
> > >=20
> > > Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> >=20
> > Same thing as the previous patch.
> >=20
> > > ---
> > >   tools/testing/selftests/net/fib_tests.sh | 49 +++++++++++++++++++++=
++-
> > >   1 file changed, 48 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing=
/selftests/net/fib_tests.sh
> > > index 35d89dfa6f11..55bc6897513a 100755
> > > --- a/tools/testing/selftests/net/fib_tests.sh
> > > +++ b/tools/testing/selftests/net/fib_tests.sh
> > > @@ -9,7 +9,7 @@ ret=3D0
> > >   ksft_skip=3D4
> > >  =20
> > >   # all tests in this script. Can be overridden with -t option
> > > -TESTS=3D"unregister down carrier nexthop suppress ipv6_notify ipv4_n=
otify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics =
ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv=
6_mangle ipv4_bcast_neigh"
> > > +TESTS=3D"unregister down carrier nexthop suppress ipv6_notify ipv4_n=
otify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics =
ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv=
6_mangle ipv4_bcast_neigh fib6_gc_test"
> >=20
> > At this point is likely worthy splitting the above line in multiple
> > ones, something alike:
> >=20
> > TESTS=3D"unregister down carrier nexthop suppress ipv6_notify \
> > 	ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric
> > \
> > 	ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw \
> > 	rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh \
> > 	fib6_gc_test"
> >=20
> > >  =20
> > >   VERBOSE=3D0
> > >   PAUSE_ON_FAIL=3Dno
> > > @@ -747,6 +747,52 @@ fib_notify_test()
> > >   	cleanup &> /dev/null
> > >   }
> > >  =20
> > > +fib6_gc_test()
> > > +{
> > > +	setup
> > > +
> > > +	echo
> > > +	echo "Fib6 garbage collection test"
> > > +	set -e
> > > +
> > > +	OLD_INTERVAL=3D$(sysctl -n net.ipv6.route.gc_interval)
> > > +	# Check expiration of routes every 3 seconds (GC)
> > > +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=3D3
> > > +
> > > +	$IP link add dummy_10 type dummy
> > > +	$IP link set dev dummy_10 up
> > > +	$IP -6 address add 2001:10::1/64 dev dummy_10
> > > +
> > > +	for i in 0 1 2 3 4 5 6 7 8 9; do
> > 		$(seq 0 9)
> >=20
> > > +	    # Expire route after 2 seconds
> > > +	    $IP -6 route add 2001:20::1$i \
> > > +		via 2001:10::2 dev dummy_10 expires 2
> > > +	done
> > > +	N_EXP=3D$($IP -6 route list |grep expires|wc -l)
> > > +	if [ $N_EXP -ne 10 ]; then
> > > +		echo "FAIL: expected 10 routes with expires, got $N_EXP"
> > > +		ret=3D1
> > > +	else
> > > +	    sleep 4
> > > +	    N_EXP_s20=3D$($IP -6 route list |grep expires|wc -l)
> > > +
> > > +	    if [ $N_EXP_s20 -ne 0 ]; then
> > > +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s20"
> > > +		ret=3D1
> > > +	    else
> > > +		ret=3D0
> > > +	    fi
> > > +	fi
> >=20
> > Possibly also worth trying with a few K of permanent routes, and dump
> > the time required in both cases?
>=20
> I just realized that I don't know how to measure the time required to do=
=20
> GC without providing additional APIs or exposing numbers to procfs or=20
> sysfs. Do you have any idea about this?

Something like this should do the trick

sysctl -wq net.ipv6.route.flush=3D1

# add routes=20
#...

# delete expired routes synchronously
sysctl -wq net.ipv6.route.flush=3D1

Note that the net.ipv6.route.flush handler uses the 'old' flush value.

Cheers,

Paolo


