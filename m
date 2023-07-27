Return-Path: <netdev+bounces-21720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9976467F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26011C21323
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F282A944;
	Thu, 27 Jul 2023 06:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB03538B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:10:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DA1990
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690438234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Md4SRid1hDg9nGCkfKo1X89jQCVvHHyaEAACgzafNkc=;
	b=fVrBJ6aRVHk2MZnXwSDgiVR2r9nw4GtPsRa4wkWWBVKHo0c6OhtupZdePRSUMJDmKdaiin
	0365UDJeNYx8xucQ7eXIJQQwn3zymFk03fYljMd4lMkhV3Bl9orBhxnlIi08dKhLx4K5ml
	FF6O7JTXK1I0LzrbA32CauObQQ5CfVY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-MubqXo_uPwGy-vA7QQjnMg-1; Thu, 27 Jul 2023 02:10:33 -0400
X-MC-Unique: MubqXo_uPwGy-vA7QQjnMg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fd2e59bc53so3030105e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690438232; x=1691043032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Md4SRid1hDg9nGCkfKo1X89jQCVvHHyaEAACgzafNkc=;
        b=k3w0TRlFkXth4pHvjvQ8h4uV6xVsNXlY9QfJHJ7lorS02xUATYhRqe/oGZgguN6Mbn
         HXbGQnPsf9gnWP6sIHlAl7NKu7Nr1Hwe4RsKPj6AZWzG10tjIvk15EV6fQwdsTjpe7xB
         1Uwz5TMDMoJhP/wi+ERk0LG32907e9RE3JXi5rlPgw0MgEE79JE+lnlzufiOk/MYiOqS
         pv6u1XGLrMAslvrSLt8nAtB3nmuh7sgqfAEU46CfFRCZYBOOB7aM5BPL3HP2nsHs6OFU
         84Uro/8Hzqp+k1GK7wWnRttfOhecGoAOVY7OONpKk+2sYWWmgiBYx5eXxFvTAG6uTIkp
         XDJA==
X-Gm-Message-State: ABy/qLa7GxZ7nl3kg4V+ed1xJYepP/eYQPjeSRjcnHL4782nOFxbhcXO
	Voy8ZS+4CDaATyWUF2Co668yGwagNAnx+SkkJX8kvlSRnuUDsMTS1XVKKE3ub2U/p31Lf/49LVP
	Kecz/flwDBkjQ3l+e
X-Received: by 2002:a1c:4c0f:0:b0:3fd:2f8e:2c69 with SMTP id z15-20020a1c4c0f000000b003fd2f8e2c69mr833445wmf.32.1690438232198;
        Wed, 26 Jul 2023 23:10:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWUV7J6CiJBzfD+xPifRyv8cgXYmKJozN4Bl5HrvqQlHyOWlIxZSJGr1lK4NMKNUKNcejm0Q==
X-Received: by 2002:a1c:4c0f:0:b0:3fd:2f8e:2c69 with SMTP id z15-20020a1c4c0f000000b003fd2f8e2c69mr833433wmf.32.1690438231845;
        Wed, 26 Jul 2023 23:10:31 -0700 (PDT)
