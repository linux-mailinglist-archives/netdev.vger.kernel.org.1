Return-Path: <netdev+bounces-35509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917BF7A9BBD
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2BF282609
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47283AC2E;
	Thu, 21 Sep 2023 17:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6A19BDD
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:53:06 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFF4101AA
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:52:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405361bb949so8345175e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318748; x=1695923548; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GHbPt+uRiGazWwzPgy+ZoJBtbPuuy9FvR+oJREusTo=;
        b=H0aNzzYumxOiqq6nB58LAQuWcNLxF98CIBeFARjuyjl1Cr/YSd0oHCIqfhya9X9wOJ
         +boGagWWFYBBYVYfaxCw+o8YSI/TqdmJOiXaBa88cJ3Wtsbt8l9a38a2f9C4giDOmQqK
         D4pdAHV47mj/vLdMypVFf5IcNkgVVK9AsiPTaNtLnH40OYdVDvMOuuKJTAynF4S+jdtv
         hplVpJ6+IQldHKXiNbE82zW4uhclZXnmsc3WuKtbviUqkct5eWe5igjTp7G3VHLfPUF1
         gXMYaBTNjuglE1CpyJWrgCOYbZUkKPtfvhv5ryX5y1nP8b+a3v0nLHwfxbFWdN+iES48
         oFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318748; x=1695923548;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GHbPt+uRiGazWwzPgy+ZoJBtbPuuy9FvR+oJREusTo=;
        b=QW3xi2h/QaaMY1Ig3OPgC345hdMVlPriq+Jiswc28pUUaex1HCENeJx4exbxWq8ln0
         06gzSto+y+7ASCBLNo+bZ+x37g7WEOXbd01XPGWEpPTfgmZCys3LJ//Fj3ixDhQjJpxn
         U3kw4zerJDVb437s4zNrZVkXJi1GdbovUgViBzGM6VGxNBAWxIW5iTUyFPayScrWRFgm
         IUieFlW6VPMnXAeiRw5fmTElF2r7df/4JZ88nhSo1mUV7rtoGzsIveEQRVRJQAXheoBp
         V1q6ElmCvm9CSOcyk3WuPJkeyFp9czU/c+kIDwl1isSIZMRmRytZZ/h67cNEeBpB/a5d
         CvNg==
X-Gm-Message-State: AOJu0YydfWbIY1FPjay8pZO+zWBkiY+4DZ3qCOebLnPOKOrMSuedPBXn
	l/QjLdlmPJ7MA89L9RkwTCdCBUjWu94=
X-Google-Smtp-Source: AGHT+IHk6u2vH42kLc028jxZT7Xd8OecT2LXANAPrJi3C18LEbFJLa0bcZxvUBxJHM9dO3gn5lCZTQ==
X-Received: by 2002:a17:906:4d:b0:9aa:338:4a0f with SMTP id 13-20020a170906004d00b009aa03384a0fmr3877225ejg.72.1695284048245;
        Thu, 21 Sep 2023 01:14:08 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906584d00b00992b8d56f3asm666963ejs.105.2023.09.21.01.14.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 01:14:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <be58d429-90d1-42ff-a36b-da318db6ee68@gmail.com>
Date: Thu, 21 Sep 2023 11:13:55 +0300
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
Message-Id: <6A98504D-DB99-42A5-A829-B81739822CB2@gmail.com>
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
 <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
 <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
 <CANn89iJCJhJ=RWqPGkdbPoXhoa1W9ovi0s1t4242vsz-1=0WLw@mail.gmail.com>
 <85F1F301-BECA-4210-A81F-12CAEEC85FD7@gmail.com>
 <be58d429-90d1-42ff-a36b-da318db6ee68@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bagas,


Its not easy to make this on production, have too many users on it.

i make checks and find with kernel 6.3.12-6.5.13 all is fine.
on first machine that i have with kernel 6.4 and still work run kernel =
6.4.2 and have problem.

in my investigation problem is start after migration to kernel 6.4.x=20

in 6.4 kernel is add rcuref :=20

https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.4=20

commit bc9d3a9f2afca189a6ae40225b6985e3c775375e
Author: Thomas Gleixner <tglx@linutronix.de>
Date: Thu Mar 23 21:55:32 2023 +0100

net: dst: Switch to rcuref_t reference counting

Under high contention dst_entry::__refcnt becomes a significant =
bottleneck.

atomic_inc_not_zero() is implemented with a cmpxchg() loop, which goes =
into
high retry rates on contention.

Switch the reference count to rcuref_t which results in a significant
performance gain. Rename the reference count member to __rcuref to =
reflect
the change.

The gain depends on the micro-architecture and the number of concurrent
operations and has been measured in the range of +25% to +130% with a
localhost memtier/memcached benchmark which amplifies the problem
massively.

Running the memtier/memcached benchmark over a real (1Gb) network
connection the conversion on top of the false sharing fix for struct
dst_entry::__refcnt results in a total gain in the 2%-5% range over the
upstream baseline.

Reported-by: Wangyang Guo <wangyang.guo@intel.com>
Reported-by: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230307125538.989175656@linutronix.de
Link: https://lore.kernel.org/r/20230323102800.215027837@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>


and i think problem is here :=20

--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -66,7 +66,7 @@ void dst_init(struct dst_entry *dst, str
dst->tclassid =3D 0;
#endif
dst->lwtstate =3D NULL;
- atomic_set(&dst->__refcnt, initial_ref);
+ rcuref_init(&dst->__refcnt, initial_ref);
dst->__use =3D 0;
dst->lastuse =3D jiffies;
dst->flags =3D flags;
@@ -162,31 +162,15 @@ EXPORT_SYMBOL(dst_dev_put);

void dst_release(struct dst_entry *dst)
{
- if (dst) {
- int newrefcnt;
-
- newrefcnt =3D atomic_dec_return(&dst->__refcnt);
- if (WARN_ONCE(newrefcnt < 0, "dst_release underflow"))
- net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
- __func__, dst, newrefcnt);
- if (!newrefcnt)
- call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
- }
+ if (dst && rcuref_put(&dst->__refcnt))
+ call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
}
EXPORT_SYMBOL(dst_release);

void dst_release_immediate(struct dst_entry *dst)
{
- if (dst) {
- int newrefcnt;
-
- newrefcnt =3D atomic_dec_return(&dst->__refcnt);
- if (WARN_ONCE(newrefcnt < 0, "dst_release_immediate underflow"))
- net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
- __func__, dst, newrefcnt);
- if (!newrefcnt)
- dst_destroy(dst);
- }
+ if (dst && rcuref_put(&dst->__refcnt))
+ dst_destroy(dst);
}
EXPORT_SYMBOL(dst_release_immediate);


but this is my thinking


Martin


> On 21 Sep 2023, at 10:50, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> On 20/09/2023 14:32, Martin Zaharinov wrote:
>> I will make this yes .
>>=20
>> And will wait if any find fix in future release.
>>=20
>=20
> Please don't top-post; reply inline with appropriate context instead.
>=20
> Martin, what prevents you from doing bisection as Eric requested =
again?
> If you only have production systems, why can't you afford to have
> testing ones? Why not turning one of your prod machines to be testing
> and bisect from there?
>=20
> Sorry for inconvenience.
>=20
> --=20
> An old man doll... just what I always wanted! - Clara
>=20


