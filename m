Return-Path: <netdev+bounces-18445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E955757008
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 00:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491C01C20BD1
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BAD1118E;
	Mon, 17 Jul 2023 22:52:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A304BE46
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 22:52:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA200133
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689634329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wy84DSSq8n2YYiK0mWellsvoswCFp/2kMAmdZ+UHHc=;
	b=WSU35uqKWX5qXsL9Eqi4qqS9SCAvtRdUoP1pqlX2O/1cZK2gLwhVZqB5eExNH9bGJCaIvz
	BDObKB9Pjgy9nnNWI0Mg64rgQFu1m48ni/wL21sFRtdMbxZw6ZsGTbH7RccOeY6fV1KDLB
	hn5FNoggx6POG5Pi2hj0zNHisqxMXTQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-F8mCRwqONAm0x9MbIFeyjQ-1; Mon, 17 Jul 2023 18:52:07 -0400
X-MC-Unique: F8mCRwqONAm0x9MbIFeyjQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-786fa88a6f0so317983539f.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689634327; x=1692226327;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wy84DSSq8n2YYiK0mWellsvoswCFp/2kMAmdZ+UHHc=;
        b=Q5C5dVnmfxIdIbWw6yMHus1Yy8VFsrMiM8vb6KVjD85rDU/K2Ieg9mRXRnILn5Nuui
         1+7+ILzz95UXU8gRXA79R7q4LijT1l0PnzFXhlDHfajafQ8LpIRNmPkopBMQFmgw0qkX
         uSy0GqkT/8zL9ayLd0kTIMabeFuhyVoOXI7BH96Tjuc89XTv3KkuhcdY0vrYeZvpzf0Z
         LCIjI0ax2eqegDa9D2z/Bb58J8TKJoIChpnqmvpAUHwhbiqOyMlsgpUdbAHylThcrNf7
         mJbUW5aQXwfiU9Hs8K2AV3crW1TOnyWsZCjjnqfvtQeBTjui9p51MDYcxYwQEmUnZmP0
         x39Q==
X-Gm-Message-State: ABy/qLYRy7yABSRdPCoxgU3EIl3rwMpFQjpYmX5RBGLVJ4ppdYgj4aDl
	cCTdlMOuf5slY4wobtHrKdZyRdLYSz3/jVGiLhj9Y/l07mezp34Rt6WPoF7Q3CkymArX0DPlrvy
	dkzYAYLX5a7zlIIxF
X-Received: by 2002:a92:c651:0:b0:347:693a:7300 with SMTP id 17-20020a92c651000000b00347693a7300mr1012066ill.26.1689634327051;
        Mon, 17 Jul 2023 15:52:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlBYmCdY1EaUds5QDcX7E6PqePOm9wJTOwk2wgOBkeJp+9wxIVvWJlHjSTuTXhWw/m+atXtQ==
X-Received: by 2002:a92:c651:0:b0:347:693a:7300 with SMTP id 17-20020a92c651000000b00347693a7300mr1012015ill.26.1689634326829;
        Mon, 17 Jul 2023 15:52:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d10-20020a92ddca000000b00341c0710169sm242627ilr.46.2023.07.17.15.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:52:06 -0700 (PDT)
Date: Mon, 17 Jul 2023 16:52:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Grzegorz Jaszczyk <jaz@semihalf.com>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-usb@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>, Paul
 Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>, Jason Wang
 <jasowang@redhat.com>, dri-devel@lists.freedesktop.org, Michal Hocko
 <mhocko@kernel.org>, linux-mm@kvack.org, Kirti Wankhede
 <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe
 <axboe@kernel.dk>, Vineeth Vijayan <vneethv@linux.ibm.com>, Diana Craciun
 <diana.craciun@oss.nxp.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shakeel Butt <shakeelb@google.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>,
 Harald Freudenberger <freude@linux.ibm.com>, Fei Li <fei1.li@intel.com>,
 x86@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, Halil Pasic
 <pasic@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 intel-gfx@lists.freedesktop.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, linux-fpga@vger.kernel.org, Zhi Wang
 <zhi.a.wang@intel.com>, Wu Hao <hao.wu@intel.com>, Jason Herne
 <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd
 Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linuxppc-dev@lists.ozlabs.org, Eric Auger <eric.auger@redhat.com>, Borislav
 Petkov <bp@alien8.de>, kvm@vger.kernel.org, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, cgroups@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, virtualization@lists.linux-foundation.org,
 intel-gvt-dev@lists.freedesktop.org, io-uring@vger.kernel.org,
 netdev@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>, Tvrtko
 Ursulin <tvrtko.ursulin@linux.intel.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Sean Christopherson <seanjc@google.com>, Oded
 Gabbay <ogabbay@kernel.org>, Muchun Song <muchun.song@linux.dev>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Frederic Barrat
 <fbarrat@linux.ibm.com>, Moritz Fischer <mdf@kernel.org>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Xu Yilun
 <yilun.xu@intel.com>, Dominik Behr <dbehr@chromium.org>, Marcin Wojtas
 <mw@semihalf.com>
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <20230717165203.4ee6b1e6.alex.williamson@redhat.com>
In-Reply-To: <ZLW8wEzkhBxd0O0L@ziepe.ca>
References: <20230630155936.3015595-1-jaz@semihalf.com>
	<20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
	<CAH76GKPF4BjJLrzLBW8k12ATaAGADeMYc2NQ9+j0KgRa0pomUw@mail.gmail.com>
	<20230717130831.0f18381a.alex.williamson@redhat.com>
	<ZLW8wEzkhBxd0O0L@ziepe.ca>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 17 Jul 2023 19:12:16 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Jul 17, 2023 at 01:08:31PM -0600, Alex Williamson wrote:
> 
> > What would that mechanism be?  We've been iterating on getting the
> > serialization and buffering correct, but I don't know of another means
> > that combines the notification with a value, so we'd likely end up with
> > an eventfd only for notification and a separate ring buffer for
> > notification values.  
> 
> All FDs do this. You just have to make a FD with custom
> file_operations that does what this wants. The uAPI shouldn't be able
> to tell if the FD is backing it with an eventfd or otherwise. Have the
> kernel return the FD instead of accepting it. Follow the basic design
> of eg mlx5vf_save_fops

Sure, userspace could poll on any fd and read a value from it, but at
that point we're essentially duplicating a lot of what eventfd provides
for a minor(?) semantic difference over how the counter value is
interpreted.  Using an actual eventfd allows the ACPI notification to
work as just another interrupt index within the existing vfio IRQ uAPI.
Thanks,

Alex


