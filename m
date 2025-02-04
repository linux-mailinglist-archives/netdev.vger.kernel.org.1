Return-Path: <netdev+bounces-162547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB30A27367
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC6B18881E8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D7211475;
	Tue,  4 Feb 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp5wvko5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606F120DD47
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676226; cv=none; b=f0cLih5IJly9XF8pMvRMfUPSHiJ5DhbqI3lQ/LOX6SsfB2XBP6Gb4PAfXBFQRMhi0W2iC61NunSEwkO/MG8vL/WSwPF/uHNDmLtacteaNSzePT6uNA9mzDZtJStcd9vU/QdEjK4DHpn2f9ShO11fEwNvCh6ffasARuJhCCklTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676226; c=relaxed/simple;
	bh=yPdM4mhas6vfFH1tkLfqIqvDt0VG5r+foA36y7ZL8RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgBg3WF+dYDp5lygb+rw4bdAho9wY0cxKK3/VoZQ5w/w4WLlzfiQT8olEMtCxzN32Sm7DiZ5sYUphem+tiFRUt+EKCvkCHWMZXZwkrVxN/sVn96lKdNTUpmtlTisbs41CbNCykSWSLKz2RvzbMFl6VBLxKND0cnlrMg72c5ngDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp5wvko5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3467DC4CEDF;
	Tue,  4 Feb 2025 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738676225;
	bh=yPdM4mhas6vfFH1tkLfqIqvDt0VG5r+foA36y7ZL8RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kp5wvko5A67TYzOnDyKxsaVpeGyiEKhJjEKQdp1HJ4rxi3ueq0d1srU0nr7uLRQL2
	 pVMTTvAqojPIHGXErkir6e1Mew0WI21NMZKW3N8FmObFQi+5fL5y1KzKMBX5exfynC
	 m1GxMjv2x4k0TYJl7oeDfm5MB/2rtlW2HXX5F9RpzUWkCnYCra3bXpEcct5ENePukY
	 4q+xQRf1KDD3qxfO3CBHBfIjFFz1UH/vsBMZ9JF2k39ZjYCmHpy+T5ELEBjP+q3MIH
	 wnjkvIVivtPrUzsOGamLzAbc8EKUHumDThHdZGiy1qtSu+jh8UpoyIJZIayfcepTpA
	 Pm7Phl3lT7SVA==
Date: Tue, 4 Feb 2025 13:37:01 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	richardcochran@gmail.com, Milena Olech <milena.olech@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: add PTP support for E610 device
Message-ID: <20250204133701.GB234677@kernel.org>
References: <20250204071259.15510-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204071259.15510-1-piotr.kwapulinski@intel.com>

On Tue, Feb 04, 2025 at 08:12:59AM +0100, Piotr Kwapulinski wrote:
> Add PTP support for E610 adapter. The E610 is based on X550 and adds
> firmware managed link, enhanced security capabilities and support for
> updated server manageability. It does not introduce any new PTP features
> compared to X550.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


