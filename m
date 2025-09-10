Return-Path: <netdev+bounces-221621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19880B513CC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B5B7A8920
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083E30F7F0;
	Wed, 10 Sep 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4K+kdev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74E2DCF55;
	Wed, 10 Sep 2025 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499934; cv=none; b=gSbuTjS/k0cavpdT8kOTmA1M+iVaq9OikzIi6DO+3e7qdd0e0uyyDJ0XFYgz30kAB3YUZQn8WN0q3y7XMjT95KCrm6BIcvzrHTQuK/bHAjomta6+QLkv8NxB6ALVzoV3azAjS+WIjxYQiSth16udBbR4CvRld2xCUlDeAp2pfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499934; c=relaxed/simple;
	bh=rOQxOgEMHcjOh++UqbUESyHQ5d1FesjktaJp9ctQiAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NllAgqT/76CDPKFDcKx8nBNtMUH3//+HsD2M+CcxqCno4XizzTjW8FTVSxlUSvU2x5AaLgig2QWPmKXVUVbiCQu8gIymItQFw82KsliaHqeA+1A/EPKPZ9irlXNr7HIpimEqXVm5w5rheHY+0RsJoG0xaekaDLD5GnWap8x8Dn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4K+kdev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2692BC4CEF0;
	Wed, 10 Sep 2025 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757499933;
	bh=rOQxOgEMHcjOh++UqbUESyHQ5d1FesjktaJp9ctQiAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4K+kdevzHGbYRrec4m+ky9DW3o4crg47X0AbSlGJkqgiabBEiwxdKkU6us5Vgxpr
	 bxQnspbQIaDrkez1h7jyF+5DJZTGvDcLqZn2L8BBp6I8r0q0o5qZyqOtoStYFcS5V7
	 9904tL+Gy3mAtD9nxYLQWIR0LHwsV44ZYtqzsHfPoxvzjHrzkUIhKxxFBrw/z5WO5L
	 MBijN8s/qIyiMADWPXDyqk8ZWUcxR4KqKJQrEwMu+OXbdsgwA4QooCLDgOTkI3Pu/X
	 GiGvtrrAK7XVqNvrsWhUxK0LryZqtlHRvXqXWqE02melptFeQx/6FdUb9Dme2K/Dzl
	 VasjEYf1cVLtw==
Date: Wed, 10 Sep 2025 11:25:28 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250910102528.GA30363@horms.kernel.org>
References: <aMAZ7wIeT1sDZ4_V@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMAZ7wIeT1sDZ4_V@kspp>

On Tue, Sep 09, 2025 at 02:13:35PM +0200, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the __struct_group() helper to fix 31 instances of the following
> type of warnings:
> 
> 30 net/bluetooth/mgmt_config.c:16:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 net/bluetooth/mgmt_config.c:22:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use __struct_group() instead of TRAILING_OVERLAP().
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aLSCu8U62Hve7Dau@kspp/

Reviewed-by: Simon Horman <horms@kernel.org>


