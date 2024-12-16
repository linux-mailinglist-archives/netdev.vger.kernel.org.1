Return-Path: <netdev+bounces-152157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651E9F2E87
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A489D163464
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FED203D5A;
	Mon, 16 Dec 2024 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOOBgw6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEE1FF7CA
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346326; cv=none; b=rJP27MiL+zKb3A1/ueEOGksDKYbGBjL7YZT709QzQc93yrjudrfYHneif8G1fsW+LHMAxft0wE0Rv9rTIJMJ1LU6SGI4dDMsuMzxdgnhITFlOGBn3r3DWiwBoAowLVCgI4FOmUk3sqJtIVrzXgkbMSFxzRhdJQATVXrVHUOfHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346326; c=relaxed/simple;
	bh=KKWZlrwtc5qKS329x2bVeBQO8xT5h9VS+ca+hfXz0rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyApr5c7+qel961PJPesW1NxCbcPpFIPGtqdYS2Uoq0Xkl6RJiG/tgVS/AmT8AiowWVg7t0H2wtCB7EVQNB/3auJTaMoWqvS2HNcFjJ/Ui01OJQZu573gQ20mRtbBmZb3flG/Qjt2Z+jT7vwLpsilq9VZ2ulw8ck7idqXJwwDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOOBgw6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA924C4CEE0;
	Mon, 16 Dec 2024 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734346324;
	bh=KKWZlrwtc5qKS329x2bVeBQO8xT5h9VS+ca+hfXz0rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOOBgw6Iw7P0TiTJhwKiZRnjVY059uQlVqb5+VDdJkmeBIq35sGHYTq2axIidDeFx
	 rcwqEI+dH5Vqtyhy2g2vdoNEk7IjF5hquMf/pSLT1zzpKwLdzgHDHm0S/o+pFTwenX
	 HFwgsZvfC9fTz4MFmuHN5jhEcddmkng/jcU3v1/3Nys/ES8fLnvge1DC/C9mQ92FxS
	 ViLfDsH9YNG3GS2Xwm0qr7ZS96JHIGJcSbwM7y0rKqGNSxDPwxJBXAP6AHJeQT6v9B
	 QpoO9bASlb6EuIEq49vvf+0RBM7G6UJP4QxhUQm7ESdYipLIdN3iSlOZ4Uo6L2fKgc
	 Wgsd2oLE1SaAA==
Date: Mon, 16 Dec 2024 10:52:00 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Chun-Hao Lin <hau@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] r8169: add support for RTL8125D rev.b
Message-ID: <20241216105200.GC780307@kernel.org>
References: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
 <75e5e9ec-d01f-43ac-b0f4-e7456baf18d1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e5e9ec-d01f-43ac-b0f4-e7456baf18d1@gmail.com>

On Fri, Dec 13, 2024 at 08:02:58PM +0100, Heiner Kallweit wrote:
> From: ChunHao Lin <hau@realtek.com>
> 
> Add support for RTL8125D rev.b. Its XID is 0x689. It is basically
> based on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> [hkallweit1@gmail.com: rebased after adjusted version numbering]
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


