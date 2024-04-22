Return-Path: <netdev+bounces-90237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0572E8AD3FB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297A21C2031B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6613F442;
	Mon, 22 Apr 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so5WSWIf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2F1B977
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810731; cv=none; b=PpxRMnO5lFGVQSnCa+548I0iq9aO/31Wl5NmoPZe+2uikxPqqerw3lBnpoUU1mOrzfBgIoUZbnmQCKODyEC/Pi27regARnTsPOcm+y1hpBMMbyqAY0BLi1QmB1yJV2rrT8jtZsumrOL6p6US7nKhGwlgeOBz3Bd5M7rJi07Fu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810731; c=relaxed/simple;
	bh=kXqg48OQIw7Y2/Rm0Gf0L41p9Mxor/5YuKqrYipPbXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlBmCY0LWVuEZ8bTcSGA1tQDTRCSpbPh+Puq7tvOwdiJS5k4TLD2JyUuXA5Y2Zg4zYPZouxR5LP5rbFlwCtnYJfMfuFlEeN7bCtJR0cl1kdXjbDlvo3J0YqoUGF+ow5Kfw9GNTF5j3ib8X0j+7ReMIwho7qmuh5a1nSa1VY7XnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so5WSWIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596FDC113CC;
	Mon, 22 Apr 2024 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713810731;
	bh=kXqg48OQIw7Y2/Rm0Gf0L41p9Mxor/5YuKqrYipPbXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=so5WSWIfseLg9jSBsYDq8G3T2sxBCeXkKqa3RwnUj8v67Wk4MzcIjJyHR1+heGvWm
	 GSOBe/ttAJqknImtTQ2rN7j7Q4TmkT2YrYSWlDZ+KdlAGLTD53Q6XhVDJ+HO0qgXgo
	 mGx3XcWTI4uRiiqpe0Vb/hljLcXo0cJht9bVOsiW2ZxLiCemiQzPzsluUp4YHQkkqD
	 tGRIh7Nho+pjvj45i7hmi3PzZQhSNrPY9sGCVAoygNN7wV/PACL4Ts3xWyFpwwDC/s
	 cKkPoiUEMGCh+5Yjc0BKhQIhZm/M4CHlJ9/lJ7Mv0qLEKb/oClzAgHa5LAgX0WbNEa
	 +euGn6Ld3w79g==
Date: Mon, 22 Apr 2024 19:32:06 +0100
From: Simon Horman <horms@kernel.org>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Sokolowski, Jan" <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v2 2/5] ixgbe: Add support for E610 device
 capabilities detection
Message-ID: <20240422183206.GE42092@kernel.org>
References: <20240415103435.6674-1-piotr.kwapulinski@intel.com>
 <20240415103435.6674-3-piotr.kwapulinski@intel.com>
 <20240420181826.GA42092@kernel.org>
 <DM6PR11MB461069F903C65507AB64228BF3122@DM6PR11MB4610.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB461069F903C65507AB64228BF3122@DM6PR11MB4610.namprd11.prod.outlook.com>

On Mon, Apr 22, 2024 at 10:41:47AM +0000, Kwapulinski, Piotr wrote:
> >-----Original Message-----
> >From: Simon Horman <horms@kernel.org> 
> >Sent: Saturday, April 20, 2024 8:18 PM
> >To: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> >Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Gomes, Vinicius <vinicius.gomes@intel.com>; Wegrzyn, Stefan <stefan.wegrzyn@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Sokolowski, Jan <jan.sokolowski@intel.com>
> >Subject: Re: [PATCH iwl-next v2 2/5] ixgbe: Add support for E610 device capabilities detection
> >
> >On Mon, Apr 15, 2024 at 12:34:32PM +0200, Piotr Kwapulinski wrote:
> >> Add low level support for E610 device capabilities detection. The 
> >> capabilities are discovered via the Admin Command Interface. Discover 
> >> the following capabilities:
> >> - function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
> >> - device caps: vsi, fdir, 1588
> >> - phy caps
> >> 
> >> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> >> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> >> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> >> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> >> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> >> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> >
> >Hi Pitor,
> >
> >A few minor nits from my side.
> >No need to respin just because of these.
> >
> >> ---
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 517 
> >> ++++++++++++++++++  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  
> >> 11 +
> >>  2 files changed, 528 insertions(+)
> >> 
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c 
> >> b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >
> >...
> >
> >> +/**
> >> + * ixgbe_get_num_per_func - determine number of resources per PF
> >> + * @hw: pointer to the HW structure
> >> + * @max: value to be evenly split between each PF
> >> + *
> >> + * Determine the number of valid functions by going through the 
> >> +bitmap returned
> >> + * from parsing capabilities and use this to calculate the number of 
> >> +resources
> >> + * per PF based on the max value passed in.
> >> + *
> >> + * Return: the number of resources per PF or 0, if no PH are available.
> >> + */
> >> +static u32 ixgbe_get_num_per_func(struct ixgbe_hw *hw, u32 max) {
> >> +	const u32 IXGBE_CAPS_VALID_FUNCS_M = 0xFF;
> >
> >nit: Maybe this could simply be a #define?
> Hello,
> will do
> 
> >
> >> +	u8 funcs = hweight8(hw->dev_caps.common_cap.valid_functions &
> >> +			    IXGBE_CAPS_VALID_FUNCS_M);
> >
> >nit: Please consider using reverse xmas tree order - longest line to shortest -
> >     for local variables in new Networking code
> Will do
> 
> >
> >> +
> >> +	return funcs ? (max / funcs) : 0;
> >> +}
> >
> >...
> >
> >> +/**
> >> + * ixgbe_aci_disable_rxen - disable RX
> >> + * @hw: pointer to the HW struct
> >> + *
> >> + * Request a safe disable of Receive Enable using ACI command (0x000C).
> >> + *
> >> + * Return: the exit code of the operation.
> >> + */
> >> +int ixgbe_aci_disable_rxen(struct ixgbe_hw *hw) {
> >> +	struct ixgbe_aci_cmd_disable_rxen *cmd;
> >> +	struct ixgbe_aci_desc desc;
> >> +
> >> +	cmd = &desc.params.disable_rxen;
> >> +
> >> +	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_disable_rxen);
> >> +
> >> +	cmd->lport_num = (u8)hw->bus.func;
> >
> >nit: This cast seems unnecessary.
> >     AFAICT the type of hw->bus.func is u8.
> Will do

Thanks. FWIIW, I think I noticed a similar cast at least once more
elsewhere in the patchset

> 
> >
> >> +
> >> +	return ixgbe_aci_send_cmd(hw, &desc, NULL, 0); }
> >
> >...
> Thank you for review
> Piotr
> 

