Return-Path: <netdev+bounces-192809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4ADAC1200
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689664E2946
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610C519A2A3;
	Thu, 22 May 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4LutPHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E5194094;
	Thu, 22 May 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934473; cv=none; b=JXewXva/M6AbRJujU4pcr1tmTNAmSRcvDOBd72wlkd8/we6b3t6N0UGhfzLjemVwiVstHOhMdxpxLg9uORmJ66mp3MNhjlhCprwTnKrg361p6pZAzFsSEBJDgUgbD/CBne6gWcaVga3NxMJ36K6Kubv8hUJX+ebnF1c/Kd+YfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934473; c=relaxed/simple;
	bh=IHokm80AvQoeLm7V8X5gQdcJ8Sn6Kew2FcZbLHZKjOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBLTFmkf6dNzx7Ge23u/P4+A4fzSHQ9vIW7an7TE6Ts71eZVHD42zE8T7+z5Crb0TjjOL95HylEdzuZ2WGZMtnkwX31bsBa8nrZEkpYrJEldxQt9FVcKAEcljKyF2AzS+GSQsWCAuwF06NGWFzjZFIls6OR8wWdM78IxU6sFd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4LutPHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65102C4CEE4;
	Thu, 22 May 2025 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747934472;
	bh=IHokm80AvQoeLm7V8X5gQdcJ8Sn6Kew2FcZbLHZKjOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4LutPHn7c8o3nAYAn8ij9FvAMc5D1Bur8iwE8oA1I1UlW/5ghPTzVeKCHUGyDRko
	 dk2Gm6MMkuM5P232UB+qMASq7h1gz8zegWSQqbbksGV2DnREdByoJPsrryIWtg/zir
	 ZUWxBhb1NDsumgfhknDWzQCQIuSZVMZYcsyXVUuwjq4Jc34cH8h8pNWApPRx/x4gwi
	 4m/kDOblhP6qYp/Vi7xmKJYpvANMQ3/iYHpTAQo5nFBLP/gfpbCo44tCRN779x+aOF
	 PMfLEMLenKqBQYAwyNGKN99VPoorI1q9UhRp4eOg7Q7nzGJaH8zqTcWr9cx0HCjMuG
	 2I5ctQB4qgnIw==
Date: Thu, 22 May 2025 18:21:08 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [PATCH] ixgbe: Fix typos and clarify comments in X550 driver code
Message-ID: <20250522172108.GK365796@horms.kernel.org>
References: <20250522074734.3634633-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522074734.3634633-1-alok.a.tiwari@oracle.com>

On Thu, May 22, 2025 at 12:47:26AM -0700, Alok Tiwari wrote:
> Corrected spelling errors such as "simular" -> "similar",
> "excepted" -> "accepted", and "Determime" -> "Determine".
> Fixed including incorrect word usage ("to MAC" -> "two MAC")
> and improved awkward phrasing.
> 
> Aligned function header descriptions with their actual functionality
> (e.g., "Writes a value" -> "Reads a value").
> Corrected typo in error code from -ENIVAL to -EINVAL.
> Improved overall clarity and consistency in comment across various
> functions.
> 
> These changes improve maintainability and readability of the code
> without affecting functionality.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 28 +++++++++----------

...

> @@ -1754,7 +1754,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
>  	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
>  
>  	/* If no SFP module present, then return success. Return success since
> -	 * SFP not present error is not excepted in the setup MAC link flow.
> +	 * SFP not present error is not accepted in the setup MAC link flow.

I wonder if "excepted" was supposed to be "expected".

>  	 */
>  	if (ret_val == -ENOENT)
>  		return 0;
> @@ -1804,7 +1804,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
>  	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
>  
>  	/* If no SFP module present, then return success. Return success since
> -	 * SFP not present error is not excepted in the setup MAC link flow.
> +	 * SFP not present error is not accepted in the setup MAC link flow.

Ditto.

>  	 */
>  	if (ret_val == -ENOENT)
>  		return 0;

The above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


