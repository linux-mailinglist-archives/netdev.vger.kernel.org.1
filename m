Return-Path: <netdev+bounces-20806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988B97610DC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F041C20DBF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DEC1EA7E;
	Tue, 25 Jul 2023 10:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091B14ABC
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:28:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B2E3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690280879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDKpKxn/TUwlWtyjfTz8EsZgChePB/9F1/tzCT53qQc=;
	b=Gzq+1jFiuIYwdIGNBes+Ljxxk1jcAWXfqXFLrE3L2qoD2X1O1jQOJFmkp6vQjb57loJvg8
	bOI/AnpdM578zrX8SkVvwOKk5Ly3d0WyhjXepbFuSBsGTQdRVOgofQSrrUmLz6zJlUs3HZ
	ohQ5TI84UNO8w+y0eVKQCwy6rGB7Pv0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-GnkWetymOP-BQrMG7EiNNw-1; Tue, 25 Jul 2023 06:27:57 -0400
X-MC-Unique: GnkWetymOP-BQrMG7EiNNw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-405512b12f5so8871091cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280877; x=1690885677;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDKpKxn/TUwlWtyjfTz8EsZgChePB/9F1/tzCT53qQc=;
        b=ZE/1+FuIzPRM4/XM4MKRoRiwH2jlsMFQn4tC40UUTwIrM6n3yHJvi2EZGKB3XSsgo2
         RfV5K5bqIsFuUItr/pbHBx8tTw4l4in+1gMiMsReoq+Dr3lJv+FosOkGSsEkIsbL9czQ
         DgunUzNUUOIYcP2yJU8k5zMp7OTYV8Jj/B18prf7swSkD6B/YJU0SdLE7OUcXrBTuV8A
         e56wGOp5s/e2UquH8VkAllvngFVxtiRcSKmkKTrjqn3EiqI09J4Er7J5m8g8a+OT6PDS
         qLEA1p+VNStBNyw0CYeQfnRHxVF4QYs/y6K0Nx/7Lcnzhc6nnHUBJXYBwv+McN4poFXV
         iPgw==
X-Gm-Message-State: ABy/qLZDcGPJeCJxd5hsQGu1eTRIhdZYwpd3dnLkd4oTRbk5tdvrKJHt
	cjCpn5gbEVRnORaFefFCRH/17O9oeCwxSCKs+9QcSiOXtSn5dV3Sf7soPVn0MqIizQlvMm+0ST2
	NMDUryshP5/aPylyV
X-Received: by 2002:a05:622a:1b9f:b0:400:a9a4:8517 with SMTP id bp31-20020a05622a1b9f00b00400a9a48517mr14697745qtb.4.1690280877143;
        Tue, 25 Jul 2023 03:27:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGDZ0zMxY2bu4jMXAw6insEXU+9dUZ1IrzXU6vRBlXNYK31Kk7cft1It2m2smn5yN0tOq/Pzg==
X-Received: by 2002:a05:622a:1b9f:b0:400:a9a4:8517 with SMTP id bp31-20020a05622a1b9f00b00400a9a48517mr14697731qtb.4.1690280876782;
        Tue, 25 Jul 2023 03:27:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id h21-20020ac85495000000b004053dc8365esm3917471qtq.23.2023.07.25.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:27:56 -0700 (PDT)
Message-ID: <f7ba3fc5327f88a0e9b20e177a0ce599b77833db.camel@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: fib_tests: Add a test case
 for IPv6 garbage collection
From: Paolo Abeni <pabeni@redhat.com>
To: kuifeng@meta.com, dsahern@kernel.org, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 martin.lau@linux.dev,  kernel-team@meta.com, yhs@meta.com
Cc: thinker.li@gmail.com
Date: Tue, 25 Jul 2023 12:27:52 +0200
In-Reply-To: <20230722003839.897682-3-kuifeng@meta.com>
References: <20230722003839.897682-1-kuifeng@meta.com>
	 <20230722003839.897682-3-kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-21 at 17:38 -0700, kuifeng@meta.com wrote:
