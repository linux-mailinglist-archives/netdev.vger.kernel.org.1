Return-Path: <netdev+bounces-168099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB4A3D7A9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E13D189BED4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218231D2F53;
	Thu, 20 Feb 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIS3q8E9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70D2862BD
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049465; cv=none; b=ompX/Sr8Ian+FdiamBLDIZovpxsrNg+bU13QFV+WERz38x6WgUTFSQR3ujnnsnL6v9JfXrOIFLB8nt+OSoXLMn5IM6WmjHYM1IF30pAR8mAoXXrEw1nbXuPSwJqM+MCXt0zwa9f2FD+oEROZKhq2b0Yp9QQD9bunaoGDWzqwmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049465; c=relaxed/simple;
	bh=9JJLi5//xYGK4Radl004BlCb2owBsBf44fem4vyCV4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybs8Hkrq/tjM6ADfifJEwv9CPHlqMcsgjWX9ErflvlVZlrg9gGPEssXEE9ksBOStfSNI6Og+2gY+WVspAUV9OscxwfGnSwxiJfov/e/skP7+pp/GnZNATb3HHf0azMwxx144fg8QE5W1zehR+jvVr8+Rxf8U1tQTgccFYwARZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIS3q8E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC33EC4CED1;
	Thu, 20 Feb 2025 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049464;
	bh=9JJLi5//xYGK4Radl004BlCb2owBsBf44fem4vyCV4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIS3q8E97NVnM2r57uAF7oBFPzMTKoiGpsJxhVNdBLEh+I4e6Wc0w5cGHWmrEZp4v
	 xoNMimatP4RlQub2scgoxaBrdzQIGpQ5khxA5fFMFqK49EYVRfHF1QkfYOvmeZQx71
	 lgO/HJ4Wm2sFZ8QpWxs73tnLfx06/2wJMH8JzlVfu+uMxYYJfSM9K3EjCAQdxuRL1z
	 du1tVDKwHbUVDa5+Ogh8COSnatY19PPFq7uJOX4wlzpH5G//1s2bGQodpMjgzh4qMQ
	 yFEEgDjtqRA3Wufkm8RK0gjSc1VuShy+HvIFhyZoWUCl558tzguAWV0DqQGn03/8nB
	 PHol71fPl5etw==
Date: Thu, 20 Feb 2025 11:04:20 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: realtek: add helper
 RTL822X_VND2_C22_REG
Message-ID: <20250220110420.GU1615191@kernel.org>
References: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>

On Fri, Feb 14, 2025 at 09:31:14PM +0100, Heiner Kallweit wrote:
> C22 register space is mapped to 0xa400 in MMD VEND2 register space.
> Add a helper to access mapped C22 registers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

FTR, this is now present in net-next as:

- net: phy: realtek: add helper RTL822X_VND2_C22_REG
  https://git.kernel.org/netdev/net-next/c/8af2136e7798


