Return-Path: <netdev+bounces-35137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C7A7A739C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10052281AE8
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE951749C;
	Wed, 20 Sep 2023 07:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78321522F
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:04:07 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8190
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:04:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9adca291f99so642709366b.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695193444; x=1695798244; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtvuKxMbgejKPBCSdN6koZbRZKuD3bJTK6qH37Jo/rA=;
        b=Li2lBTmk3qYWYXoQV3QDN5oOPgwKT4LcKx6QKXKxDWLqLwsxjW6r6hdf81OBS/ngvD
         ajzXqpdhGfwLPYCDDb0p6vdIk5dplP/0E+Rm4mQX/dE8epWcBLkx9/NHWyWg/J5RxoRc
         GI1K7RBr8wWP6if/pHm+emhgOsG8+uF93L4mOjgZInod7IhpFdgfnwHY850FaLcA2JaA
         tb5jN4L9OxWCwVyr1WIBXSJFna4QG9sxR29guQ6fI5iboFhVEWX5JJQ67D8tkWE3rxZC
         Ya4a8cRdjHshiMxtZSebR5nMsw9HANJGDwOhknncBx2Hlz8NcGJDLbsZyz6HB02geU9g
         V4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695193444; x=1695798244;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtvuKxMbgejKPBCSdN6koZbRZKuD3bJTK6qH37Jo/rA=;
        b=ADG9Wg2fTZVJGk5pqCwV6YN0MlIX7BIj5fWvvctWePHDHkcUzMbvCR2CSp2qOwgNof
         9q7XzbqBsk4daHr8sj4OAGxByvcxgeSymZZ4oC+M8EPsRErcLH8bj6lMnNF/SovrQt5w
         zwnW81p5Kgtd2ohO13tXvBQZRA3UwN6kl+UbfBRDH0lCKCV8x52M6ha3Soq2obHXMUqj
         oZBK/xSzZmw0Qr9eshZ3lTHKLW+u+sVP3p+PuUhc5wDJoxASl6flQkOwBEtO+sRJo7q9
         KfzPEC3D+ZFyDAVsDd5++IM5AIDpbGGP/o1hEyVPD9l5Ol77wEotBX+8InyFQt3YPxGo
         CMVw==
X-Gm-Message-State: AOJu0YxoxwINOsxyGa/MNpGvoDlkTIfahKXaExtW8TcH26liW7mc9Be0
	F/mRq4lh+MZJLn7BISAZUMk=
X-Google-Smtp-Source: AGHT+IE+N80KjJYnEnssVoj2rN/N9PgJ8iUIr9k8fx0LxI/XSAgsGMTpd1y3t/UgbT+OZgQ8s12f6g==
X-Received: by 2002:a17:906:20d9:b0:99b:4ed4:5527 with SMTP id c25-20020a17090620d900b0099b4ed45527mr1417172ejc.25.1695193443578;
        Wed, 20 Sep 2023 00:04:03 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709061b4800b0099c53c44083sm8859768ejg.79.2023.09.20.00.04.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2023 00:04:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <ZQqOJOa_qTwz_k0V@debian.me>
Date: Wed, 20 Sep 2023 10:03:51 +0300
Cc: Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
 <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
 <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
 <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com> <ZQqOJOa_qTwz_k0V@debian.me>
To: Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

Ok on first see all is look come after in kernel 6.4 add : atomics: =
Provide rcuref - scalable reference counting  ( =
https://www.spinics.net/lists/linux-tip-commits/msg62042.html )

I check all running machine with kernel 6.4.2 is minimal and have same =
bug report.

i have fell machine with kernel 6.3.9 and not see problems there .

and the problem may be is allocate in this part :=20

[39651.444202] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[39651.444297] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[39651.444391] dst_release (./arch/x86/include/asm/preempt.h:95 =
./include/linux/rcuref.h:151 net/core/dst.c:166)
[39651.444487] __dev_queue_xmit (./include/net/dst.h:283 =
net/core/dev.c:4158)
[39651.444582] ? nf_hook_slow (./include/linux/netfilter.h:143 =
net/netfilter/core.c:626)

may be changes in dst.c make problem , I'm guessing at the moment.=20

but in real with kernel 6.3 all is fine for now.

dst.c changes 6.3.9 > 6.5.4 :

--- linux-6.3.9/net/core/dst.c	2023-06-21 14:02:19.000000000 +0000
+++ linux-6.5.4/net/core/dst.c	2023-09-19 10:30:30.000000000 +0000
@@ -66,7 +66,8 @@ void dst_init(struct dst_entry *dst, str
 	dst->tclassid =3D 0;
 #endif
 	dst->lwtstate =3D NULL;
-	atomic_set(&dst->__refcnt, initial_ref);
+	rcuref_init(&dst->__rcuref, initial_ref);
+	INIT_LIST_HEAD(&dst->rt_uncached);
 	dst->__use =3D 0;
 	dst->lastuse =3D jiffies;
 	dst->flags =3D flags;
@@ -162,31 +163,15 @@ EXPORT_SYMBOL(dst_dev_put);

 void dst_release(struct dst_entry *dst)
 {
-	if (dst) {
-		int newrefcnt;
-
-		newrefcnt =3D atomic_dec_return(&dst->__refcnt);
-		if (WARN_ONCE(newrefcnt < 0, "dst_release underflow"))
-			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
-					     __func__, dst, newrefcnt);
-		if (!newrefcnt)
-			call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
-	}
+	if (dst && rcuref_put(&dst->__rcuref))
+		call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
 }
 EXPORT_SYMBOL(dst_release);

 void dst_release_immediate(struct dst_entry *dst)
 {
-	if (dst) {
-		int newrefcnt;
-
-		newrefcnt =3D atomic_dec_return(&dst->__refcnt);
-		if (WARN_ONCE(newrefcnt < 0, "dst_release_immediate =
underflow"))
-			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
-					     __func__, dst, newrefcnt);
-		if (!newrefcnt)
-			dst_destroy(dst);
-	}
+	if (dst && rcuref_put(&dst->__rcuref))
+		dst_destroy(dst);
 }
 EXPORT_SYMBOL(dst_release_immediate);



> On 20 Sep 2023, at 9:16, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> On Wed, Sep 20, 2023 at 09:05:10AM +0300, Martin Zaharinov wrote:
>>> On 20 Sep 2023, at 6:59, Eric Dumazet <edumazet@google.com> wrote:
>>> Again, your best route is a bisection.
>>=20
>> For now its not possible to make bisection , its hard to change =
kernel on running machine =E2=80=A6
>>=20
>=20
> You have to do bisection, unfortunately. There is many guides there on
> Internet. Or you can read Documentation/admin-guide/bug-bisect.rst.
>=20
> Bye!
>=20
> --=20
> An old man doll... just what I always wanted! - Clara


