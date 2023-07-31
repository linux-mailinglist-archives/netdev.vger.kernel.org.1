Return-Path: <netdev+bounces-22687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08DE768C07
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C4281468
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 06:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189B6137;
	Mon, 31 Jul 2023 06:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38336138
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:30:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F19D1A5
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690785020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9F90Lb2s6G0ugGSS8D5PR3Nu2cqZtzEuNKJh0Awsb80=;
	b=iVT8dpg0TDxtbhOmiE+agqWIezsII3xOVtBNgyTN0e3alPuwLbN+yo8ysuIUKi8nsy9D/Y
	E3ZnRhxAJWTCDjcsivKylK3s06hdnYpKNwV1IIGFYajhD5mUN/Uzs7zwKs4eqef8khxs9j
	s7i3EaCA3CeByX92RU8j5Ii6evqJzk0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-PWhhcL2hM2CFtosPpUVtUg-1; Mon, 31 Jul 2023 02:30:18 -0400
X-MC-Unique: PWhhcL2hM2CFtosPpUVtUg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9c548bc66so33571961fa.1
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690785016; x=1691389816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F90Lb2s6G0ugGSS8D5PR3Nu2cqZtzEuNKJh0Awsb80=;
        b=Tbbp9t6nnBtv4R/6fkX6ef9CvLXRF7Kpf5MYm4RlS8/n54Ixi1+JdPrm/YurN9JXpI
         XThhXCBJBXB2bGym1L9AGIJUJzyPV0sXM+REPYw5GlAfkNY/aH0SuCPwck0838NhTgMI
         ybuLtPEpP1nidbIpekJa6J8ZlNSxz+3ITs4XeE2dwQ/ANnJQuBJAbZyuzcJr9DWIKWs2
         Zw7IYz5sUs8YvG0KC7BcMD/46F8vaiZg/e1X/NM3D21WpoqR22JV3VaudlBUey/0mWOh
         WB05zz94lESI+84KIc5Sy8SOaIo58ZMFxM5pFJgv7pZqD+c3OxD0SdZDhLAzAR2KKs7Q
         liOA==
X-Gm-Message-State: ABy/qLbYnLptne+0McEJ4Eu4hnF8xly7+H0CG3/Dt2H5yoFsuy/zT/oM
	5qKct9JMt0UXryDH9jNRyd42r9Rs15umG4Jd047Xs2D+WKJDQooZUJ2ZsKCe+IELqOAVZL6DvPi
	KOZg/gdTuIW6P25a+oXmb5TpmRweqq+p0
X-Received: by 2002:a2e:99c5:0:b0:2b9:df53:4c2a with SMTP id l5-20020a2e99c5000000b002b9df534c2amr2649458ljj.20.1690785016714;
        Sun, 30 Jul 2023 23:30:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGsf5BI9a89FmPfuA62UfQe/Gu3jAK6ZoAvqPzg14jDYGNtWJh1aM8aKl3uXlnUoU1eNeut1vEJYkKShriZjKE=
X-Received: by 2002:a2e:99c5:0:b0:2b9:df53:4c2a with SMTP id
 l5-20020a2e99c5000000b002b9df534c2amr2649436ljj.20.1690785016410; Sun, 30 Jul
 2023 23:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org> <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org> <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org> <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org> <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727054300-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 31 Jul 2023 14:30:04 +0800
Message-ID: <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 5:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > They really shouldn't - any NIC that takes forever to
> > > program will create issues in the networking stack.
> >
> > Unfortunately, it's not rare as the device/cvq could be implemented
> > via firmware or software.
>
> Currently that mean one either has sane firmware with a scheduler that
> can meet deadlines, or loses ability to report errors back.
>
> > > But if they do they can always set this flag too.
> >
> > This may have false negatives and may confuse the management.
> >
> > Maybe we can extend the networking core to allow some device specific
> > configurations to be done with device specific lock without rtnl. For
> > example, split the set_channels to
> >
> > pre_set_channels
> > set_channels
> > post_set_channels
> >
> > The device specific part could be done in pre and post without a rtnl l=
ock?
> >
> > Thanks
>
>
> Would the benefit be that errors can be reported to userspace then?
> Then maybe.  I think you will have to show how this works for at least
> one card besides virtio.

Even for virtio, this seems not easy, as e.g the
virtnet_send_command() and netif_set_real_num_tx_queues() need to
appear to be atomic to the networking core.

I wonder if we can re-consider the way of a timeout here and choose a
sane value as a start.

Thanks

>
>
> --
> MST
>


