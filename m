Return-Path: <netdev+bounces-19444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3EE75AAED
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC39281586
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B419A1C;
	Thu, 20 Jul 2023 09:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F919A11
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:33:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3F446B7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689845547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chtf0bMwiSNUyjYGe/wL1aSLw8MyZc7MyMHBkyGQNy4=;
	b=BWonFoep2Yqdu/o9U/bp5gpC5xa1yPXwUwdIWVWo3Jw4NR2wSbZ7aNJabcl71MA3pEuQ+m
	JAmj5ICfYywoJLApGT1PXdy52iN6ISrlk69WBXITy8fKAM84ZJe/nn520C5sb1FTuPLc88
	7P3BnmQbKZC8kPbvqSvr4RjFl05vRbo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-tcn1R5GlPIaOlivaJ9Q4tw-1; Thu, 20 Jul 2023 05:32:26 -0400
X-MC-Unique: tcn1R5GlPIaOlivaJ9Q4tw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6364867fa8aso1876426d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689845545; x=1690450345;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chtf0bMwiSNUyjYGe/wL1aSLw8MyZc7MyMHBkyGQNy4=;
        b=iUZLQMHq7FMkBOG3GJp6NiBdLgfcCfEgGXKtNpAweLL63hVmUBnWiCYtEFyDq51oLt
         BRdMsUL0+G1b+PcjQhRCEAgLxQGPhc0YmNRil0H/Qjkhqoj+hfWHCbpRUqa9zRhOzj0H
         jteayrHUZtH6nggKN5JHZK4GwmruZyk1dv3TGWuZ2k+IJg9rv6/LXlmh+eDJVHAMQw4b
         I9VRwi1ml6KQq1rPXHT0PBL/L+ypQKl8USKcfqLTW1F9wq65y9LlMo0Fl6xlAPWs+rpp
         txeNiBsAVCQvksXd8AaKVVjLey0xZSeSOYleL+8xfFRL2LUp2tai/Hw4t2/Ubu6UNOJn
         Tokg==
X-Gm-Message-State: ABy/qLYfSXYn0YLrXBQTqi8d17IuNo65HiTI2iMjD6TqURddfEK+Sgds
	GoRw28sXCQn9xUY+vVVl5mqDODaxvTWMa7e9/DTGdfainM4IlUPSDabvqI8RpZ6gMpVjKqheJO6
	pp05xg5zCDO9FRhwA
X-Received: by 2002:a05:6214:2409:b0:635:da19:a67f with SMTP id fv9-20020a056214240900b00635da19a67fmr2174503qvb.1.1689845545451;
        Thu, 20 Jul 2023 02:32:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0BFPxzy8qCCF7VUkEc5JGkNoK7Hlg87vy/uOc1PYBcyi7CvIa0GkOVJJEj9cQRmlLx6s8oQ==
X-Received: by 2002:a05:6214:2409:b0:635:da19:a67f with SMTP id fv9-20020a056214240900b00635da19a67fmr2174476qvb.1.1689845545109;
        Thu, 20 Jul 2023 02:32:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ce0cc000000b00623950fbe48sm214321qvk.41.2023.07.20.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:32:24 -0700 (PDT)
Message-ID: <9743a6cc267276bfeba5b0fdcf7ba9a4077c67e1.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add a test case
 for IPv6 garbage collection
From: Paolo Abeni <pabeni@redhat.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, dsahern@kernel.org, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  martin.lau@linux.dev, kernel-team@meta.com,
 yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Date: Thu, 20 Jul 2023 11:32:20 +0200
In-Reply-To: <20230718180321.294721-3-kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
	 <20230718180321.294721-3-kuifeng@meta.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-18 at 11:03 -0700, Kui-Feng Lee wrote:
> Add 10 IPv6 routes with expiration time.  Wait for a few seconds
> to make sure they are removed correctly.
>=20
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

Same thing as the previous patch.

> ---
>  tools/testing/selftests/net/fib_tests.sh | 49 +++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/sel=
ftests/net/fib_tests.sh
> index 35d89dfa6f11..55bc6897513a 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -9,7 +9,7 @@ ret=3D0
>  ksft_skip=3D4
> =20
>  # all tests in this script. Can be overridden with -t option
> -TESTS=3D"unregister down carrier nexthop suppress ipv6_notify ipv4_notif=
y ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4=
_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_ma=
ngle ipv4_bcast_neigh"
> +TESTS=3D"unregister down carrier nexthop suppress ipv6_notify ipv4_notif=
y ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4=
_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_ma=
ngle ipv4_bcast_neigh fib6_gc_test"

At this point is likely worthy splitting the above line in multiple
ones, something alike:

TESTS=3D"unregister down carrier nexthop suppress ipv6_notify \
	ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric
\
	ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw \
	rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh \
	fib6_gc_test"

> =20
>  VERBOSE=3D0
>  PAUSE_ON_FAIL=3Dno
> @@ -747,6 +747,52 @@ fib_notify_test()
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
> +	OLD_INTERVAL=3D$(sysctl -n net.ipv6.route.gc_interval)
> +	# Check expiration of routes every 3 seconds (GC)
> +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=3D3
> +
> +	$IP link add dummy_10 type dummy
> +	$IP link set dev dummy_10 up
> +	$IP -6 address add 2001:10::1/64 dev dummy_10
> +
> +	for i in 0 1 2 3 4 5 6 7 8 9; do
		$(seq 0 9)

> +	    # Expire route after 2 seconds
> +	    $IP -6 route add 2001:20::1$i \
> +		via 2001:10::2 dev dummy_10 expires 2
> +	done
> +	N_EXP=3D$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP -ne 10 ]; then
> +		echo "FAIL: expected 10 routes with expires, got $N_EXP"
> +		ret=3D1
> +	else
> +	    sleep 4
> +	    N_EXP_s20=3D$($IP -6 route list |grep expires|wc -l)
> +
> +	    if [ $N_EXP_s20 -ne 0 ]; then
> +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s20"
> +		ret=3D1
> +	    else
> +		ret=3D0
> +	    fi
> +	fi

Possibly also worth trying with a few K of permanent routes, and dump
the time required in both cases?

> +
> +	set +e
> +
> +	log_test $ret 0 "ipv6 route garbage collection"
> +
> +	sysctl -wq net.ipv6.route.gc_interval=3D$OLD_INTERVAL

No need to restore, gc_interval is a per namespace param specific
>=20


