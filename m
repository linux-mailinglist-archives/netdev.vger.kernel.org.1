Return-Path: <netdev+bounces-27035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF57779F55
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 12:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04991C206FD
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEB61CCC4;
	Sat, 12 Aug 2023 10:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD3370
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 10:52:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09435A9;
	Sat, 12 Aug 2023 03:51:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E121968B05; Sat, 12 Aug 2023 12:49:51 +0200 (CEST)
Date: Sat, 12 Aug 2023 12:49:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Brett Creeley <bcreeley@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"shannon.nelson@amd.com" <shannon.nelson@amd.com>
Subject: Re: [PATCH v14 vfio 6/8] vfio/pds: Add support for dirty page
 tracking
Message-ID: <20230812104951.GC11480@lst.de>
References: <20230807205755.29579-1-brett.creeley@amd.com> <20230807205755.29579-7-brett.creeley@amd.com> <20230808162718.2151e175.alex.williamson@redhat.com> <01a8ee12-7a95-7245-3a00-2745aa846fca@amd.com> <20230809113300.2c4b0888.alex.williamson@redhat.com> <ZNPVmaolrI0XJG7Q@nvidia.com> <BN9PR11MB5276F32CC5791B3D91C62A468C13A@BN9PR11MB5276.namprd11.prod.outlook.com> <20230810104734.74fbe148.alex.williamson@redhat.com> <ZNUcLM/oRaCd7Ig2@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUcLM/oRaCd7Ig2@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 02:19:40PM -0300, Jason Gunthorpe wrote:
> > It's somewhat a strange requirement since we have no expectation of
> > compatibility between vendors for any other device type, but how far
> > are we going to take it?  Is it enough that the device table here only
> > includes the Ethernet VF ID or do we want to actively prevent what
> > might be a trivial enabling of migration for another device type
> > because we envision it happening through an industry standard that
> > currently doesn't exist?  Sorry if I'm not familiar with the dynamics
> > of the NVMe working group or previous agreements.  Thanks,
> 
> I don't really have a solid answer. Christoph and others in the NVMe
> space are very firm that NVMe related things must go through
> standards, I think that is their right.

Yes, anything that uses a class code needs a standardized way of
being managed.  That is very different from say mlx5 which is obviously
controlled by Mellanox.

So I don't think any vfio driver except for the plain passthrough ones
should bind anything but very specific PCI IDs.

And AMD really needs to join the NVMe working group where the passthrough
work is happening right now.  If you need help finding the right persons
at AMD to work with NVMe send me a mail offline, I can point you to them.


