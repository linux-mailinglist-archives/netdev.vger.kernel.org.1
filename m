Return-Path: <netdev+bounces-35418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C17A9720
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B581C209C7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B2BE71;
	Thu, 21 Sep 2023 17:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6014F9A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:04:06 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472153588
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:03:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b703a0453fso20405451fa.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315715; x=1695920515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK21WYzVm30pkR03hEDVnx/qoe/Q1Eu8nWyTdq2Kd2M=;
        b=AtK9WFo9j6TXScvSqMuZzlK961dmvO5IByqc3CEdoSnvmpGARZL++KF/danrXxiVjj
         0JsouZzSWVMXvnusSHy2HgP+UFPVxMMOlXSVS18d3BSsk8yI7k6CPjjnbBp1iKs9vA4G
         xObgaytINSPBG1jGTnszAbRyygnWqP0/AqMTwIJmLSWL9wjw7B6KM2LTj2qalPjdB1Jm
         z+D1noypmil7Hf7z7pga7lBx60LOW40G9DcBtjtvcfXP7facYdyMOyXleNujcAQREF+c
         eQMnjPhed9g9fqldsb8OHpUHTlR1iA8owLezktX8e+ZuXdi4J6VqqsdKihslWxSK9/pw
         tizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315715; x=1695920515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK21WYzVm30pkR03hEDVnx/qoe/Q1Eu8nWyTdq2Kd2M=;
        b=IKWrUx1xLgd0wuWCQ5Maiuq08K1IWTQQLaUOIYaSrvYfVtiGUqJzOEWwauk0RbXeKd
         P1xpG9CX5ZMuAtphD5Sd6eIPHi3f4pieES8Ucvpy8leRQSOBlucpVSwKqf9FqLSamfyI
         x7GynCBpOsMLhqohDMQw0UFuBu2bgTNitqF0BddyEawPG7DumDQ3MugcZtTjo6n51C/H
         2ntp0T/kCGPgoP79Ndad9XfDBgU7QE8kunFtIE7FBG8KTrY9Khq60C+pRVAFT/FZeWR4
         pLgCw0WnpBvvqGB8UT1uIbTqN001tIOMpngYDOYKPR+8Ao3r3tULgZbkYwGjR1N0cmNu
         XJBQ==
X-Gm-Message-State: AOJu0YyzEfG+J5NODcHIrctBfijg9usl4uP7ZiyvuBW9DLSueiyjvVbr
	4TcfKxW2M9RF+rLR41zbW3z4h5Qa/aw2pvrZb01bng==
X-Google-Smtp-Source: AGHT+IHLbVQVPTbY4mDzyywro5wxLvNUrwqDk+GNRXLAejAiLRmP8JbYyOL8hu0K3iY3VhZahUwBpgI5KJvnt87aXJs=
X-Received: by 2002:a2e:8882:0:b0:2bf:e65d:e815 with SMTP id
 k2-20020a2e8882000000b002bfe65de815mr5662841lji.38.1695315715063; Thu, 21 Sep
 2023 10:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919175323.144902-1-jrife@google.com> <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
 <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
 <CAF=yD-K3oLn++V_zJMjGRXdiPh2qi+Fit6uOh4z4HxuuyCOyog@mail.gmail.com> <b822f1246a35682ad6f2351d451191825416af58.camel@redhat.com>
In-Reply-To: <b822f1246a35682ad6f2351d451191825416af58.camel@redhat.com>
From: Jordan Rife <jrife@google.com>
Date: Thu, 21 Sep 2023 10:01:42 -0700
Message-ID: <CADKFtnTz-gDRKtDpw1p=AEkBSa3MispZDV8Rz5n+ZahdBr3vnA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	dborkman@kernel.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, airlied@redhat.com, 
	chengyou@linux.alibaba.com, kaishen@linux.alibaba.com, jgg@ziepe.ca, 
	leon@kernel.org, bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com, 
	teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com, 
	lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com, 
	horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, 
	fw@strlen.de, santosh.shilimkar@oracle.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 8:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2023-09-21 at 09:30 -0400, Willem de Bruijn wrote:
> > On Thu, Sep 21, 2023 at 4:35=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Wed, 2023-09-20 at 09:30 -0400, Willem de Bruijn wrote:
> > > > Jordan Rife wrote:
> > > > > Similar to the change in commit 0bdf399342c5("net: Avoid address
> > > > > overwrite in kernel_connect"), BPF hooks run on bind may rewrite =
the
> > > > > address passed to kernel_bind(). This change
> > > > >
> > > > > 1) Makes a copy of the bind address in kernel_bind() to insulate
> > > > >    callers.
> > > > > 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
> > > > >
> > > > > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jri=
fe@google.com/
> > > > > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > >
> > > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > >
> > > I fear this is going to cause a few conflicts with other trees. We ca=
n
> > > still take it, but at very least we will need some acks from the
> > > relevant maintainers.
> > >
> > > I *think* it would be easier split this and patch 1/3 in individual
> > > patches targeting the different trees, hopefully not many additional
> > > patches will be required. What do you think?
> >
> > Roughly how many patches would result from this one patch. From the
> > stat line I count { block/drbd, char/agp, infiniband, isdn, fs/dlm,
> > fs/ocfs2, fs/smb, netfilter, rds }. That's worst case nine callers
> > plus the core patch to net/socket.c?
>
> I think there should not be problems taking directly changes for rds
> and nf/ipvs.
>
> Additionally, I think the non network changes could consolidate the
> bind and connect changes in a single patch.
>
> It should be 7 not-network patches overall.
>
> > If logistically simpler and you prefer the approach, we can also
> > revisit Jordan's original approach, which embedded the memcpy inside
> > the BPF branches.
> >
> > That has the slight benefit to in-kernel callers that it limits the
> > cost of the memcpy to cgroup_bpf_enabled. But adds a superfluous
> > second copy to the more common userspace callers, again at least only
> > if cgroup_bpf_enabled.
> >
> > If so, it should at least move the whole logic around those BPF hooks
> > into helper functions.
>
> IMHO the approach implemented here is preferable, I suggest going
> forward with it.
>
> Thanks,
>
> Paolo
>

> Additionally, I think the non network changes could consolidate the
> bind and connect changes in a single patch.
>
> It should be 7 not-network patches overall.

I'm fine with this. If there are no objections, I can drop the non-net
changes in this patch series and send out several
kernel_connect/kernel_bind patches to the appropriate trees as a
follow up. Shall we wait to hear back from the maintainers or just go
ahead with this plan?

-Jordan

