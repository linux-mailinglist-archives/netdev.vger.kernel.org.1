Return-Path: <netdev+bounces-175740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8EFA67589
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73EF16FD9F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77AC20DD51;
	Tue, 18 Mar 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmdEAT56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944CF20DD45
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305694; cv=none; b=nkcCEaOBqJWW6l469ruS6MKMKx5X/79AaXG3Mgz6ESU1UfOcLgeyL9rV70XbxYAUfZsptJxys+dtl4C1Y7LzPlJS86dvr7izx25/W7m45vxLWqdAMZrRaBbtv8bkAcS0HXPEmr/UcG4VjcPSqyDAVZ9aFZYk1p7/uamMSuAg5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305694; c=relaxed/simple;
	bh=OiPk/ndUjYrNjhh3Y4OWHECT/ZBSLYEOLHsqmH4J4/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwfHoFxAQcM7p02N6LBBR5XshRl9Sg9+SwoLETz71A6XebIwCis2BcgBuE18yJTC/3W7/PlWfY2yOWBpm+i56XjYX5URo9BcjF5aK2c1ZGFKhU+Ih2zua0ziJ0tU8F5lR8wrWMEx2RxPVa7aGRTI31Ur0jFGfl4QaMALc5QaRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmdEAT56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E00C4CEE3;
	Tue, 18 Mar 2025 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742305694;
	bh=OiPk/ndUjYrNjhh3Y4OWHECT/ZBSLYEOLHsqmH4J4/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmdEAT566OUKPz00yB61/cxYpFFvxlxlm7pbJBctxLnF1kyOrCCiy2YUYjdjJq5om
	 J7E0YglcW7a1FkD+xb4W5T5reD7bygwsHDxz8U+1vUb+5Ja+1wkMy+yP8t041TAZdL
	 Ds7WAr+mBu4YCYKuMyCiGHw3FwVEbxqjhkBFO9jE=
Date: Tue, 18 Mar 2025 14:46:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	dakr@kernel.org, rafael@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, cratiu@nvidia.com,
	jacob.e.keller@intel.com, konrad.knitter@intel.com,
	cjubran@nvidia.com
Subject: Re: [PATCH net-next RFC 1/3] faux: extend the creation function for
 module namespace
Message-ID: <2025031826-scoff-retake-787a@gregkh>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318124706.94156-2-jiri@resnulli.us>

On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -744,7 +744,7 @@ static inline void __module_get(struct module *module)
>  /* This is a #define so the string doesn't get put in every .o file */
>  #define module_name(mod)			\
>  ({						\
> -	struct module *__mod = (mod);		\
> +	const struct module *__mod = (mod);	\
>  	__mod ? __mod->name : "kernel";		\
>  })

This feels like it should be a separate change, right?  Doesn't have to
do with this patch.

greg k-h

