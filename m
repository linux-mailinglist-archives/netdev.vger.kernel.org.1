Return-Path: <netdev+bounces-38768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F107BC650
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF10282179
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A6E168BD;
	Sat,  7 Oct 2023 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCjL0Qir"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27316407
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 09:02:56 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517EFB9
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 02:02:55 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49aa8518df8so1959250e0c.1
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696669374; x=1697274174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bncvbRKL75jaTSKRCrOH4RHFEMNg9I0EHn5AgUSN3WU=;
        b=QCjL0QirPT70BiZ9gIuE0Oe0JyG7Pwzj3oUYLfQNITHUgeT5N1MJ8KuPaU6DWZNjNN
         MmS88pqTaBSp/SCqzqrhkEZuBwTLS3N6ApfxEwamKrvJ8U/6v0JNXTlC+uJnZUx1Inmt
         oBse5zLgZO0pGIScgczVlH5cT989L5vFHdza9cNcEKVeMACIlwbWyYfMsqBHrhbHTOML
         wjSmFFilLBFqxeroN3fNFmIRptOTIImgkfup+THygs4Sms0of4/x9r5eYFJsN4QxeFNi
         nZnZg52EiH+JAYMLleM9OryWnn7Y3vUPeaQSmMQw9A02KXQa5bP/q6hPMYuYzEozT6W+
         axJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696669374; x=1697274174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bncvbRKL75jaTSKRCrOH4RHFEMNg9I0EHn5AgUSN3WU=;
        b=dJK1q4LsVxzwv31bYSAF5uhIRq/QF+/mUqc1RoH1NW9gfbBD5ApGWHJb4PzudOembl
         VcR4hgDtxXaRS63f7fNKwoeJ5qKFC2PW9v2GZakWEoZ49AS27Hb4CkcDlIZK1Rbbj+OD
         +M0oEY4AjWDtebu/JQ+AhWJlzkDIHXnUFm2zvql7TAPJocehvHwY9/RIOmZMvbtd4bMZ
         L/YEgceM3LndWLEcymj055O8Q9BY8AH7Yj3T3ldk4oygHaXS4jxDLEFjYbaeAK435NZg
         V+c6hYWP++1J+lZL4gcvQoNQbQ76orzlP/BKI7y7E/xGyZqOvBC0/LicqYy2r0xiPfC8
         3rUQ==
X-Gm-Message-State: AOJu0YzfrI+1KMir44lSw1GtkSbPm2uOsyJwih19SKoN0znruJU+Lkmu
	LaVc4eMbpWvPUDniFFeLVt2iCfedgRNbgK3Q9EU=
X-Google-Smtp-Source: AGHT+IHLPwvDITF0YQnDbDRJtUQBCPq1Aqb0Or0sS9616FcvprxtCuoB4hDKT4Jp/6U9i/KxORj8pAe3BOQtPWKA6cs=
X-Received: by 2002:a1f:9889:0:b0:49d:2a13:58fc with SMTP id
 a131-20020a1f9889000000b0049d2a1358fcmr3395240vke.2.1696669374359; Sat, 07
 Oct 2023 02:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com> <20231006173030.4908a356@kernel.org>
In-Reply-To: <20231006173030.4908a356@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 7 Oct 2023 04:02:17 -0500
Message-ID: <CAF=yD-KCb8K46qdDvSjqkdfMNWJuLdVjH1wrkm0ea83CTZkzsA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] add skb_segment kunit coverage
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, alexander.duyck@gmail.com, fw@strlen.de, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 7:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  5 Oct 2023 09:48:54 -0400 Willem de Bruijn wrote:
> > As discussed at netconf last week. Some kernel code is exercised in
> > many different ways. skb_segment is a prime example. This ~350 line
> > function has 49 different patches in git blame with 28 different
> > authors.
> >
> > When making a change, e.g., to fix a bug in one specific use case,
> > it is hard to establish through analysis alone that the change does
> > not break the many other paths through the code. It is impractical to
> > exercise all code paths through regression testing from userspace.
> >
> > Add the minimal infrastructure needed to add KUnit tests to networking,
> > and add code coverage for this function.
>
> Apparently we're supposed add descriptions to all modules now:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/core/gso_test.o

Will fix and resend. Thanks.

