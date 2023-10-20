Return-Path: <netdev+bounces-42892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6A7D089B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E6D28224F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F0B652;
	Fri, 20 Oct 2023 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XxLFdweu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4B6112
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:39:46 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA54CE
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:39:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso591116a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697783983; x=1698388783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2yp/+uoXDPdDZvc0A60oXmXPqC6NUCSNebw398N6I0=;
        b=XxLFdweuaY6glNwcHvo3S7tU0HFKADCe+pwHRndN3UueSXOtJnXSCiyLSUmRh+Y85R
         lgS3j5cBmQ5gHiu9Z4d/esviIgP+DPeGQ8th8Y+v9AB2D9KrzOpFI0QTycgibbxnVikY
         t2UH4odyUE77znhmX/QwYPGF7zk3gTWU0r67wXenzMgsXpc/PvEBhl2WMkMKdiE/ZPwZ
         qnMmiCL2spjKFRMuMm/tvCX7bxd5rbS/UZKZ0V+tkshfUw/9rtG1+hR2kow3Xs9sg7/P
         fWxMMLFCT9q6DHfZIJpnJB9UgHtrZgJPLsPZB+MYe82Rrz+PK5kSN36ykgzFpURkZjcT
         36ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697783983; x=1698388783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2yp/+uoXDPdDZvc0A60oXmXPqC6NUCSNebw398N6I0=;
        b=c8lozENB6tBFzAlUb0phsQSR1eFu57NM5fmjHzOYlgNgmmmZQ6Q/d6Cs7f2huBxNso
         D5+YHKLndIYoU6K1DCEehgvYQx3VuDRw9Ow/hKy9UTPjQefUAgJd3l/rBuz/SNNzatxQ
         TTFev/JuCvuj7b9Cp61vnm8nh6YWT2QVjG5Nuhd5XZHVremKhoTMFC2Arw0duVQTjVq2
         6Ge/eDKMDyOMy2mlnvK4gWEcrQqMKTGBRhCFY5S+mUyzJ1FifsBZRvT/+RyOOgz8C51V
         CiPdQyFQqPmr3xBS2UMFRnJg9qssZ29W6Oa9iII1X5YFNTSCjsp8VKYeQdbK68SdK16b
         nx7g==
X-Gm-Message-State: AOJu0YzRds6qFls2I1BOdJSo1CgLj+80BfcjbLrqCb0MUDpsMR55DmV+
	h/Se73qbKNeQPKFz5W2953Ys1oO14NT6s3O5Ix3m4Q==
X-Google-Smtp-Source: AGHT+IHB35/EOIOr35HN++ZRTCy6gPZn5GdWe6FQtupPL660MqWX2OkTGpZVDEc2RaXXWPPDHowi48EH0tOyEkBNITA=
X-Received: by 2002:a50:d742:0:b0:53f:6ed5:4dab with SMTP id
 i2-20020a50d742000000b0053f6ed54dabmr805859edj.24.1697783983308; Thu, 19 Oct
 2023 23:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697779681.git.yan@cloudflare.com> <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
 <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
In-Reply-To: <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 20 Oct 2023 01:39:31 -0500
Message-ID: <CAO3-PbqtEPQro4wsQbaD-UbF-2RpxsVKVvs3M0X10-oE7K1LXA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:06=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Oct 20, 2023 at 7:32=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > dst_allfrag was added before the first git commit:
> >
> > https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.h=
tml
> >
> > The feature would send packets to the fragmentation path if a box
> > receives a PMTU value with less than 1280 byte. However, since commit
> > 9d289715eb5c ("ipv6: stop sending PTB packets for MTU < 1280"), such
> > message would be simply discarded. The feature flag is neither supporte=
d
> > in iproute2 utility. In theory one can still manipulate it with direct
> > netlink message, but it is not ideal because it was based on obsoleted
> > guidance of RFC-2460 (replaced by RFC-8200).
> >
> > The feature test would always return false at the moment, so remove it
> > from the output path.
>
> What about other callers of dst_allfrag() ?
>
> This feature seems broken atm.

It is broken as far as I can tell. The reason I removed just one
caller here is to keep the code simpler and consistent. If I don't do
so, I ought to test it for both GSO fast path and slow path to be
logically consistent. Seems an overkill to me. For the removal of the
rest, I'd hope it could come in as a standalone patch(set) because it
is not just callers but also those unnecessary flags and tests on IP
corks and sockets, not quite aligned with this patch's intention. I
noted you have drafted something like this in the past:

https://lkml.kernel.org/netdev/1335348157.3274.30.camel@edumazet-glaptop/

I guess it might be a good base point to work on as a new patch(set)?
What's your call on this?

Yan

