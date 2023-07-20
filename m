Return-Path: <netdev+bounces-19430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA475AA78
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF021C212E2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFFB38D;
	Thu, 20 Jul 2023 09:19:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A1361
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:19:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1AE5276
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689844740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuwUfUHdA5X8aVhuZ1jkLox+VIo/gSV8aH8b/RIqV9Q=;
	b=Df3x3VXOH+ElfiMLrRXlFd7IS/XM/w4Yqx6w7D0bdUoZIVn2RR9QtCWdKUBZsiaHfz9daT
	N/MkDUVjBsfUIW9hp62xvmr991c3uYMfOPjheg+OeivS6oUSUvgsl/94kloXwNwVW/3hP3
	vuHjcemJbZy1oDSpAEKcdSseLohfNJA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-f3PwmuSTM_O_oiw6SasaGQ-1; Thu, 20 Jul 2023 05:18:58 -0400
X-MC-Unique: f3PwmuSTM_O_oiw6SasaGQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767ca6391aeso15494285a.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689844738; x=1690449538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuwUfUHdA5X8aVhuZ1jkLox+VIo/gSV8aH8b/RIqV9Q=;
        b=Yb1WbvjQ+6cex8DhOucEiqLKm1JpyddwTj7bd3JLT3uKqo1hMTx1tqy/iK/FhF33pe
         B15BM+LSupNdQNjOINHywZBqHspnsBFqZ1tgn86ou4uwJdGSOHrs27u/WONJTXv916BD
         WZeMSOr49MyBgLQOm8pUXAJUU2VFEH99sTrWE8nnLFpl7SPeqtCfhQI3u+0Hm0Y6aRgF
         OJL2+WEd5SVBFXB3h37v/biu+NiQp+WKB/vEYeb5ylZPEVozJ7uDzKTpIXj9AVNAjXkq
         DChJZUx6fHDEpThmPv5wpMGEdL1aCp9GYqGXCsEjzGp15FmgEDLlDulaaBx+TJZItpBg
         xztA==
X-Gm-Message-State: ABy/qLbPHDUjROb6Vn6CPlcyrtG7YodoZFTbCWyvuMIC02v1szPZk1Cy
	4oYi1uBAl0ihwnakK6bz5kkSgCF9IAtrcICOu/G7hBVkyanDKgvS1xzeLeWESgksasUJPzAnbKm
	tjMG5kQIDVN5qugld
X-Received: by 2002:ad4:5ca5:0:b0:625:8684:33f3 with SMTP id q5-20020ad45ca5000000b00625868433f3mr2163843qvh.0.1689844738450;
        Thu, 20 Jul 2023 02:18:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwyc/hNlo6eFLceQhNHsJiQMChv7wjh64paEaIrX3wNbRZ80bjElWz75B8aA1Quvr4IYjVRg==
X-Received: by 2002:ad4:5ca5:0:b0:625:8684:33f3 with SMTP id q5-20020ad45ca5000000b00625868433f3mr2163828qvh.0.1689844738115;
        Thu, 20 Jul 2023 02:18:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id t25-20020a05620a035900b00767d62ed8e6sm115596qkm.19.2023.07.20.02.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:18:57 -0700 (PDT)
Message-ID: <32fa8af544b90be8c70ac52135fcb75aa7504f21.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] net/ipv6: Remove expired routes with a
 separated list of routes.
From: Paolo Abeni <pabeni@redhat.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, dsahern@kernel.org, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  martin.lau@linux.dev, kernel-team@meta.com,
 yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Date: Thu, 20 Jul 2023 11:18:54 +0200
In-Reply-To: <20230718180321.294721-2-kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
	 <20230718180321.294721-2-kuifeng@meta.com>
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

On Tue, 2023-07-18 at 11:03 -0700, Kui-Feng Lee wrote:
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tr=
ee
> can be expensive if the number of routes in a table is big, even if most =
of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.
>=20
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

There is a mismatch between the sender (Kui-Feng Lee
<thinker.li@gmail.com>) and the SoB tag, please either change the sob
or add a From: header tag to fix such mismatch.

> @@ -2312,6 +2323,40 @@ static int fib6_age(struct fib6_info *rt, void *ar=
g)
>  	return 0;
>  }
> =20
> +static void fib6_gc_table(struct net *net,
> +			  struct fib6_table *tb6,
> +			  void *arg)

Here 'arg' is actually 'struct fib6_gc_args *', you can/should update
the type (and name) accordingly ...

> +{
> +	struct fib6_info *rt;
> +	struct hlist_node *n;
> +	struct nl_info info =3D {
> +		.nl_net =3D net,
> +		.skip_notify =3D false,
> +	};
> +
> +	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
> +		if (fib6_age(rt, arg) =3D=3D -1)
> +			fib6_del(rt, &info);
> +}
> +
> +static void fib6_gc_all(struct net *net, void *arg)

... same here.


Cheers,

Paolo


