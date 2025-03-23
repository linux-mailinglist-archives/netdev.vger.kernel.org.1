Return-Path: <netdev+bounces-176965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765A5A6D02B
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4496B7A6ABD
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054B86325;
	Sun, 23 Mar 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR2fbwu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688202E336C
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742749945; cv=none; b=jgbyjnk22lNeTwivFa7Hq05VZMZYiF76xopG2GF9tJ5xvXbtRoErp7Z52g5n0Jj56plWbpNWr7L4NlTzBeioSqOs3m3XTgoIhwKLCx7aajjTLchjysIgiBTWirXDWKvu16RVxvh3UxZLFUKhZWIh5B7HNojZpDRCaocnL6ZRQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742749945; c=relaxed/simple;
	bh=6vTLHja0lc6DMhMyhdlBwZOJMjDznhKcLs1eZuRtQ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STSlSamozKuNP8hR90pWHm+4pllqHY6yu/KofEgLoqmsGfJNWwzKh2FmssUqCCk7RlWdMjhBeQHuJXdqnczKogQuFAWvNfMUBsE/yqUYSvkcYu17F4fxa93w4yaNcK7PztQFpO1cX8RbGIDOGdouwIbvzHXuz2k9eyUrfhyaF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR2fbwu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40347C4CEE2;
	Sun, 23 Mar 2025 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742749944;
	bh=6vTLHja0lc6DMhMyhdlBwZOJMjDznhKcLs1eZuRtQ+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UR2fbwu6tQlRQxdBwmXXQb8EuaNbBMaaksKoK+9upfrxf9wWwEePYLmYhunLNHkik
	 WYxN9CZOeGVX9DUurq+EWqkAagi3cRvuiKbnwB0b6+rnmSLRYjUa5GkEp2Afuctudz
	 e0Tk0H2CApMbJn6SBP+582qfEgcSBLH425dlXvjti/1NALY0xNNjiptgLpi0EyU3Eg
	 /SXYByyTbjggoOWdqivzejoL3u+79JC2LHIv1COC+PQabf0J0i6y0SNx+ufipS0j/N
	 3LMwhDQDv/0r3KqNeXpXNUkTm2oFnODuUZuMT/bsgfjiGNJMiHEwVJ1kmEDCL08bf1
	 li7/JeeUJE4JQ==
Date: Sun, 23 Mar 2025 17:12:20 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v3 1/3] ice: remove SW side band access
 workaround for E825
Message-ID: <20250323171220.GT892515@horms.kernel.org>
References: <20250320131538.712326-1-grzegorz.nitka@intel.com>
 <20250320131538.712326-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320131538.712326-2-grzegorz.nitka@intel.com>

On Thu, Mar 20, 2025 at 02:15:36PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Due to the bug in FW/NVM autoload mechanism (wrong default
> SB_REM_DEV_CTL register settings), the access to peer PHY and CGU
> clients was disabled by default.
> 
> As the workaround solution, the register value was overwritten by the
> driver at the probe or reset handling.
> Remove workaround as it's not needed anymore. The fix in autoload
> procedure has been provided with NVM 3.80 version.
> 
> NOTE: at the time the fix was provided in NVM, the E825C product was
> not officially available on the market, so it's not expected this change
> will cause regression when running with older driver/kernel versions.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


