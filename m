Return-Path: <netdev+bounces-191036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38601AB9CDA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B624E3FE6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2146239E83;
	Fri, 16 May 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+WYhbjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F21E521E
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400708; cv=none; b=tHUb8vkX8RrZdGcc9FaFQaYV61PpoFR3cNTJCOb8Ord7SQDBcTKRu63l2tZlefxgM0tX9KEcukkfHQPrtspr+7ut/BPz8gO8v0E35jsqr3gOZ9k4nhFfFDR3YAQOjzfhDRujG9L3sSgkUMp0NJi9jacUI7LvyTsKuZBYpWnqcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400708; c=relaxed/simple;
	bh=IHdLTJ+PfmEGjfTFYWVFBLX32m3BFb+o6xTU+iLBmA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvtywGRhWuMuCiPXU4a56aJaHejFSlgGo6qT1yfkGpqfaDPfmqdcoQhgnnVSS15zNV1zxlQ+dXybllGYUsMe4bJ4Jb4QuIFSWMwuw4iZzyB+vp9hQ8euiGWEdsZFN+U4LaJIyzhe0jCqFS2cqfvjkqd9hxj3E/7oLNJ4sJoGN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+WYhbjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8FDC4CEE4;
	Fri, 16 May 2025 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747400708;
	bh=IHdLTJ+PfmEGjfTFYWVFBLX32m3BFb+o6xTU+iLBmA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+WYhbjjKVPGWZUz7Wup3JQ7aKLTZtrA/lZXAeTTMNuUHU2WSjffYt0VPhzQr1wA1
	 CHhv07ZFtQax9SJ6Jpdb5v8Jz2ANoZvBCNvvKVBN6ebWGwainGrsmCns8FHNIvDyIY
	 eYhRKE+z1lh9uAyMluRFBAb0RzkZ4MTzu0Lo/WzbpCdj5im2eQFOQi5WvHxaHPPhrd
	 0C/9jQvXLtOjTH2TAtpeRjYM/btrTcdKXq+CDknhmT9UKyi6huUrizWeH7wO2PbR1g
	 vRtOqJWHNsrmpXDHLberrIsAm1CkdhzfwrWoleFM8cVgUT93cXEksVJgQv69TA4P44
	 F7AYgNXcYK+kw==
Date: Fri, 16 May 2025 14:05:05 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: add 40G speed to Admin Command GET PORT
 OPTION
Message-ID: <20250516130505.GF3339421@horms.kernel.org>
References: <20250515091105.3005987-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515091105.3005987-1-aleksandr.loktionov@intel.com>

On Thu, May 15, 2025 at 09:11:05AM +0000, Aleksandr Loktionov wrote:
> Introduce the ICE_AQC_PORT_OPT_MAX_LANE_40G constant and update the code
> to process this new option in both the devlink and the Admin Queue Command
> GET PORT OPTION (opcode 0x06EA) message, similar to existing constants like
> ICE_AQC_PORT_OPT_MAX_LANE_50G, ICE_AQC_PORT_OPT_MAX_LANE_100G, and so on.
> 
> This feature allows the driver to correctly report configuration options
> for 2x40G on ICX-D LCC and other cards in the future via devlink.
> 
> Example comand:
>  devlink port split pci/0000:01:00.0/0 count 2 
> 
> Example dmesg:
>  ice 0000:01:00.0: Available port split options and max port speeds (Gbps):
>  ice 0000:01:00.0: Status  Split      Quad 0          Quad 1
>  ice 0000:01:00.0:         count  L0  L1  L2  L3  L4  L5  L6  L7
>  ice 0000:01:00.0:         2      40   -   -   -  40   -   -   -
>  ice 0000:01:00.0:         2      50   -  50   -   -   -   -   -
>  ice 0000:01:00.0:         4      25  25  25  25   -   -   -   -
>  ice 0000:01:00.0:         4      25  25   -   -  25  25   -   -
>  ice 0000:01:00.0: Active  8      10  10  10  10  10  10  10  10
>  ice 0000:01:00.0:         1     100   -   -   -   -   -   -   -
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 6488151..f2c0b28 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -667,7 +667,8 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
>  
>  		if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
>  			port_topology->serdes_lane_count = 4;
> -		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
> +		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G ||
> +					 max_speed == ICE_AQC_PORT_OPT_MAX_LANE_40G)

nit: I think it would be better to indent the line above like this.

		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G ||
			 max_speed == ICE_AQC_PORT_OPT_MAX_LANE_40G)

>  			port_topology->serdes_lane_count = 2;
>  		else
>  			port_topology->serdes_lane_count = 1;

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

