Return-Path: <netdev+bounces-79621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B259587A44E
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A1281D69
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630218E12;
	Wed, 13 Mar 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpqlSt/c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C112B93
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320075; cv=none; b=XYpV24gIkuRWcc9v8qufx2QKNNGKYel3MLLF2qjm0EMBnznuQgLQzHuBn5qjBgq7/bOLYQMkB33b+vNKv+d1Sgm01XakqUbCUYgiMppJiL6c9xcrQXjafMroouk2jthgkY4oRXlN720UNPdv9j/rcnV/qUBeSStd0qmT+eff4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320075; c=relaxed/simple;
	bh=DO2vjwTpbrN3nyHXcJYXF52C5DOxpVu7LcSd0qbPhDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hntVfXtI8En9frMfab5aVUEHjpaEWx6d80+TWYwzO9GvOsBu5lgkBbq/9vMLAYwdMxzO0xaEEqW7eXbA+xtSNRiKSFr+t8of5N2zb4AucCLRw2GPdnvX0Xe48yZ8rkr5QY2/hPGnbHrI+LqM/T5ZJBciFXkC+pbI2hHxjNjxZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpqlSt/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EBCC433F1;
	Wed, 13 Mar 2024 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710320075;
	bh=DO2vjwTpbrN3nyHXcJYXF52C5DOxpVu7LcSd0qbPhDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpqlSt/c3MwIQgKqSybFmBakXlBIdPOTIVQMh2J3rneT5XykON+E3Acb0AW6ktIsZ
	 nSKIurNVYA+yUTdeYKLuxMrSPxwkoLyR2VIkRlXlxV9nyzDpiXJATp3RQxv4rYMVZm
	 e9Ro2IzgonZeX25fm9sHobt3usQI9zOm6tdi49+Z5qpiWQVgdKBi2X6aK4bazNDLAo
	 k4AKunU0L1ouxmSoHJ7uvDHXxKu67dAEQMYn/nTyCd30p4+K4mIesruPvChxKl27rI
	 wR5ayXozVgg+G4JileZ9vPb4aVE8J0ywsRWy+b/+cf1MIGK941DYLEMQYrg2jOrZIc
	 regYb9dmhwsgQ==
Date: Wed, 13 Mar 2024 10:54:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v3] xfrm: Add Direction to the SA in or out
Message-ID: <20240313085430.GW12921@unreal>
References: <8ca32bd68d6e2eee1976fd06c7bc65f8ed7e24d3.1710273084.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca32bd68d6e2eee1976fd06c7bc65f8ed7e24d3.1710273084.git.antony.antony@secunet.com>

On Tue, Mar 12, 2024 at 08:59:29PM +0100, Antony Antony wrote:
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v2->v3:
>  - delete redundant XFRM_SA_DIR_USET
>  - use u8 for "dir"
>  - fix HW OFFLOAD DIR check
> 
> v1->v2:
>  - use .strict_start_type in struct nla_policy xfrma_policy
>  - delete redundant XFRM_SA_DIR_MAX enum
> ---
>  include/net/xfrm.h        |  1 +
>  include/uapi/linux/xfrm.h |  6 +++++
>  net/xfrm/xfrm_compat.c    |  7 ++++--
>  net/xfrm/xfrm_device.c    |  5 +++++
>  net/xfrm/xfrm_state.c     |  1 +
>  net/xfrm/xfrm_user.c      | 46 +++++++++++++++++++++++++++++++++++----
>  6 files changed, 60 insertions(+), 6 deletions(-)

<...>

> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 3784534c9185..481a374eff3b 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  		return -EINVAL;
>  	}
> 
> +	if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) {
> +		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> +		return -EINVAL;
> +	}

It is only one side, the more comprehensive check should be done for
XFRM_SA_DIR_IN too.

if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
!((xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN))
....

and IMHO, it is better to have this check in verify_newsa_info().

Thanks

