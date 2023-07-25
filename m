Return-Path: <netdev+bounces-20716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F8760C17
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3741C20D7C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FD11CB0;
	Tue, 25 Jul 2023 07:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15D11C99
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:39:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807EFD3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690270770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VEG98KIvt8LRb8tcIeahsb2VtaKO2Trib+565MxI7U=;
	b=A21hSXhv2MhPnVoXmJrEam47krlLpR8GwvhN/R5fLu5xRrdgY2D/cuGgXoTE3W0sadYAz8
	0VuFe2yujYBm5ibkElC2geb0TXXxel7Qf3e75IAGKN+C8N+qc40ZzNMpFjWATMKhqmhaYA
	Ln+UYe8YkGojONCBF3iyx4dMKFlJu34=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-vbVdAuj_Pqa7yTm2HJ9t2w-1; Tue, 25 Jul 2023 03:36:19 -0400
X-MC-Unique: vbVdAuj_Pqa7yTm2HJ9t2w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-997c891a88dso420270266b.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270578; x=1690875378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VEG98KIvt8LRb8tcIeahsb2VtaKO2Trib+565MxI7U=;
        b=Ale2Rvwv6w1wBlmZUVUPzby66mpANehSxbpzmrZ6l7gx5awgtTWSMjZLAXv8EmweYg
         j5+cpEhAcTlJkq/9F1qmyUuFh91UJliwzbr9WVzn8Ar24ld3tEYAXWvqB6udxHNL5VIs
         BtFdxWqwJsNlHSAZkazamiqY7VKvwejFWoZFy2atc2chtSl3eTTD4LHCeV+B1h+doyLA
         vz6iC3B4WWvGUX9y/2T+ZSV17cOyv6VlrAqfITmvOtWFUNFz6ZCa7O6XTzj4x7sGj9hr
         oS6pwLB/5RVMwUTO612tUTAeyhNWfNqXXCtTa5chc1BGRw/qCeoooZM2Rlt6ACdG1CUB
         BU0A==
X-Gm-Message-State: ABy/qLZoatWaOW91mkU9Zft6OZQ+hpwWb4IjXWwZioczrbQKC4UicWVy
	Qq0mza7s4temXCIpkfwgYnd+/hyrC2W8tRJ2KuKQXUAFwwAVm+XJvcF/EVKkI146skVLUtGzyHn
	PiYoYYqB0zrkWBpUg
X-Received: by 2002:a17:907:7750:b0:992:4250:5462 with SMTP id kx16-20020a170907775000b0099242505462mr11927153ejc.50.1690270578557;
        Tue, 25 Jul 2023 00:36:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbuQ+B36ExWOmlZ5PK0JXR3LiRI6TjSV+5qKRE6dIJffKcs1oJ2j/QzHg1GhN52TQxfOi1cg==
X-Received: by 2002:a17:907:7750:b0:992:4250:5462 with SMTP id kx16-20020a170907775000b0099242505462mr11927135ejc.50.1690270578169;
        Tue, 25 Jul 2023 00:36:18 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id p26-20020a170906a01a00b00992f81122e1sm7750226ejy.21.2023.07.25.00.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:36:17 -0700 (PDT)
