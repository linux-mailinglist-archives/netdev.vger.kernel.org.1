Return-Path: <netdev+bounces-40096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2497C5B5F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EF2281099
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D901C299;
	Wed, 11 Oct 2023 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjeJHx+O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896A2232E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7EBC433C8;
	Wed, 11 Oct 2023 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697049117;
	bh=/9J780tQzBEeuQwQSPtBbrIhiw9EHx3g3BlP3psFwKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjeJHx+OqphaUMzYfFUXuSccv4+TtSpF63t940mzVkbY7AXjpKi+Xo6laOu+muCQ9
	 fFJ0zmahdIzmWqhzWQTmQ5bYxktRQrYNjZEsUbNWr0HdkhtVbT2fPJTEOsEm1Spbqd
	 JfKIS5EqZt6KQUvxNwqR2FHEkPfYhan42MM2HMLS4yV83Spr9u6It1xWzi1sUjfxpv
	 YSUuP2QRsQHKSyG5JowwyFAGvow8lxSQbq4rrx80ltiDvNvtNfdWikjhFK4vyutBlC
	 O4+7+RjFPAwNvTX0TZil50ZXztKj7qMW2qNDQH6tqcSEFF8y0ublI4IhLuha2Ei1N3
	 +QICDvqqzJtYg==
Date: Wed, 11 Oct 2023 20:31:54 +0200
From: Simon Horman <horms@kernel.org>
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: wwan: wwan_core.c: resolved spelling
 mistake
Message-ID: <20231011183154.GA1140976@kernel.org>
References: <20231010044608.33016-1-m.muzzammilashraf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010044608.33016-1-m.muzzammilashraf@gmail.com>

On Tue, Oct 10, 2023 at 09:46:08AM +0500, Muhammad Muzammil wrote:
> resolved typing mistake from devce to device
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

Hi Muhammad,

while we are here could we also consider fixing concurent ==> concurrent
in the same file?

> ---
>  drivers/net/wwan/wwan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 87df60916960..12c3ff91a239 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
>  
>  static const struct {
>  	const char * const name;	/* Port type name */
> -	const char * const devsuf;	/* Port devce name suffix */
> +	const char * const devsuf;	/* Port device name suffix */
>  } wwan_port_types[WWAN_PORT_MAX + 1] = {
>  	[WWAN_PORT_AT] = {
>  		.name = "AT",
> -- 
> 2.27.0
> 
> 

