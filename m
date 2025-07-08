Return-Path: <netdev+bounces-205112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B2AFD6D9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0EF56407C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AFE2E610A;
	Tue,  8 Jul 2025 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fryarhpI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744732E5B3E
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001600; cv=none; b=J9NQR95G0hHZmSehClBeoOi9FDvMz7da8LWVWw74ABf6gtnZDystf4fd7y/RspEChXS7G843vPHbHqMThGFljUbr6vlsbqhjFHlkeQ8OhAU+x60AYE9sAcNwMeJNQb0G7hOvmH51kEvDPvba7yAyfrRtgLrzPP31QZXqswzryz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001600; c=relaxed/simple;
	bh=DlUlzmq1XBA7NBkVzqscejjs37rD2o/CbIOz3pFjXzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oby0Gl5FQQXOnfeXMusfnctAWFAEnPfsUrA5paM27CRmOejyhuOConutT9mKA2nBiGzuaQbQegL0X0c3KyiG+DP7uNhHpqoaKx3TDz8Z3iGcyfjqtg/QVzQDomPq5EXGtiOl+pEDb9KJljuBdw3NGNBRRvRg6cmaUtpfA+cMvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fryarhpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99D3C4CEED;
	Tue,  8 Jul 2025 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001600;
	bh=DlUlzmq1XBA7NBkVzqscejjs37rD2o/CbIOz3pFjXzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fryarhpIK+1nP7tSgoPcDvxI9XjtY+Hli2RSEAqJ4O9AK/HR81cZROSRp+wPlcQ7y
	 iVjB/LFs7eZE55MzPELBmpBAmLczTovO5lCJiD3YG7rX+buEhZXrU3DUfEidusZPwk
	 t2Zo1TYe0sjPJZqWIgG8+LK5G/Gf3Gl4hiLQJWn6fPbT1GfsD7m0cUXTOmvgGmKXQu
	 U+aofVBWnsfZYyL+77DDDexbpDCOI0BgvYG7viab7Zhk67wruk+5Fs9d+xavMOx/Cp
	 UjiWP4nSa4Q0cUcYHgtxSCroRDTPAyw8S0n9PARX4PpcePNDTaL+fcGKz1Hormv8wg
	 nTExBnBWr09yQ==
Date: Tue, 8 Jul 2025 20:06:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 1/5] e1000: drop unnecessary constant casts
 to u16
Message-ID: <20250708190635.GW452973@horms.kernel.org>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <e199da76-00d0-43d3-8f61-f433bc0352ad@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e199da76-00d0-43d3-8f61-f433bc0352ad@jacekk.info>

On Tue, Jul 08, 2025 at 10:16:52AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> Let the C type system do it's job.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>  drivers/net/ethernet/intel/e1000/e1000_hw.c      | 4 ++--
>  drivers/net/ethernet/intel/e1000/e1000_main.c    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index d06d29c6c037..d152026a027b 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -806,7 +806,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
>  	}
>  
>  	/* If Checksum is not Correct return error else test passed */
> -	if ((checksum != (u16)EEPROM_SUM) && !(*data))
> +	if ((checksum != EEPROM_SUM) && !(*data))
>  		*data = 2;

nit: If there is a v3 for some other reason, then I think
     you could also drop the inner parentheses here.

>  
>  	return *data;
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> index f9328f2e669f..0e5de52b1067 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> @@ -3970,7 +3970,7 @@ s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
>  		return E1000_SUCCESS;
>  
>  #endif
> -	if (checksum == (u16)EEPROM_SUM)
> +	if (checksum == EEPROM_SUM)
>  		return E1000_SUCCESS;
>  	else {
>  		e_dbg("EEPROM Checksum Invalid\n");
> @@ -3997,7 +3997,7 @@ s32 e1000_update_eeprom_checksum(struct e1000_hw *hw)
>  		}
>  		checksum += eeprom_data;
>  	}
> -	checksum = (u16)EEPROM_SUM - checksum;
> +	checksum = EEPROM_SUM - checksum;
>  	if (e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
>  		e_dbg("EEPROM Write Error\n");
>  		return -E1000_ERR_EEPROM;
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d8595e84326d..09acba2ed483 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -313,7 +313,7 @@ static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
>  		} else {
>  			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
>  		}
> -		if ((old_vid != (u16)E1000_MNG_VLAN_NONE) &&
> +		if ((old_vid != E1000_MNG_VLAN_NONE) &&

Ditto.

But more importantly, both Clang 20.1.7 W=1 builds (or at any rate, builds
with -Wtautological-constant-out-of-range-compare), and Smatch complain
that the comparison above is now always true because E1000_MNG_VLAN_NONE is
-1, while old_vid is unsigned.

Perhaps E1000_MNG_VLAN_NONE should be updated to be UINT16_MAX?


>  		    (vid != old_vid) &&
>  		    !test_bit(old_vid, adapter->active_vlans))
>  			e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q),
> -- 
> 2.47.2
> 