Date: Tue, 25 Jul 2023 03:36:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230725033506-mutt-send-email-mst@kernel.org>
References: <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 11:07:40AM +0800, Jason Wang wrote:
> On Mon, Jul 24, 2023 at 3:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 24, 2023 at 02:52:05PM +0800, Jason Wang wrote:
> > > On Sat, Jul 22, 2023 at 4:18 AM Maxime Coquelin
> > > <maxime.coquelin@redhat.com> wrote:
> > > >
> > > >
> > > >
> > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > > >>
> > > > >>
> > > > >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > >>>>
> > > > >>>>
> > > > >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > >>>>>>>
> > > > >>>>>>> Adding cond_resched() to the command waiting loop for a better
> > > > >>>>>>> co-operation with the scheduler. This allows to give CPU a breath to
> > > > >>>>>>> run other task(workqueue) instead of busy looping when preemption is
> > > > >>>>>>> not allowed on a device whose CVQ might be slow.
> > > > >>>>>>>
> > > > >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >>>>>>
> > > > >>>>>> This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > >>>>>> more.  Thanks.
> > > > >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > >>>>>>
> > > > >>>>>
> > > > >>>>> I'd like to see a full solution
> > > > >>>>> 1- block until interrupt
> > >
> > > I remember in previous versions, you worried about the extra MSI
> > > vector. (Maybe I was wrong).
> > >
> > > > >>>>
> > > > >>>> Would it make sense to also have a timeout?
> > > > >>>> And when timeout expires, set FAILED bit in device status?
> > > > >>>
> > > > >>> virtio spec does not set any limits on the timing of vq
> > > > >>> processing.
> > > > >>
> > > > >> Indeed, but I thought the driver could decide it is too long for it.
> > > > >>
> > > > >> The issue is we keep waiting with rtnl locked, it can quickly make the
> > > > >> system unusable.
> > > > >
> > > > > if this is a problem we should find a way not to keep rtnl
> > > > > locked indefinitely.
> > >
> > > Any ideas on this direction? Simply dropping rtnl during the busy loop
> > > will result in a lot of races. This seems to require non-trivial
> > > changes in the networking core.
> > >
> > > >
> > > >  From the tests I have done, I think it is. With OVS, a reconfiguration
> > > > is performed when the VDUSE device is added, and when a MLX5 device is
> > > > in the same bridge, it ends up doing an ioctl() that tries to take the
> > > > rtnl lock. In this configuration, it is not possible to kill OVS because
> > > > it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> > > > net.
> > >
> > > Yeah, basically, any RTNL users would be blocked forever.
> > >
> > > And the infinite loop has other side effects like it blocks the freezer to work.
> > >
> > > To summarize, there are three issues
> > >
> > > 1) busy polling
> > > 2) breaks freezer
> > > 3) hold RTNL during the loop
> > >
> > > Solving 3 may help somehow for 2 e.g some pm routine e.g wireguard or
> > > even virtnet_restore() itself may try to hold the lock.
> >
> > Yep. So my feeling currently is, the only real fix is to actually
> > queue up the work in software.
> 
> Do you mean something like:
> 
> rtnl_lock();
> queue up the work
> rtnl_unlock();
> return success;
> 
> ?

yes


> > It's mostly trivial to limit
> > memory consumption, vid's is the
> > only one where it would make sense to have more than
> > 1 command of a given type outstanding.
> 
> And rx mode so this implies we will fail any command if the previous
> work is not finished.

don't fail it, store it.

> > have a tree
> > or a bitmap with vids to add/remove?
> 
> Probably.
> 
> Thanks
> 
> >
> >
> >
> > > >
> > > > >
> > > > >>>>> 2- still handle surprise removal correctly by waking in that case
> > >
> > > This is basically what version 1 did?
> > >
> > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
> > >
> > > Thanks
> >
> > Yes - except the timeout part.
> >
> >
> > > > >>>>>
> > > > >>>>>
> > > > >>>>>
> > > > >>>>>>> ---
> > > > >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> > > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >>>>>>>
> > > > >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> > > > >>>>>>> --- a/drivers/net/virtio_net.c
> > > > >>>>>>> +++ b/drivers/net/virtio_net.c
> > > > >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > >>>>>>>              * into the hypervisor, so the request should be handled immediately.
> > > > >>>>>>>              */
> > > > >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> > > > >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> > > > >>>>>>> +               cond_resched();
> > > > >>>>>>>                     cpu_relax();
> > > > >>>>>>> +       }
> > > > >>>>>>>
> > > > >>>>>>>             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > >>>>>>>      }
> > > > >>>>>>> --
> > > > >>>>>>> 2.39.3
> > > > >>>>>>>
> > > > >>>>>>> _______________________________________________
> > > > >>>>>>> Virtualization mailing list
> > > > >>>>>>> Virtualization@lists.linux-foundation.org
> > > > >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > >>>>>
> > > > >>>
> > > > >
> > > >
> >


