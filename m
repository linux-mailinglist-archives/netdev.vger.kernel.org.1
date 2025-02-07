Return-Path: <netdev+bounces-163996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AED1A2C41B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE543ACCF9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E391F7547;
	Fri,  7 Feb 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFYkuMg6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F71F1509
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936213; cv=none; b=uZsURuN9C+zqdLvrPrQs06bdZp6Q6nHPQjPpElDUBp79V+sg+i0YEjEqW79nrRQTce0yAfecLxnnKNkjQVrBiewfbVi+URZlkzWiwxzIve79kNlPtcJFgk/VK0wbRN5pAJz3pXgu2qqmZNY+Xv6DuYAkfD8DaYOiobpxV5SgN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936213; c=relaxed/simple;
	bh=FXMx362M+vYDOjieVoZGpLYHrbMAz5S5rLewpTVOEAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7IgNZCIz3pohquJNTNbsU7FSjhk7pG8yDUuzxnvXdAdvPmfn0em5XJeEdvZO0W3eSF0Ea3Y0RIaSelA5J8k5Pzfmob+NLCGbRTD3iaCj2LsfUne1+6sKuzOFHE7YvVN6OGTN2J21uHLw6wYkpU938rNsCAKl4p5URqY54xhMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFYkuMg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CBFC4CED1;
	Fri,  7 Feb 2025 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936213;
	bh=FXMx362M+vYDOjieVoZGpLYHrbMAz5S5rLewpTVOEAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFYkuMg6vC1zD0GuPqaCzaNDauaBuw/Qrt9knuE1frfAL5TLawjPPrDlkeQjy7KC6
	 iUXTnpOKGkdSurXS2VcYv5Qx+idovVAxOBDv0UYxD7nT2RoGEXofUGJUKvq+5z1hUK
	 Vx7+/lqBcbs5Pi4CAGCfIfgc01qZaEv7pni7cWduZrJHgXcuJH0LFk1b8eM3E7eFK7
	 xw0gBnoMtH7TDpWgEbvfHbEC+Vk+REP5+ytmZMkLHVWgKUcGkNV9AwWwtzyzDQQOcR
	 Mfp8y976rFE3lveGsg9xaDo38F0zbE507epjqpHNJTXm+WHj5yTNYT07XUDn+5De1x
	 sLGIRyHv4wYCA==
Date: Fri, 7 Feb 2025 13:50:09 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH iwl-net v2] ice: health.c: fix compilation on gcc 7.5
Message-ID: <20250207135009.GW554665@kernel.org>
References: <20250206223101.6469-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206223101.6469-2-przemyslaw.kitszel@intel.com>

On Thu, Feb 06, 2025 at 11:30:23PM +0100, Przemek Kitszel wrote:
> GCC 7 is not as good as GCC 8+ in telling what is a compile-time
> const, and thus could be used for static storage.
> Fortunately keeping strings as const arrays is enough to make old
> gcc happy.
> 
> Excerpt from the report:
> My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.
> 
>   CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>                                ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
>    "Change or replace the module or cable.", {ice_port_number_label}},
>                                               ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
> Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2: use static const char[] instead of #define - Simon
>     +added RB tag from Michal, but not adding TB tag from Qiuxu
> 
> v1:
>  https://lore.kernel.org/netdev/20250205104252.30464-2-przemyslaw.kitszel@intel.com
> 
> CC: Kees Cook <kees@kernel.org>
> CC: Jiri Slaby <jirislaby@kernel.org>

Thanks Przemek,

Testing locally gcc 7.5.0 [1] seems happy with this.

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/7.5.0/

