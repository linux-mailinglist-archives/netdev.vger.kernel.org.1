Return-Path: <netdev+bounces-38375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8AC7BA9E3
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B2D8F281B7F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66E41234;
	Thu,  5 Oct 2023 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1DYS1c/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C08405FE
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:18:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339D4DB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696533515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2R8nvS1fGysVMS5a70TnQ+euq+3ceDHbf0f2W4kS2b4=;
	b=E1DYS1c/Vb5lNUwW4K3kNTESufFV8GfqCa7asZgeG+C8zEe2n31TbUpIS0wd6IbAkBySWS
	/L+jIYf7XTOpvjXtjataBoLlc09qjmYS+Txj/o9vcOXkWcfa2g2g7eBFo71ZW4W8zArdD7
	Ao/cDj1FZFGLr7ua5+pTiZyJgudQbGQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-M5xR1a1ROcOt4BdSGVVNiQ-1; Thu, 05 Oct 2023 15:18:31 -0400
X-MC-Unique: M5xR1a1ROcOt4BdSGVVNiQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3217fdf913dso1047991f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 12:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533510; x=1697138310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2R8nvS1fGysVMS5a70TnQ+euq+3ceDHbf0f2W4kS2b4=;
        b=GdvnQef7OJ9d7aEsg/qVgJTd/jUj9JCAE5IffaFib+G8KQnE/OxwqSCqdQ9jsXVF53
         Tc58eGSL0htBLQE2OPXTktq9uv9kxWATaEQ/7GrKGRiRJpBD3EypQf9zPM+GHc4l3mhx
         nte55AqBQUJUmiVoGMlHDnid4JZ1RK5+Ow8cyIGpxcOSwD8IOdz+K49baKJXh5owyXQ/
         8PveKho/pWe+1kMSwLtYhN4qtkIzR1P8lOPOdDUefXll96o6zcqzrFIFB6aN348ZeVWa
         qRpsRCw9XoDq1tEVv9l1ETroFIX8GGyohUmSGta60/F36rwyNI9pSwsqC9BRu/ah6fWU
         yq+A==
X-Gm-Message-State: AOJu0YxcJ+J8xMpc2/RUjqCqTfFLcBV66hPpAW8L5u9tqAh9HVo/pANP
	XQb140CwvXpmrSNkGhgLt32Z/Im/BRlzEdXRz+NLhOti0gA4BjOnR1cf+259/Kq8SGJM1eD8DQ/
	PwJrz+Nq9o3KMub6L
X-Received: by 2002:a5d:58c2:0:b0:319:7a9f:c63 with SMTP id o2-20020a5d58c2000000b003197a9f0c63mr5707830wrf.50.1696533510571;
        Thu, 05 Oct 2023 12:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJSoSJCYUxP/9cvc2Te2pM2upBQSmDoYt/HKnGitt6LjIRBQVlh0qAuXtMDSL56hXqGRauRg==
X-Received: by 2002:a5d:58c2:0:b0:319:7a9f:c63 with SMTP id o2-20020a5d58c2000000b003197a9f0c63mr5707810wrf.50.1696533510205;
        Thu, 05 Oct 2023 12:18:30 -0700 (PDT)
Received: from redhat.com ([2.52.3.174])
        by smtp.gmail.com with ESMTPSA id e1-20020adffc41000000b003267b4692e5sm2421018wrs.19.2023.10.05.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:18:28 -0700 (PDT)
Date: Thu, 5 Oct 2023 15:18:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	Gal Pressman <gal@nvidia.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH vhost v2 00/16] vdpa: Add support for vq descriptor
 mappings
Message-ID: <20231005151812-mutt-send-email-mst@kernel.org>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
 <20231005133054-mutt-send-email-mst@kernel.org>
 <9dfa552011c20a58d8550bd794977de821212df4.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dfa552011c20a58d8550bd794977de821212df4.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 05:44:01PM +0000, Dragos Tatulea wrote:
> On Thu, 2023-10-05 at 13:31 -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 28, 2023 at 07:45:11PM +0300, Dragos Tatulea wrote:
> > > This patch series adds support for vq descriptor table mappings which
> > > are used to improve vdpa live migration downtime. The improvement comes
> > > from using smaller mappings which take less time to create and destroy
> > > in hw.
> > > 
> > > The first part adds the vdpa core changes from Si-Wei [0].
> > > 
> > > The second part adds support in mlx5_vdpa:
> > > - Refactor the mr code to be able to cleanly add descriptor mappings.
> > > - Add hardware descriptor mr support.
> > > - Properly update iotlb for cvq during ASID switch.
> > > 
> > > Changes in v2:
> > > 
> > > - The "vdpa/mlx5: Enable hw support for vq descriptor mapping" change
> > >   was split off into two patches to avoid merge conflicts into the tree
> > >   of Linus.
> > > 
> > >   The first patch contains only changes for mlx5_ifc.h. This must be
> > >   applied into the mlx5-next tree [1] first. Once this patch is applied
> > >   on mlx5-next, the change has to be pulled fom mlx5-next into the vhost
> > >   tree and only then the remaining patches can be applied.
> > 
> > 
> > I get it you plan v3?
> There are some very small improvements (commit message in 13/16 and fix in
> 16/16) that could make a v3. The latter can be addressed as a separate patch
> when moving dup_iotlb to vhost/iotlb. What do you think?


if there's a fix by all means post v3.

> > 
> > > [0]
> > > https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next
> > > 
> > > Dragos Tatulea (13):
> > >   vdpa/mlx5: Expose descriptor group mkey hw capability
> > >   vdpa/mlx5: Create helper function for dma mappings
> > >   vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
> > >   vdpa/mlx5: Take cvq iotlb lock during refresh
> > >   vdpa/mlx5: Collapse "dvq" mr add/delete functions
> > >   vdpa/mlx5: Rename mr destroy functions
> > >   vdpa/mlx5: Allow creation/deletion of any given mr struct
> > >   vdpa/mlx5: Move mr mutex out of mr struct
> > >   vdpa/mlx5: Improve mr update flow
> > >   vdpa/mlx5: Introduce mr for vq descriptor
> > >   vdpa/mlx5: Enable hw support for vq descriptor mapping
> > >   vdpa/mlx5: Make iotlb helper functions more generic
> > >   vdpa/mlx5: Update cvq iotlb mapping on ASID change
> > > 
> > > Si-Wei Liu (3):
> > >   vdpa: introduce dedicated descriptor group for virtqueue
> > >   vhost-vdpa: introduce descriptor group backend feature
> > >   vhost-vdpa: uAPI to get dedicated descriptor group id
> > > 
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  31 +++--
> > >  drivers/vdpa/mlx5/core/mr.c        | 191 ++++++++++++++++-------------
> > >  drivers/vdpa/mlx5/core/resources.c |   6 +-
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 100 ++++++++++-----
> > >  drivers/vhost/vdpa.c               |  27 ++++
> > >  include/linux/mlx5/mlx5_ifc.h      |   8 +-
> > >  include/linux/mlx5/mlx5_ifc_vdpa.h |   7 +-
> > >  include/linux/vdpa.h               |  11 ++
> > >  include/uapi/linux/vhost.h         |   8 ++
> > >  include/uapi/linux/vhost_types.h   |   5 +
> > >  10 files changed, 264 insertions(+), 130 deletions(-)
> > > 
> > > -- 
> > > 2.41.0
> > 
> 


