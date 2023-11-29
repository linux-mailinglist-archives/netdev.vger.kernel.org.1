Return-Path: <netdev+bounces-52189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575C37FDD87
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121A3282541
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD3D38DF0;
	Wed, 29 Nov 2023 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9VeoTMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E560374DC
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E246DC433C7;
	Wed, 29 Nov 2023 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276355;
	bh=xyGkzJOwryPI3xou4Wa2vHE+sW4/4uqtG68QNchN5LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9VeoTMN7TnMhvL6wfalm6GNQThPs3Snm3mnXssmcl0J1HauRPKtxlU9A7wr+ptQn
	 LuOCmmHpGvxXVtVVmb2ClkCsJ86oHQ9w18MNXtd6n5wQblx4SOVe3gZGJXh1XQZ3xd
	 OzD6VXd59rUJhFpJikhdC3KaIH3nZ90z2Ng5ZsUzSJQ6Fink4Hiv57fnYQGAC03qau
	 RfxfMxu4Qs5ddGtGuzSa3YXEOpT9un53ZJgnbPvtEeeHZwfDh42cHvh8UOcD31F/lA
	 PFWjYWryfH68HVxuQRcwh+hLfCb6RlxIvsmOr1u3Miab6Po18foGpb1+4O8NT190U9
	 J63vW+f18BY9w==
Date: Wed, 29 Nov 2023 16:45:51 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next] ice: Rename E822 to E82X
Message-ID: <20231129164551.GE43811@kernel.org>
References: <20231124114555.253412-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124114555.253412-1-karol.kolacinski@intel.com>

On Fri, Nov 24, 2023 at 12:45:55PM +0100, Karol Kolacinski wrote:
> When code is applicable for both E822 and E823 devices, rename it from
> E822 to E82X.
> ICE_PHY_PER_NAC_E822 was unused, so just remove it.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Karol,

while I think this naming scheme may have some shortcomings
if other E82[0-9] chips come along with different overlap
in function re-use, I also do see that it is a convenient
shorthand. And moreover that it matches what is already in-tree
as of at least:

88c360e49f51 ("ice: Support cross-timestamping for E823 devices")

So, FWIIW, beyond my mumblings here I am happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

