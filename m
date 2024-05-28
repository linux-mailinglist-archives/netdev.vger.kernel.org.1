Return-Path: <netdev+bounces-98458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E518D1819
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4344F1C20A0A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66A51021;
	Tue, 28 May 2024 10:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92117E8F4
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890796; cv=none; b=KNhlKNFhZiyMgFpO2VyIRQCnSzkcH4vfhviyfeI6JQ3OY1X7pTtnMPKz+ynz1qRbd1aUIqSvqoRfwAo6MyaLGJXsfZVSP/U1a2Ond/Ge5Wmy2dMH0n7Tyi7FQ07M1POLwTOu7Rgx/YXYlQGa9eMlz8gva5IYR/abSyv7/qMKQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890796; c=relaxed/simple;
	bh=szMT7N/+KZhLSQad9fbgMTL64oc9NPmsHteSfuXWQVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GWH5P7PTCISlIWoNwAZbnAa2jmTGZKZ/v61hkyMRh5oaHYJIQ2EJ0jXZb1NZzDMXZh6JD4D6bmAKMCogldJWxFcrC/58WVC2tvommWK+ZVJqxHrBoBpC5rsURN9Fybx0O9+YzIy3xHWwA2NYl02+ihe2RyknG18w/SLcw4lh57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-eZ6TLXt4OrSAE8k5Cg2Xww-1; Tue, 28 May 2024 06:05:16 -0400
X-MC-Unique: eZ6TLXt4OrSAE8k5Cg2Xww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90E4D812296;
	Tue, 28 May 2024 10:05:15 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C51E840C6EB7;
	Tue, 28 May 2024 10:05:13 +0000 (UTC)
Date: Tue, 28 May 2024 12:05:12 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>
Subject: Re: [PATCH net-next] ipv6: sr: restruct ifdefines
Message-ID: <ZlWsWDFWDCcEa4r9@hog>
References: <20240528032530.2182346-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240528032530.2182346-1-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hangbin,

2024-05-28, 11:25:30 +0800, Hangbin Liu wrote:
> There are too many ifdef in IPv6 segment routing code that may cause logi=
c
> problems. like commit 160e9d275218 ("ipv6: sr: fix invalid unregister err=
or
> path"). To avoid this, the init functions are redefined for both cases. T=
he
> code could be more clear after all fidefs are removed.
>=20
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

I think this was suggested by Simon?


> @@ -520,7 +514,6 @@ int __init seg6_init(void)
>  =09if (err)
>  =09=09goto out_unregister_pernet;
> =20

(With a bit more context around this:)

> -#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
>  =09err =3D seg6_iptunnel_init();
>  =09if (err)
>  =09=09goto out_unregister_genl;
> =20
>  =09err =3D seg6_local_init();
>  =09if (err) {
>  =09=09seg6_iptunnel_exit();

With those changes, we don't need this weird partial uninit anymore,
we can just create a new label above the other seg6_iptunnel_exit()
call and jump there directly.

>  =09=09goto out_unregister_genl;
>  =09}
> -#endif
> =20
> -#ifdef CONFIG_IPV6_SEG6_HMAC
>  =09err =3D seg6_hmac_init();
>  =09if (err)
>  =09=09goto out_unregister_iptun;
> -#endif
> =20
>  =09pr_info("Segment Routing with IPv6\n");
> =20
>  out:
>  =09return err;
> -#ifdef CONFIG_IPV6_SEG6_HMAC
>  out_unregister_iptun:
> -#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
>  =09seg6_local_exit();

[jump here]

>  =09seg6_iptunnel_exit();
> -#endif
> -#endif
> -#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
>  out_unregister_genl:
> -#endif
> -#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6=
_HMAC)
>  =09genl_unregister_family(&seg6_genl_family);
> -#endif
>  out_unregister_pernet:
>  =09unregister_pernet_subsys(&ip6_segments_ops);
>  =09goto out;

--=20
Sabrina


