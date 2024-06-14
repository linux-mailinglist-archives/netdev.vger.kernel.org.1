Return-Path: <netdev+bounces-103566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D6908A8C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B13A1F215D8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBA1957E1;
	Fri, 14 Jun 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPhEUErW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05532193099
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362532; cv=none; b=gSZ5hND1AzWwpdsIRrdT6m41/MobErpxUA68I3zCahKozsUOzZF9LZXMavsf9M/roxeQ3hdaz8ciEPN5kCUsglqlmzm49HxdIAbWxE1YX0EJvJXvylnOfCZaM/8BmEoQbmkpEWrxLziQS8d3MEMNC1hV3Rn5USMfOz0Ux3hH4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362532; c=relaxed/simple;
	bh=7FM7sSOKz8V1VtpSRlj3q7t8Kf/IRAcBNLO7c5iedAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRU3ZP16e2KkS+XE4PwLyPx59nPjj9mH8oIlU+NpBVGJOugBynpU4otWP6NDOH2gELenK4qddLX6PH2xd7MSYd8CS5y9PoEperog2BYg84DIDw3vX7mUb+cLBWHIOMtBv+M6MBMAXOopN/ZPv+q7KK4Oep1brmlMMDIOw3OPLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPhEUErW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB95DC2BD10;
	Fri, 14 Jun 2024 10:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718362531;
	bh=7FM7sSOKz8V1VtpSRlj3q7t8Kf/IRAcBNLO7c5iedAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPhEUErWELJa1iPREq/SpA4Gp88USVffHJwe2LPJgamfUzonP6DfcfhuVU86aiIaS
	 gARYBpu2LlNpFePtuEQMKI0nVcX7Z6NaTZBmFT5jZqAa/tEgeke9dbAnpGQzT80kAG
	 /64ZAvBzQgvHih2LYGwfi3400JOtDXa2LIrYDC9Xu47PehXaRXUihvJooYq+j6j9or
	 Xt7M3OHhPsY7pBbptoE6KQloaLAzPn8yzdBqWSFvNrrUygkFgLEhNWtss3Oo0kO/w3
	 xFH6OhLAn/PDp+tpRE6Q7xyDnVAfknB8ag9Ipq/ajaDCqnqZv+cYoMpjIkL2QuY6Eu
	 Vq84pBiQjQNhQ==
Date: Fri, 14 Jun 2024 11:55:26 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v5 05/15] ice: allocate devlink for subfunction
Message-ID: <20240614105526.GG8447@kernel.org>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-6-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606112503.1939759-6-michal.swiatkowski@linux.intel.com>

On Thu, Jun 06, 2024 at 01:24:53PM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Make devlink allocation function generic to use it for PF and for SF.
> 
> Add function for SF devlink port creation. It will be used in next
> patch.
> 
> Create header file for subfunction device. Define subfunction device
> structure there as it is needed for devlink allocation and port
> creation.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks Piotr,

I believe this addresses Jiri's review of v4.
And the minor nit below not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c

...

> @@ -1422,6 +1425,7 @@ static void ice_devlink_free(void *devlink_ptr)
>   * Allocate a devlink instance for this device and return the private area as
>   * the PF structure. The devlink memory is kept track of through devres by
>   * adding an action to remove it when unwinding.
> + *
>   */
>  struct ice_pf *ice_allocate_pf(struct device *dev)
>  {

nit: this hunk seems unrelated to the rest of the patch.

...

