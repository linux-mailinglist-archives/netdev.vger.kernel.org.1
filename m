Return-Path: <netdev+bounces-26691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9344D778997
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4139F282091
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D705679;
	Fri, 11 Aug 2023 09:19:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461C1869
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:19:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D53C5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691745546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGdSssISZdYkw7T85LRer1ntqt/JyX2ZF+++BCIHsA4=;
	b=EguVPO5byEjIfgSi45ErUW+lAdL+H91jLM+bAkW1eqoLgM25bQccDwlq2nG0Pc1CglTidu
	eMzyKE/FSvTFwz0T0NofiBWg6yvNV1f6KLCBypGFCSwW1GYuHx0Baik1l5HRbsG43HdLqm
	F8dDwAzmOfzes1hiy69OqfmPvSd5HWA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-WBC_cEoRPsC_yEyZWShkTg-1; Fri, 11 Aug 2023 05:19:05 -0400
X-MC-Unique: WBC_cEoRPsC_yEyZWShkTg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9da035848so19219381fa.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691745543; x=1692350343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGdSssISZdYkw7T85LRer1ntqt/JyX2ZF+++BCIHsA4=;
        b=cv7vfPkGIBX03qoJH/t4pZ5xXms8J2aXYQPZBHsZ7Qeo/E3R1pTZW861eKWIBTviUC
         pECPtG0YijlLVXG+dcH9y5aj+gYKv1uBqHvnTgTA3/X0kq3S9GN/RVLUwpUUAcRAkzPa
         Xs4GpKIQ67cCAyNMvCCsc3057a82YMmo2KaZXN1ysq9fwDWKO0Zyd+QTvZLCaOjME0X+
         QXZqWzG3VmB1l4buXp+WBotZCK27JYFob2odkRwBik9wjELcA9c4BeyMDIQhVsRc7MNz
         4HbkdYjebYZn1b2n9RR3eZ6aXu8jTx7/i9PqkePNayMibSpe5asBwVXkkbCwGbSFT9jb
         +EAA==
X-Gm-Message-State: AOJu0YxXsxdT5Zd7xGTgz3u62zs5oebr5SYsa6ovpzdHXDJmU11r06JI
	0zlEdXW+WrQewbjKLe5oXCHHaj6S7J8zD7i4bIxc4yUmJEBr9c9QQ86HqgUfTIeb2fIi1zh1sGS
	y+YZ5lwKFo2xDEpH7KinqbTGP6PRIzxTV
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id e8-20020a2e8188000000b002b1ad15fe38mr1124397ljg.3.1691745543666;
        Fri, 11 Aug 2023 02:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRSv6LX+hSldz3htlZqeyiqLtB22I217onQne1fAzxKaGyV86gUpG4v24jBvRPBt+lPmGZPgcxmQqsdRHKiLQ=
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id
 e8-20020a2e8188000000b002b1ad15fe38mr1124379ljg.3.1691745543321; Fri, 11 Aug
 2023 02:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org> <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org> <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org> <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org> <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230811012147-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Aug 2023 17:18:51 +0800
Message-ID: <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 1:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> > On Fri, Aug 11, 2023 at 3:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > > On Mon, Jul 31, 2023 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Jul 27, 2023 at 5:46=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > > program will create issues in the networking stack.
> > > > > > >
> > > > > > > Unfortunately, it's not rare as the device/cvq could be imple=
mented
> > > > > > > via firmware or software.
> > > > > >
> > > > > > Currently that mean one either has sane firmware with a schedul=
er that
> > > > > > can meet deadlines, or loses ability to report errors back.
> > > > > >
> > > > > > > > But if they do they can always set this flag too.
> > > > > > >
> > > > > > > This may have false negatives and may confuse the management.
> > > > > > >
> > > > > > > Maybe we can extend the networking core to allow some device =
specific
> > > > > > > configurations to be done with device specific lock without r=
tnl. For
> > > > > > > example, split the set_channels to
> > > > > > >
> > > > > > > pre_set_channels
> > > > > > > set_channels
> > > > > > > post_set_channels
> > > > > > >
> > > > > > > The device specific part could be done in pre and post withou=
t a rtnl lock?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > Would the benefit be that errors can be reported to userspace t=
hen?
> > > > > > Then maybe.  I think you will have to show how this works for a=
t least
> > > > > > one card besides virtio.
> > > > >
> > > > > Even for virtio, this seems not easy, as e.g the
> > > > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > > > appear to be atomic to the networking core.
> > > > >
> > > > > I wonder if we can re-consider the way of a timeout here and choo=
se a
> > > > > sane value as a start.
> > > >
> > > > Michael, any more input on this?
> > > >
> > > > Thanks
> > >
> > > I think this is just mission creep. We are trying to fix
> > > vduse - let's do that for starters.
> > >
> > > Recovering from firmware timeouts is far from trivial and
> > > just assuming that just because it timed out it will not
> > > access memory is just as likely to cause memory corruption
> > > with worse results than an infinite spin.
> >
> > Yes, this might require support not only in the driver
> >
> > >
> > > I propose we fix this for vduse and assume hardware/firmware
> > > is well behaved.
> >
> > One major case is the re-connection, in that case it might take
> > whatever longer that the kernel virito-net driver expects.
> > So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
> > and fail early?
>
> Ugh more mission creep. not at all my point. vduse should cache
> values in the driver,

What do you mean by values here? The cvq command?

Thanks

> until someone manages to change
> net core to be more friendly to userspace devices.
>
> >
> > > Or maybe not well behaved firmware will
> > > set the flag losing error reporting ability.
> >
> > This might be hard since it means not only the set but also the get is
> > unreliable.
> >
> > Thanks
>
> /me shrugs
>
>
>
> > >
> > >
> > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > >
>


