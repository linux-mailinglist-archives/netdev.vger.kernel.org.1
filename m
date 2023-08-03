Return-Path: <netdev+bounces-23916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006A676E274
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323301C21495
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26DA14263;
	Thu,  3 Aug 2023 08:07:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B89440
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:07:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A85B9E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691050040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jthayd5ui56Fpxqb9t3oQzEYmi7UMCMbE1ASe7GtkgY=;
	b=LMe/BuKCSYiuwFscQ8KkvFfptCLN8CpE5q8mj/kq6wro8u8v9bbBCzTfw4S4VTTe+PaTHf
	2mkrmuQtHInwM8D0wod7j+POP/007BA3wwpt+hXCBd/DYHZg+ynxHDodMZz5B+jaUiw5T5
	NXc8i7T6dxiwmpTqVw1lUX+MI8CDIEc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-hvSYrUyhNW6ZMlWy_m78Tw-1; Thu, 03 Aug 2023 04:07:18 -0400
X-MC-Unique: hvSYrUyhNW6ZMlWy_m78Tw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76ca3baaec8so14662485a.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691050038; x=1691654838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jthayd5ui56Fpxqb9t3oQzEYmi7UMCMbE1ASe7GtkgY=;
        b=mIxi/v13DfWne2OUefhMX6JWIowHiw81cLAaatZwTWtdr0u8ThO2lcbPMlSyuZsma4
         Mi3hv2bJiNZkNWUAviJve5Ry7UJTFlBqmeL4bmBSbXjr1mXruzgKNmdtLXEjWyiFfH8X
         mILQxRywn3S1EB2/ud/4kV9iDf/CbdMaGUPhKjmokwkUMKQNOBGMTHocHJAqLvTTZM/R
         yoZ2M0cLgBIyzm43B9qYpGD/bfuIhDfwadw4kPvecU4a2b9GJBo1p32wAuHOsCRxFq3i
         NAfoauywDAjbOM48WB3YbsTdj87+e4x97UPkB7/QV3AqFFfcEZUYro80dbSxKffM+S+C
         hyDA==
X-Gm-Message-State: ABy/qLadmeBgWCi7nwYeMfTmOTlbYm1OwXjXZlQ4uBIAlyfcjCR2+f5/
	r/fhK/GBXJ1uwRhnEuEgpBkPg7dJI3hXl+NabFi5D98jJcafvh/w96Y79CXliLf1qfo6rC+ESGB
	Toe+Hty0wHDU1sHwG
X-Received: by 2002:a05:620a:4402:b0:767:e5ae:85cf with SMTP id v2-20020a05620a440200b00767e5ae85cfmr20789793qkp.5.1691050038478;
        Thu, 03 Aug 2023 01:07:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFViPhNhnNp9SBe9EOo0iTO871MZ55RotErSLZwYTVfkCRo/1er0GobsFumxfa1ZKbpiUUQug==
X-Received: by 2002:a05:620a:4402:b0:767:e5ae:85cf with SMTP id v2-20020a05620a440200b00767e5ae85cfmr20789778qkp.5.1691050038153;
        Thu, 03 Aug 2023 01:07:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it. [146.241.226.226])
        by smtp.gmail.com with ESMTPSA id d8-20020a37c408000000b00767b4fa5d96sm5645884qki.27.2023.08.03.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:07:17 -0700 (PDT)
Message-ID: <9916825da00d375a33abdcb0aa773c5520a307e1.camel@redhat.com>
Subject: Re: [net-next 2/2] selftests: seg6: add selftest for NEXT-C-SID
 flavor in SRv6 End.X behavior
From: Paolo Abeni <pabeni@redhat.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>,  linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo Lungaroni
	 <paolo.lungaroni@uniroma2.it>, Ahmed Abdelsalam <ahabdels.dev@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>
Date: Thu, 03 Aug 2023 10:07:14 +0200
In-Reply-To: <20230731175117.17376-3-andrea.mayer@uniroma2.it>
References: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
	 <20230731175117.17376-3-andrea.mayer@uniroma2.it>
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

On Mon, 2023-07-31 at 19:51 +0200, Andrea Mayer wrote:
> From: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
>=20
> This selftest is designed for testing the support of NEXT-C-SID flavor
> for SRv6 End.X behavior. It instantiates a virtual network composed of
> several nodes: hosts and SRv6 routers. Each node is realized using a
> network namespace that is properly interconnected to others through veth
> pairs, according to the topology depicted in the selftest script file.
> The test considers SRv6 routers implementing IPv4/IPv6 L3 VPNs leveraged
> by hosts for communicating with each other. Such routers i) apply
> different SRv6 Policies to the traffic received from connected hosts,
> considering the IPv4 or IPv6 protocols; ii) use the NEXT-C-SID
> compression mechanism for encoding several SRv6 segments within a single
> 128-bit SID address, referred to as a Compressed SID (C-SID) container.
>=20
> The NEXT-C-SID is provided as a "flavor" of the SRv6 End.X behavior,
> enabling it to properly process the C-SID containers. The correct
> execution of the enabled NEXT-C-SID SRv6 End.X behavior is verified
> through reachability tests carried out between hosts belonging to the
> same VPN.
>=20
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Signed-off-by: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>

The patches LGTM, but there is a minor issues WRT the tag area. Since
this patch contains a

From: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>

tag, Paolo's sob should come first.

According to the the newly created shell script comments, it looks like
the patch as been co developed by both Paolo abd Andrea.

In that case the correct tag sequence would be:

SoB Paolo
Co-devel Andrea
SoB Andrea

Since the above is relevant for correct patch authorship attribution I
suggest to address that in a new revision.

BTW, I a really appreciate the descriptive-but-not-too-verbose commit
message!

Thanks,

Paolo


