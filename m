Return-Path: <netdev+bounces-46693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA057E5D8D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3072812CB
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64DE34CFD;
	Wed,  8 Nov 2023 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMxkl6rj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCC32C88
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 18:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAB0C433C7;
	Wed,  8 Nov 2023 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699469994;
	bh=v3G0suFuSmu2T8ydyAp7Qupj+ZJkhevbQT+X0L5Plq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMxkl6rjHtARSgLUKCfaKY7dL8FOPzGBmz08vbvy2tXotYk/YTjDsRtZWpXfV0B7o
	 kmlormRXApzecYV5LVzRXTiuM3osLP7pqrhFrb3LCcGO+zseyLSVhWH3eKx4ady4nO
	 pgpuJS5amOoZLtxw5e8eCW/rdGIOW6pBtTVzlWsGaEDfFuKPQnEQ+lhbvxyyP5nHUq
	 ZA54kJByRrer55129aQMhwDRSTI2bo34d2eH+wFgaWsYYA3Yt2idFrajqrXAcm+w0S
	 v64wEeUaVyPZack2Rv6yRhoBc+Q+rtdUR+KrvoAbuFuFo8ELesymjoYA/tWlwBdWAc
	 v8IgVmMC82YYA==
Date: Wed, 8 Nov 2023 13:59:51 -0500
From: Simon Horman <horms@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, kuba@kernel.org, tony.brelinski@intel.com,
	Dan Nowlin <dan.nowlin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net v3] ice: fix DDP package download for packages
 without signature segment
Message-ID: <20231108185951.GE173253@kernel.org>
References: <20231107173227.862417-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107173227.862417-1-paul.greenwalt@intel.com>

On Tue, Nov 07, 2023 at 12:32:27PM -0500, Paul Greenwalt wrote:
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> Commit 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
> incorrectly removed support for package download for packages without a
> signature segment. These packages include the signature buffer inline
> in the configurations buffers, and not in a signature segment.
> 
> Fix package download by providing download support for both packages
> with (ice_download_pkg_with_sig_seg()) and without signature segment
> (ice_download_pkg_without_sig_seg()).
> 
> Fixes: 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
> Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Closes: https://lore.kernel.org/netdev/ZUT50a94kk2pMGKb@boxer/
> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


