Return-Path: <netdev+bounces-156698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B85A07851
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0141889EC7
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7C218EBF;
	Thu,  9 Jan 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBm+CcBd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ECC218AA8
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431093; cv=none; b=dBEot+mWwA+r87w7QCtdYNQyczqPFe8MfbopBoq6/3wHUPqaBFZVmJaAvXPxBXuAfm3kGy9iRMLIxwYE304VUWXgB4XHuFVCqLjNGGhhq2sNh29kPE37HUM5JfIwwn48TiRewPPccguX63PLEALdaVnB23nev1K2aYp23hJfcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431093; c=relaxed/simple;
	bh=4jvAQtxGt6lHLjAUeqQa1YwbGjB10mmT5jdbgU8+iMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRSt58S0TeYSWpsZJ2vLcp542NVW8YBvw9N07WyjkVatlu5zMg8j0yOTHscviHiefOZw+thOz4SaR/vMc1fYVub+Gxkyn7CjD7EQ/il64x8Aw9tUTclVbyUmRc2gJXCeQ94ryZkOaIk0I33fWZBuk0Gm+sCJAt03iy26Isiy+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBm+CcBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E93C4CED2;
	Thu,  9 Jan 2025 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736431092;
	bh=4jvAQtxGt6lHLjAUeqQa1YwbGjB10mmT5jdbgU8+iMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBm+CcBdrjBze0hGMUUOEfGGmJwoDRsAWWvuwcuk8IFYHN8JHf8gaC2pcnZ8yePtU
	 /KA/i6kaGt3yBAacliFjopK0P0UUXfAI/mL/tASgWhMPAQ2W7NMzzg/BqXZ0DKfJ2s
	 FxmyGLfaE/auR3atTlF8QyN3fZo8UKxCusrsL68vjc5Pi4gMzVDy7bMxXD0IZhih7A
	 7oCzHZqIEwpZW82b1hxayONStIJs7UTLP62IYJzrApreNqbJ+wEUMtoR40Q5x3YcMS
	 yRqVJWsadX7hfhf05L366ZfQ0UAKRU3zSqte5EkziFUohCfPj2e+JQ0bG+IHZd5egq
	 tbL053B1bOQdw==
Date: Thu, 9 Jan 2025 13:58:09 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, nbd@nbd.name, sean.wang@mediatek.com,
	lorenzo@kernel.org, Mark-MC.Lee@mediatek.com
Subject: Re: [PATCH net v2 5/8] MAINTAINERS: remove Mark Lee from MediaTek
 Ethernet
Message-ID: <20250109135809.GF7706@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
 <20250108155242.2575530-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108155242.2575530-6-kuba@kernel.org>

On Wed, Jan 08, 2025 at 07:52:39AM -0800, Jakub Kicinski wrote:
> The mailing lists have seen no email from Mark Lee in the last 4 years.
> 
> gitdm missingmaints says:
> 
> Subsystem MEDIATEK ETHERNET DRIVER
>   Changes 103 / 400 (25%)
>   Last activity: 2024-12-19
>   Felix Fietkau <nbd@nbd.name>:
>     Author 88806efc034a 2024-10-17 00:00:00 44
>     Tags 88806efc034a 2024-10-17 00:00:00 51
>   Sean Wang <sean.wang@mediatek.com>:
>     Tags a5d75538295b 2020-04-07 00:00:00 1
>   Mark Lee <Mark-MC.Lee@mediatek.com>:
>   Lorenzo Bianconi <lorenzo@kernel.org>:
>     Author 0c7469ee718e 2024-12-19 00:00:00 123
>     Tags 0c7469ee718e 2024-12-19 00:00:00 139
>   Top reviewers:
>     [32]: horms@kernel.org
>     [15]: leonro@nvidia.com
>     [9]: andrew@lunn.ch
>   INACTIVE MAINTAINER Mark Lee <Mark-MC.Lee@mediatek.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I concur. The last email I see from Mark was in November 2019,
and the last commit I seem him mentioned in is dated June 2019.

Reviewed-by: Simon Horman <horms@kernel.org>

