Return-Path: <netdev+bounces-215209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30325B2DA26
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5872687C9F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9622DFA2B;
	Wed, 20 Aug 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcm4PIzE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CA2D94A5
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686138; cv=none; b=pHUtAAGnMtqnodFtct0ecQFGPdPx4GS5BVLJqNAbwPCGP/fq5oSkxNtgo+fL3RRn5WSi9adyA0L0+QNZhG9wPrxlDf94QDICsMhaPhdU7U8s/g9flFK/HNDFF6AmPRiHurg3yC8MXE50qrdeA6WV4mB281dbrF2gVQnafIJEqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686138; c=relaxed/simple;
	bh=5LVI1KmzUCzUxqGkfJb6tjeX2FuOB0wXbJzcvKDhOvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2Niuo38xDF9NMojZcUL3cMpxljWopzvw0hGrB8ux3dZ9N4yM3y2zwE0mFYh5dSYYJXRdlXCJx04Ha5Ec5nzHhZa6LAQokquoKyhbYW/fYFelBXJuiffaeFoQ8ElJCXi7ZBFIP9LApLFGNLpyvFSoa2j4nb2De9/DWRhJcdTVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcm4PIzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267E0C4CEEB;
	Wed, 20 Aug 2025 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755686138;
	bh=5LVI1KmzUCzUxqGkfJb6tjeX2FuOB0wXbJzcvKDhOvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rcm4PIzEswEuJxPIAMekBfQT3I+DcD4byxky+Tx5Ha6jUxaUVzvs3YjUKGIWJR11D
	 nw+GTMer8BFNHFnFWvIVBATbxC0RErXZIxUDsVmVTn2Psfwt4S7KT2puiD7ZizBMRE
	 lPCm+UuPye9NDinxAgfYzi/pPfryFLbOzM/Ua5zWTH/YP2BhkrAZW3YOebbKgGVnqr
	 1mOANTRH21eJwCopUtEwCqqDxsUohgglPEkI4SbKSxJ4M1qQiDdmj6ZzC1sU6+9EpE
	 wd8RWzBLFpXre0H5IMeNLLaHym1wZqdBraSi9FX72EX1blgFdlFAv7CE+bijVjO5gi
	 rzgytonvYDIPQ==
Message-ID: <bafcd787-fed4-4133-a27a-97114a744c62@kernel.org>
Date: Wed, 20 Aug 2025 12:35:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net: page_pool: add page_pool_get()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com,
 michael.chan@broadcom.com, tariqt@nvidia.com, dtatulea@nvidia.com,
 ilias.apalodimas@linaro.org, alexanderduyck@fb.com, sdf@fomichev.me
References: <20250820025704.166248-1-kuba@kernel.org>
 <20250820025704.166248-2-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250820025704.166248-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/08/2025 04.56, Jakub Kicinski wrote:
> There is a page_pool_put() function but no get equivalent.
> Having multiple references to a page pool is quite useful.
> It avoids branching in create / destroy paths in drivers
> which support memory providers.
> 
> Use the new helper in bnxt.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   include/net/page_pool/helpers.h           |  5 +++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

