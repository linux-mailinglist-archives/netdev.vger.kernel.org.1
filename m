Return-Path: <netdev+bounces-35643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED87AA73A
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id B6D331F21B4F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BEB385;
	Fri, 22 Sep 2023 03:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1197FD
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:06:38 +0000 (UTC)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDA194
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:06:36 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-493542a25dfso692275e0c.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695351996; x=1695956796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6X0PKOimTbsxZTjYFPpLza08mWiA8aUu9v5BicDRCw=;
        b=D4/qdFIeC0piD7JbsAvf92TruroGkb2HCagVDXyb9rTLaz+/B49VW6D6YcrWlYQcV/
         mh3xVwo7ycbGFyZFymOZ7VV3YjwLUXvGpV35bkiJg+n9gLp6tJ4+WTf3N+bMixTy2EH/
         tb4kKf1/jPr6bK1FqMoKarbwocezsjRFYbvw0IkNBuIc897PXaAXho9ydLOrCq9Z91a0
         4JSmi9JINdEYqSlY+AwBTN5VvK8cv7eHqL9QRsHxViJZnRlBwSAwLuNgJSO2voMGy4aB
         ttdeQuk+rc0WWsiRd6oz7KMkJZ/F/blghY30V2Dpwk0pnhqcnvltjoYVdupOps13XOjJ
         WJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695351996; x=1695956796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6X0PKOimTbsxZTjYFPpLza08mWiA8aUu9v5BicDRCw=;
        b=SNfrfq1sNc28u/idl/H82f8rdt3fC6q231afPB/TmLYS+8UvqNLOWdZ1mmJRkRc7T1
         0Q0WpFcoi4mmPTlczGkteTOSKsMHlXL95wKAQ76N5h50X9iQ0AleZCQgjtA88Y4bblhu
         Kb9CXXdnUFUgB5KGQ8TNtjtfDSCScc8CCdXVSTs4HwYcCLeA/ZwS2J9Z6k8FvAo15/x1
         q74FJv2r8ILDtDboDISmnfpkgfASKRUvpqmgAtY7wGfxa4/oYaKRLxsnmsFnQ/hBMFd9
         rten2V3c4pIBNhYaN+2yD7QKeG1qxxodj6Q4305CAKG3BdZrOoHnZdPFDoBNFDalqXhE
         eCJQ==
X-Gm-Message-State: AOJu0Yxr3IeFWM7wLEfxufPbsfDJzvn3aPt/amWK84+oxVPxG4EKXRnr
	uC+8inarPLXmX7Fx3EcDwsU=
X-Google-Smtp-Source: AGHT+IGguXOsPlNeZ6P6fRewB6MqTQ2QHYfhQiTih2KfqgfrthzJhwuk/JVd2WRsCAk7JPC8igNEng==
X-Received: by 2002:a05:6122:1697:b0:493:d68a:951 with SMTP id 23-20020a056122169700b00493d68a0951mr8895441vkl.14.1695351994464;
        Thu, 21 Sep 2023 20:06:34 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b0068fe7e07190sm2121118pfe.3.2023.09.21.20.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 20:06:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id AD13E81B96D2; Fri, 22 Sep 2023 10:06:31 +0700 (WIB)
Date: Fri, 22 Sep 2023 10:06:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Martin Zaharinov <micron10@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev <netdev@vger.kernel.org>, patchwork-bot+netdevbpf@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kuba+netdrv@kernel.org, dsahern@gmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Wangyang Guo <wangyang.guo@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
Message-ID: <ZQ0EtyRxjzQTrPNd@debian.me>
References: <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
 <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com>
 <ZQqOJOa_qTwz_k0V@debian.me>
 <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
 <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
 <CANn89iJCJhJ=RWqPGkdbPoXhoa1W9ovi0s1t4242vsz-1=0WLw@mail.gmail.com>
 <85F1F301-BECA-4210-A81F-12CAEEC85FD7@gmail.com>
 <be58d429-90d1-42ff-a36b-da318db6ee68@gmail.com>
 <6A98504D-DB99-42A5-A829-B81739822CB2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CmhnOXDG7xp31zXy"
