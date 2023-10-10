Return-Path: <netdev+bounces-39498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1C7BF88B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32DF1C20B18
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557718042;
	Tue, 10 Oct 2023 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMdr/pNw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47F16431
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:26:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE0A9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696933566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTHlTwU4uZiN8UO3TES+88nKKkaUDBWXQJI6+/WgYu8=;
	b=hMdr/pNwqTKcE8qdcQG+6K2nv8R7hBjON3Urc7+nFYVmXqztDpRtJs2yrExikPYpvOHEIe
	sTjS8P45e2+vhUNebgvl3OOzDMyMMH6xYGb0cLT3xPCSgwZJUTBq/DQxx36bA1Q0qSIVz9
	Oqx63eLpsut1uK5O2bvU9zdpIy72BiE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-1PsYXPEsPE-pPXA0tYjtIQ-1; Tue, 10 Oct 2023 06:25:55 -0400
X-MC-Unique: 1PsYXPEsPE-pPXA0tYjtIQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b295d163fdso122131166b.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933554; x=1697538354;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTHlTwU4uZiN8UO3TES+88nKKkaUDBWXQJI6+/WgYu8=;
        b=MebpOycZ9BhQpGL+QF9m+6EONPntwerfzd6F+G5h+NUPmvJ65cmszfBlXBXJvGsAPM
         N5YnD7nafnY37baq9ABh+k/4Ff5E4/ht9gpViFVH0rXZXNBfZwwiteUPzVFJrwV7i4j4
         cyvVPl7/rD/C+4Lteso3sfQp+zRWAojrnoK5cJZOsLb44FZaoWfbYFwy3+KFF7H8YOw1
         xVqGCGdxqzI7oIYxFI6StgAvfi3eVyNnEsBDdrCmDNzCzw/I0Gt8RbUkAsu7ZQULEAo4
         Jj++LTMxZi21pxGMYVyXaLsYUb82DrWueh5BtForYqLGhtJf3cOpEEOyHg0dkRWnA3HM
         QSCw==
X-Gm-Message-State: AOJu0YxX/ls7jYIPgQ1YYmzlAUoYC7oIyugLGOVwLYZi2FiT/R8+2uHx
	bBgDKbjK/Y7gxpNbaGl/Pj3vxZFhvwzMeSL+A4x8uNa3efgTroO4UUyM6VhkaDumrowvCn78+yX
	FS0MDfwVho1qx+RGa
X-Received: by 2002:a05:6402:5191:b0:52f:bedf:8f00 with SMTP id q17-20020a056402519100b0052fbedf8f00mr14632386edd.1.1696933553970;
        Tue, 10 Oct 2023 03:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE75sQGbfKRKWkJhKNVG7X96z1rcluOnaRC4YTGjeiZvnW8R9ofe5Wmn3aMyUHOu7bQ67/lYw==
X-Received: by 2002:a05:6402:5191:b0:52f:bedf:8f00 with SMTP id q17-20020a056402519100b0052fbedf8f00mr14632375edd.1.1696933553607;
        Tue, 10 Oct 2023 03:25:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id er24-20020a056402449800b0052febc781bfsm282373edb.36.2023.10.10.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:25:53 -0700 (PDT)
Message-ID: <96bdb031129cdebfa6e0bdd4342439d9d864518b.camel@redhat.com>
Subject: Re: [PATCH net 1/4] selftests: openvswitch: Add version check for
 pyroute2
From: Paolo Abeni <pabeni@redhat.com>
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Adrian Moreno <amorenoz@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>
Date: Tue, 10 Oct 2023 12:25:51 +0200
In-Reply-To: <20231006151258.983906-2-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
	 <20231006151258.983906-2-aconole@redhat.com>
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
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
> Paolo Abeni reports that on some systems the pyroute2 version isn't
> new enough to run the test suite.  Ensure that we support a minimum
> version of 0.6 for all cases (which does include the existing ones).
> The 0.6.1 version was released in May of 2021, so should be
> propagated to most installations at this point.
>=20
> The alternative that Paolo proposed was to only skip when the
> add-flow is being run.  This would be okay for most cases, except
> if a future test case is added that needs to do flow dump without
> an associated add (just guessing).  In that case, it could also be
> broken and we would need additional skip logic anyway.  Just draw
> a line in the sand now.
>=20
> Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://lore.kernel.org/lkml/8470c431e0930d2ea204a9363a60937289b7=
fdbe.camel@redhat.com/
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  tools/testing/selftests/net/openvswitch/openvswitch.sh | 2 +-
>  tools/testing/selftests/net/openvswitch/ovs-dpctl.py   | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/too=
ls/testing/selftests/net/openvswitch/openvswitch.sh
> index 9c2012d70b08e..220c3356901ef 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -525,7 +525,7 @@ run_test() {
>  	fi
> =20
>  	if python3 ovs-dpctl.py -h 2>&1 | \
> -	     grep "Need to install the python" >/dev/null 2>&1; then
> +	     grep -E "Need to (install|upgrade) the python" >/dev/null 2>&1; th=
en
>  		stdbuf -o0 printf "TEST: %-60s  [PYLIB]\n" "${tdesc}"
>  		return $ksft_skip
>  	fi
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools=
/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 912dc8c490858..9686ca30d516d 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -28,6 +28,8 @@ try:
>      from pyroute2.netlink import nlmsg_atoms
>      from pyroute2.netlink.exceptions import NetlinkError
>      from pyroute2.netlink.generic import GenericNetlinkSocket
> +    import pyroute2
> +
>  except ModuleNotFoundError:
>      print("Need to install the python pyroute2 package.")
>      sys.exit(0)
> @@ -1998,6 +2000,12 @@ def main(argv):
>      nlmsg_atoms.ovskey =3D ovskey
>      nlmsg_atoms.ovsactions =3D ovsactions
> =20
> +    # version check for pyroute2
> +    prverscheck =3D pyroute2.__version__.split(".")
> +    if int(prverscheck[0]) =3D=3D 0 and int(prverscheck[1]) < 6:
> +        print("Need to upgrade the python pyroute2 package.")

I think it would be better to propagate/print also the minimum version
required, so that the user should not have to resort looking at the
self-test sources to learn the required minimum version.

Cheers,

Paolo


