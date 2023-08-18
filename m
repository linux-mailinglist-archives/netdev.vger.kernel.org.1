Return-Path: <netdev+bounces-28921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2A7812BD
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9727A28213E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04011B7C8;
	Fri, 18 Aug 2023 18:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8C63A0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:18:39 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB71FE9
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:18:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so9395e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692382712; x=1692987512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3j4Mqn/PbeNoccarhbs+EdB7Fu2ck9H3LC4u5W/k/o=;
        b=NHuGuvQVCXo1QS1pE+nZc/9rYhs+1IJwmwoSCY6rdKHSK61HzJrCDuO7aEL5x4uNwL
         a7A6bHEhYKjE5qjg9dTUsTTrtMBmzrlVo/MTjNdAb/S6l3ovkXRFpb+fTlbV6woR9G5l
         GSZzg7HdUJTo7VHEkeXUvGIvP+15UKjOILSYNKGaTmWuXI/mQjYVSZ7t8ZJxS2KZIg4z
         gHu+D091lYezJYa48+Xh+k7boUNygg2PFF0D5rbLQ/wUoUp2jpC0opS3S6ZXMLTqL1uY
         AQtgF5sL8zAjxdxNO6M93RrFv/vlGa5Kc1I6wyKTJZN+X/nnBGKfv8VtB+ECbiEyrhvA
         H2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382712; x=1692987512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3j4Mqn/PbeNoccarhbs+EdB7Fu2ck9H3LC4u5W/k/o=;
        b=eMEWPo+pB4iyAEy4sss04gSJYK2Wa9/0RgArAdD+H9CfdMnRB5Xm+1Qn3DFQlIeVpM
         d35PN/XUENqnjqhxXo3UUfTP5+UbcegVBVum9M7P/v1c2hAEDdDKAkeq+3aVBmIDbbcM
         Lk58Z1R9SghxVkEcDZ4YdF2beIl5CYWbwaOxUUUSF6COdR7o+tKCjZBWTqjIqHtg69sp
         SlsbNp3tIbp+URg8Cd4ijKqIbyWThUtIbIyTGTPB3kkfw7uu/UnaGigzQBnhT0Y7ewey
         fu45mtTw1pQ14WJF0QiRryTLvv4CYyzWb7/uNeRHhmOPmQUOFsNhSUfIHDnfKfKjalhD
         +IMQ==
X-Gm-Message-State: AOJu0Yxt6MUk+yoMlCW3UxDTV6jZmULr9UI5lAwBX4b2+6sod3o6YWoK
	BCvaICibGLaTTdlJg1xfEH3sly+bKold8Wax9Cuirg==
X-Google-Smtp-Source: AGHT+IE2bnr83EpQmRKVuas2woPVovHkWEaZ3QEqDJfRlcyK67dVgTIbS1ftqyNCMU8/OGRnxXNOu738uWH7fudiVGY=
X-Received: by 2002:a05:600c:1907:b0:3f4:fb7:48d4 with SMTP id
 j7-20020a05600c190700b003f40fb748d4mr106532wmq.3.1692382712518; Fri, 18 Aug
 2023 11:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818041740.gonna.513-kees@kernel.org> <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
In-Reply-To: <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Aug 2023 20:17:55 +0200
Message-ID: <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, 
	Hans Liljestrand <ishkamiel@gmail.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Alexey Gladkov <legion@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 7:56=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrot=
e:
>
> > From: Elena Reshetova <elena.reshetova@intel.com>
> >
> > atomic_t variables are currently used to implement reference counters
> > with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> >
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows and
> > underflows. This is important since overflows and underflows can lead
> > to use-after-free situation and be exploitable.
>
> ie, if we have bugs which we have no reason to believe presently exist,
> let's bloat and slow down the kernel just in case we add some in the
> future?

Yeah. Or in case we currently have some that we missed.

Though really we don't *just* need refcount_t to catch bugs; on a
system with enough RAM you can also overflow many 32-bit refcounts by
simply creating 2^32 actual references to an object. Depending on the
structure of objects that hold such refcounts, that can start
happening at around 2^32 * 8 bytes =3D 32 GiB memory usage, and it
becomes increasingly practical to do this with more objects if you
have significantly more RAM. I suppose you could avoid such issues by
putting a hard limit of 32 GiB on the amount of slab memory and
requiring that kernel object references are stored as pointers in slab
memory, or by making all the refcounts 64-bit.

