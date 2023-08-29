Return-Path: <netdev+bounces-31294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9978CA28
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 19:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F5C1C20A45
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C28A17FE2;
	Tue, 29 Aug 2023 17:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35714F94
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 17:05:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC4FC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693328742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wp+lO0Za9L1acZGmo62Fhb05kvKx8z5CE6eXi+DCnBs=;
	b=dMBNjZIT6gOMdczQBlPnDUsRDj6O+FwZC4tFi2eQpm9Yxk3kCz2KFKfh1ZMtXmXbxJiCAK
	Zj4NPo7LLEJ+o2cpfKTdpKNE+SW9SJ+uXOwR1TgdBSUFy40UJSlLMShAW1ttpL31jChplv
	7aRyI179175PU81nwFbHNfUorVt+urw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-wyn5qQz0PuyKwbXtUP7wEA-1; Tue, 29 Aug 2023 13:05:40 -0400
X-MC-Unique: wyn5qQz0PuyKwbXtUP7wEA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99cc32f2ec5so338694366b.1
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328739; x=1693933539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp+lO0Za9L1acZGmo62Fhb05kvKx8z5CE6eXi+DCnBs=;
        b=FE3IvlNaQMYehzAXBJhj7ssGAz5KW3TPgkvEC/hYiB1IiwsgXdoeUO8RoMGv+lfYWY
         cos+70c/Zekka4b5Q/syL1LyWZ1nIojnE/w7GNZ0E6nLLbRHV2PlVBPqe560lmQE6q7S
         wlSWV09FBoUyNWFd79MwMmRID/5EfkM6sNL2an77zl0T9HUZ8R5CUJAaYsNkzevmV2x/
         dGz87EH1RJEsPo+xPHhMnTMy2j/dVEe7whxiLLDcbk46ucuj5D54Q9laoklp5KoikyV0
         nSNtCxoymO/GUZVspoFcXDQulerRkVEyU+1gUfK3F7vsGJ7GBfg7qkcUG4MOq0Q4XZEy
         lDvA==
X-Gm-Message-State: AOJu0YxOVgu69IzqzB+QVE3xaSwTUi706g6AEqBHBBtMwt/ll2L490ZA
	OX5vZtV7hsOrKxM3P8cuWu2ntyMP5IqmIFHHIL08vzJvQwvJ4wrqTH652Uh+bPNma1jSuuApUzr
	WH5VOJEiHF+VNEclq
X-Received: by 2002:a17:907:2ccc:b0:99c:c50f:7fb4 with SMTP id hg12-20020a1709072ccc00b0099cc50f7fb4mr22020865ejc.1.1693328739785;
        Tue, 29 Aug 2023 10:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUG9QCLSRWNIOZmLbNMXZrQdhj8bqgWsaIjevUAoHBLvB/ItbfFf7wUUc51DKfYBWhoiJfog==
X-Received: by 2002:a17:907:2ccc:b0:99c:c50f:7fb4 with SMTP id hg12-20020a1709072ccc00b0099cc50f7fb4mr22020850ejc.1.1693328739454;
        Tue, 29 Aug 2023 10:05:39 -0700 (PDT)
Received: from redhat.com ([2.55.167.22])
        by smtp.gmail.com with ESMTPSA id ju26-20020a17090798ba00b00982a352f078sm6146254ejc.124.2023.08.29.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:05:38 -0700 (PDT)
Date: Tue, 29 Aug 2023 13:05:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, xieyongji@bytedance.com,
	jasowang@redhat.com, david.marchand@redhat.com, lulu@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230829130430-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
 <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 03:34:06PM +0200, Maxime Coquelin wrote:
> 
> 
> On 8/11/23 00:00, Jakub Kicinski wrote:
> > On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
> > > > Directly into the stack? I thought VDUSE is vDPA in user space,
> > > > meaning to get to the kernel the packet has to first go thru
> > > > a virtio-net instance.
> > > 
> > > yes. is that a sufficient filter in your opinion?
> > 
> > Yes, the ability to create the device feels stronger than CAP_NET_RAW,
> > and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
> > experience with virt so no strong opinion, perhaps it does make sense
> > for someone's deployment? Dunno..
> > 
> 
> I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
> devices, as the device could be attached to vhost-vDPA and so not
> visible to the Kernel networking stack.
> 
> However, CAP_NET_ADMIN should be required to attach the VDUSE device to
> virtio-vdpa/virtio-net.
> 
> Does that make sense?
> 
> Maxime

OK. How are we going to enforce it?
Also, we need a way for selinux to enable/disable some of these things
but not others.

-- 
MST


