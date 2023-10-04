Return-Path: <netdev+bounces-37969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3587B8139
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9F7CB1C20837
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509FB154A0;
	Wed,  4 Oct 2023 13:46:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86814AA7
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9B4C433C7;
	Wed,  4 Oct 2023 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696427159;
	bh=Y3BmwF1KMQTZaurfsApWQj9Ur5s5JXdDqe4t2kyvNuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8nrTJ/lUpQKP6UJMvOacIPHavv4eTu9mszLq6RJGnVUsAjrl+swqOEYEBnwyWrab
	 HoYPKt7B6oFIRCJa910TZSCycFUmiAGqoGTv0ACsJsOkMtqUitFASU7UQ1+bpXDGZ/
	 PJoaVxuX8uITj37dHRi37XIiariBrqwTK88Nml01Sv+vQ4uHUiZJBsjNjZNm+ZSBit
	 vZ+foHIqOdEdUVT7C92sxAHeEOJSok7+sDWgm1zidKW9x+66shp0YZA/axwa4x1hNW
	 GCfDF+zwZP3vq1JGEarRgde4RJP01+0Wt89k1znBpJhVTZ4/l51Scij81OIIisdFfO
	 bXFhX+EsO2pxQ==
Date: Wed, 4 Oct 2023 15:45:56 +0200
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1 0/2] intel: format specifier cleanups
Message-ID: <ZR1slAb0AQ3ayARW@kernel.org>
References: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003183603.3887546-1-jesse.brandeburg@intel.com>

On Tue, Oct 03, 2023 at 11:36:01AM -0700, Jesse Brandeburg wrote:
> Clean up some warnings from the W=1 build which moves the intel
> directory back to "clean" state. This mostly involved converting to
> using ethtool_sprintf where appropriate and kasprintf in other places.
> 
> The second patch goes the extra mile and cleans up -Wformat=2 warnings
> as suggested by Alex Lobakin, since those flags will likely be turned on
> as well.
> 
> gcc-12 runs clean after these changes, and clang-15 still has some minor
> complaints as mentioned in patch-2.
> 
> Jesse Brandeburg (2):
>   intel: fix string truncation warnings
>   intel: fix format warnings
> 
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 ++-
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    |  8 ++--
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 22 ++++-------
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  7 ++--
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  4 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  |  4 +-
>  drivers/net/ethernet/intel/igb/igb_main.c     | 37 +++++++++----------
>  drivers/net/ethernet/intel/igc/igc_ethtool.c  |  5 ++-
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 +-
>  9 files changed, 46 insertions(+), 51 deletions(-)

For series,


Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested


