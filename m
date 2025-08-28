Return-Path: <netdev+bounces-217829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFBDB39EE4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4520F5628E4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7172311C3F;
	Thu, 28 Aug 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1pkrag3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7C311C01;
	Thu, 28 Aug 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387714; cv=none; b=g0MkHYOm7Bfn7WlrmqVwHD6ESr1jBZoQNSHC27QjCW3JTjz+2a+0wmbz39Ze0PMTU426GoM6ngMs0C8LTcqyserGiR912UBsMmDI7UxNGCGMqlx3bkPKthnX3PIdwb8xIS3FfcSsIwkwWG6ZXQpXmv4fuE9vjKM+pJKhaXmrgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387714; c=relaxed/simple;
	bh=sD6IqhJUAUQSX8sWZdD+3J1KXCwPxPovjWXybaXMCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCulga9F89Z4NzuXqelA/FpI3dhprnSe0ohZrx0dzoJfS8/uG66CY/f53hz/FeBvzpxbMfBuf8gRq+JXx4f3t26DJFmONuYoKvU8H7fy65dP7UCM2VtB9RujwJD7Wp8lSda3Y5cX9rqE2OxrSvQA3GPzr7dyy2ACqbM4yMy4lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1pkrag3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1933BC4CEEB;
	Thu, 28 Aug 2025 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756387713;
	bh=sD6IqhJUAUQSX8sWZdD+3J1KXCwPxPovjWXybaXMCZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1pkrag3z0zG5P2/OS95dMgXCg9ooEhLyjZP0/T3B5huTEC2F1sowiuxHCCFXHJJD
	 jZma4iNXMv9yXOUJqHz+wiaJPLp/qypSI7D6uo2zDC5AVKLvcBQlciZTxxGl0IgtIg
	 emSx6QrjXFWKjQNOwK9YCx1YtdSeLnGaBcbY5uV2Pb1dVmDKzs10vzO6IA4jSfyb5t
	 m4W9QHV8iG7Bw3f0EAFUJuUXmMX03eCugeF2MXBoHNBfTmA1O54hWKf1XTDSV1GXU2
	 fTqDTmduG+AZYmw7fnw6GuwLDzQBxit2hzfibIUY2kWZP+dD7vzjf3qxWkr2i+FP/x
	 RUxH0BCCnTT7A==
Date: Thu, 28 Aug 2025 14:28:28 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: thunderx: Remove redundant ternary operators
Message-ID: <20250828132828.GL10519@horms.kernel.org>
References: <20250827101607.444580-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827101607.444580-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 06:16:07PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr


