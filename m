Return-Path: <netdev+bounces-31399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736FF78D624
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67491C203B6
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A005694;
	Wed, 30 Aug 2023 13:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C5538A
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 13:30:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78E198
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693402239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrmtevR+OHspc/c545A2F7OAMYEjllnCprVaLeVCRbQ=;
	b=Oi4msi9VB3j0ZgJuqCfU42WZObDCxWJQgAsZSl+Ouk+H2iUVnUXEzIGaL5vwsQk/KvfAk+
	Sr4GcZdrMPg08zs5kLCFGQoaMKuXUfz9yJjGHRsG29qALHoCv4Fb+tdDPJPSONkvCBUdry
	EIquKv6LZqSAsIYytV/oq6fMaN3Xd9c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-GuJV49bPPUi3JaMy8TK0uA-1; Wed, 30 Aug 2023 09:30:38 -0400
X-MC-Unique: GuJV49bPPUi3JaMy8TK0uA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-978a991c3f5so428899866b.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402237; x=1694007037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrmtevR+OHspc/c545A2F7OAMYEjllnCprVaLeVCRbQ=;
        b=h/SI0JoCDwuzjxpJsz9A/j7KDJTAixPgPO7cL1wKhgfr1hA7Cg82I9l+thhZNNQcUS
         fKEYY/e2dp6xSb5q2tVYbvsDBFy0XXZhyL/Dar+mpb0oOiNPp3MQTDpFKUbFh6IFvJaL
         zh/7ycXLgqGxwaMhmakUII3MPzfcy+QEFjj85V9pCRxvGkkUj+on/c2DP+RdbhYRyRyF
         u6wV7m/yvcXvDV8ljE9JdBLl885rIZJa7CoSmsgu0vjRA8AYibuR8lWNek36XAbEAEU+
         6VwkgP3kw3MCVbFwh3y8KxActE4FIRLcgcW1GKia0oJa2528IrWD/cntzZSc5FbZMHEI
         UkxA==
X-Gm-Message-State: AOJu0YykV01FnfJzsmLyuOGlzRUHBvGY9Z7a4CaEbVZ12iu79XxKSvc+
	m4L368cZ/GOfmjFfaeq4kyBCILXIfRPUE52rz+FDRUmjI07/FJLCPKRufzsxY3ZAu38Jrv+rI3J
	ajTDaOHnvcz6x4e0K
X-Received: by 2002:a17:906:8b:b0:9a5:7887:ef09 with SMTP id 11-20020a170906008b00b009a57887ef09mr1872771ejc.32.1693402237183;
        Wed, 30 Aug 2023 06:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxUHeyUiFVorh4ZDehN292nCkRvDukdS6QYJWdvud4F+ML6iNTqT9rYxTEkbhUobIqpPlWg==
X-Received: by 2002:a17:906:8b:b0:9a5:7887:ef09 with SMTP id 11-20020a170906008b00b009a57887ef09mr1872753ejc.32.1693402236839;
        Wed, 30 Aug 2023 06:30:36 -0700 (PDT)
Received: from redhat.com ([2.55.167.22])
        by smtp.gmail.com with ESMTPSA id ju26-20020a17090798ba00b00982a352f078sm7183100ejc.124.2023.08.30.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:30:35 -0700 (PDT)
Date: Wed, 30 Aug 2023 09:30:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, xieyongji@bytedance.com,
	jasowang@redhat.com, david.marchand@redhat.com, lulu@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230830091607-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
 <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
 <20230829130430-mutt-send-email-mst@kernel.org>
 <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 01:27:18PM +0200, Maxime Coquelin wrote:
> 
> 
> On 8/29/23 19:05, Michael S. Tsirkin wrote:
> > On Tue, Aug 29, 2023 at 03:34:06PM +0200, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 8/11/23 00:00, Jakub Kicinski wrote:
> > > > On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
> > > > > > Directly into the stack? I thought VDUSE is vDPA in user space,
> > > > > > meaning to get to the kernel the packet has to first go thru
> > > > > > a virtio-net instance.
> > > > > 
> > > > > yes. is that a sufficient filter in your opinion?
> > > > 
> > > > Yes, the ability to create the device feels stronger than CAP_NET_RAW,
> > > > and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
> > > > experience with virt so no strong opinion, perhaps it does make sense
> > > > for someone's deployment? Dunno..
> > > > 
> > > 
> > > I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
> > > devices, as the device could be attached to vhost-vDPA and so not
> > > visible to the Kernel networking stack.
> > > 
> > > However, CAP_NET_ADMIN should be required to attach the VDUSE device to
> > > virtio-vdpa/virtio-net.
> > > 
> > > Does that make sense?
> > > 
> > > Maxime
> > 
> > OK. How are we going to enforce it?
> 
> Actually, it seems already enforced for all VDPA devices types.
> Indeed, the VDPA_CMD_DEV_NEW Netlink command used to add the device to
> the VDPA bus has the GENL_ADMIN_PERM flag set, and so require
> CAT_NET_ADMIN.

Hmm good point. Pity I didn't notice earlier. Oh well there's always
the next release.

> > Also, we need a way for selinux to enable/disable some of these things
> > but not others.
> 
> Ok, I can do it in a patch on top.
> Do you have a pointer where it is done for Virtio Block devices?
> 
> Maxime

It's not done yet - at the moment vduse device is always block so we
didn't need the distinction.

-- 
MST


