Return-Path: <netdev+bounces-117778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180A94F271
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BD41C211D2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325501862BD;
	Mon, 12 Aug 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVLIzELR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40F183CD9
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478778; cv=none; b=q+fpUk6pBPpKvGXaYwJptF2Yx/ChrjyoTcRTXRVXs1VElQ8kiePIXt7loS0hfdCBGX2O8NANWegXA7oxCkJgj7ZtvIqQ/wOKEQLqU6PgfNjgcx5Busgaf9ItipK7CkphzWW5OBBGkrqMOtTVN1bblUGH5eLo0sN9hm+ySaqR2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478778; c=relaxed/simple;
	bh=/Ab350HoHqgE9u8nO0zLL/PFFUJ4QZlZBC4befB8k9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdnuAEYf4bpObpoCfzuhV5jo1bv9PrOhRqQZD0U2Ir1YR7XWqZmvLIW2JL96Ow1OXlEENPLSGKCahXOXDdcljDzfaNifSRaNth1/qspJl2v2BZeTVRQ2LQ0WUWeqUv6/jBQnyHMxAKaHPCSqLQDIiFGxUeqKjuKAbxtf5CFjpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVLIzELR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397B0C32782;
	Mon, 12 Aug 2024 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478777;
	bh=/Ab350HoHqgE9u8nO0zLL/PFFUJ4QZlZBC4befB8k9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVLIzELRRH5Sgmyn0keMTDa1tZkv5FwNDz+gQfcBoosbIINjG7PnVmLvG9BWbHkdK
	 I0sArapfmkeaSFBM+BSw0h/IWGgw++SwC4swP2C3UA3O3gM2f4BOJEgNIxL7HpiCNw
	 Mpn+994d7diLxR7+mhPkx3c0ciNzpLel5odzHjL84NG5zNTg8qxgkCXpPtmh1OH7PC
	 eQvG5q5d5x4LWfxMSwQ1je9K/XQ13N/EUT3FVT7qtRBrcDEgvfWqeX4+qcsahx/j6G
	 42Qf3dvpgLhptS+APJyfnvwP4FdUlt8hZTxxFa5pWD7W0N+Gl9a0rpdAaKgdKaTtVj
	 wwgQ/MVhUVJVA==
Date: Mon, 12 Aug 2024 17:06:13 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next v1] i40e: Add Energy Efficient Ethernet ability
 for X710 Base-T/KR/KX cards
Message-ID: <20240812160613.GB44433@kernel.org>
References: <20240808112217.3560733-1-aleksandr.loktionov@intel.com>
 <20240809152549.GB1951@kernel.org>
 <4e3602d2-6c6e-4311-b4fc-b3f8e2ce4da5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3602d2-6c6e-4311-b4fc-b3f8e2ce4da5@intel.com>

On Mon, Aug 12, 2024 at 10:09:37AM +0200, Przemek Kitszel wrote:
> On 8/9/24 17:25, Simon Horman wrote:
> > On Thu, Aug 08, 2024 at 01:22:17PM +0200, Aleksandr Loktionov wrote:
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > > index 1d0d2e5..cd7509f 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > > @@ -5641,50 +5641,77 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
> > >   	return 0;
> > >   }
> > > +static void i40e_eee_capability_to_kedata_supported(__le16  eee_capability_,
> > > +						    unsigned long *supported)
> > > +{
> > > +	const int eee_capability = le16_to_cpu(eee_capability_);
> > 
> > Hi Aleksandr,
> > 
> > Maybe u16 would be an appropriate type for eee_capability.
> > Also, using const seems excessive here.
> > 
> > > +	static const int lut[] = {
> > > +		ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> > > +	};
> > > +
> > > +	linkmode_zero(supported);
> > > +	for (unsigned int i = ARRAY_SIZE(lut); i--; )
> > > +		if (eee_capability & (1 << (i + 1)))
> > 
> > Perhaps:
> > 
> > 		if (eee_capability & BIT(i + 1))
> 
> I would avoid any operations with @i other than using it as index:
> lut[i]. We have link mode bits in the table, why to compute that again?
> 
> > 
> > > +			linkmode_set_bit(lut[i], supported);
> > > +}
> > > +
> > >   static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
> > >   {
> > >   	struct i40e_netdev_priv *np = netdev_priv(netdev);
> > >   	struct i40e_aq_get_phy_abilities_resp phy_cfg;
> > >   	struct i40e_vsi *vsi = np->vsi;
> > >   	struct i40e_pf *pf = vsi->back;
> > >   	struct i40e_hw *hw = &pf->hw;
> > > -	int status = 0;
> > > +	int status;
> > 
> > This change seems unrelated to the subject of this patch.
> > If so, please remove.
> 
> Hmm, it's remotely related, trivial, and makes code better;
> I intentionally said nothing about this during our internal review ;)

Ok, I would vote for it being a separate patch.
But I won't push this one any further.

