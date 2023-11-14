Return-Path: <netdev+bounces-47591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A57EA93E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 04:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3685DB20AA8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 03:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF162946E;
	Tue, 14 Nov 2023 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCPJOtVW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169928F45
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 03:56:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568FFD43
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 19:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699934167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Wu1omyNFDVtFU1Hlcc2IaJQt9sbEgmhL34rN70HKs0=;
	b=GCPJOtVWmjyUptLnhOuB3vj3JtP7o3ucM9iHV4ha4Oo8j/ji4SnDBEuWp5B/wp2xwVK/PI
	pkTnuvpTorsqZbYY27pCX68C2LtMbv8kYjZ21mStthcShXLgBokSQl06INk5BG6UspYZ5A
	6VBRlduR6cwyeO87vsgHmqhqylruMic=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-eMpeT6EmPaeMJkvNemLbIQ-1; Mon, 13 Nov 2023 22:56:05 -0500
X-MC-Unique: eMpeT6EmPaeMJkvNemLbIQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50943cb2d96so2916322e87.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 19:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699934164; x=1700538964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Wu1omyNFDVtFU1Hlcc2IaJQt9sbEgmhL34rN70HKs0=;
        b=l1eEO7OGCqKfhDzNcAElaom406Sg9io8G2cJamvfTJtlV6XJ8UvIGDXQl8Uue5PHVq
         q61jQ6ohIfpyJoEik5U5z6kiD6vtzLknlwCepIh5cVs3+yZOuqqDVOuSYvqYk2rn/Isz
         +ejyIeKTYyj3rD2N9HHu14z8alpgfA/WDoaXW4aj+7+I8C7PxB2j80aXvy8e8fClO9P1
         9RJ9B1eyTWgrMUMpncu3xBLhYhHX1xjQrMWS7DUZc7Q36/jm45TWDjAyp3EWudhB2vQW
         DSQT3DLXXv2o+bltgKTMmrqVkfwdkDZ2+vMLy2kJ3EX0F7LC+DdKWhFKuO9cbr20GDlH
         BNeA==
X-Gm-Message-State: AOJu0YzCkhbLVASBjV3tRsv2yPrP5+oR4VenZVB9tyWH8gPF/Nu0Xbsv
	D6F8DOrJwhx0E8hSccgzqLXVEXCgWLX+433zKn7XtefYOvhqCIeJWqh9RsYYri8rOxFhtl9lQxT
	mTDB2+Hku6a51LSzQCmkH5cV3AhKwmQGA6nV6+Vmi
X-Received: by 2002:a05:6512:15a6:b0:50a:6fb8:a0c0 with SMTP id bp38-20020a05651215a600b0050a6fb8a0c0mr484416lfb.19.1699934163777;
        Mon, 13 Nov 2023 19:56:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS1MSbGPt3y7yEXZl8rECF+p48KM5DSsexq7zLBD9jB7CB91nepWM3PaNvdV3NxtMMyRByMxBbujQPLEqLfM0=
X-Received: by 2002:a05:6512:15a6:b0:50a:6fb8:a0c0 with SMTP id
 bp38-20020a05651215a600b0050a6fb8a0c0mr484409lfb.19.1699934163493; Mon, 13
 Nov 2023 19:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-9-xuanzhuo@linux.alibaba.com> <CACGkMEtLee8ELzqFnV_zOu3p5tU6hivouKM=WjtNAq+2wQzAFQ@mail.gmail.com>
 <1699527528.5637772-2-xuanzhuo@linux.alibaba.com> <CACGkMEu4toAuAuJdrXF0AJqsHc-ovPg3vi8=My-+BxaMi+TBSw@mail.gmail.com>
 <1699932516.9040368-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1699932516.9040368-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 11:55:52 +0800
Message-ID: <CACGkMEv7-U4HNe8UOENx9A+5fj-GJ7wvO=aw8v+axoiG7yhqdA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/21] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Tue, 14 Nov 2023 11:26:42 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Nov 9, 2023 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > On Thu, 9 Nov 2023 14:37:38 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
> > > > On Tue, Nov 7, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > So the send queue must support premapped mode.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/main.c       | 163 ++++++++++++++++++++++++++=
++----
> > > > >  drivers/net/virtio/virtio_net.h |  16 ++++
> > > > >  2 files changed, 163 insertions(+), 16 deletions(-)
> > > > >

[...]

> > > >
> > > > I think we need to seek a way to reuse what has been stored by virt=
io
> > > > core. It should be much more efficient.
> > >
> > >
> > > Yes.
> > >
> > > But that is for net-next branch.
> > >
> > > Can we do that as a fix after that is merged to 6.8?
> >
> > We still have time. I would like to do it from the start.
>
>
> I want to finish the job including new AF_XDP ZC feature.
> Because that this must wait the merge window.
> Base on that, the optimizing work can be done everytime.
>
> If we work from the new virtio prepare, that can be merged to 6.8.
> And the AF_XDP zc must wait 6.9. right?

It can be part of this series. Or anything I missed?

My understanding is that, since the information is handy, it just
requires new helpers. So I don't expect it needs a large series.

Thanks

>
> Thanks
>


