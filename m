Return-Path: <netdev+bounces-21599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B453763F7D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3568D281F27
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602024CE9C;
	Wed, 26 Jul 2023 19:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFE4CE8F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:25:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F72212D
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690399549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b470bquDvAWwTJ3wEUm2l/rKWbtahDTcrXgZvkuAUQM=;
	b=QzZxSmdtkR0Ld42nFtYsbFdrxsMrwL7GhdmeFKCGfPmG4I9QtPkSfr6Cj77qxmY2DPlUY4
	zjxnniK8t1jOIqVhhSUCP2NMygk0CF1AhJbcY/bHeC1Q4EpmhH7ZDh8AGmJ2+mRPBcCPnQ
	P3hjplMFlzoYFs0p/IkBH17L5gyAh7E=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-gAsvXeqQNZ6JYf-52imdVg-1; Wed, 26 Jul 2023 15:25:47 -0400
X-MC-Unique: gAsvXeqQNZ6JYf-52imdVg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7865e0082c5so7979839f.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399547; x=1691004347;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b470bquDvAWwTJ3wEUm2l/rKWbtahDTcrXgZvkuAUQM=;
        b=JkgYddQX3ulsrXIZQ5HKcklHtEodWLIp1SdCimarvFVVp7+RbLcIht+wEeenmry8nM
         CZlnnHCurtlGU9FGTCTk2r7smJHPzAl3TYlopBHxEvYbpo2CNTYD7ykg/Z2xPeVY6cTs
         XaH0c5dtOPxNX7muPm8wMhdzK6QayiSFQ9MBy0wTS8vT2IlV1qKK458dkso3UJZHnmIu
         EwAu2wNprNKE4A5xZ1v7mPjnWnCP0hNxxR5vAyhoxavKElnxq8LVRCRk9DHXCd51EuYC
         tCFqq3c5PEaEvs0p65leV8NYdZ5vMztP3Ji6Dr70tlp+U45KQ7V3izbhWv5V7Rr2rkv0
         3/LQ==
X-Gm-Message-State: ABy/qLb5agCglLaVa+BFg+TSpfA58y4EudhTX48hvslmzJarLxz8vJaD
	y3GRF+lZ6jFf6WG+luHIjpYjx/iCuUzg1SIVMsTB5lcW9nXFNby2uKZCdU5DmUatYsS0aTOUtkT
	ga8HayOYH7JGDASkl
X-Received: by 2002:a05:6602:10f:b0:783:57a0:612c with SMTP id s15-20020a056602010f00b0078357a0612cmr3115863iot.10.1690399547029;
        Wed, 26 Jul 2023 12:25:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHKSNJk//D8TxnhZOZHTizZXe3HvjTavmKRr+BZbiNXoTGUO8viZnZraxYCP7ylJPTA66TjGg==
X-Received: by 2002:a05:6602:10f:b0:783:57a0:612c with SMTP id s15-20020a056602010f00b0078357a0612cmr3115848iot.10.1690399546796;
        Wed, 26 Jul 2023 12:25:46 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id e26-20020a5d925a000000b0078335414ddesm5258050iol.26.2023.07.26.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:25:46 -0700 (PDT)
Date: Wed, 26 Jul 2023 13:25:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <bcreeley@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Brett Creeley <brett.creeley@amd.com>,
 kvm@vger.kernel.org, netdev@vger.kernel.org, yishaih@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
 simon.horman@corigine.com, shannon.nelson@amd.com
Subject: Re: [PATCH v13 vfio 0/7] pds-vfio-pci driver
Message-ID: <20230726132544.69e52844.alex.williamson@redhat.com>
In-Reply-To: <95fa9f2d-a529-4d79-167f-eaee1ed0ac4f@amd.com>
References: <20230725214025.9288-1-brett.creeley@amd.com>
	<ZMEhCrZDNLSrWP/5@nvidia.com>
	<20230726125051.424ed592.alex.williamson@redhat.com>
	<95fa9f2d-a529-4d79-167f-eaee1ed0ac4f@amd.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 12:05:13 -0700
Brett Creeley <bcreeley@amd.com> wrote:

> On 7/26/2023 11:50 AM, Alex Williamson wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Wed, 26 Jul 2023 10:35:06 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> >> On Tue, Jul 25, 2023 at 02:40:18PM -0700, Brett Creeley wrote:
> >>  
> >>> Note: This series is based on the latest linux-next tree. I did not base
> >>> it on the Alex Williamson's vfio/next because it has not yet pulled in
> >>> the latest changes which include the pds_vdpa driver. The pds_vdpa
> >>> driver has conflicts with the pds-vfio-pci driver that needed to be
> >>> resolved, which is why this series is based on the latest linux-next
> >>> tree.  
> >>
> >> This is not the right way to handle this, Alex cannot apply a series
> >> against linux-next.
> >>
> >> If you can't make a shared branch and the conflicts are too
> >> significant to forward to Linus then you have to wait for the next
> >> cycle.  
> > 
> > Brett, can you elaborate on what's missing from my next branch vs
> > linux-next?
> > 
> > AFAICT the pds_vdpa driver went into mainline via a8d70602b186 ("Merge
> > tag 'for_linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost") during the
> > v6.5 merge window and I'm not spotting anything in linux-next obviously
> > relevant to pds-vfio-pci since then.
> > 
> > There's a debugfs fix on the list, but that's sufficiently trivial to
> > fixup on merge if necessary.  This series also applies cleanly vs my
> > current next branch.  Was the issue simply that I hadn't updated my
> > next branch (done yesterday) since the v6.5 merge window?  You can
> > always send patches vs mainline.  Thanks,  
> 
> Yeah, this was exactly it. Your vfio/next branch didn't have the 
> pds_vdpa series in it yet, which also included some changes to the 
> header files used by the pds-vfio-pci series, which is where the 
> conflicts are.

Ok, so let's put this back on the table as a candidate for v6.6.

> Should I rebase my series on your vfio/next branch and resend?

It doesn't seem necessary, I think rebasing my next branch to v6.5-rc3
made it effectively equivalent to linux-next for the purposes of this
driver.  It applies cleanly, so I think we can continue review from
this.  Thanks,

Alex


