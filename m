Return-Path: <netdev+bounces-35146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360C7A742D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B19B1C20997
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C88C09;
	Wed, 20 Sep 2023 07:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78A5395
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:32:23 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17554CA
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:32:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-532c3b4b55eso1782388a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695195140; x=1695799940; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pORGOvhMLEtGSnXrx5AOPrF1BTFbPR5dAcAmBCxlUrc=;
        b=boWPKxqGjZtnHLfkKWJaEylniWfxUwUGjt5oNtDz1ZvNmzjdVenQlyl9u1br5dA1Pm
         ShL+285MHR/mGl7oJzMcTyWd7k0QtVUPRw5dzXqpVSt689/0X4cJ/Sof7pOi/Cdyo8+K
         nidQVq5wpEw2SMBbIR7AdySbF1uKY4CwD5hn+r+cB2h9uuETOtVzbtMhoSLCjng78w7l
         LwuYMUifKXyLrsxuAGtBh2fr5FVKfzr3P8EvMNHF5ekF6FkZvKLaFpeKDv9BFttEre7m
         bcODX2kCgReVm4zaeaf2G4vqiYFx4v9ZQpRXcLl1i16r4wWrWHJjvX5mkIun6gJCS9W8
         CcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195140; x=1695799940;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pORGOvhMLEtGSnXrx5AOPrF1BTFbPR5dAcAmBCxlUrc=;
        b=e1qQAGH6/aGw+qNkmg970lsQlZUsNODVKTS1qG8K5K/QscK8kfadVvXfEI9UzS+ucv
         kLYGS3JjrIQgd9fhtyALVORx91Cns+Llb9tbX3mdmnmC2TS1oJ6fdYoPFpk/rH42ePFb
         EPlj6NmiLUBNdG6qB6NTnFtsPI4sjPOHJD63udU5U1fHtCQg+LwNfwtO+OZPLgv/uNMw
         Wwn3Pma91ZkzgfjPRjIhiB67O76DCTZX8PpvxXbx0jih/IZkt2zt4v6lteN8pqmT7jE3
         gyowH8xqt+m3ZbcbzvFDS1FhscwoD8x8uDi0wlOTHvFWqcRSBw0lLrjQxsFG7ho7lAEY
         0n0w==
X-Gm-Message-State: AOJu0Yxy2C3qq4FW1317VcyusKTNMn3lZcxMQq5WtTcfU8ws9S/PLHCH
	BTOkCNQBDD5iFf7279D5Le8=
X-Google-Smtp-Source: AGHT+IHwgOFGVySNsijIj5w8sy9ifh8lnGO8HWM4FkIxlVPCEOQ5wn2XYuQ+pi029Zdttf2PjGKIlA==
X-Received: by 2002:a05:6402:14d6:b0:532:c6d7:b93c with SMTP id f22-20020a05640214d600b00532c6d7b93cmr1607086edx.5.1695195140380;
        Wed, 20 Sep 2023 00:32:20 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id eh16-20020a0564020f9000b005256aaa6e7asm3924058edb.78.2023.09.20.00.32.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2023 00:32:19 -0700 (PDT)
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
In-Reply-To: <CANn89iJCJhJ=RWqPGkdbPoXhoa1W9ovi0s1t4242vsz-1=0WLw@mail.gmail.com>
Date: Wed, 20 Sep 2023 10:32:08 +0300
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
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
Message-Id: <85F1F301-BECA-4210-A81F-12CAEEC85FD7@gmail.com>
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
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I will make this yes .

And will wait if any find fix in future release.

Thanks for your time Eric

m.



> On 20 Sep 2023, at 10:29, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Wed, Sep 20, 2023 at 9:25=E2=80=AFAM Eric Dumazet =
<edumazet@google.com> wrote:
>>=20
>> On Wed, Sep 20, 2023 at 9:04=E2=80=AFAM Martin Zaharinov =
<micron10@gmail.com> wrote:
>>>=20
>>> Hi
>>>=20
>>> Ok on first see all is look come after in kernel 6.4 add : atomics: =
Provide rcuref - scalable reference counting  ( =
https://www.spinics.net/lists/linux-tip-commits/msg62042.html )
>>>=20
>>> I check all running machine with kernel 6.4.2 is minimal and have =
same bug report.
>>>=20
>>> i have fell machine with kernel 6.3.9 and not see problems there .
>>>=20
>>> and the problem may be is allocate in this part :
>>>=20
>>> [39651.444202] ? rcuref_put_slowpath (lib/rcuref.c:267 =
(discriminator 1))
>>> [39651.444297] ? rcuref_put_slowpath (lib/rcuref.c:267 =
(discriminator 1))
>>> [39651.444391] dst_release (./arch/x86/include/asm/preempt.h:95 =
./include/linux/rcuref.h:151 net/core/dst.c:166)
>>> [39651.444487] __dev_queue_xmit (./include/net/dst.h:283 =
net/core/dev.c:4158)
>>> [39651.444582] ? nf_hook_slow (./include/linux/netfilter.h:143 =
net/netfilter/core.c:626)
>>>=20
>>> may be changes in dst.c make problem , I'm guessing at the moment.
>>>=20
>>> but in real with kernel 6.3 all is fine for now.
>>>=20
>>> dst.c changes 6.3.9 > 6.5.4 :
>>=20
>> Then start a real bisection. This is going to be the last time I say =
it.
>=20
> Or stick to an older kernel for your production, and wait for others
> to find the issue.


