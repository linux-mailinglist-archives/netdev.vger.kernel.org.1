Return-Path: <netdev+bounces-162475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40263A27005
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60F71641CA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639A20C025;
	Tue,  4 Feb 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckGdRb8q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E520C016
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667570; cv=none; b=TUbAzaG4fKYpxMm0DOtcUzCpj0SQJSr3ZjCBm5saOwT5Hq+gsg5Ctj40cHl9Xo23Rtr3zYSOk/55jT7XzWlGCPb0HSCoK4gos+vlTZbhzQSNnhz6hkJoHZF8tAO3xaA6OLYXVfVg4fiA9BiuICBHRtCxiRCH7dsGSWyeduRu2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667570; c=relaxed/simple;
	bh=0oJiZKIsZUxi0MB8I6pw017elW0k38xoy6q4WMGlREs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhSILhPH9JG33fy4fXd3RNp0Eb2BIYC9CB1LTHaqC/4WoBeiYHKx4CneqVFNs+Zogy2IZTaeBlzvRAWsZfijlvUlPVh+cQJck0fas8iT/glfldYJFaEOrO8aBMWprESZ0R+KFITvr7w0fCws9r07keM4nr6HcCU28vZyu670I5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckGdRb8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58220C4CEE2;
	Tue,  4 Feb 2025 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738667570;
	bh=0oJiZKIsZUxi0MB8I6pw017elW0k38xoy6q4WMGlREs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckGdRb8qvyjaQg5blne36abTlavwIGuf8BJBOI/Uw8aoYtJ6vzOMn9mr0/9UhDeZr
	 EwRYFjt4xBHCR3DEnoVo5I1cR1d0VDJsNy1CGLG3Yuz4U6/0UMtTreObO8p8WliKCP
	 pgeYxuBihtiFz3MNn/g+Y2PqE/gQMNjIuRxPhZA70eaCxCZ7xjD5eulqCIH1HuoRC5
	 +d1W7201WgPaiPQ0GcWEhe3fGJHNOA5NNusDXxz8vx0Vy3TbXRjcRPtJc2AzWPyr0+
	 QCCA+rvSeKWihTLnNeqUqa0S6gDaXjaUjvqJxWh6OZMJ3E4mKQVBmHq4daNKvyY0TQ
	 jjsFRlABPqrkA==
Date: Tue, 4 Feb 2025 11:12:46 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH net-next] net: phy: realtek: make HWMON support a
 user-visible Kconfig symbol
Message-ID: <20250204111246.GR234677@kernel.org>
References: <3466ee92-166a-4b0f-9ae7-42b9e046f333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3466ee92-166a-4b0f-9ae7-42b9e046f333@gmail.com>

On Mon, Feb 03, 2025 at 09:33:39PM +0100, Heiner Kallweit wrote:
> Make config symbol REALTEK_PHY_HWMON user-visible, so that users can
> remove support if not needed.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

