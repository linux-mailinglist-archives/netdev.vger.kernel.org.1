Return-Path: <netdev+bounces-29085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC76781951
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6951C209D2
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76FD4C7F;
	Sat, 19 Aug 2023 11:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3194429
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 11:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DFBC433C8;
	Sat, 19 Aug 2023 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692445610;
	bh=ktSR7J8kTyZkpGc5dJeshn+lv17xi4wH7+hNWwwXTrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVXFD22oipbPgfc2UZMjlLE88kQ4DeEjVayVcvGUIdSAVcH/EGemYxj5uvrT3ICi+
	 ugGwf6y6Tz1sZw5ZdMTtwdnOXoVKYywqwF/Kf86fiYwLD1O3bJ4zSkz32xhqV9gNu2
	 SYm4fZ9MFSO/oEMhDqh2s+I6x1fXpJ3birMPUo79xbEOy2smHrsbNouRFRrx+5i4ph
	 vgubo9He5YNGTXH6U6KWfrvS3tQtyVXHWcFz5AlOi81hzIzHEmVPM837mfGwidt7JO
	 tp7SASQeNbgiHRfoq0pPym9HY0lmfcJfJNYu0OjlFG3qW/d+gv+QwG2rCGw8Gr/jln
	 iqbD8s1C0XYkg==
Date: Sat, 19 Aug 2023 14:46:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next] ice: remove unused ice_flow_entry fields
Message-ID: <20230819114646.GO22185@unreal>
References: <20230818105929.544072-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818105929.544072-1-przemyslaw.kitszel@intel.com>

On Fri, Aug 18, 2023 at 06:59:29AM -0400, Przemek Kitszel wrote:
> Remove ::entry and ::entry_sz fields of &ice_flow_entry,
> as they were never set.
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c | 5 +----
>  drivers/net/ethernet/intel/ice/ice_flow.h | 3 ---
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

