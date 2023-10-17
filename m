Return-Path: <netdev+bounces-41637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E627CB80C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934991C20A11
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9336F17E3;
	Tue, 17 Oct 2023 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUdGCZdR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096017D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:37:54 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBA9B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:37:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so3856a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697506671; x=1698111471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4lH3j7esCxDQeDcLTPc8s4J230d9rvBtFbkpXVFEGs=;
        b=rUdGCZdRo3boLuHgIm1qUR2vXCUJzGrQuO0DFvb4uFlIkopqCWvCC6weVkDhBK9qjx
         pFX6pc5p2BeYAKDCU5zaMkydgOBDLBnHzCGIngn2IZXIIPTZQWmyV0ryrIPB6dkBTlc0
         acus1k+tRUFypqjZGPQh1j4+XLxt1nd/rI33kFp/oosVYoPOUJvXGlIa7Rnb7IFQfK1l
         3Dg2K2JAq7oRKllPHPvI1SucQXeYglZirWOuG5E2XoY+zfJ4BAh++WFDQpFOZi67okiF
         jgmx1WtkkKEu5lM/1WFutDAVlVvz6/39vLu0HHstTFT3ssRWjznRtzoyXc2LMiXL2RJp
         nn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697506671; x=1698111471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4lH3j7esCxDQeDcLTPc8s4J230d9rvBtFbkpXVFEGs=;
        b=nvX7BY2CEx8WOMUqU/Zctw32Cb4dh/jLVj4M3Evv8FjoZwrAF7LoMbyQGEK04YX53w
         udY9pVo2j5qKoD5a3nvYwEL0WTtAJC56yUp9Z9qjDGZOOnZ8MWpSJDJU2JPv3bmFvWSh
         k5+UujP0gpQ/JKlkbvSjsQFKDCrGoNNgVt9VKbGOEgAuCsyekTmgG+TaXA/nQ8caA8VF
         Nv573cyQEaJSf4leDEF8Jp7ylWeFmTl3R2QAZvdxZ5Gi7Sne6BMLGV5IUoqEuN9ieMPd
         JcrJiliCzXuYLJvWWLMMwOyTMvJnh7s3j/sGlQzXjF2D5FpwNOct2JWbn5t4p+zNyV3f
         0LqA==
X-Gm-Message-State: AOJu0YyUwKJGEAS/XCTQQK4ymuy06AZecXyqF7rLADNFhy7wCAqFXZ4F
	p6wtHuxKsa4ijTL5vs6DoxvVBJxkk2f79m1tfyIjsQ==
X-Google-Smtp-Source: AGHT+IFGdbFHU6kqUjKQRG2QUwRBpZfZJQEiFOTDTVrA99c9DBahRvOi02QN59qbO66LnmoBbz2rEHoELmx+MinV9N8=
X-Received: by 2002:a50:8ad6:0:b0:522:4741:d992 with SMTP id
 k22-20020a508ad6000000b005224741d992mr61683edk.4.1697506671080; Mon, 16 Oct
 2023 18:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-2-lixiaoyan@google.com> <20231004064146.18857c9a@kernel.org>
In-Reply-To: <20231004064146.18857c9a@kernel.org>
From: Coco Li <lixiaoyan@google.com>
Date: Mon, 16 Oct 2023 18:37:39 -0700
Message-ID: <CADjXwjj537V1+OskHxvkrqa=TSQXXG2CPc7sfQ0OzqumtW79+w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for the reviews, Jakub!

We opted to have separate documentation for future folks who are
interested in more organization to have a baseline of what was
considered fast path (i.e. UDP case mentioned in the other patch
series).

I have added a pointer to the relevant header files in hopes of
getting better attraction for the documentations.


On Wed, Oct 4, 2023 at 6:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 16 Sep 2023 01:06:21 +0000 Coco Li wrote:
> > Analyzed a few structs in the networking stack by looking at variables
> > within them that are used in the TCP/IP fast path.
> >
> > Fast path is defined as TCP path where data is transferred from sender =
to
> > receiver unidirectionaly. It doesn't include phases other than
> > TCP_ESTABLISHED, nor does it look at error paths.
> >
> > We hope to re-organizing variables that span many cachelines whose fast
> > path variables are also spread out, and this document can help future
> > developers keep networking fast path cachelines small.
> >
> > Optimized_cacheline field is computed as
> > (Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
> > results (see patches to come for these).
>
> Great work! I wonder if it's not better to drop the Documentation/
> files and just add the info from the "comments" inline in the struct?
> Is there precedent for such out-of-line documentation?
> The grouping in structures makes it clear what the category of the
> field is (and we can add comments where it isn't).
>
> Right now the "documentation" does not seem to be mentioned anywhere
> in the source code. Chances that anyone will know to look for it are
> close to zero :(
>
> The guidance on how the optimizations were performed OTOH would be
> quite useful to document.

