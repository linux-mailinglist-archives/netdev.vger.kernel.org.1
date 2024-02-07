Return-Path: <netdev+bounces-69781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79284C929
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C1D2866EC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CA179AF;
	Wed,  7 Feb 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABAUjI5P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4317BB4
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303939; cv=none; b=aPwEZ3MwPj3NN052gw9iNaHPUuLSHrIFe13M1I9XqorryN2WmN4PknJij3mUcJK7EKoPH60/pbcPtCraPreqwGoGXava27qETYDo150Gu7zwGYpbpa2Z77fpvioIJCVtShYq0opkhNB2GPG4rOhZMjaozzfiV6GhQ0wfcHZouLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303939; c=relaxed/simple;
	bh=Ued9DmPKllBATP1Poa4kkww6YmbB5pFYPCXXV/+mOw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5ezv/W7GmXHIm+rcVnukovDCi3uuMHskEF79OavbYSv6qu8pHYFfQqZhLq1O0hi2qS6NPWDLMmPKtp5hwOO4/CJj/lNl49HzdQLJp9f3gYgkC61FQ2IZgQzRb3MSykGGjXvFoNq+O8m1WAseGfADOfD4qZ7EqFGgNjlk4JvdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABAUjI5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC4AC433C7;
	Wed,  7 Feb 2024 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707303939;
	bh=Ued9DmPKllBATP1Poa4kkww6YmbB5pFYPCXXV/+mOw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABAUjI5PAZZG9Wm0wFhoL2+p24Er/BTsxclp+Zma0cbIv9OnQlAIAZ9Ie2qbTOu2w
	 5A1C+08wWyr7+R+EiI0zEEFXi8UBauvNMAurR3vkT1rqG4OytSdGzSYSVsMZmz/Oyp
	 ME4+qjZtJJfolcTZ0ri8ULEcBvei9qyZeY33YzYsI3yK/sjRFhKvdOm6Awc+Pbt21l
	 cq1rznp2iYsd6vC9ijlfEtAoWJ6RCvs3ks/Nmg7clHRvrxkSG12UW1YV5Y2rbcl+JW
	 mloQ2a/bCrf//Bm+LvkB1FraGLYo0fRjafx9MBixXN6/870FyqVwfJQk7jdcE2n5ov
	 ijodwjkrkGvpQ==
Date: Wed, 7 Feb 2024 11:05:34 +0000
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [pull request][net-next V4 00/15] mlx5 updates 2024-01-26
Message-ID: <20240207110534.GB1297511@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>

On Mon, Feb 05, 2024 at 04:55:12PM -0800, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> v3->v4:
>  - Prevent a use after free in case of error flow inside
>    mlx5dr_dbg_create_dump_data() patch #13
> 
> v2->v3:
>  - Add noinline_for_stack to address large frame size issue patch #13
> 
> v1->v2:
>  - Fix large stack buffer usage in patch #13

Hi Saeed,

Thanks for the updates.
I have nothing to flag in v4 :)

