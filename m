Return-Path: <netdev+bounces-21576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62E763EF6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B97D1C212C4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495364CE73;
	Wed, 26 Jul 2023 18:51:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8A7E1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:51:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F891FEC
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690397459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QcbDGFNGyrYMflmHGqX/IsfCv+zGpwF2/bsKWDKJIp8=;
	b=Ui7kIHyBUzyS2BzKUAhEZtCbWyJhWg/fBTXgBebRTLKi6PwB/4Fe8n273IMEIFqGrVqvfN
	F1p85IsUapHX5mn/CRdJBo/q+HFo1Pc0GCp7F26+XKYwZtYkG1Y7e5Xo3oI3Z8c0T+Hm3L
	kQZtI5F7VYgeTQMBp2blNzlXMfZ5OCs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-5jYx6z9yNnKygaQNRBvH8Q-1; Wed, 26 Jul 2023 14:50:58 -0400
X-MC-Unique: 5jYx6z9yNnKygaQNRBvH8Q-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-348c5e4690cso337905ab.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397458; x=1691002258;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcbDGFNGyrYMflmHGqX/IsfCv+zGpwF2/bsKWDKJIp8=;
        b=PAjRAs9Q1+s0WSO88Ld0BapNQOSEtsAbjBKejzOg8fjRbcfmIx2jZCwwrc3UB3wm5I
         ip9p+8llpVsVl+Ibj64uDsDEHwBtXjIxoS2irGjasaQ2lYZVX2mIJo9raE248zQREMnj
         8XrADZjDlYk4XaMq6lMRdPTerxir4aqX3IhaFBRjVn9WDjO0932IHgRS/MZAvfPguTzG
         Tl/fnLwDv4zo01zdhapLAJDaEwsqRyjV7z+tNJkp5RwHkYfSsQz3GPn/VpqfJhjmU8aj
         aU43UgJpl6w/jSZD3m8EcjrWmtv3/xTWb1L7vRE7qI3i3ngZ+7SonZcl3YARDNLb4fiQ
         PUdw==
X-Gm-Message-State: ABy/qLZ1WUnsLZOf5g9+tQ0dJ5OqJrpjmbRvie2h2d6zfRPXWnY+5Khp
	ASjEND2LrDckYs25CS+eD2zFVLOq6Z39dW+yEA5KQNJlUa7sHcZ95IB/Yy3Kqj8ZIj2ZO7rSWbI
	aWJRwINpgU3YnFzei
X-Received: by 2002:a05:6e02:1d9b:b0:348:f0a2:84e9 with SMTP id h27-20020a056e021d9b00b00348f0a284e9mr1629867ila.15.1690397457993;
        Wed, 26 Jul 2023 11:50:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWr9KN/3gmDtc0e/YmU+TWLlciolPJwB74ehqdkPyMuqmq6grQvJuksTfuEqTpJIXP53zVJQ==
X-Received: by 2002:a05:6e02:1d9b:b0:348:f0a2:84e9 with SMTP id h27-20020a056e021d9b00b00348f0a284e9mr1629849ila.15.1690397457788;
        Wed, 26 Jul 2023 11:50:57 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id g10-20020a02c54a000000b0042b6ae47f0esm4454923jaj.108.2023.07.26.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:50:57 -0700 (PDT)
Date: Wed, 26 Jul 2023 12:50:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Brett Creeley <brett.creeley@amd.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, yishaih@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
 simon.horman@corigine.com, shannon.nelson@amd.com
Subject: Re: [PATCH v13 vfio 0/7] pds-vfio-pci driver
Message-ID: <20230726125051.424ed592.alex.williamson@redhat.com>
In-Reply-To: <ZMEhCrZDNLSrWP/5@nvidia.com>
References: <20230725214025.9288-1-brett.creeley@amd.com>
	<ZMEhCrZDNLSrWP/5@nvidia.com>
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

On Wed, 26 Jul 2023 10:35:06 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 25, 2023 at 02:40:18PM -0700, Brett Creeley wrote:
> 
> > Note: This series is based on the latest linux-next tree. I did not base
> > it on the Alex Williamson's vfio/next because it has not yet pulled in
> > the latest changes which include the pds_vdpa driver. The pds_vdpa
> > driver has conflicts with the pds-vfio-pci driver that needed to be
> > resolved, which is why this series is based on the latest linux-next
> > tree.  
> 
> This is not the right way to handle this, Alex cannot apply a series
> against linux-next.
> 
> If you can't make a shared branch and the conflicts are too
> significant to forward to Linus then you have to wait for the next
> cycle.

Brett, can you elaborate on what's missing from my next branch vs
linux-next?

AFAICT the pds_vdpa driver went into mainline via a8d70602b186 ("Merge
tag 'for_linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost") during the
v6.5 merge window and I'm not spotting anything in linux-next obviously
relevant to pds-vfio-pci since then.

There's a debugfs fix on the list, but that's sufficiently trivial to
fixup on merge if necessary.  This series also applies cleanly vs my
current next branch.  Was the issue simply that I hadn't updated my
next branch (done yesterday) since the v6.5 merge window?  You can
always send patches vs mainline.  Thanks,

Alex


