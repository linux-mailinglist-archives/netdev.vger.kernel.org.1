Return-Path: <netdev+bounces-38051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF437B8C56
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2705D281637
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65618219FD;
	Wed,  4 Oct 2023 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prcOQ5bR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438741B29D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD31C433C8;
	Wed,  4 Oct 2023 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696447078;
	bh=1dS0Z9ElgIFUBEHsLYVsPlKwiqE6Sp4y8ahK1w2rhBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=prcOQ5bRe94hF2LvEsWOm0VuelDW8/mBkP8Okukn2ssJRhwJjqE30UhiqCuDZE3h7
	 pQEHJcFCeaHbR4KIYSTzPB4zeSjnlfVxQaR+FbFqbc0EPwQfzYX8hY9XHz9f4KfDYL
	 OE82WHKyKMNOJmzVe4eRjsSPAxe8LUFiTmZtORhvO+7N812m4FehZLYLL9Rtl7/vYE
	 /jCgQe9sFSTCGLHzM1qhKkSe23eQWGKcDUE7C9co0Afh8UJ73N0ipk9kdL/15rQpX/
	 KgbssMrWq06wN7lSaesnPhHwDmeUYZucNW34YYKLmeEOPL314Sy/ICCqtGEYgdNIgg
	 ExBBIRZd+Rqjw==
Date: Wed, 4 Oct 2023 12:17:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>
Cc: Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>,
 <poros@redhat.com>, <mschmidt@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 0/9] i40e: House-keeping and clean-up
Message-ID: <20231004121757.6812fe64@kernel.org>
In-Reply-To: <95a7c916-dd15-624e-3cd4-f9225324df72@intel.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
	<95a7c916-dd15-624e-3cd4-f9225324df72@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 15:12:09 -0700 Jesse Brandeburg wrote:
> On 9/27/2023 1:31 AM, Ivan Vecera wrote:
> > The series makes some house-keeping tasks on i40e driver:
> > 
> > Patch 1: Removes unnecessary back pointer from i40e_hw
> > Patch 2: Moves I40E_MASK macro to i40e_register.h where is used
> > Patch 3: Refactors I40E_MDIO_CLAUSE* to use the common macro
> > Patch 4: Add header dependencies to <linux/avf/virtchnl.h>
> > Patch 5: Simplifies memory alloction functions
> > Patch 6: Moves mem alloc structures to i40e_alloc.h
> > Patch 7: Splits i40e_osdep.h to i40e_debug.h and i40e_io.h
> > Patch 8: Removes circular header deps, fixes and cleans headers
> > Patch 9: Moves DDP specific macros and structs to i40e_ddp.c
> > 
> > Changes:
> > v2 - Fixed kdoc comment for i40e_hw_to_pf()
> >     - Reordered patches 5 and 7-9 to make them simplier  
> 
> spelling: simpler
> 
> Thanks for this cleanup series, the changes all seem sane.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

I'm marking as "awaiting upstream" but feel free to ask for these
to be applied directly to net-next if you prefer.
-- 
pw-bot: au

