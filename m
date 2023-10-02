Return-Path: <netdev+bounces-37313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C8E7B4B48
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 188A7281623
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 06:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141CECE;
	Mon,  2 Oct 2023 06:04:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3173A53
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:04:35 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B39B;
	Sun,  1 Oct 2023 23:04:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C27A68D1C; Mon,  2 Oct 2023 08:04:25 +0200 (CEST)
Date: Mon, 2 Oct 2023 08:04:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, Chris Leech <cleech@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <20231002060424.GA781@lst.de>
References: <20230929170023.1020032-1-cleech@redhat.com> <20230929170023.1020032-4-cleech@redhat.com> <2023093055-gotten-astronomy-a98b@gregkh> <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox> <2023093002-unlighted-ragged-c6e1@gregkh> <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de> <2023100114-flatware-mourner-3fed@gregkh> <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
> in particular these two (from the e529d3507a93 dma-mapping pull for
> 6.2):

That's complete BS.  The driver was broken since day 1 and always
ignored the DMA API requirement to never try to grab the page from the
dma coherent allocation because you generally speaking can't.  It just
happened to accidentally work the trivial dma coherent allocator that
is used on x86.


