Return-Path: <netdev+bounces-216952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5CEB36668
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9861C210A2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74534DCE6;
	Tue, 26 Aug 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKEiW9a0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3E345726
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216135; cv=none; b=XKUd8bjmSDK34ytsDe1XSaOytcw5DlYC/08sLw34wO0Iz9FqTFO2xMfyqIB5NfeJuA8aFEW5/XGeymU+0DlDV2zghMN/zs5lPHQZteW2yy9zuVaj9iqhrYP/HBqtgJGLYrTJXIdWUqOhAmJC/LddFGx6FVX+d2nvUqz+mI+PIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216135; c=relaxed/simple;
	bh=XGiRH+1trpEwpUcqcmaqq2E7b01zJv0ChUBF1gJeF4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/gZXpEKPclU4JJZ597fvR05RBO23eSBMb8cDEcYqjt2qvKRLrCSKRrs4+RdYW6eh99jn66bLZm/5SbosmaMMTrEHcudD5x4qqNeDEq4YsbZvtZoJvf+cxODZf6PBOdgcfdBMY5J3E5K9bAk7HCfEaDkFXl48hSIZDhBegy0lbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKEiW9a0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97D0C4CEF1;
	Tue, 26 Aug 2025 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756216135;
	bh=XGiRH+1trpEwpUcqcmaqq2E7b01zJv0ChUBF1gJeF4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKEiW9a0GV2oQv268spDXPs54Scu4EjEUieeaLwcUXa6H4u/pp6g6xJ8SNH6r+pSs
	 PFpkXMn6B2/ruJD9zUclcwYoanrGe3ffPoHCUne8nETzJq4c6/Sy+dqgkENbxs/qiQ
	 fP8hNLuAZyTS9Y8O54WNEIyy5IG0evknX3lLI4lPhQpFZfa2s57/Opc3Zwf8D+i9LA
	 2ycXxWZluVbQFj3DWAyYX6BKSgFS6l2TBXwjVSIKeakvvaHp5vyjwYu0uGhD5pnjAC
	 xrDEirpGwgiRYlJuVrPr7MRdxufkCgNfaYdy7tCZDwLGbAtUN2NE52PeTprpwZ/yTQ
	 s6ziis6N7lI7Q==
Date: Tue, 26 Aug 2025 14:48:51 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com
Subject: Re: [PATCH iwl-next v2 00/15] Fwlog support in ixgbe
Message-ID: <20250826134851.GA5892@horms.kernel.org>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>

On Tue, Aug 12, 2025 at 06:23:21AM +0200, Michal Swiatkowski wrote:
> Hi,
> 
> Firmware logging is a feature that allow user to dump firmware log using
> debugfs interface. It is supported on device that can handle specific
> firmware ops. It is true for ice and ixgbe driver.
> 
> Prepare code from ice driver to be moved to the library code and reuse
> it in ixgbe driver.
> 
> v1 --> v2: [1]
>  * fix building issue in patch 9
> 
> [1] https://lore.kernel.org/netdev/20250722104600.10141-1-michal.swiatkowski@linux.intel.com/
> 
> Michal Swiatkowski (15):
>   ice: make fwlog functions static
>   ice: move get_fwlog_data() to fwlog file
>   ice: drop ice_pf_fwlog_update_module()
>   ice: introduce ice_fwlog structure
>   ice: add pdev into fwlog structure and use it for logging
>   ice: allow calling custom send function in fwlog
>   ice: move out debugfs init from fwlog
>   ice: check for PF number outside the fwlog code

nit: I think that patch 8/15 updates ice_fwlog_init()
     such that it begins with a blank line. I would delete it.

>   ice: drop driver specific structure from fwlog code
>   libie, ice: move fwlog admin queue to libie
>   ice: move debugfs code to fwlog
>   ice: prepare for moving file to libie
>   ice: reregister fwlog after driver reinit
>   ice, libie: move fwlog code to libie
>   ixgbe: fwlog support for e610

...

The nit above notwithstanding, this looks good to me.
Please feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>


