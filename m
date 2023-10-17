Return-Path: <netdev+bounces-41697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DC7CBB62
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5183D2824E5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D1C13F;
	Tue, 17 Oct 2023 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6F134D2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:35:46 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F8AB6;
	Mon, 16 Oct 2023 23:35:44 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so5655556276.0;
        Mon, 16 Oct 2023 23:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697524543; x=1698129343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pTEuOWWO2hlVz1NuykhvoeD8VoF12j0MOdF/y8cBc4=;
        b=RKVplXhkJk8SQSzofkg2AepXrYhUkyElUnjWJRBB6bAvWHBVh1LkY2QhumOLmT0cjp
         tHYpUDH/xHpHdk9IGqqhIRjEm2YUnTdgjTFdb0qz1Mckhv2LQwMAHIoqYKe1GvOTeHJv
         DNL4epxYzld53P2TdZjEWmWQp9tAzqejQDkdcVs0Z6DC4aOHipd5KXneqgnIKFei1PPq
         W5OHpgzz3sp0W9kPsAjB97cVEEKGvZURsX0aj+vFIZy5bb7H8j0A6/t5wIXr5tfw3is0
         KxBPb1TANdouIHreFwXuJ2qHc2vFqfNj/CawM0Smo/UlmHFxaJ1B3A0HG8OyZ7cgdMQA
         iBqA==
X-Gm-Message-State: AOJu0YxKKizm+DtVBkTvPAQCjuNv+DFA04eYSaUR3CV+p0XRIKlzn6hd
	EmJwkSq/abuIhBlSWJ/wH+1JK7adC2joXA==
X-Google-Smtp-Source: AGHT+IFnv0lgddBMII7pF+MiRV/fZUnZmtcgbaF3JDHvddytkxHxt3mNSmQJvA7VgnO+Q1SjLe8wnQ==
X-Received: by 2002:a25:aacc:0:b0:d78:3047:62c6 with SMTP id t70-20020a25aacc000000b00d78304762c6mr1102104ybi.21.1697524543390;
        Mon, 16 Oct 2023 23:35:43 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id l23-20020a25b317000000b00d9b4ddf1c32sm307560ybj.2.2023.10.16.23.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 23:35:43 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a7b92cd0ccso67131107b3.1;
        Mon, 16 Oct 2023 23:35:42 -0700 (PDT)
X-Received: by 2002:a81:4f87:0:b0:5a8:6397:5bdb with SMTP id
 d129-20020a814f87000000b005a863975bdbmr1458422ywb.3.1697524542508; Mon, 16
 Oct 2023 23:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697460614.git.geert+renesas@glider.be> <fb3bd4ed540bbe18f60bf1f700c110d662533503.1697460614.git.geert+renesas@glider.be>
 <25740B27-9C85-46D9-8ACF-17D45D56A014@redhat.com>
In-Reply-To: <25740B27-9C85-46D9-8ACF-17D45D56A014@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 08:35:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3bXKNW=eoiQS6dw3LocYgr+wxi+D0xQKutmFxdmj3_Q@mail.gmail.com>
Message-ID: <CAMuHMdX3bXKNW=eoiQS6dw3LocYgr+wxi+D0xQKutmFxdmj3_Q@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/2] sunrpc: Wrap read accesses to rpc_task.tk_pid
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ben.

On Mon, Oct 16, 2023 at 11:15=E2=80=AFPM Benjamin Coddington
<bcodding@redhat.com> wrote:
> On 16 Oct 2023, at 9:09, Geert Uytterhoeven wrote:
> > The tk_pid member in the rpc_task structure exists conditionally on
> > debug or tracing being enabled.
> >
> > Introduce and use a wapper to read the value of this member, so users
> > outside tracing no longer have to care about these conditions.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310121759.0CF34DcN-lkp=
@intel.com/
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I never work on kernels that don't have tk_pid, but I can say its so usef=
ul
> that for 2 out of the 224 bytes that rpc_task uses (on aarch64), I'd be
> inclined to just include it all the time.  That way its around for folks =
to
> reference with realtime tools (like bpftrace, stap).

That would work, too.
In fact always including it should not increase the size of struct rpc_task=
,
as there's still unused spaced in the gap at the end.

> Does anyone know if there is a good reason not to include it for all
> configurations?
>
> Ben
>
> ..also:
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

