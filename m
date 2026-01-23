Return-Path: <netdev+bounces-252962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEAME/bUc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:07:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F087A7BF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C80E73013859
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B222D5946;
	Fri, 23 Jan 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ4g5Ny+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE092D4B77
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198821; cv=none; b=uSj/2PHtSDl5dTyvYKON6SPUAnPokDDQd/jXf/UDSkHOmE4tqFq6MzdmUnAL3IkuU8GKLeSy4+BjQJK3AGPoCcq19qeQaEeQ5D3eBIfUEjNrbTwEPSNGZiyVnwHZnW4MS3+bx04eULMTxG4pagrw6dZy6ez1I0ZPyuOzjo+Q5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198821; c=relaxed/simple;
	bh=lcCyOJKDqJ7rIblU2CVVC7VTXDVTs9HmqHKKqlBmPSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVF4vfyLI2sxbL9udJKdMyFRsD8E7LCrSrQclSz0dIosRGgLXqXoV/2598BbYG7o9jqkkONXDkzigIJ8+Recgn6G3FFuZzyA+3ULTpuuFq0XiU+ive/fB78erIhjRgRx9D9SNSJrZ2qk4ZiX/bw7X0xZLU2kUCgeuQtZib4uGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ4g5Ny+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00C6C4CEF1;
	Fri, 23 Jan 2026 20:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769198821;
	bh=lcCyOJKDqJ7rIblU2CVVC7VTXDVTs9HmqHKKqlBmPSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ4g5Ny+aiAqxEyJa6i4cYIiMTtz31cT9PbWgpg5hO156GCaEA6A/dLph2KSmI9YM
	 XW1zDVkcxT6uTPCKCxLhBdnqnOztfYN35hzzWOzl6KJS4w5E7bKyMFeTcs+ZN8rB+T
	 v91hRopEjMOOooQXJ8wMblQssi7+n5N4lH/ZRZhRernhrGbNV98DnMjBGb1+wUypb6
	 PwPpLXqQQNPvEo7x4vbP7Y0m2jG65qDZjDDQqiKGRrCzCIxKXtP3vsx4AAcUSZ+Eqz
	 9lKoDRLyTIb63t2c5RACd+2evBz48aIgioiXQaqmVArgl2ejEBhLFjSD6SNdoQ9Xcr
	 +qKXF/WaZ0daw==
Date: Fri, 23 Jan 2026 20:06:57 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	dan.carpenter@linaro.org, pmenzel@molgen.mpg.de,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v2 1/2] ixgbe: e610: Convert ACI descriptor
 buffer to little endian
Message-ID: <aXPU4YQi73T088lS@horms.kernel.org>
References: <20260122164632.112607-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122164632.112607-1-piotr.kwapulinski@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: E8F087A7BF
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 05:46:32PM +0100, Piotr Kwapulinski wrote:
> The ixgbe device registers/descriptors expect little-endian ordering. Make
> the code aware that the e610 adapter operates on data with little endian
> ordering. The extra conversion is required on big-endian hosts. In most
> scenarios this conversion is not required.
> 
> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index c2f8189..f494e90 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  
>  	/* Descriptor is written to specific registers */
>  	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> -		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
> +		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
> +				le32_to_cpu(raw_desc[i]));

IXGBE_WRITE_REG is backed by writel.  And my understanding is that writel
converts values from host byte order to little endian.  So I'm confused
about where this is going.

>  
>  	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
>  	 * PF_HICR_EV
> @@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if ((hicr & IXGBE_PF_HICR_SV)) {
>  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];

I'm also curious to know what the intent (if any) of the line above was/is.

> +			raw_desc[i] = cpu_to_le32(raw_desc[i]);

Please don't use the same variable to store both host byte order and little
endian values.  In this case I'd use another local variable, say scoped to
within this block, to store the intermediate value.

And if raw_desc will be used to hold __le32 values, it's type should be
updated.

>  		}
>  	}
>  
> @@ -153,7 +154,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
>  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];
> +			raw_desc[i] = cpu_to_le32(raw_desc[i]);
>  		}
>  	}
>  
> -- 
> 2.47.1
> 

