Return-Path: <netdev+bounces-207562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDDCB07D12
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CF51C2849D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11729B200;
	Wed, 16 Jul 2025 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+LsNpY6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8A188A3A;
	Wed, 16 Jul 2025 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691437; cv=none; b=ZlaFtO0/OflKyCuMP2I9xcbegqA7Q7z26+yBVgZ6LJ6gMwZ0xy2Cw5PIQihLIbj4mCcv67cko1ZE81gaiQ9Uh5nWGI30F7tDuO8tM76aHlVNGgtRtXS1fwDq0BaHxxt4dCM8q4P3sX+lH74BW+jzNms3cshW0aoi9HzvOx3TMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691437; c=relaxed/simple;
	bh=CZgt1L+rhk4mkpjmGSdry/ouaqn5NLPv9pM3X8aH7NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy7UyaokS0/O95S4jb0iLKlq3AS5M3oATQaQy/OwSy3uK093sDeBEIc4dwp8HUVQMbUfedLvaP5qC2/oUGLGf1dPXjLHqdXc5fVMc1vok0NWGgGOkxLU8H50cxUZxg/FeRA07HBuxT2IBrwb8pUyj3/utrnFjTloaqre42f7ZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+LsNpY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9157EC4CEF1;
	Wed, 16 Jul 2025 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752691437;
	bh=CZgt1L+rhk4mkpjmGSdry/ouaqn5NLPv9pM3X8aH7NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+LsNpY6sIMXqJHi+WYjoTs0wsFdgqTmEtThkquGWCcNhiDVQtajCWWjHxka39xJv
	 qVHJWphjRN77g9CFasKdvJ5OYAc/bYY1aV6k6rpes/OnBLlo7BBhp75aJjd7HnSzvH
	 B+XsbvmZnlKztwpcxnn64Yg4EdkHSeB64NdsWKiIOh+oubGI62mQ2x/ILt1pBQ2dI1
	 9/DB2JzghfK0wFegbp0a/+FC5A7yhhRDpxq3kZje3GngF9eBYpUR2/IVT/8wBtULfk
	 bv638TXgiNct8xm62S/7mWJxC63ZL8dFlrr+pUsEWUrFpxqpP0PfFv+SG8x+Dj1pcf
	 OXwe7KV7/7Odg==
Date: Wed, 16 Jul 2025 19:43:53 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ag71xx: Add missing check after DMA map
Message-ID: <20250716184353.GP721198@horms.kernel.org>
References: <20250716095733.37452-3-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716095733.37452-3-fourier.thomas@gmail.com>

On Wed, Jul 16, 2025 at 11:57:25AM +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> v1 -> v2:
>   - do not pass free function to ag71xx_fill_rx_buf()

Reviewed-by: Simon Horman <horms@kernel.org>


