Return-Path: <netdev+bounces-108417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94773923BE7
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A638B2185B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0315A87B;
	Tue,  2 Jul 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spfFKAtC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB701598EC
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917779; cv=none; b=F8KPBPzfbgUXOxrlV4vOkPaphVDQYCgI85rWfGLqedJu+q5UuC8UY+nLe7FeLk1lcSw1U0OsiS/T1P+uXfGi6lCSMi4BktatqdiaiarpxMfMyZahoBx+MROYAy46GBlLzQzlDCjACs7QE1gaHm2ip+2Uzw+ATjYmb7SUgLf6EM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917779; c=relaxed/simple;
	bh=3HWPW4vPXtwFBCCKdoVdqDwSDXV+HUOoD02Bw61tsic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRfpsw0+V5cBy2muCY4+Ha8PPpa+3/rRX5nwhwZMpOE03nQ9c6R1TyLR0W5dTczRzOLPqvwSSXuvqnV19z1oelZL18C3BKWf7B9tw3ZzwB+RrCEDlePd45X4kAI0Lobx/LmGp2Yi5e/9TZNyoFgjip5/0qFY7MJZU/A5OyptE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spfFKAtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D97C4AF0D;
	Tue,  2 Jul 2024 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719917778;
	bh=3HWPW4vPXtwFBCCKdoVdqDwSDXV+HUOoD02Bw61tsic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spfFKAtCzZyVpghMCJY9Cl0L9En1tN9pGF8EjJ174fGu+no1d4gZazdxc7MqSvSNT
	 srghKK5oELxV+wF2u5xluplckmrzYTp9Cu+UsIcVlYdkv7rZCZdVRKyapkXGQV7fB8
	 HK9ZrD7nzLOgLqbinf90PJJkSD50D+1cEr5ixvSNpVaNxyJ6Uf6KCAurNSpAUZhAzW
	 oEYQTbJ2YUv2QU4ou8RKa2ibMFlf1MzPkyH13LxxWWpJ++8Y89XvUyT94/pw655OzM
	 vwjpsU9ulBVJWTRymW6zwFcMN8c6faHiNWkzv/Zh0RhFNS0UfQLxNKIrXeHx9NBdAy
	 /aXvk8YuTULaQ==
Date: Tue, 2 Jul 2024 11:56:15 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next 7/7] ice: Enable 1PPS out from CGU for E825C
 products
Message-ID: <20240702105615.GG598357@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-16-karol.kolacinski@intel.com>
 <20240701132744.GD17134@kernel.org>
 <815f7f5c-6d98-4be2-8fc7-09851fe281d0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815f7f5c-6d98-4be2-8fc7-09851fe281d0@intel.com>

On Mon, Jul 01, 2024 at 05:08:09PM +0200, Przemek Kitszel wrote:
> On 7/1/24 15:27, Simon Horman wrote:
> > On Thu, Jun 27, 2024 at 05:09:31PM +0200, Karol Kolacinski wrote:
> > > From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> > > 
> > > Implement 1PPS signal enabling/disabling in CGU. The amplitude is
> > > always the maximum in this implementation
> > > 
> > > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > > Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> > > Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > index 07ecf2a86742..fa7cf8453b88 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > @@ -661,6 +661,27 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
> > >   	return 0;
> > >   }
> > > +#define ICE_ONE_PPS_OUT_AMP_MAX 3
> > > +
> > > +/**
> > > + * ice_cgu_ena_pps_out - Enable/disable 1PPS output
> > > + * @hw: pointer to the HW struct
> > > + * @ena: Enable/disable 1PPS output
> > 
> > Please include a "Returns: " or "Return: " section in the kernel doc
> > for functions that have a return value.
> 
> last time I have checked only the singular "Return:" was supported (aka
> non-complained) by kdoc checker on W=2 builds

Yes, agreed.

My point was that the kernel document should have a (correct :)
section to document the return value.

> 
> > 
> > NIPA has recently got more picky about this.
> > Flagged by kernel-doc -none --Warn
> > 
> > > + */
> > > +int ice_cgu_ena_pps_out(struct ice_hw *hw, bool ena)
> > > +{
> > > +	union nac_cgu_dword9 dw9;
> > > +	int err;
> > > +
> > > +	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	dw9.one_pps_out_en = ena;
> > > +	dw9.one_pps_out_amp = ena * ICE_ONE_PPS_OUT_AMP_MAX;
> > > +	return ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
> > > +}
> > > +
> > >   /**
> > >    * ice_cfg_cgu_pll_dis_sticky_bits_e82x - disable TS PLL sticky bits
> > >    * @hw: pointer to the HW struct
> > 
> > ...
> > 
> 