Received: from redhat.com ([31.187.78.131])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fc02219081sm880016wmi.33.2023.07.26.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 23:10:31 -0700 (PDT)
Date: Thu, 27 Jul 2023 02:10:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230727020930-mutt-send-email-mst@kernel.org>
References: <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 02:03:59PM +0800, Jason Wang wrote:
> On Wed, Jul 26, 2023 at 7:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 26, 2023 at 09:55:37AM +0800, Jason Wang wrote:
> > > On Tue, Jul 25, 2023 at 3:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Jul 25, 2023 at 11:07:40AM +0800, Jason Wang wrote:
> > > > > On Mon, Jul 24, 2023 at 3:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jul 24, 2023 at 02:52:05PM +0800, Jason Wang wrote:
> > > > > > > On Sat, Jul 22, 2023 at 4:18 AM Maxime Coquelin
> > > > > > > <maxime.coquelin@redhat.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > > > > > > >>
> > > > > > > > >>
> > > > > > > > >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > > > >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > > > > >>>>
> > > > > > > > >>>>
> > > > > > > > >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > > >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > > > > >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > >>>>>>>
> > > > > > > > >>>>>>> Adding cond_resched() to the command waiting loop for a better
> > > > > > > > >>>>>>> co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > > > >>>>>>> run other task(workqueue) instead of busy looping when preemption is
> > > > > > > > >>>>>>> not allowed on a device whose CVQ might be slow.
> > > > > > > > >>>>>>>
> > > > > > > > >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > > > > >>>>>> more.  Thanks.
> > > > > > > > >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > > >>>>>>
> > > > > > > > >>>>>
> > > > > > > > >>>>> I'd like to see a full solution
> > > > > > > > >>>>> 1- block until interrupt
> > > > > > >
> > > > > > > I remember in previous versions, you worried about the extra MSI
> > > > > > > vector. (Maybe I was wrong).
> > > > > > >
> > > > > > > > >>>>
> > > > > > > > >>>> Would it make sense to also have a timeout?
> > > > > > > > >>>> And when timeout expires, set FAILED bit in device status?
> > > > > > > > >>>
> > > > > > > > >>> virtio spec does not set any limits on the timing of vq
> > > > > > > > >>> processing.
> > > > > > > > >>
> > > > > > > > >> Indeed, but I thought the driver could decide it is too long for it.
> > > > > > > > >>
> > > > > > > > >> The issue is we keep waiting with rtnl locked, it can quickly make the
> > > > > > > > >> system unusable.
> > > > > > > > >
> > > > > > > > > if this is a problem we should find a way not to keep rtnl
> > > > > > > > > locked indefinitely.
> > > > > > >
> > > > > > > Any ideas on this direction? Simply dropping rtnl during the busy loop
> > > > > > > will result in a lot of races. This seems to require non-trivial
> > > > > > > changes in the networking core.
> > > > > > >
> > > > > > > >
> > > > > > > >  From the tests I have done, I think it is. With OVS, a reconfiguration
> > > > > > > > is performed when the VDUSE device is added, and when a MLX5 device is
> > > > > > > > in the same bridge, it ends up doing an ioctl() that tries to take the
> > > > > > > > rtnl lock. In this configuration, it is not possible to kill OVS because
> > > > > > > > it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> > > > > > > > net.
> > > > > > >
> > > > > > > Yeah, basically, any RTNL users would be blocked forever.
> > > > > > >
> > > > > > > And the infinite loop has other side effects like it blocks the freezer to work.
> > > > > > >
> > > > > > > To summarize, there are three issues
> > > > > > >
> > > > > > > 1) busy polling
> > > > > > > 2) breaks freezer
> > > > > > > 3) hold RTNL during the loop
> > > > > > >
> > > > > > > Solving 3 may help somehow for 2 e.g some pm routine e.g wireguard or
> > > > > > > even virtnet_restore() itself may try to hold the lock.
> > > > > >
> > > > > > Yep. So my feeling currently is, the only real fix is to actually
> > > > > > queue up the work in software.
> > > > >
> > > > > Do you mean something like:
> > > > >
> > > > > rtnl_lock();
> > > > > queue up the work
> > > > > rtnl_unlock();
> > > > > return success;
> > > > >
> > > > > ?
> > > >
> > > > yes
> > >
> > > We will lose the error reporting, is it a real problem or not?
> >
> > Fundamental isn't it? Maybe we want a per-device flag for a asynch commands,
> > and vduse will set it while hardware virtio won't.
> > this way we only lose error reporting for vduse.
> 
> This problem is not VDUSE specific, DPUs/vDPA may suffer from this as
> well. This might require more thoughts.
> 
> Thanks

They really shouldn't - any NIC that takes forever to
program will create issues in the networking stack.
But if they do they can always set this flag too.

> >
> > > >
> > > >
> > > > > > It's mostly trivial to limit
> > > > > > memory consumption, vid's is the
> > > > > > only one where it would make sense to have more than
> > > > > > 1 command of a given type outstanding.
> > > > >
> > > > > And rx mode so this implies we will fail any command if the previous
> > > > > work is not finished.
> > > >
> > > > don't fail it, store it.
> > >
> > > Ok.
> > >
> > > Thanks
> > >
> > > >
> > > > > > have a tree
> > > > > > or a bitmap with vids to add/remove?
> > > > >
> > > > > Probably.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >>>>> 2- still handle surprise removal correctly by waking in that case
> > > > > > >
> > > > > > > This is basically what version 1 did?
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Yes - except the timeout part.
> > > > > >
> > > > > >
> > > > > > > > >>>>>
> > > > > > > > >>>>>
> > > > > > > > >>>>>
> > > > > > > > >>>>>>> ---
> > > > > > > > >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > >>>>>>>
> > > > > > > > >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > >>>>>>> --- a/drivers/net/virtio_net.c
> > > > > > > > >>>>>>> +++ b/drivers/net/virtio_net.c
> > > > > > > > >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > >>>>>>>              * into the hypervisor, so the request should be handled immediately.
> > > > > > > > >>>>>>>              */
> > > > > > > > >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > >>>>>>> +               cond_resched();
> > > > > > > > >>>>>>>                     cpu_relax();
> > > > > > > > >>>>>>> +       }
> > > > > > > > >>>>>>>
> > > > > > > > >>>>>>>             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > > >>>>>>>      }
> > > > > > > > >>>>>>> --
> > > > > > > > >>>>>>> 2.39.3
> > > > > > > > >>>>>>>
> > > > > > > > >>>>>>> _______________________________________________
> > > > > > > > >>>>>>> Virtualization mailing list
> > > > > > > > >>>>>>> Virtualization@lists.linux-foundation.org
> > > > > > > > >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > > > > >>>>>
> > > > > > > > >>>
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >


