Return-Path: <netdev+bounces-118449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C3951A57
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373D31C2165B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E9B19EEAF;
	Wed, 14 Aug 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brqXe4Nb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4616143879
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635969; cv=none; b=RfU52sXNWUid+/FhSOKog965blqKnJCIDxDKVSVEa4AZt+AS2CV92NQ4XrR6PouLqd60AVKfmKRt/hfHrAHc/GrW94Hjx6g55x8OMwt+0pMAuT2cN84v9/dC+U7RkiWqY4YHd/fi8upHKe8DL8jSNW29VKovuf2xLTqPlAjQmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635969; c=relaxed/simple;
	bh=W0++7NsE+uSBaD5heL7GBMaXR3rmJU8cgDBbLfCucVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyrdaKnEIe6fy4LY0HQEWKKNLqjN+HmlKfXTp6cFa5HdpRtJm6jFmYILxg8STQiNO7idfRoTRCme8vMJ+ouDlto1UMDsKVIa2YvZBUJbA4KFKe97jY0v47y+QXvQy7X628zESJF7lUfWqAUuGSfCUS9zLLlCDqIhANVRBBRskYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brqXe4Nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE71C4AF0D;
	Wed, 14 Aug 2024 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723635969;
	bh=W0++7NsE+uSBaD5heL7GBMaXR3rmJU8cgDBbLfCucVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brqXe4Nbm7O0OeNAK3sXgWPD6JAkm/AVudjTmiDTEZOXC0oB6fwPL5d7STY7mTldQ
	 D3UvfUE+2FIx1mk23nSZVURWGFpwgXu3u+2FKc8PXuiBfDTkbjNXeq5faEWhlvVt+8
	 eW0b7zfApy/l1wcPdh5Co6hMOZ4ePEoM5+yVYKbvTuE0TJ/z7IqupZV8EgwAMga9lx
	 Pi0D90lb1jFsTGn4/LGktEPoQbMPzWiymeDCBg99LWxjAUL4gl4L/A4Ccm12OJOES4
	 qLapEs6aVWJYcWmSb1qSKTGxqnPvwca/7219R4hGL1b2jA/0U/zAuVD8ZyWYx4fZaR
	 c46IOKN0a68pQ==
Date: Wed, 14 Aug 2024 12:46:05 +0100
From: Simon Horman <horms@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
	jacob.e.keller@intel.com, vadfed@meta.com, darinzon@amazon.com,
	kuba@kernel.org
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
Message-ID: <20240814114605.GC69536@kernel.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813125602.155827-2-maciek@machnikowski.net>

On Tue, Aug 13, 2024 at 12:56:00PM +0000, Maciek Machnikowski wrote:
> The Timex structure returned by the clock_adjtime() POSIX API allows
> the clock to return the estimated error. Implement getesterror
> and setesterror functions in the ptp_clock_info to enable drivers
> to interact with the hardware to get the error information.
> 
> getesterror additionally implements returning hw_ts and sys_ts
> to enable upper layers to estimate the maximum error of the clock
> based on the last time of correction. This functionality is not
> directly implemented in the clock_adjtime and will require
> a separate interface in the future.
> 
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  drivers/ptp/ptp_clock.c          | 18 +++++++++++++++++-
>  include/linux/ptp_clock_kernel.h | 11 +++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..2cb1f6af60ea 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -164,9 +164,25 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
>  
>  			err = ops->adjphase(ops, offset);
>  		}
> +	} else if (tx->modes & ADJ_ESTERROR) {
> +		if (ops->setesterror)
> +			if (tx->modes & ADJ_NANO)
> +				err = ops->setesterror(ops, tx->esterror * 1000);
> +			else
> +				err = ops->setesterror(ops, tx->esterror);

Both GCC-14 and Clang-18 complain when compiling with W=1 that the relation
of the else to the two if's is ambiguous. Based on indentation I suggest
adding a { } to the outer-if.

>  	} else if (tx->modes == 0) {
> +		long esterror;
> +
>  		tx->freq = ptp->dialed_frequency;
> -		err = 0;
> +		if (ops->getesterror) {
> +			err = ops->getesterror(ops, &esterror, NULL, NULL);
> +			if (err)
> +				return err;
> +			tx->modes &= ADJ_NANO;
> +			tx->esterror = esterror;
> +		} else {
> +			err = 0;
> +		}
>  	}
>  
>  	return err;

...

