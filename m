Return-Path: <netdev+bounces-35142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F37A7401
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D19D281C5E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626C8830;
	Wed, 20 Sep 2023 07:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321F1C26
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:26:10 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B793
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:26:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-415155b2796so204251cf.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695194766; x=1695799566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEvUSZYn2QdyoynMg+EbUUA3yvQOOos33taxf2vHQIw=;
        b=VLld+sfgqSbrEaAj8WjEWCic+Znovc3Tb9jSTTK+WO7TAUrD7MllVKEkl7AhT2SS2e
         99N6255fb0Lz7a/wm43F20di86fcVFRWuoETyiJGFXgjlWc6O8wx8EnVrKuOnMklOlVT
         QH11i8JNzk4EHaFiWZLnaV89+P4cqpHCwLR9b1IqGkUIhosbC00ElQgYHWxD3d0wlFVi
         re7vhZrWpQKjuIzkv7udjcpDTG2bR6bV4K7vZ0NagYHqvmHIk6/nYCyJ3xwyG6LkPDNH
         IFhQHjfL6Q06T/Mdd7D7z2awJAuEfT1RA2N8E8JsKlzX81bVINlubI0Sjdj84DPcY8b1
         mvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194766; x=1695799566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEvUSZYn2QdyoynMg+EbUUA3yvQOOos33taxf2vHQIw=;
        b=NmMW3YVcDo8nSrOoRq0Cw3WcdnsP3Y98CYX9YGCFTPSNl3u2s54zW+2Tujt+pFZciD
         AuMOolwKsYDN39c3YKdfVTAYU8MNr8ui13hnTD/NdeTCu5/kLlyKHnbv2GaWmrcgjRIV
         6+3Z8/cz2hCpcHx9bf9L6nIT0ybrYNYxxd/Eb4RvaBOUfUWcnks6nthGfkczJjzq6z53
         iZ1iKElISpUlH6gs8lxgLSbK06R2O0XPBXrN8pgXxdp/pT4uwDnaDl2RmsTk6/CnU3OM
         fwED5E44cKCdLWMGxyi9sdrpzEd8+kUyOjb6qmJ5rE7PwG6N8YUljdcB1iN48SeGr9v4
         SZdA==
X-Gm-Message-State: AOJu0YxYZU1s60pgxH6nSv/HbHdaEyngjQ66S9yWBIjlLLRxeWdbGtJ6
	QUhlugb1eXjGrtzt1uaYYfEpvDrYYXgRaK8vjDchPg==
X-Google-Smtp-Source: AGHT+IGZe0+AHSCXUf+SgOKBwQLdbHtbQfJ7eNqn8GI+tHK505xeyQLT3Ll0cidm+HcXMILmlgW4mbwtt/1P/3/b14A=
X-Received: by 2002:a05:622a:3cd:b0:410:88dc:21b with SMTP id
 k13-20020a05622a03cd00b0041088dc021bmr215251qtx.26.1695194766220; Wed, 20 Sep
 2023 00:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com> <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com> <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
 <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com> <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com> <ZQqOJOa_qTwz_k0V@debian.me> <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
In-Reply-To: <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Sep 2023 09:25:54 +0200
Message-ID: <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
To: Martin Zaharinov <micron10@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	netdev <netdev@vger.kernel.org>, patchwork-bot+netdevbpf@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org, 
	dsahern@gmail.com, Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:04=E2=80=AFAM Martin Zaharinov <micron10@gmail.co=
m> wrote:
>
> Hi
>
> Ok on first see all is look come after in kernel 6.4 add : atomics: Provi=
de rcuref - scalable reference counting  ( https://www.spinics.net/lists/li=
nux-tip-commits/msg62042.html )
>
> I check all running machine with kernel 6.4.2 is minimal and have same bu=
g report.
>
> i have fell machine with kernel 6.3.9 and not see problems there .
>
> and the problem may be is allocate in this part :
>
> [39651.444202] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
> [39651.444297] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
> [39651.444391] dst_release (./arch/x86/include/asm/preempt.h:95 ./include=
/linux/rcuref.h:151 net/core/dst.c:166)
> [39651.444487] __dev_queue_xmit (./include/net/dst.h:283 net/core/dev.c:4=
158)
> [39651.444582] ? nf_hook_slow (./include/linux/netfilter.h:143 net/netfil=
ter/core.c:626)
>
> may be changes in dst.c make problem , I'm guessing at the moment.
>
> but in real with kernel 6.3 all is fine for now.
>
> dst.c changes 6.3.9 > 6.5.4 :

Then start a real bisection. This is going to be the last time I say it.