Content-Disposition: inline
In-Reply-To: <6A98504D-DB99-42A5-A829-B81739822CB2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--CmhnOXDG7xp31zXy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 11:13:55AM +0300, Martin Zaharinov wrote:
> Hi Bagas,
>=20
>=20
> Its not easy to make this on production, have too many users on it.
>=20
> i make checks and find with kernel 6.3.12-6.5.13 all is fine.
> on first machine that i have with kernel 6.4 and still work run kernel 6.=
4.2 and have problem.
>=20
> in my investigation problem is start after migration to kernel 6.4.x=20
>=20
> in 6.4 kernel is add rcuref :=20
>=20
> https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.4=20
>=20
> commit bc9d3a9f2afca189a6ae40225b6985e3c775375e
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu Mar 23 21:55:32 2023 +0100
>=20
> net: dst: Switch to rcuref_t reference counting

Is it the culprit you look for? Had you done the bisection and it points
the culprit to that commit

>=20
> Under high contention dst_entry::__refcnt becomes a significant bottlenec=
k.
>=20
> atomic_inc_not_zero() is implemented with a cmpxchg() loop, which goes in=
to
> high retry rates on contention.
>=20
> Switch the reference count to rcuref_t which results in a significant
> performance gain. Rename the reference count member to __rcuref to reflect
> the change.
>=20
> The gain depends on the micro-architecture and the number of concurrent
> operations and has been measured in the range of +25% to +130% with a
> localhost memtier/memcached benchmark which amplifies the problem
> massively.
>=20
> Running the memtier/memcached benchmark over a real (1Gb) network
> connection the conversion on top of the false sharing fix for struct
> dst_entry::__refcnt results in a total gain in the 2%-5% range over the
> upstream baseline.
>=20
> Reported-by: Wangyang Guo <wangyang.guo@intel.com>
> Reported-by: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20230307125538.989175656@linutronix.de
> Link: https://lore.kernel.org/r/20230323102800.215027837@linutronix.de
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>=20
>=20
> and i think problem is here :=20
>=20
> --- a/net/core/dst.c
> +++ b/net/core/dst.c
> @@ -66,7 +66,7 @@ void dst_init(struct dst_entry *dst, str
> dst->tclassid =3D 0;
> #endif
> dst->lwtstate =3D NULL;
> - atomic_set(&dst->__refcnt, initial_ref);
> + rcuref_init(&dst->__refcnt, initial_ref);
> dst->__use =3D 0;
> dst->lastuse =3D jiffies;
> dst->flags =3D flags;
> @@ -162,31 +162,15 @@ EXPORT_SYMBOL(dst_dev_put);
>=20
> void dst_release(struct dst_entry *dst)
> {
> - if (dst) {
> - int newrefcnt;
> -
> - newrefcnt =3D atomic_dec_return(&dst->__refcnt);
> - if (WARN_ONCE(newrefcnt < 0, "dst_release underflow"))
> - net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
> - __func__, dst, newrefcnt);
> - if (!newrefcnt)
> - call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
> - }
> + if (dst && rcuref_put(&dst->__refcnt))
> + call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
> }
> EXPORT_SYMBOL(dst_release);
>=20
> void dst_release_immediate(struct dst_entry *dst)
> {
> - if (dst) {
> - int newrefcnt;
> -
> - newrefcnt =3D atomic_dec_return(&dst->__refcnt);
> - if (WARN_ONCE(newrefcnt < 0, "dst_release_immediate underflow"))
> - net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
> - __func__, dst, newrefcnt);
> - if (!newrefcnt)
> - dst_destroy(dst);
> - }
> + if (dst && rcuref_put(&dst->__refcnt))
> + dst_destroy(dst);
> }
> EXPORT_SYMBOL(dst_release_immediate);
>=20
>=20
> but this is my thinking
>=20

What do you think that above causes your regression?

Confused...

[To Thorsten: I'm unsure if the reporter do the bisection and suddenly he f=
ound
the culprit commit. Should I add it to regzbot? I had dealt with this repor=
ter
before when he reported nginx regression and he didn't respond with bisecti=
on
to the point that I had to mark it as inconclusive (see regzbot dashboard).
What advice can you provide to him?]

--=20
An old man doll... just what I always wanted! - Clara

--CmhnOXDG7xp31zXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQ0EsgAKCRD2uYlJVVFO
o9QDAQDpvd9PEpZckbP7tZxkUL1QqIWYpzgiCXrgfcE/vJFnBwEA9JGq1g2jr+Z/
n37uKBx6W86b3MJGlDkQC4t+TrTnuAI=
=JJdN
-----END PGP SIGNATURE-----

--CmhnOXDG7xp31zXy--

