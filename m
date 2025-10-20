Return-Path: <netdev+bounces-231026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CFEBF4075
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EAAE4E28B9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C912EF67F;
	Mon, 20 Oct 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2rMK1FX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CA2253EB;
	Mon, 20 Oct 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003144; cv=none; b=ULNJTpUXdP9qBucm1CrqlBgbiq9uVGwjhGg1GiLeKPkoJEFabgjeikl8frUm0tXTiupTNkqU1/fHSytLJQtHgjvIycsmCT9qgXJcuMi/p0U1haYVT7hwcZwCHCaNmWPvE1ymY2XY8PLYsJPHXWuP4Ofozv6Gg7APmt/5v4Y4PZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003144; c=relaxed/simple;
	bh=/19EKelH6N+5WWT7qIMuu0lKQ5wgovg0kgRFLlAz0jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWWc5Z/ZP6CZr4lkx+538ojFrh7cb+9IWvI+N1YTeiH86cnUH8eEqv4VueF2PbSiHznRwDM1qyJvLCz0PB0PnVIvi/2qsdKZJ0CMzDFbO65j3893VqjmVOxPLVpmv4kVoP5zR2AKKGSkeaHNGNBMX+UW4kZVMgcLsGgwJRi2yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2rMK1FX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD18DC4CEFB;
	Mon, 20 Oct 2025 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761003143;
	bh=/19EKelH6N+5WWT7qIMuu0lKQ5wgovg0kgRFLlAz0jU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2rMK1FXzT8vZmjJQHz4opC1ZR7wR2bgZ7S9ySiUFFcFpYBJF7tcLYaJWZ9n3xth8
	 jqrKPN232/G3X+y8eAnCqvm9RIrzDFiv2WVZwM4TnEKS+ZDd6Aocfg2X196Ws4Fffc
	 McGqYJ6kBc3BEzQRTuyyA9YM3JFag4oxq8iZdmx2yKc6pucOtS9qrZyvs6ieOJo2IZ
	 S/KtFgUxrqKh6zVv0J9GNJMcCbXXQ8gtSP8yHTbSbbHCjFbP81MclIcAU1mBY/KV3E
	 F1oiX/8znG31Hdty9FaRr5CsNHmHzuSJunLMSVbr37M2KI9x5g9IDONu2ZCmXdpDiI
	 5K1/C3/CzEjEA==
Date: Mon, 20 Oct 2025 16:32:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
Message-ID: <20251020163221.2c8347ea@kernel.org>
In-Reply-To: <20251018151737.365485-5-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
	<20251018151737.365485-5-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 17:17:37 +0200 Zahari Doychev wrote:
> The Linux tc actions expect that the action order starts from index
> one. To accommodate this, add a start-index property to the ynl spec
> for indexed arrays. This property allows the starting index to be
> specified, ensuring compatibility with consumers that require a
> non-zero-based index.
> 
> For example if we have "start_index = 1" then we get the following
> diff.
> 
>  		ynl_attr_put_str(nlh, TCA_FLOWER_INDEV, obj->indev);
>  	array = ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
>  	for (i = 0; i < obj->_count.act; i++)
> -		tc_act_attrs_put(nlh, i, &obj->act[i]);
> +		tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
>  	ynl_attr_nest_end(nlh, array);

The first one is just silently skipped by the kernel right?

We need to be selective about what API stupidity we try to
cover up in YNL. Otherwise the specs will be unmanageably complex.
IMO this one should be a comment in the spec explaining that action
0 is ignore and that's it.

