Return-Path: <netdev+bounces-76959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAF86FB07
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7B31F228E6
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478A014A93;
	Mon,  4 Mar 2024 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8JSprGE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A10171B0
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538163; cv=none; b=orC8GLZEFmPsOxnM7ZUEig/q4R/RyCP6o+awneZGWcTqPSLzHOiEQzUA6efUazTgmc0NCZws98vqQBlMdBxz5eQLe7rwxbNyOb2l2KkIL0JWlZEiv08ldhySXioFchmDYrgpOuxT5QyY115dkgTtIHCri8ZZm4SIi0r5oXJkZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538163; c=relaxed/simple;
	bh=UlcG+1INkDZAm4+SWOhV8PJ0yWpVMXdkjlSPLf3P9U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVoON0e/E/YGqkDS9gzY8JlHV+ON8/2G1OdBOGMZuy5hIVdJ6/mLHj/Ay0m8C4pSuAeRZELhS5zX1ZoAuJdOZtbvOvtsaLnKy/Z8LXNMePHr5bFlCex55tKWjh7fWuk0NM6zI3JEBqBkAdrA8dHLrTQW0uHzK3uwk9dWolJhq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8JSprGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7272CC433C7;
	Mon,  4 Mar 2024 07:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709538162;
	bh=UlcG+1INkDZAm4+SWOhV8PJ0yWpVMXdkjlSPLf3P9U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8JSprGEt16TG0OmlfbAa+QvPwRYrFOzmWyA5y7oRiooO9xPZbIMq6rOzPuQkEXiT
	 6ki/BOoMg0n2gLkWgumXZyMvgxIlFbBfkHl2CX6WZ39I2k7MgTmWkiOI02yYyNYVdS
	 v0ENJ9Y5cvjp1ZmvmTXJHE7vMU/QKbChMJ7LK/9cH6Z3VGmPS97u7d+I5e0/dZ9Gde
	 J/baTqiwPVDpFv0TaHSYgxwYNVQEbiPlwaghYQULs3phIrIuTLeNH0bL9eg+OWo+MQ
	 Xx2UAg5xVQEZns8jAWUOCBVhvU97BY7TsJ/HTzKTLFw+/pfxOwHS1pIX3MFfRuaPXo
	 CxxdCQ1/euF6Q==
Date: Mon, 4 Mar 2024 09:42:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] xfrm: Add Direction to the SA in or out
Message-ID: <20240304074239.GB13620@unreal>
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>

On Sun, Mar 03, 2024 at 10:08:41PM +0100, Antony Antony wrote:
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
>  include/net/xfrm.h        |  1 +
>  include/uapi/linux/xfrm.h |  8 ++++++++
>  net/xfrm/xfrm_compat.c    |  6 ++++--
>  net/xfrm/xfrm_device.c    |  5 +++++
>  net/xfrm/xfrm_state.c     |  1 +
>  net/xfrm/xfrm_user.c      | 43 +++++++++++++++++++++++++++++++++++----
>  6 files changed, 58 insertions(+), 6 deletions(-)

<...>

> +enum xfrm_sa_dir {
> +	XFRM_SA_DIR_UNSET = 0,
> +	XFRM_SA_DIR_IN	= 1,
> +	XFRM_SA_DIR_OUT	= 2,
> +	XFRM_SA_DIR_MAX = 3,
> +};

<...>

> +	if (attrs[XFRMA_SA_DIR]) {
> +		u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
> +
> +		if (!sa_dir || sa_dir >= XFRM_SA_DIR_MAX)  {

Netlink approach is to rely on attrs[XFRMA_SA_DIR] as a marker for XFRM_SA_DIR_UNSET.
If attrs[XFRMA_SA_DIR] == NULL, then the direction is XFRM_SA_DIR_UNSET.
Also, why do you need XFRM_SA_DIR_MAX in UAPI?

Thanks

