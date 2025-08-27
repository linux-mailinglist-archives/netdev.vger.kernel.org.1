Return-Path: <netdev+bounces-217243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433B2B37FFE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DDF1B60D49
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EEA29A33E;
	Wed, 27 Aug 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7pSloHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202023ABA9
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291032; cv=none; b=i5WHpWpyY+6F0FFbF09pSuvF5R5YUlSBBhGO3VXPkOifIV/hElHICXetRKGIdu1lgPolvPaTHC73msZZf8C3EYJTynZIhEHvROYD8h6d5e1SCKpPX1OHfERQmwwO2p604C8kNfRcsrRnFO0M36jta8k3HXreGC40kxjvcILpYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291032; c=relaxed/simple;
	bh=zz0HnrV5d51b3sZWgXThN2FcD8pbBRycJmJ5peYukvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/1IW07y+0mZzBhk+uheyOBkcnaHkOPxGCmhRA8uhprNjGRVp6SoGlQEVKGkPJre9TB+2FSf1ZOt6/7uVjqWNrburLeh7c5wMzdAvxMdAfbmeyUSe7u0cCXEUH7Eub5uIHOywIVjF6bppAcXbq6DKDLNEzWFp/wF6WotOE4ddGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7pSloHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E18FC4CEEB;
	Wed, 27 Aug 2025 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756291031;
	bh=zz0HnrV5d51b3sZWgXThN2FcD8pbBRycJmJ5peYukvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7pSloHxOHT0+mKcggOKnM4Nd1lfd1GQkk+Ggj+UbV1dNXwOcHmTfvz0nJc2HPRid
	 Jn7FuVbu+ZOfAJ8cF/ghOYY6shgpipWNTbp0EJ+Cwycxl/ljifom7w6b1f2z9eAiOR
	 NfCrLMkMq5qm2h+LPPXd4g2eN9pTZkYR0gFcCERFnmVxRcbybTeT8hR8ajFrb/eneN
	 Ti+kPeWoaPHB52g8kOdXmT3SzYt26cf7S8HO780mX+hkw2zM85yHDHvkdAED4aIgWJ
	 WymdxS94tQvEwh07TMgXBahFpOOX7NxoNde/pZxwbDQ73kAaIq00L1IzqknEtj5eIS
	 Gmq5FWReNkSWg==
Date: Wed, 27 Aug 2025 11:37:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kheib@redhat.com, Paul Menzel <pmenzel@molgen.mpg.de>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] i40e: fix Jumbo Frame support after iPXE boot
Message-ID: <20250827103707.GA18629@horms.kernel.org>
References: <20250815-jk-fix-i40e-ice-pxe-9k-mtu-v2-1-ce857cdc6488@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-jk-fix-i40e-ice-pxe-9k-mtu-v2-1-ce857cdc6488@intel.com>

On Fri, Aug 15, 2025 at 05:20:39PM -0700, Jacob Keller wrote:
> The i40e hardware has multiple hardware settings which define the Maximum
> Frame Size (MFS) of the physical port. The firmware has an AdminQ command
> (0x0603) to configure the MFS, but the i40e Linux driver never issues this
> command.
> 
> In most cases this is no problem, as the NVM default value has the device
> configured for its maximum value of 9728. Unfortunately, recent versions of
> the iPXE intelxl driver now issue the 0x0603 Set Mac Config command,
> modifying the MFS and reducing it from its default value of 9728.
> 
> This occurred as part of iPXE commit 6871a7de705b ("[intelxl] Use admin
> queue to set port MAC address and maximum frame size"), a prerequisite
> change for supporting the E800 series hardware in iPXE. Both the E700 and
> E800 firmware support the AdminQ command, and the iPXE code shares much of
> the logic between the two device drivers.
> 
> The ice E800 Linux driver already issues the 0x0603 Set Mac Config command
> early during probe, and is thus unaffected by the iPXE change.
> 
> Since commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set"), the
> i40e driver does check the I40E_PRTGL_SAH register, but it only logs a
> warning message if its value is below the 9728 default. This register also
> only covers received packets and not transmitted packets. A warning can
> inform system administrators, but does not correct the issue. No
> interactions from userspace cause the driver to write to PRTGL_SAH or issue
> the 0x0603 AdminQ command. Only a GLOBR reset will restore the value to its
> default value. There is no obvious method to trigger a GLOBR reset from
> user space.
> 
> To fix this, introduce the i40e_aq_set_mac_config() function, similar to
> the one from the ice driver. Call this during early probe to ensure that
> the device configuration matches driver expectation.
> 
> In addition, instead of just checking the I40E_PRTGL_SAH register, update
> its value to the 9728 default and write it back. This ensures that the
> hardware is in the expected state, regardless of whether the iPXE (or any
> other early boot driver) has modified this state.
> 
> This is a better user experience, as we now fix the issues with larger MTU
> instead of merely warning. It also aligns with the way the ice E800 series
> driver works.
> 
> A final note: The Fixes tag provided here is not strictly accurate. The
> issue occurs as a result of an external entity (the iPXE intelxl driver),
> and this is not a regression specifically caused by the mentioned change.
> However, I believe the original change to just warn about PRTGL_SAH being
> too low was an insufficient fix.
> 
> Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
> Link: https://github.com/ipxe/ipxe/commit/6871a7de705b6f6a4046f0d19da9bcd689c3bc8e
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


