Return-Path: <netdev+bounces-170198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4AA47C0F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AE3172661
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E08218AAF;
	Thu, 27 Feb 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2ndC/MX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A61DB122
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655424; cv=none; b=rZyO3h5XPYQyyaJs8eBmyOiFFFQGaW3I8Q1nAqqT7XiPvcrY9YOP5fSRAYyiBcYg5Fmm6jFczuw02qUexpEzR0UZ7bzr2iSZZ4ADBv2u8MNkrj5G3N43NSREPoeDM8BfLsLj00rOVYIAiZLORZhejJloxo+nC2RY9TywxSbniOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655424; c=relaxed/simple;
	bh=e9Nho5OF8tCuj0g5OKDSBx3+nvAcIOynZbsbwusFglA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDK++nxxw+kFwtlVBkDZTc3CQnD8J8BhqeZzMKjo4cSJBjfhygZwM9ud49e0R9bmM7R5gFAtX/gdt7zp0u2nqr8qTJKdmE0wcZY65D7xb+uEAZS9eOYr3SxRCEwyh/FDINzuoyrTLKTiXXok3Gc4IMBK7rpvksWI7frI4z545oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2ndC/MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D4C4CEDD;
	Thu, 27 Feb 2025 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740655423;
	bh=e9Nho5OF8tCuj0g5OKDSBx3+nvAcIOynZbsbwusFglA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2ndC/MXz7RLeVo2zDgbiBT6xvY5pXev1D9Y7uKgrFw4ZSRKfdyn5zHJ836exU7CU
	 csb4/P0Wd/ZXv8XbVlfWB0a1NnwUd2y9RHGT4D311YkWo6cUixNYYbux55VSqI4zjm
	 N+Nh9e7N5xAmH/3NGMnZtmxmIBNGiKdb7Ly+BlYDq7FMZLBE8yeypTbw4AjpQxqjiJ
	 h0lPXNK4iNLzTCIrBzw25ON5EkXJLNOD5SdzZYxGk1Xypw7vaxZPXa2ZxBrsjOv+o7
	 STego9Kn3EQjK98kiW8RcgzX7VfY1pAiRBVBHCd55fWgxhiCEQeOhIx6cJ15TlHC5/
	 Ws+EvSlk1AmNg==
Date: Thu, 27 Feb 2025 11:23:40 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de, andrew@lunn.ch,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v3] ixgbe: fix media type detection for E610
 device
Message-ID: <20250227112340.GE1615191@kernel.org>
References: <20250221154917.3710-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221154917.3710-1-piotr.kwapulinski@intel.com>

On Fri, Feb 21, 2025 at 04:49:17PM +0100, Piotr Kwapulinski wrote:
> The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
> device") introduced incorrect media type detection for E610 device. It
> reproduces when advertised speed is modified after driver reload. Clear
> the previous outdated PHY type high value.
> 
> Reproduction steps:
> modprobe ixgbe
> ethtool -s eth0 advertise 0x1000000000000
> modprobe -r ixgbe
> modprobe ixgbe
> ethtool -s eth0 advertise 0x1000000000000
> Result before the fix:
> netlink error: link settings update failed
> netlink error: Invalid argument
> Result after the fix:
> No output error
> 
> Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


