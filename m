Return-Path: <netdev+bounces-20255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E210875EC02
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE0D1C209BC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D21117;
	Mon, 24 Jul 2023 06:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774717F8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 06:53:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9EEE56
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690181583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pKG/QpR2RzRLFZUHbEZEOsoTAlRHGNWkIflkbnf814=;
	b=FBDoHLF90gR6yzb5LXKlLXj8JE/FjdLWSpHffYJDkw5PZYFhVvEU9qf6Oyq1IWQnVg599t
	LbN1zyRxp2ZY/aDkJAr5jwMU20VCe0nnDZZsYwzJ1a9LKQI5mafWBT0sVPDThMd8BzY+np
	OihEAwzfVrpsweAscNrCmjmEPcccXyQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Bol3FeGDOJSmcZgAbL7B5A-1; Mon, 24 Jul 2023 02:53:02 -0400
X-MC-Unique: Bol3FeGDOJSmcZgAbL7B5A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9939495f8so2683721fa.2
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 23:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690181580; x=1690786380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pKG/QpR2RzRLFZUHbEZEOsoTAlRHGNWkIflkbnf814=;
        b=MdjOD/C2O3g9JAS3+3shBPGDYYBca4cc42mX9+9QXq2RZGO5/H+TGEe/58q2dO8m7N
         zpsA/3LFYDeVVwZhGtke0bP0Hk/DxQFAS+x+FVlVMAHvZ5tsdb/zsUB8WPwN/uLvaQ/p
         wqjS0ougFpxcaesPo/+vMnhoOcJ9EGL9OV5AR1L27Few7bj08bjUtxCvIFTV4IzfiY5o
         r9W55hkWV4DUn8Cad50SnDpwmSg9ddGbAaY3q7y4cE0ega3/rx9bd38ThfHbvspWu+iL
         54mUFFOcN9FDSORezbcvAZn3WtEKnKBsrMSZSKsvIwQr7b+r3bP9m0pCV8YdMjrQHY4E
         1+Qw==
X-Gm-Message-State: ABy/qLZ8wMbxLjSKvydXu9umclZqedG6QT/OFzwfP2B2Atho14l8cKYP
	fwdCuR30TvmjlBxSdnsUoBYVGV9Gh8c+PdRzmLRvqdU+9H2uNucnuK3jqYKrAMamutz5gZSiGwg
	pBxfyRCCCqAstKEHDRfY5DOIFfQX25Drq
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id y5-20020a05651c020500b002b59f54e290mr4905522ljn.0.1690181580677;
        Sun, 23 Jul 2023 23:53:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGAmLS3rinVGsLd7AiJM7P6pJi3Om6DIylJcrxKdBPPEYm9eGwGfcqzWBBrKCtsdHC9O5nMYXmIxWSEsqiejcM=
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id
 y5-20020a05651c020500b002b59f54e290mr4905511ljn.0.1690181580374; Sun, 23 Jul
 2023 23:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com> <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com> <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com> <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com> <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com> <20230723053441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230723053441-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Jul 2023 14:52:49 +0800
Message-ID: <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 2:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> >
> >
> > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > >
> > > >
> > > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > >
> > > > > >
> > > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrot=
e:
> > > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > >
> > > > > > > > > Adding cond_resched() to the command waiting loop for a b=
etter
> > > > > > > > > co-operation with the scheduler. This allows to give CPU =
a breath to
> > > > > > > > > run other task(workqueue) instead of busy looping when pr=
eemption is
> > > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > >
> > > > > > > > This still leaves hung processes, but at least it doesn't p=
in the CPU any
> > > > > > > > more.  Thanks.
> > > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > >
> > > > > > >
> > > > > > > I'd like to see a full solution
> > > > > > > 1- block until interrupt
> > > > > >
> > > > > > Would it make sense to also have a timeout?
> > > > > > And when timeout expires, set FAILED bit in device status?
> > > > >
> > > > > virtio spec does not set any limits on the timing of vq
> > > > > processing.
> > > >
> > > > Indeed, but I thought the driver could decide it is too long for it=
.
> > > >
> > > > The issue is we keep waiting with rtnl locked, it can quickly make =
the
> > > > system unusable.
> > >
> > > if this is a problem we should find a way not to keep rtnl
> > > locked indefinitely.
> >
> > From the tests I have done, I think it is. With OVS, a reconfiguration =
is
> > performed when the VDUSE device is added, and when a MLX5 device is
> > in the same bridge, it ends up doing an ioctl() that tries to take the
> > rtnl lock. In this configuration, it is not possible to kill OVS becaus=
e
> > it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio=
-
> > net.
>
> So for sure, we can queue up the work and process it later.
> The somewhat tricky part is limiting the memory consumption.

And it needs to sync with rtnl somehow, e.g device unregistering which
seems not easy.

Thanks

>
>
> > >
> > > > > > > 2- still handle surprise removal correctly by waking in that =
case
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > > ---
> > > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virti=
o_net.c
> > > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(s=
truct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > >              * into the hypervisor, so the request should=
 be handled immediately.
> > > > > > > > >              */
> > > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > +               cond_resched();
> > > > > > > > >                     cpu_relax();
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > >             return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > > > > > > >      }
> > > > > > > > > --
> > > > > > > > > 2.39.3
> > > > > > > > >
> > > > > > > > > _______________________________________________
> > > > > > > > > Virtualization mailing list
> > > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtua=
lization
> > > > > > >
> > > > >
> > >
>


