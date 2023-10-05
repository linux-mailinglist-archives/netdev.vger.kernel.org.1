Return-Path: <netdev+bounces-38315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3637BA613
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5DED0281CD8
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E334CE9;
	Thu,  5 Oct 2023 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp9X388J"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C33347D8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:25:04 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C15263
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:25:03 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9e478e122so817513a34.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696523102; x=1697127902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj4Gd1fbatAsLSbuEz2dtHGL2Wq1DMvXOYfE8V925HQ=;
        b=Bp9X388JHmf8zeEsBNaBaAvGA49xqNhef0cLUJKNNEBKRTdC7KfMuwBu/G7q3gLJs7
         t/obTQQ6CkhsLR1kWXFHDJHCrTi0G5jHWTGiqTDJZPPtAPavONfnoo/uxP9iM9+dDwk9
         uMKedbbmqBZXOPEEPyEJSheYwAvhFCrUrkOCUDTliujA/L8pXwCRQfdzvwg+HU06fXj9
         NUS6f20jyasSqr2vBAxReStCKlQMKBXXibiShaYB7VQSLGdTozDl6NEKTA1WqywH/tHG
         teS01wJc1l1WEFrB6pIJn2LqRbkA7LMmLfb9/PmyEVrlkB4vwnEbfJnylONsQ8SGd+gu
         Lh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523102; x=1697127902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj4Gd1fbatAsLSbuEz2dtHGL2Wq1DMvXOYfE8V925HQ=;
        b=A1V1E7K6I9a17HlJC/uxM184qgDiTP0xUQuNQRCYEA8sK8NIzUZ0qy4kyTOE1URVTK
         MITIhWEDBGeW0tOKpTygNUwWUT2e9jMtLdX6V3jnd1xblcjZKQK8+ROj47NoP5J2zui8
         Lh80o+JfaIR5KrYOQnBWGTtKc3blgt6pSPuAcqtOdXNFLeCIIdO3q8rH8wVFZp2ZSkNB
         V/IMxfVyW9WfuiEODWUILBTQhdjZLgu2ZNipLZe4mXVjZgX85XJq+urx9YO/i0cuyl5M
         GdBXmoXaBgTPh6VNtHjMmqCD59PZpZTAtfdpTMBkE4B5vwIInInS6CPvnBRJ2DWUqGU3
         gBsA==
X-Gm-Message-State: AOJu0YyIb60Uld16ZflrmKH/voRSrSaHk3Y9E0ZhmiSlxk+u6Z0Q3xnI
	B5di39w0K7KkqzWrEeCAIGs+hyTaQ5mBh7ldVD8=
X-Google-Smtp-Source: AGHT+IHgJsAHmHdUK0ubd/llvOkkkApOjEVY5ii1EKAzSFHN2jfBPCwNCSl+RLIImJ6ELw9mS8LLw5tb9XcVIjzratQ=
X-Received: by 2002:a05:6358:2806:b0:14c:79ec:1b86 with SMTP id
 k6-20020a056358280600b0014c79ec1b86mr7101127rwb.24.1696523102214; Thu, 05 Oct
 2023 09:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927082918.197030-1-k.kahurani@gmail.com> <20231004114758.44944e5d@kernel.org>
 <CAAZOf27_Cy8jaJBnjKV7YgyaKO2WohYrxcftV5BdOdm66g_Apw@mail.gmail.com> <20231005090328.73e87e71@kernel.org>
In-Reply-To: <20231005090328.73e87e71@kernel.org>
From: David Kahurani <k.kahurani@gmail.com>
Date: Thu, 5 Oct 2023 19:24:50 +0300
Message-ID: <CAAZOf25k-c_C3sYz_0zwnc4k5Yf66=LZUSmnwusomZx_CJt1rw@mail.gmail.com>
Subject: Re: [PATCH] net/xen-netback: Break build if netback slots > max_skbs
 + 1
To: Jakub Kicinski <kuba@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, netdev@vger.kernel.org, 
	wei.liu@kernel.org, paul@xen.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 7:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 5 Oct 2023 18:39:51 +0300 David Kahurani wrote:
> > > MAX_SKB_FRAGS can now be set via Kconfig, this allows us to create
> > > larger super-packets. Can XEN_NETBK_LEGACY_SLOTS_MAX be made relative
> > > to MAX_SKB_FRAGS, or does the number have to match between guest and
> > > host?
> >
> > Historically, netback driver allows for a maximum of 18 fragments.
> > With recent changes, it also relies on the assumption that the
> > difference between MAX_SKB_FRAGS and XEN_NETBK_LEGACY_SLOTS_MAX is one
> > and MAX_SKB_FRAGS is the lesser value.
> >
> > Now, look at Ubuntu kernel for instance( a change has been made and,
> > presumably, with good reason so we have reason to assume that the
> > change will persist in future releases).
> >
> > /* To allow 64K frame to be packed as single skb without frag_list we
> >  * require 64K/PAGE_SIZE pages plus 1 additional page to allow for
> >  * buffers which do not start on a page boundary.
> >  *
> >  * Since GRO uses frags we allocate at least 16 regardless of page
> >  * size.
> >  */
> > #if (65536/PAGE_SIZE + 1) < 16
> > #define MAX_SKB_FRAGS 16UL
> > #else
> > #define MAX_SKB_FRAGS (65536/PAGE_SIZE + 1)
> > #endif
> >
> > So, MAX_SKB_FRAGS can sometimes be 16. This is exactly what we're
> > trying to avoid with this patch. I host running with this change is
> > vulnerable to attack by the guest(though, this will only happen when
> > PAGE_SIZE > 4096).
>
> My bad, you're protecting from the inverse condition than I thought.
>
> But to be clear the code you're quoting (the defines for MAX_SKB_FRAGS)
> are what has been there upstream forever until 3948b059 was merged.
> Not 100% sure why 3948b059 switched the min from 16 to 17, I think it
> was just to keep consistency between builds.

Okay, now that might change everything because the patch was made with
the assumption that Ubuntu(and probably others) have code modifying
the default values for MAX_SKB_FRAGS. If this was upstream, then,
maybe when the time comes they will grab 3948b059. I consider this
solved at this point :-)

>
> If this change gets backported to 6.1 stable it will break ppc build
> of stable, right? Since ppc has 64k pages.

