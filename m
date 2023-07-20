Return-Path: <netdev+bounces-19445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8A75AB09
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F73281A9A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82719A1C;
	Thu, 20 Jul 2023 09:38:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC2174C7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:38:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2374686
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689845919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AWjVLpAonFx6U+jLEFc+D84W41RKV7H4k3WlbmwTbU=;
	b=ND+YOTLgkgX7xS9QUiehiWMoPPJw6+G371sEKZjh5bK8oucB9YBErRzFsAW16C/KgSHA3Y
	baidvD7seWBOC80NcWPml2KoHrfLZLZt2ycFH4P23rUGGALqv1atUnhl67kxxhvcpjp3fN
	ZRc1DslpAHBP4v/xuUtj3kLHX5f6SrI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-AE4wikp6NNezmPtybOZwfg-1; Thu, 20 Jul 2023 05:38:37 -0400
X-MC-Unique: AE4wikp6NNezmPtybOZwfg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7672918d8a4so20711385a.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689845917; x=1690450717;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0AWjVLpAonFx6U+jLEFc+D84W41RKV7H4k3WlbmwTbU=;
        b=kr7YVM5MCkzqe5rS/pE5topKMhDK0QTo0+Up5ykSpIbNxlggP6ToFAvpFE/ucy9Z1t
         84vjt+dSNXBQ6JQzw6rz9qK/Tfx6WPgo498V5du77lZnN77DfXaW6AstcUfYmB0rjYbM
         fyy52+nWCo+CtWxtKNwPrwKmY20ESKnVQVwn0bTN7vEV48GOxo9IPP5sjxJ5Innub8oa
         OwCzijn+armXMqgc9z9yJb1rkesdMeDLOzhtzgUifEjRyVFpfvkIKPM/OHwqIYF6DPWL
         cNXZRFLyqhHOi/xvtTU0jTAN3fPciT+kPxjmhF75OxXRPWIunVm0Gz8cMgSDYDdC7nM6
         A4pA==
X-Gm-Message-State: ABy/qLYrxqmondBJOV8sjuVvvHskFkXxpBYfW0kRiz9bbfK0LxN1gWde
	zZVqszb4S0M3nNZIwULMX89C+6yG2puFn7i46q6YPG5QBfEQADYuRLhU4fNERblGdKLyxEgYkg+
	gjTf8RuuNps73T6yN
X-Received: by 2002:a05:6214:1305:b0:626:2305:6073 with SMTP id pn5-20020a056214130500b0062623056073mr2253701qvb.4.1689845917355;
        Thu, 20 Jul 2023 02:38:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZNpelH74SlrM5sHH5r/FZh0EFlX2FFsKs2gMRUKLjx/oalUJ5qqgnEu5Vyih99V+yhGmD8A==
X-Received: by 2002:a05:6214:1305:b0:626:2305:6073 with SMTP id pn5-20020a056214130500b0062623056073mr2253684qvb.4.1689845917017;
        Thu, 20 Jul 2023 02:38:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id x14-20020a0ce0ce000000b00623813aa1d5sm211068qvk.89.2023.07.20.02.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:38:36 -0700 (PDT)
Message-ID: <348f3a7ba5477170f81660acb6a3f0c71295f9db.camel@redhat.com>
Subject: Re: [PATCH net-next v3 0/2] Remove expired routes with a separated
 list of routes.
From: Paolo Abeni <pabeni@redhat.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, dsahern@kernel.org, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  martin.lau@linux.dev, kernel-team@meta.com,
 yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Date: Thu, 20 Jul 2023 11:38:33 +0200
In-Reply-To: <20230718183351.297506-1-kuifeng@meta.com>
References: <20230718183351.297506-1-kuifeng@meta.com>
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

On Tue, 2023-07-18 at 11:33 -0700, Kui-Feng Lee wrote:
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tr=
ee
> can be expensive if the number of routes in a table is big, even if most =
of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The size of a Linux IPv6 routing table can become a big problem if not
> managed appropriately.  Now, Linux has a garbage collector to remove
> expired routes periodically.  However, this may lead to a situation in th=
e routing path is blocked for a long period due to an
> excessive number of routes.
>=20
> For example, years ago, there is a commit c7bb4b89033b ("ipv6: tcp: drop
> silly ICMPv6 packet too big messages") about "ICMPv6 Packet too big
> messages". The root cause is that malicious ICMPv6 packets were sent back
> for every small packet sent to them. These packets add routes with an
> expiration time that prompts the GC to periodically check all routes in t=
he
> tables, including permanent ones.
>=20
> Why Route Expires
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Users can add IPv6 routes with an expiration time manually. However,
> the Neighbor Discovery protocol may also generate routes that can
> expire.  For example, Router Advertisement (RA) messages may create a
> default route with an expiration time. [RFC 4861] For IPv4, it is not
> possible to set an expiration time for a route, and there is no RA, so
> there is no need to worry about such issues.
>=20
> Create Routes with Expires
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> You can create routes with expires with the  command.
>=20
> For example,
>=20
>     ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \=20
>         dev enp0s3 expires 30
>=20
> The route that has been generated will be deleted automatically in 30
> seconds.
>=20
> GC of FIB6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The function called fib6_run_gc() is responsible for performing
> garbage collection (GC) for the Linux IPv6 stack. It checks for the
> expiration of every route by traversing the trees of routing
> tables. The time taken to traverse a routing table increases with its
> size. Holding the routing table lock during traversal is particularly
> undesirable. Therefore, it is preferable to keep the lock for the
> shortest possible duration.
>=20
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The cause of the issue is keeping the routing table locked during the
> traversal of large trees. To solve this problem, we can create a separate
> list of routes that have expiration. This will prevent GC from checking
> permanent routes.
>=20
> Result
> =3D=3D=3D=3D=3D=3D
>=20
> We conducted a test to measure the execution times of fib6_gc_timer_cb()
> and observed that it enhances the GC of FIB6. During the test, we added
> permanent routes with the following numbers: 1000, 3000, 6000, and
> 9000. Additionally, we added a route with an expiration time.
>=20
> Here are the average execution times for the kernel without the patch.
>  - 120020 ns with 1000 permanent routes
>  - 308920 ns with 3000 ...
>  - 581470 ns with 6000 ...
>  - 855310 ns with 9000 ...
>=20
> The kernel with the patch consistently takes around 14000 ns to execute,
> regardless of the number of permanent routes that are installed.
>=20
> Major changes from v2:
>=20
>  - Remove unnecessary and incorrect sysctl restoring in the test case.
>=20
> Major changes from v1:
>=20
>  - Moved gc_link to avoid creating a hole in fib6_info.
>=20
>  - Moved fib6_set_expires*() and fib6_clean_expires*() to the header
>    file and inlined. And removed duplicated lines.
>=20
>  - Added a test case.
>=20
> ---
> v1: https://lore.kernel.org/all/20230710203609.520720-1-kuifeng@meta.com/
> v2: https://lore.kernel.org/all/20230718180321.294721-1-kuifeng@meta.com/

Too bad I did not notice v3 before starting reviewing v2.

When posting a new version you must wait the 24h quarantine period,
see:

https://elixir.bootlin.com/linux/v6.4/source/Documentation/process/maintain=
er-netdev.rst#L15

I assume this does not cope with the feedback on previous version ;)

/P


