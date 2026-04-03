Return-Path: <netdev+bounces-275032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIs0MOC4z2kd0AYAu9opvQ
	(envelope-from <netdev+bounces-275032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:56:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF0394401
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32CB830B13F9
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6106D3AE1B1;
	Fri,  3 Apr 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOStDcoy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658F2ED15D
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220586; cv=none; b=ULMfUf7AgC9mhslWBrD+Cut0AWeC1C4CN1vxdmH/IyfVfW65TUiH732VBRgg9zNN2y4XR0ndvlpRZnecgPkRxLNjPbSAEz+/nTWExhrEYEuJ7/1w2Hx1dV22U4FPRq/azro/JcHKDKmXNljwsiXFrZTpp4jazCqKtlXHQaoX644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220586; c=relaxed/simple;
	bh=oe1k06X8LzeLYzPSqTUn6zZwnoXsWv9v1PI95wY03zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5uVyVZPKbIh64UwIxI4j3NkFnliQqgWtIuNfr1xeN/AiVX8OAVJW8Xs71QdhDS7HwngpuKd0vD3GdgyyjFLp+wGNT3/ShLNyDdJwEP8DypWiMrOb0vbcRJhme1lo3KdxuwazA2Cuor4bZeCCjZn7NHM1U6fNopoYylpaHu0aGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOStDcoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F8C4CEF7;
	Fri,  3 Apr 2026 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775220585;
	bh=oe1k06X8LzeLYzPSqTUn6zZwnoXsWv9v1PI95wY03zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOStDcoy773/nHKR3XdJisKUw/d/nD0GWcc79stsMFn2tJPJtCZRU17MdueYx1ayw
	 F8bDzk9WbIS/Orv7/UcqFHwOFP9wZrKwCqAw4oIfWLy9sPF/YTODumbtdROmZzYX4o
	 AtBPpX7yKh3IBwkCgbFumNBv6Z6ZVtPvRvAAsqGEla9w6Qt9CmsvLrpYrW7K/i0X5g
	 XcmvSDgdRHmm4yK71zm3Gbo5WaaHJeObSwBW3abHpyS4VyMMO6EhBmPCsUNEyk96lo
	 mBufMPs+HJglxHSlq1+nacLKedbPONkqztxZMgxEUW31xvqeFgUpyHGvLdB2JKM8Mz
	 4Kphl5Oe/xS2w==
Date: Fri, 3 Apr 2026 13:49:42 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: increase SWFW semaphore timeout for X550
 FW updates
Message-ID: <20260403124942.GA103228@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275032-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 11EF0394401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:35AM +0100, Aleksandr Loktionov wrote:
> From: Soumen Karmakar <soumen.karmakar@intel.com>
> 
> According to FW documentation, the most time-consuming part of continuous
> FW activity is Shadow RAM (SR) dump which takes up to 3.2 seconds.  For
> X550 devices, the module-update FW command can take over 4.5 s.  Increase
> the max Software/Firmware (SW/FW) semaphore wait time from the default
> 200 ms to 5 s for X550 to avoid spurious semaphore timeout failures

Should 200ms be 1s (200 x 5us) ?

> during FW update operations.
> 
> Signed-off-by: Soumen Karmakar <soumen.karmakar@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> index e67e2fe..85047ef 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> @@ -577,6 +577,9 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
>  
>  	swmask |= swi2c_mask;
>  	fwmask |= swi2c_mask << 2;
> +	if (hw->mac.type == ixgbe_mac_X550)
> +		timeout = 1000;

I think it would be nice to centralise the initialisation of timeout,
to either it's default or device-specific value, here.

And to provide a comment indicating what the values mean in terms
of maximum delay in s or ms.

> +
>  	for (i = 0; i < timeout; i++) {
>  		/* SW NVM semaphore bit is used for access to all
>  		 * SW_FW_SYNC bits (not just NVM)
> -- 
> 2.52.0
> 

