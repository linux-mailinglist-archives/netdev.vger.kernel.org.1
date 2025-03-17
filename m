Return-Path: <netdev+bounces-175381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB34A65839
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D0C16B985
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F41A23BB;
	Mon, 17 Mar 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT7f2LfZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB01A00F0
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229397; cv=none; b=DGPsyNYpEfabaX7VyswyLdsVCW6hbva+eoVsqIdvTPDbhkgRFl57TqQzSdFOZ8/SHfUgewu3w4+x3UUCvpIYs168+IHRlFQbfADkA5cFLIOOjNCHVSxy6CIT79Dr8jrN4KIpeWzx/Wd4/2KXUMcxAGzyMR+fxR0G7LihB1gd/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229397; c=relaxed/simple;
	bh=Jo5bYLXd2n3FxjbuIWaKZfgiA2G8U5y0lBTzVuRSLVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozYKRGRm8+qGek/ILUeBrBuBli8nwWAwewHFB7uV/wZav00gERDrUQyORBWTDmKC79gYT/IivxnIi036l5Hw5pUooa+2++h1A19MVCIgfZ6DF7ITkRTNuC8Qmoexhj0LGe2RosOdNjOlTr061/5HBRdb16QoRrr1jqPza/rZqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT7f2LfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BA7C4CEE3;
	Mon, 17 Mar 2025 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229397;
	bh=Jo5bYLXd2n3FxjbuIWaKZfgiA2G8U5y0lBTzVuRSLVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nT7f2LfZLmvgPljLSXdlXzdjk3UfhjNzIwcO1r7yQnwaOfNBK12mKD9TMx7CyfJsu
	 hm6o812LhzNDhS0nbNGQ95cb9Ianx0UNU792TqNnA7/qQqTudqUMYpcmz021DxL/ti
	 DUUoquUwEMSLQAd/Kg4Rl8t5gAOAcnjp1tmIEePcrkSy+oJRZ9B/vYQVddW7biSZ92
	 SzNrH1RDC0iKPskc+aUrIiSweol6LMY/UPi9+rJ18vb3ChWPCxvXeBz84hqRuo0kby
	 jX88P68QS1295RL39epC4Yds7mLxzE4ncxwJrIFUxGMBqU8ky/G38BBRitM2mxlkrB
	 R4QguFT/fzQcw==
Date: Mon, 17 Mar 2025 16:36:34 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 3/3] ice: enable timesync operation on 2xNAC
 E825 devices
Message-ID: <20250317163634.GE688833@kernel.org>
References: <20250310122439.3327908-1-grzegorz.nitka@intel.com>
 <20250310122439.3327908-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310122439.3327908-4-grzegorz.nitka@intel.com>

On Mon, Mar 10, 2025 at 01:24:39PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> According to the E825C specification, SBQ address for ports on a single
> complex is device 2 for PHY 0 and device 13 for PHY1.
> For accessing ports on a dual complex E825C (so called 2xNAC mode),
> the driver should use destination device 2 (referred as phy_0) for
> the current complex PHY and device 13 (referred as phy_0_peer) for
> peer complex PHY.
> 
> Differentiate SBQ destination device by checking if current PF port
> number is on the same PHY as target port number.
> 
> Adjust 'ice_get_lane_number' function to provide unique port number for
> ports from PHY1 in 'dual' mode config (by adding fixed offset for PHY1
> ports). Cache this value in ice_hw struct.
> 
> Introduce ice_get_primary_hw wrapper to get access to timesync register
> not available from second NAC.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


