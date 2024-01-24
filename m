Return-Path: <netdev+bounces-65638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F183B3E4
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3311C22D33
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E661353F6;
	Wed, 24 Jan 2024 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzaGWpM7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441A1353E4
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131619; cv=none; b=AsdWLn36sUDqOhaOfdAoexCuveBYfT5jv3KZd1evrXJ0jkoxD9tovKTCCxNScm1PzicVNckqNGSbuWpaZphwc1GuW1EQKbxvLQE4JgpDBuSsC7SQ75kbhInfWNBqRqaPbE0W2T3ylulvj5ggZ5HJLC9xvL0y0lzTrSudLUeBQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131619; c=relaxed/simple;
	bh=lCOjQOk7wxMizEVQCLQ7fNTuC0MebLxnMQwmgJUQwb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Deg4MYt/AVMaqhtdubA/JyTosCy5K6D3iPDOlS6bb4fL3FcCjzosej4xlCAKf0hYVetriRU7/6kUVxeaeIp4gKnZ5EbxA/V5jE+DtXUY0vBFq+VGhlmbzpcFP1ubJWECYlyI1QYXJuzuTX7X4ufud/Knd9PaXKGSt0tX8xIhg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzaGWpM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69485C433C7;
	Wed, 24 Jan 2024 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706131618;
	bh=lCOjQOk7wxMizEVQCLQ7fNTuC0MebLxnMQwmgJUQwb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzaGWpM7ggNujGT2ILNyXDOxpDxaPfJ6oDnDbvC3QwR3RzPzbcaUEf+Vbeo+FN+1e
	 xlw3j8av8cwhrJtpjIazRp9AYsLcW3MzRahzsxBVYl16tybSoNpWm+w+Gsn5xsAPnM
	 YCTBVPonkr2cvk3n+bhRXMk0FiTFErjUOSXocFF6wmnpIYdXaAO+uN5sHPSSM3A2+f
	 JnBI7unAq8gbSI2vR+hcIyGqF0pY6vFDaXZ21Pa74ZJntiQDqDQYB0bCORfV9RdJeb
	 C0pbGCbtqwFBYOAkFKpaLWykX7ltVrilqh9REMGu3JYinvx9m8q4PtqDVjwA86mHdq
	 xyyTwpGtXieUw==
Date: Wed, 24 Jan 2024 21:26:54 +0000
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next] ice: remove duplicate comment
Message-ID: <20240124212654.GA348897@kernel.org>
References: <20240122182419.889727-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122182419.889727-1-anthony.l.nguyen@intel.com>

On Mon, Jan 22, 2024 at 10:24:17AM -0800, Tony Nguyen wrote:
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> Remove a comment that was not correct; this structure has nothing
> to do with FW alignment.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Sure, but the subject doesn't seem to match the patch description.
And, Tony, your Sob seems to be missing.

> ---
>  drivers/net/ethernet/intel/ice/ice_debugfs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
> index c2bfba6b9ead..85aa31dd86b1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
> +++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
> @@ -64,9 +64,6 @@ static const char * const ice_fwlog_level_string[] = {
>  	"verbose",
>  };
>  
> -/* the order in this array is important. it matches the ordering of the
> - * values in the FW so the index is the same value as in ice_fwlog_level
> - */
>  static const char * const ice_fwlog_log_size[] = {
>  	"128K",
>  	"256K",

