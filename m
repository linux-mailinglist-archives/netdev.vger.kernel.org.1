Return-Path: <netdev+bounces-37201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1B7B4303
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 20:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2403B28201B
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858D828EC;
	Sat, 30 Sep 2023 18:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AFA168CA
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 18:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110ACC433C7;
	Sat, 30 Sep 2023 18:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696098602;
	bh=Y4imC89W3KdMY2UPdzMV4XPUqHsU4iC+LIa8tI7NQ8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1RyzUb0dql97BmSTWWXH4WElBuESRh1nfdjAYmTH6vuLq7CQYn81zMxLMOFAd/clX
	 iF+kliizT2sMMAonxvxRvneMRkqHLihK8T/2wT2afNvjL8A1K1mlo4KXLJcHHMSGmr
	 Y47tDVyqgVi4Hl20otmWlcRMF8i+XqmAWjqicUL0=
Date: Sat, 30 Sep 2023 20:29:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Chris Leech <cleech@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Rasesh Mody <rmody@marvell.com>, Ariel Elior <aelior@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2023093003-city-pursuant-956e@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <yfws24bzfebts5mr7n7y4dekjlrhlbbk6afr6vgbducpx4j2wh@iiftl57eonc6>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yfws24bzfebts5mr7n7y4dekjlrhlbbk6afr6vgbducpx4j2wh@iiftl57eonc6>

On Sat, Sep 30, 2023 at 02:10:50AM -0700, Jerry Snitselaar wrote:
> [1] https://github.com/open-iscsi/open-iscsi/blob/master/iscsiuio/README

That's IP offload, not what UIO is supposed to be for at all (yes, I
know DPDK abuses this api as well, and I hate it.)  But this is on a
network card, it shouldn't need UIO.  Why is iscsi somehow "special" for
this?

still confused,

greg k-h

