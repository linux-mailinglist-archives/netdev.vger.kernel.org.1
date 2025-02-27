Return-Path: <netdev+bounces-170203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB6A47C38
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1537A9463
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732AC22CBC8;
	Thu, 27 Feb 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO4VkYtb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7DD22C35C
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655611; cv=none; b=aqmzkpP/mvPkWyFU6KQEMMobdNOOr9VFd5teFKzbCrezz1oplfr2m5pyz60UtoRXqYEoQdkoe7VlH0KUmvpJuHTbQMWoowec9IELYZ34ki1sciXy9T9xr41vXbTU/nBCm6Xjq3elBrcSaAf5/nrdD1EpG1ojHlyoxtfyqOAGS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655611; c=relaxed/simple;
	bh=joa65lQgJqepjK/oan+yreZVBckdZfznLoJjDlT+9+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9aJXQ49gvGAA2m40Qlm5d0P6JErWgG/wDq1DzfRthQK1TrCEPLfd8uiOJeoSyxVlxlsP2SRsi30iLz5CF4BLijis74vPPdpzIzAqCJfK2xlO0mVll6aFqsy/vNz6rHshyBFLVpMcTbmkVpcejOMGcQmuZ6CNCRvoOgjwRlVneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO4VkYtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A4FC4CEE8;
	Thu, 27 Feb 2025 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740655610;
	bh=joa65lQgJqepjK/oan+yreZVBckdZfznLoJjDlT+9+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WO4VkYtbDvggp456HFQDWq+opgnr0uRB+sXmlxZC4c9FyKa0xULdPloHbUjSC0Fr5
	 a6AgxefGgKtTmoyFfvol7YrlLLBwC3KMCCnOJUr8hEog+mUHGZIB5ZY/0PF4TcdQAQ
	 7ZryLiw1CC36BMwf+/inL7cH73ps7uQCcn1lkWVePj4mYYacKXaFBidRAFgnkhI+51
	 oeDD411JqxV/um6XzmqED41Q6GibghbsSMjs07/ITRjftrqEwkWwwMhYGZVTgfIrUV
	 TZkHE9poo6c15xmK4x6leckJ4rrqAe8ScRFqXoedHY8MWZ05M5kI4LdQhmqRl4fKhH
	 Y+8xXCCaHjRKg==
Date: Thu, 27 Feb 2025 11:26:47 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH iwl-next v2] ice: Allow 100M speed for E825C SGMII device
Message-ID: <20250227112647.GF1615191@kernel.org>
References: <20250224205924.2861584-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224205924.2861584-1-grzegorz.nitka@intel.com>

On Mon, Feb 24, 2025 at 09:59:24PM +0100, Grzegorz Nitka wrote:
> Add E825C 10GbE SGMII device to the list of devices supporting 100Mbit
> link mode. Without that change, 100Mbit link mode is ignored in ethtool
> interface. This change was missed while adding the support for E825C
> devices family.
> 
> Testing hints (please note, for previous version, 100baseT/Full entry
> was missing):
> [root@localhost]# ethtool eth3
> Settings for eth3:
>         Supported ports: [ TP ]
>         Supported link modes:   100baseT/Full
>                                 1000baseT/Full
>                                 10000baseT/Full
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: Yes
>         Supported FEC modes: None
>         Advertised link modes:  100baseT/Full
>                                 1000baseT/Full
>                                 10000baseT/Full
> 	...
> 
> Fixes: f64e189442332 ("ice: introduce new E825C devices family")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Reviewed-by: Simon Horman <horms@kernel.org>