> From: Kui-Feng Lee <kuifeng@meta.com>
>=20
> Add 10 IPv6 routes with expiration time.  Wait for a few seconds
> to make sure they are removed correctly.
>=20
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 90 +++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/sel=
ftests/net/fib_tests.sh
> index 35d89dfa6f11..4c92fb3c3844 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -9,13 +9,16 @@ ret=3D0
>  ksft_skip=3D4
> =20
>  # all tests in this script. Can be overridden with -t option
> -TESTS=3D"unregister down carrier nexthop suppress ipv6_notify ipv4_notif=
y ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4=
_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_ma=
ngle ipv4_bcast_neigh"
> +TESTS=3D"unregister down carrier nexthop suppress ipv6_notify ipv4_notif=
y \
> +       ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metr=
ics \
> +       ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
> +       ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
> =20
>  VERBOSE=3D0
>  PAUSE_ON_FAIL=3Dno
>  PAUSE=3Dno
> -IP=3D"ip -netns ns1"
> -NS_EXEC=3D"ip netns exec ns1"
> +IP=3D"$(which ip) -netns ns1"
> +NS_EXEC=3D"$(which ip) netns exec ns1"
> =20
>  which ping6 > /dev/null 2>&1 && ping6=3D$(which ping6) || ping6=3D$(whic=
h ping)
> =20
> @@ -747,6 +750,86 @@ fib_notify_test()
>  	cleanup &> /dev/null
>  }
> =20
> +fib6_gc_test()
> +{
> +	setup
> +
> +	echo
> +	echo "Fib6 garbage collection test"
> +	set -e
> +
> +	# Check expiration of routes every 3 seconds (GC)
> +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=3D300
> +
> +	$IP link add dummy_10 type dummy
> +	$IP link set dev dummy_10 up
> +	$IP -6 address add 2001:10::1/64 dev dummy_10
> +
> +	$NS_EXEC sysctl -wq net.ipv6.route.flush=3D1
> +
> +	# Temporary routes
> +	for i in $(seq 1 1000); do
> +	    # Expire route after 4 seconds
> +	    $IP -6 route add 2001:20::$i \
> +		via 2001:10::2 dev dummy_10 expires 4
> +	done
> +	N_EXP=3D$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP -ne 1000 ]; then
> +		echo "FAIL: expected 1000 routes with expires, got $N_EXP"
> +		ret=3D1
> +	else
> +	    sleep 5
> +	    REALTM_P=3D$($NS_EXEC strace -T sysctl \
> +		       -wq net.ipv6.route.flush=3D1 2>&1 | \
> +		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $=
0;}')

I guess the above works somehow ?!?

But I think something alike:

	# just after printing the banner
	TIME=3D$(which time)
	if [ -z "$TIME" ]; then
		echo "command 'time' is missing, skipping test"
		return
	fi
	# ...

		# replacing the strace command
		REALTM_P=3D$(time -f %e $NS_EXEC sysctl \
		       -wq net.ipv6.route.flush=3D1 2>&1)

would be better.

In any case you should check explicitly for the additionally needed
command ('strace' in your code, 'time' here).

And you could include the expected output in the commit message (just a
line, right?)

Cheers

Paolo


> +	    N_EXP_s5=3D$($IP -6 route list |grep expires|wc -l)
> +
> +	    if [ $N_EXP_s5 -ne 0 ]; then
> +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s5"
> +		ret=3D1
> +	    else
> +		ret=3D0
> +	    fi
> +	fi
> +
> +	# Permanent routes
> +	for i in $(seq 1 5000); do
> +	    $IP -6 route add 2001:30::$i \
> +		via 2001:10::2 dev dummy_10
> +	done
> +	# Temporary routes
> +	for i in $(seq 1 1000); do
> +	    # Expire route after 4 seconds
> +	    $IP -6 route add 2001:20::$i \
> +		via 2001:10::2 dev dummy_10 expires 4
> +	done
> +	N_EXP=3D$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP -ne 1000 ]; then
> +	    echo
> +	    "FAIL: expected 1000 routes with expires, got $N_EXP (5000 permanen=
t routes)"
> +		ret=3D1
> +	else
> +	    sleep 5
> +	    REALTM_T=3D$($NS_EXEC strace -T sysctl \
> +		       -wq net.ipv6.route.flush=3D1 2>&1 | \
> +		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $=
0;}')
> +	    N_EXP_s5=3D$($IP -6 route list |grep expires|wc -l)
> +
> +	    if [ $N_EXP_s5 -ne 0 ]; then
> +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s5 (5000 perman=
ent routes)"
> +		ret=3D1
> +	    else
> +		ret=3D0
> +	    fi
> +	fi
> +
> +	set +e
> +
> +	log_test $ret 0 "ipv6 route garbage collection (${REALTM_P}s, ${REALTM_=
T}s)"
> +
> +	cleanup &> /dev/null
> +}
> +
>  fib_suppress_test()
>  {
>  	echo
> @@ -2217,6 +2300,7 @@ do
>  	ipv4_mangle)			ipv4_mangle_test;;
>  	ipv6_mangle)			ipv6_mangle_test;;
>  	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
> +	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
> =20
>  	help) echo "Test names: $TESTS"; exit 0;;
>  	esac


