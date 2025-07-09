Return-Path: <netdev+bounces-205325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C7AFE2F2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF3B1C4303E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457427AC44;
	Wed,  9 Jul 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf/AHaSU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3A22DA0B
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050468; cv=none; b=g73GwsyZzI3enRdcEm1Lu/UgjG7+/tHT6zukCoaI1K9OvT19S51RbZFaCOsY+13ffmY+0yOjcYn457J5LMsv1z6N3qKBQhA0z0gO73bg0cFQEcci+3wCUSBxiKVrKlaT/ps7AdNLAJRgd44C8cnyJW/dNgeuvHQB2xn6SbskwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050468; c=relaxed/simple;
	bh=cR0JSEUOpxwweYBQULwKcfK/bGBpgcuabjTrO1k1LJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpTB1b8oEU/4mc8GhVVS6UujBY3Duud8BFg1i7YmtLg0Vc/ZjivvgQq6j4fR+opKv/EAGvhyjfaABS1v7AMU1na9VjDO6H3j39P+oKKgFiIEfc7NsYKQb2zFj/Y6Bo/dCFRvZlf4H29j8BMygCxl8iKoD6D80vUP7jNzzj54diQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf/AHaSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CA9C4CEEF;
	Wed,  9 Jul 2025 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050467;
	bh=cR0JSEUOpxwweYBQULwKcfK/bGBpgcuabjTrO1k1LJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nf/AHaSUjIwbFBxqW3rR34afAQjQT4qzkspzs8l4hQ7k1yHL1Jm67ilMRnCU6yjZn
	 gKb7VtvwDwGbQvK7cpJ2KxJr1RjOD02HU2pe98a4YhA9kFiNUTTjFQ2HKKUzFUmRbY
	 enNFQ5EVfAmkU2UeK9X+rEzHuxxRP0pDLuW30BcEGll3BGbekgKx2vSi5Afeq3cRvX
	 T7seEsEGFKJfIU9O3jwfnZOntpMt+zLyGNDGCyC0mIfX88uZTHNG7bIDTkVsq2wmuA
	 qPY+mal8ZVtnMWe9z14MnEMgjWmfr+oIcZAgzSutnoVUI4pgGAG2+jH9FuecyE4CVS
	 /gbAJyYqUcWaQ==
Date: Wed, 9 Jul 2025 09:41:03 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 12/13] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <20250709084103.GN452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-13-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-13-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:54PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.
> 
> Devlink param multi-attribute values are considered to be dynamically
> sized arrays of u32 values, by introducing a new devlink param type
> DEVLINK_PARAM_TYPE_ARR_U32, driver and user space can set a variable
> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> 
> Implement get/set parsing and add to the internal value structure passed
> to drivers.
> 
> This is useful for devices that need to configure a list of values for
> a specific configuration.
> 
> example:
>  $ devlink dev param show pci/... name multi-value-param
>     name multi-value-param type driver-specific
>     values:
>       cmode permanent value: 0,1,2,3,4,5,6,7
> 
>  $ devlink dev param set pci/... name multi-value-param \
> 	value 4,5,6,7,0,1,2,3 cmode permanent
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


