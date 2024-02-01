Return-Path: <netdev+bounces-68009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC684595D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C93B28A09
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D195D46B;
	Thu,  1 Feb 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RULfAaSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E358F5336B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795598; cv=none; b=hHgarWKQwPwR6KWiJWdj7FXD83p2l6w7ralF5XXutvJb4Mq9ulIAbwfWAy2ykiiVaT5RQtyYQSL/HoB26+KMtjI8TSSl8K37xMYq6axdQnjOO5Y2eYfYYw8JuUPETFjVW07CHTItq4jaSLL21iLBuf5TdPwn2cqRnSbvOXWp6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795598; c=relaxed/simple;
	bh=sq1cWvyVkdX2fs4Z/aiPzFVgCCfswu7HDAiJGcCDW+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATm84iTOz15IhioxssgHh7g6p0aZkiwGhJqaPKZSRt25c2erQOb3thPJTm7uXmc5ZXRGPXKMO0YyZV2q0tK0I5xqX2huZTh2x6WsPuzsIN7RRoSbdXhrUyjcP6+oowq3RE5mglqk/YardvXePg3a4rSbdfFeZcfXogEdH8fB0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RULfAaSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41027C433C7;
	Thu,  1 Feb 2024 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795597;
	bh=sq1cWvyVkdX2fs4Z/aiPzFVgCCfswu7HDAiJGcCDW+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RULfAaSW0cBus6P0eYfypAFaGeMTtqv6IhRSWWUSYZ2g7CHObq96HIcTIWIz4stsB
	 1R8LpvDOabl+TO3Ei/1QTk25OPe6A6A6catrjsz+PpS70b9ibg1gXBsOG5iEfinF27
	 Y3gdoQsd8XJKIHXlAU4xCHwUBdmc9TSRYyxMVRrxe8taojdla1yFe/If1IpIJBC9Rp
	 KY3n6G7EMkUZqFhMnIoBYosG6fcZ77XDZrTN/GLMLj8MTwQQBG2WYiDkjjRzKlt3RA
	 S6XgOxMRYIfL4SU9+fRrtErrE2CkJnAPnWOx8XD+3iHkRxONSSpQX9vNiqTOMyexRq
	 xXyz9jfzhUfyQ==
Date: Thu, 1 Feb 2024 14:53:11 +0100
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: Re: [patch net-next v2 1/3] dpll: extend uapi by lock status error
 attribute
Message-ID: <20240201135311.GE530335@kernel.org>
References: <20240130120831.261085-1-jiri@resnulli.us>
 <20240130120831.261085-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130120831.261085-2-jiri@resnulli.us>

On Tue, Jan 30, 2024 at 01:08:29PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> If the dpll devices goes to state "unlocked" or "holdover", it may be
> caused by an error. In that case, allow user to see what the error was.
> Introduce a new attribute and values it can carry.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index b4e947f9bfbc..0c13d7f1a1bc 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -50,6 +50,35 @@ enum dpll_lock_status {
>  	DPLL_LOCK_STATUS_MAX = (__DPLL_LOCK_STATUS_MAX - 1)
>  };
>  
> +/**
> + * enum dpll_lock_status_error - if previous status change was done due to a
> + *   failure, this provides information of dpll device lock status error. Valid
> + *   values for DPLL_A_LOCK_STATUS_ERROR attribute
> + * @DPLL_LOCK_STATUS_ERROR_NONE: dpll device lock status was changed without
> + *   any error
> + * @DPLL_LOCK_STATUS_ERROR_UNDEFINED: dpll device lock status was changed due
> + *   to undefined error. Driver fills this value up in case it is not able to
> + *   obtain suitable exact error type.
> + * @DPLL_LOCK_STATUS_ERROR_MEDIA_DOWN: dpll device lock status was changed
> + *   because of associated media got down. This may happen for example if dpll
> + *   device was previously locked on an input pin of type
> + *   PIN_TYPE_SYNCE_ETH_PORT.
> + * @DPLL_LOCK_STATUS_ERROR_FRACTIONAL_FREQUENCY_OFFSET_TOO_HIGH: the FFO
> + *   (Fractional Frequency Offset) between the RX and TX symbol rate on the
> + *   media got too high. This may happen for example if dpll device was
> + *   previously locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
> + */
> +enum dpll_lock_status_error {
> +	DPLL_LOCK_STATUS_ERROR_NONE = 1,
> +	DPLL_LOCK_STATUS_ERROR_UNDEFINED,
> +	DPLL_LOCK_STATUS_ERROR_MEDIA_DOWN,
> +	DPLL_LOCK_STATUS_ERROR_FRACTIONAL_FREQUENCY_OFFSET_TOO_HIGH,

nit: I'm all for descriptive names,
     but this one is rather long to say the least.

> +
> +	/* private: */
> +	__DPLL_LOCK_STATUS_ERROR_MAX,
> +	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
> +};
> +
>  #define DPLL_TEMP_DIVIDER	1000
>  
>  /**
> @@ -150,6 +179,7 @@ enum dpll_a {
>  	DPLL_A_LOCK_STATUS,
>  	DPLL_A_TEMP,
>  	DPLL_A_TYPE,
> +	DPLL_A_LOCK_STATUS_ERROR,
>  
>  	__DPLL_A_MAX,
>  	DPLL_A_MAX = (__DPLL_A_MAX - 1)
> -- 
> 2.43.0
> 
> 

