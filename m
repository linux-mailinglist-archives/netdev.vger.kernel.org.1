Return-Path: <netdev+bounces-65145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06529839591
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D5B25E6C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19E80044;
	Tue, 23 Jan 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2qvZs97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698765FF0C
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028644; cv=none; b=Jzhrn+enC/qg1xe5+Py2U7hU8+rWRZdbUv4Bnn/ReV1EC60sGZiHepN3JXYPQqauKz9qzgwLOCo+bw8Ri8cyEWLoQZXQW1OW2Kwlps44rPSCDWN2PdpSF8IhBLsN9RrtP2PIsVeUE1nS18T5Vxl+S+OzTtafJY8wq1HKRL8w3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028644; c=relaxed/simple;
	bh=RmiQ2He2OXArxwfJ0IsV+iMk2H0vHq/KqVh3R9A8DcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8q48pD1QxuNDBMIOX7fHlAQGN7ez2L/iKlTd/rU6lVrSyJv1LDNYUq6zFMSeHWPK5he/aN0I76PLEZrr7aw6+TywLcG8Kp1hT9/rZRu8fRd2EKN2h9kWYi31NjJfErG6aGc+So9+DALqoLeLKX6y+RAsYyji2O8p8m1BAptMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2qvZs97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCEAC433F1;
	Tue, 23 Jan 2024 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028643;
	bh=RmiQ2He2OXArxwfJ0IsV+iMk2H0vHq/KqVh3R9A8DcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2qvZs97gpIPE2sfx3xuD46C6DvzDuy/5V3YX5jHNRwlzuNf17FL4e03j4mqN39uD
	 9nTtiFhqiPL1V2dSckdVkazFpufmjUAo27yoEuSZ6pwE0eF1We8f5AEuluh0u7U37d
	 ZwJ4XriTWf3jD9Av4GNI+GoZ3oHO+Mp4/cOsFG7/2dMaHmJ7D/i1cJhQvHPWD2kZuO
	 UPmYhMgQv4U8SecvmXsfD+ZBy/txFFwAYAI7kuoMUWINtlxwGuOaJxSPYpR9MboDZN
	 TirOM2qvef3LCgxWnPPNlecxNnJ3nVdalDCYDfs4gnwYp1iPZITVGHtiMUZrWd1qNm
	 Nun6oNc5p4zWg==
Date: Tue, 23 Jan 2024 16:50:40 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 iwl-next 3/7] ice: rename verify_cached to
 has_ready_bitmap
Message-ID: <20240123165040.GI254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-4-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-4-karol.kolacinski@intel.com>

On Tue, Jan 23, 2024 at 11:51:27AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The tx->verify_cached flag is used to inform the Tx timestamp tracking
> code whether it needs to verify the cached Tx timestamp value against
> a previous captured value. This is necessary on E810 hardware which does
> not have a Tx timestamp ready bitmap.
> 
> In addition, we currently rely on the fact that the
> ice_get_phy_tx_tstamp_ready() function returns all 1s for E810 hardware.
> Instead of introducing a brand new flag, rename and verify_cached to
> has_ready_bitmap, inverting the relevant checks.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


