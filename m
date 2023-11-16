Return-Path: <netdev+bounces-48484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B27EE88C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FF41C20848
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648E34565;
	Thu, 16 Nov 2023 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5BZVavZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946B495D4
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 20:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A59EC433C8;
	Thu, 16 Nov 2023 20:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700168173;
	bh=di+6e+KMadtCjDg86L+w2AT2Sooh9iDysaUe1lieLv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5BZVavZrdqaXOsRv4+MYrp4Dhfnl0pJL8arOjAuEyq6oHk5T+aVwF0JqSJgEoaxr
	 D2PyTIv89T1tPDsYM8xpuNxeQnSGmBNsPH3rZkNKqH78WqVDxzKQFx4N9EOujD8wsq
	 HuhwOhfwxinGrV/E+5vdX/2NDNIKQ5O+4GQI77FWaKuBUn/HD5AGTxLpEKuJGasATq
	 hPFnCcKBZPjBqzoV1nRsGZto3KuWpDhBmMOnCQ6IHRGeiDhfs5lmUwNogBrByvfdX1
	 NQ5x91nbpBQ00NAgD9LXJT0Mu6+kGytAqT0klIi3RnpehZLrK3DbQP9WTcZydjDWx4
	 pwjnfqza3fnuw==
Date: Thu, 16 Nov 2023 20:56:08 +0000
From: Simon Horman <horms@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, aelior@marvell.com,
	davem@davemloft.net, edumazet@google.com, manishc@marvell.com,
	netdev@vger.kernel.org, pabeni@redhat.com, skalluru@marvell.com,
	VENKATA.SAI.DUGGI@ibm.com, Abdul Haleem <abdhalee@in.ibm.com>,
	David Christensen <drc@linux.vnet.ibm.com>
Subject: Re: [Patch v6 0/4] bnx2x: Fix error recovering in switch
 configuration
Message-ID: <20231116205608.GJ109951@vergenet.net>
References: <4bc40774-eae9-4134-be51-af23ad0b6f84@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc40774-eae9-4134-be51-af23ad0b6f84@linux.vnet.ibm.com>

On Thu, Nov 16, 2023 at 10:08:34AM -0600, Thinh Tran wrote:
> Hi,
> 
> Could we proceed with advancing these patches? They've been in the
> "Awaiting Upstream" state for a while now. Notably, one of them has
> successfully made it to the mainline kernel:
>  [v6,1/4] bnx2x: new flag for tracking HW resource
> 
> https://github.com/torvalds/linux/commit/bf23ffc8a9a777dfdeb04232e0946b803adbb6a9
> 
> As testing the latest kernel, we are still encountering crashes due to
> the absence of one of the patches:
>   [v6,3/4] bnx2x: Prevent access to a freed page in page_pool.
> 
> Is there anything specific I need to do to help moving these patches
> forward?
> We would greatly appreciate if they could be incorporated into the
> mainline kernel.

Hi Thinh Tran,

I'd suggest that the best way to move this forwards would
be to rebase the remaining patches on net-next and posting them as a v7.
It would be useful to include the information above in the cover letter.
And to annotate that they are targeting net-next in the subject of
each patch and the cover letter.

	Subject: [PATCH net-next v8 x/3] ...

