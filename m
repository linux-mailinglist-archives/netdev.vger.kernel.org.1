Return-Path: <netdev+bounces-29242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31659782474
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A91C2084F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D31874;
	Mon, 21 Aug 2023 07:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B01848
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39352C433C7;
	Mon, 21 Aug 2023 07:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692603004;
	bh=fJxR8tRtwimzAM69IKo/gimiMbMYo913Qdg4j6aF5/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2yt0Jbag8YpsjfOAjbCks2pMkiSnfvqnBM5O9XCMowmoHsFI1Vlx8Zr2jNaOm3Kg
	 SeAgroRaFa9VzF733FIC+09PBmcmnE8LMU6TjKg3Hde+H8V/dl7ozRMencsSdJX9ET
	 VibHI0KTgTadHi7FNZyZLUEs1wDMAD6Ey+LGiKbIM+s6X9NRt6ckM6YLlzfFyyYInr
	 07Noqjz/OFTfR63Po5907mZFle9gqEoqCx09MAE27ev3M7scbzdT0u0X4K0PeqwHDO
	 KEGchDg0HNjT5cW0hnUAjry4NrDoxnWZvgkUxlu7AAUgaY/IXdpEiIXeDsb95Z/bwu
	 Nm06G8ET773xQ==
Date: Mon, 21 Aug 2023 09:30:00 +0200
From: Simon Horman <horms@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	qi.z.zhang@intel.com, ivecera@redhat.com,
	sridhar.samudrala@intel.com
Subject: Re: [PATCH iwl-next v5 01/15] ice: add parser create and destroy
 skeleton
Message-ID: <20230821073000.GC2711035@kernel.org>
References: <20230605054641.2865142-1-junfeng.guo@intel.com>
 <20230821023833.2700902-1-junfeng.guo@intel.com>
 <20230821023833.2700902-2-junfeng.guo@intel.com>
 <20230821072037.GB2711035@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821072037.GB2711035@kernel.org>

On Mon, Aug 21, 2023 at 09:20:37AM +0200, Simon Horman wrote:
> On Mon, Aug 21, 2023 at 10:38:19AM +0800, Junfeng Guo wrote:
> > Add new parser module which can parse a packet in binary
> > and generate information like ptype, protocol/offset pairs
> > and flags which can be used to feed the FXP profile creation
> > directly.
> > 
> > The patch added skeleton of the create and destroy APIs:
> > ice_parser_create
> > ice_parser_destroy
> > 
> > Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> 
> Hi Junfeng Guo,
> 
> some minor feedback from my side.
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_common.h |  4 +++
> >  drivers/net/ethernet/intel/ice/ice_ddp.c    | 10 +++---
> >  drivers/net/ethernet/intel/ice/ice_ddp.h    | 13 ++++++++
> >  drivers/net/ethernet/intel/ice/ice_parser.c | 34 +++++++++++++++++++++
> 
> Perhaps I am missing something, but it seems that although
> ice_parser.c is added by this patch-set, it is not added to
> the build by this patch-set. This seems a little odd to me.

Sorry, somehow I wasn't looking at the entire series.
I now see that ice_parser.c is compiled as of patch 12/15 of this series.

> 
> >  drivers/net/ethernet/intel/ice/ice_parser.h | 13 ++++++++
> >  5 files changed, 69 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> > new file mode 100644
> > index 000000000000..42602cac7e45
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2023 Intel Corporation */
> > +
> > +#include "ice_common.h"
> > +
> > +/**
> > + * ice_parser_create - create a parser instance
> > + * @hw: pointer to the hardware structure
> > + * @psr: output parameter for a new parser instance be created
> > + */
> > +int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
> > +{
> > +	struct ice_parser *p;
> > +
> > +	p = devm_kzalloc(ice_hw_to_dev(hw), sizeof(struct ice_parser),
> > +			 GFP_KERNEL);
> > +	if (!p)
> > +		return -ENOMEM;
> > +
> > +	p->hw = hw;
> > +	p->rt.psr = p;
> 
> It is, perhaps academic if this file isn't compiled, but the rt field of
> struct ice_parser doesn't exist at this point of the patch-set: it is added
> by the last patch of the patch-set.

And I see this field is added in patch 10/15, rather than the last patch
(15/15) as I previously stated.

> 
> > +
> > +	*psr = p;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * ice_parser_destroy - destroy a parser instance
> > + * @psr: pointer to a parser instance
> > + */
> > +void ice_parser_destroy(struct ice_parser *psr)
> > +{
> > +	devm_kfree(ice_hw_to_dev(psr->hw), psr);
> > +}
> 

