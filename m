Return-Path: <netdev+bounces-37194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F637B42DF
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 20:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E2C4F282E54
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9418AE5;
	Sat, 30 Sep 2023 18:08:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC18832
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 18:08:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A35E3
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696097329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEvNfukS8XFHJKyDM3HGupHgXxrIY8XArA1Ea/F/uuE=;
	b=X2N4NGRdcAfwOh1jz3uYe9Yez2Vdh2xOkR35GPYAn6E+vW9wlRp1dYOilIKDdwy8oeJvAY
	psAb5YUX/sUsee7zPZiOwYEspe58cTMPeL7e17Wx2U2IkAw5IMXUUAaiiMSJkDoOAgI1Nr
	ZNWBlvVw9w/mKl7UCMn1WkMfDnmT484=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-aReA7aLXMOyNU78VQoQCNw-1; Sat, 30 Sep 2023 14:08:44 -0400
X-MC-Unique: aReA7aLXMOyNU78VQoQCNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F21385A5BA;
	Sat, 30 Sep 2023 18:08:43 +0000 (UTC)
Received: from rhel-developer-toolbox (unknown [10.2.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CED2170E4;
	Sat, 30 Sep 2023 18:08:41 +0000 (UTC)
Date: Sat, 30 Sep 2023 11:08:39 -0700
From: Chris Leech <cleech@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] uio: introduce UIO_DMA_COHERENT type
Message-ID: <ZRhj+GtzkCGWyylI@rhel-developer-toolbox>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-2-cleech@redhat.com>
 <2023093037-onion-backroom-b4ef@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023093037-onion-backroom-b4ef@gregkh>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 09:10:10AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 29, 2023 at 10:00:21AM -0700, Chris Leech wrote:
> > Add a UIO memtype specificially for sharing dma_alloc_coherent
> > memory with userspace, backed by dma_mmap_coherent.
> 
> Are you sure that you can share this type of memory with userspace
> safely?  And you are saying what you are doing here, but not why you
> want to do it and who will use it.
> 
> What are the userspace implications for accessing this type of memory?

Thanks for taking the time to look at this Greg.
I'm trying to help Marvell fix a regression with these drivers, by
figuring out what the right way to handle this type of mmap is.

The dma_mmap_coherent API exists for exactly this, so I thought making
the uio interface aware of it made sense.  There are uio drivers sharing
dma_alloc_coherent memory (uio_dmem_genirq, uio_pruss) using
UIO_MEM_PHYS, but that falls apart in the face of an iommu.

> >  struct uio_mem {
> >  	const char		*name;
> > -	phys_addr_t		addr;
> > +	union {
> > +		phys_addr_t	addr;
> > +		dma_addr_t	dma_addr;
> > +	};
> >  	unsigned long		offs;
> >  	resource_size_t		size;
> >  	int			memtype;
> > -	void __iomem		*internal_addr;
> > +	union {
> > +		void __iomem	*internal_addr;
> > +		void 		*virtual_addr;
> > +	};
> > +	struct device		*dma_device;
> 
> Why are you adding a new struct device here?

dma_mmap_coherent wants it.
 
> And why the unions?  How are you going to verify that they are being
> used correctly?  What space savings are you attempting to do here and
> why?

I should have expected that would be questioned, I was being paranoid
about mixing different pointer and address types.  I can remove the
unions if putting a dma_addr_t in addr going to be OK.

- Chris


