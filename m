Return-Path: <netdev+bounces-57556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8E813615
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA01BB2037D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5044E5F1EE;
	Thu, 14 Dec 2023 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umTjqz66"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324785EE86
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 16:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15148C433C7;
	Thu, 14 Dec 2023 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702570955;
	bh=aQy0Dq+mR2qVRKVgMb5qRV1UZIcTop1MgbjzW9yIac4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umTjqz6635ql1hmSw3+Fa3Y0NwskPdtWyrxGe74qhX00yw7dSBc5N/PyJlm4898P2
	 68DqFKee8WKX16kypEZfJL42izpMYyqb1DyRc6cJH+3k4a67XfrvAjlS+H7wx5UG8R
	 n9VbWh+3AYCasCY9v53uBknsvLra9d4beU7My0AXYCkJF2fu9HNITr4qAlqCMC974+
	 EDYqfNZe2v5q0x2yQYbciB41zIVuHRIJeTqlsuG/llRQ7diLcfx+XLMydmFnb4kGjw
	 2cA5H0reb0m0zU8TrXB2NX1TO4i2kfwtnSGtEnQ0snjpTeDuAvk1lyp+B7aG/vdvpq
	 UXbWBy5f9s/Ng==
Date: Thu, 14 Dec 2023 16:22:31 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: Fix PF with enabled XDP going no-carrier
 after reset
Message-ID: <20231214162231.GL5817@kernel.org>
References: <20231212092903.446491-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212092903.446491-1-larysa.zaremba@intel.com>

On Tue, Dec 12, 2023 at 10:29:01AM +0100, Larysa Zaremba wrote:
> Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
> functions") has refactored a bunch of code involved in PFR. In this
> process, TC queue number adjustment for XDP was lost. Bring it back.
> 
> Lack of such adjustment causes interface to go into no-carrier after a
> reset, if XDP program is attached, with the following message:
> 
> ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
> ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
> ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
> ice 0000:b1:00.0: PF VSI rebuild failed: -22
> ice 0000:b1:00.0: Rebuild failed, unload and reload driver
> 
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

