Return-Path: <netdev+bounces-187253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CBAA5F83
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7CC4C205F
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D41A08B8;
	Thu,  1 May 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdE2UzFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F3132111
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107510; cv=none; b=TfNtb2WmrzuWlzockj/ZyX/T0kPA5zqX/xNHiS3FmPG1CHFYCRBPcCOp2DMpUa21+ZPU0QC5dLfC7298+dI0yD78euJZbfs7goxkRFQ0o459sTt540NVz+HMTZ/OFWyB+l81zWoBhZz+yNd3vQF8rqZ4qu+aPrBAhz7DpI7zSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107510; c=relaxed/simple;
	bh=DauXlMprmjXi7hubPObRIntEj9+slT7KeJ2HYpLM2uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsy8xQj62uZ3G6GCm7HR3h7h97GECu/N1ivVGewMjYXnanY3v9jkIKOHPLoJK3gc2yEd2mffX9UZDBDt5tJIHsU86TKB4TjyXd7OiH7M0RxRQtBnA+DN1eoqXK5Eo/JxpaAo/k799oXFmJHbB4oD9QIaI1Je3YMMXBHjZ/UAoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdE2UzFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B1CC4CEE3;
	Thu,  1 May 2025 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746107509;
	bh=DauXlMprmjXi7hubPObRIntEj9+slT7KeJ2HYpLM2uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdE2UzFGlsYU/wbzyVGHiEW9fEWlbLK758A1uVOmfq6pPmQ99km27+xgB6pWTAXpr
	 NQQM3xqmaMC1waO+xM9Sb0jESFwhMnqaKGS1Ma9oAsG3+crnZ97biOGybUMw3hexhI
	 rx82YUVrcwk83dDKzrjzBGn5+Cb+CImLKIjxs+QzvrZ7U5qNNeclQ4DWDpYABbcfDw
	 PiWbjkuAdp/aA2CdKub6wvPpp0xh9G7cIr5RUhGPjB4HD1bQc7sp1/LjZOj7vK3jTH
	 iIKTNVXhlSTZUuzjpnxZfSpvKsl71wvvM0XXnRQRriPil8COURCbrVVuHhMEar/hMe
	 b8vITCBktpEJA==
Date: Thu, 1 May 2025 14:51:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next 1/2] net: intel: rename 'hena' to 'hashcfg' for
 clarity
Message-ID: <20250501135146.GZ3339421@horms.kernel.org>
References: <20250430-jk-hash-ena-refactor-v1-0-8310a4785472@intel.com>
 <20250430-jk-hash-ena-refactor-v1-1-8310a4785472@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430-jk-hash-ena-refactor-v1-1-8310a4785472@intel.com>

On Wed, Apr 30, 2025 at 10:11:52AM -0700, Jacob Keller wrote:
> i40e, ice, and iAVF all use 'hena' as a shorthand for the "hash enable"
> configuration. This comes originally from the X710 datasheet 'xxQF_HENA'
> registers. In the context of the registers the meaning is fairly clear.
> 
> However, on its own, hena is a weird name that can be more difficult to
> understand. This is especially true in ice. The E810 hardware doesn't even
> have registers with HENA in the name.
> 
> Replace the shorthand 'hena' with 'hashcfg'. This makes it clear the
> variables deal with the Hash configuration, not just a single boolean
> on/off for all hashing.
> 
> Do not update the register names. These come directly from the datasheet
> for X710 and X722, and it is more important that the names can be searched.
> 
> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


