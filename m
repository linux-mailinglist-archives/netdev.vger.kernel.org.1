Return-Path: <netdev+bounces-35031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4627A68B2
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207CF1C20997
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB038DD2;
	Tue, 19 Sep 2023 16:16:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031AC31A65
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 16:16:10 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4DA1
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:16:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-532bf1943ebso1089509a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695140168; x=1695744968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SukbUqDWfjNtKvAvq6+slUB1LMFvgFfYW3AgQGsbtrA=;
        b=cNdHAb9BYQu2EINZ2OC2V4fZ+GVlU/4HrfzbePUrEhBctOMDac0rQ/Xsw8B5Cj6wXw
         v2cDZYE5S2MoIjFQPN14hngED4iuCSafMPuxOtaT2zO2cAzgMRXZb32XB4+gUZ9SYH+f
         o6Cju7rAsLO8INhZETXNEf84pB2+aR+6UFYUB3urpe14XKQ6ZPTZgT4CB5dRmqIiBB+P
         avGTw/9/NL8QjOILLYaAlcviVNjBflHfCCoROkbTUkuKEEk2UWaL5/2mxYBa4z8x9ue/
         geQwmCZKdxAcu5BRQjmgK1t/CO5j9mcAtiOnILyb38gcaMcpUlQMuGpqLgD5aJjP2lGC
         Xu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695140168; x=1695744968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SukbUqDWfjNtKvAvq6+slUB1LMFvgFfYW3AgQGsbtrA=;
        b=wLzNn+l3qqn47OPb90cb7ffB3bRBNlJqnw2VphE7zfQuLOlIoqTokPiTUK+Sts5iKO
         z+1TehQLdmCi+kVv6Z1dtid5zlHXRtB10CElHIjBMilfxKSg7YwVxh0Vf/XmqDsB1RKr
         XA5vHvZWnXaS5q1HnyudyM/pVb7rMVrEgs+JUthozVL8cKTJ2NlHOSDiCiiCMXvi02tO
         zQjwZzrswHQzjgrd80ov/kw+qVAV7IeesOdCgQsnq3HPmVZNEf845QDlQQHjkk7hBJkJ
         F6QpmafBTrvoFtxZEhIy19Ahw45bWhyLtp81KbjpOHyRqzW6d6hgz0DuHsCP3w6+zE1l
         DiLg==
X-Gm-Message-State: AOJu0YyFYAvChBbna2vpWLcqLu1lxrXnpJeHVxr6OYBJn8Ocl9pMB3du
	1ZNFPT2n/BOYaKuqj5VoZQT2eE13wTDxBlb2i+PQhA==
X-Google-Smtp-Source: AGHT+IFZA/rGttwX7tGD+DiS4HN6omEFPrAZ+AOzqP9CS/IHVQ5Go484VkX+R4puqfzR7jLSMBtKmNoB6LkmV+owcpA=
X-Received: by 2002:a17:907:2ceb:b0:9a1:d79a:418e with SMTP id
 hz11-20020a1709072ceb00b009a1d79a418emr10512508ejc.40.1695140167904; Tue, 19
 Sep 2023 09:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919004644.148236-1-jrife@google.com> <6509ac739ffe6_1dda1929434@willemb.c.googlers.com.notmuch>
In-Reply-To: <6509ac739ffe6_1dda1929434@willemb.c.googlers.com.notmuch>
From: Jordan Rife <jrife@google.com>
Date: Tue, 19 Sep 2023 09:15:55 -0700
Message-ID: <CADKFtnR+dbZf9Xc5k_62Ur7N8N2=ghvYY6GD8DgxruOPQhQiZw@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] net: prevent address rewrite in kernel_bind()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, airlied@redhat.com, 
	chengyou@linux.alibaba.com, kaishen@linux.alibaba.com, jgg@ziepe.ca, 
	leon@kernel.org, bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com, 
	teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com, 
	lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com, 
	horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, 
	fw@strlen.de, santosh.shilimkar@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Is there any real risk of callers passing these lengths out of bound?
>
> These are in-kernel callers, so they are by necessity trusted code. If
> there is a buggy caller, that will be addressed directly, rather than
> through these callee precondition checks.

Not to my knowledge, just being paranoid. I will remove the precondition checks.

> You want to pass &address?

Yep. Good catch.

-Jordan

