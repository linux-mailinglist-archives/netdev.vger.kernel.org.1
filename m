Return-Path: <netdev+bounces-37149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66747B3EBD
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 09:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 026352821F2
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 07:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD223D0;
	Sat, 30 Sep 2023 07:06:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4617EF
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A607C433C7;
	Sat, 30 Sep 2023 07:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696057613;
	bh=DSppv+puotLzLGa9P89I9XPs6L6xfrHSkKaipjzNnGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHUqL8TwN9w7SazoLtaCEqx9fopxIPS332QJ2cXRvzKbhE1Y+6HBQB9m3F5/fmgpP
	 /9ELdRLGy84YrjfifmI7G4+kmtLvUcm2NAF60WeZ0xDWTK51WyEpzDNckE25aVRl9l
	 uQABzr9h+gKVMkQMccQWZzQGFCT6LV/Bb2ux0uZ4=
Date: Sat, 30 Sep 2023 09:06:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Leech <cleech@redhat.com>
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
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2023093055-gotten-astronomy-a98b@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929170023.1020032-4-cleech@redhat.com>

On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
> Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> for dma_alloc_coherent buffers.

Why are ethernet drivers messing around with UIO devices?  That's not
what UIO is for, unless you are trying to do kernel bypass for these
devices without anyone noticing?

confused,

greg k-h

