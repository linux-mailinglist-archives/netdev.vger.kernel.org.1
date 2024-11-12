Return-Path: <netdev+bounces-144005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C29C515C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DDF282DF4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C320A5FA;
	Tue, 12 Nov 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsKXuoI1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BC20B1FD
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402093; cv=none; b=B+uuJTYyaJIzofx1IYZ7KbMV9CGa8sn0ZDr1bRZe6jMA4BvU2L77WHHdHH8b4WuzHOsicwhge324HKsLbB0NPHXLWdcop7t9kdnGYbT67UizLXe2rcYHwfr+iTqsWD7KiIIOVClK7mqcusejFFxY4OGmzOAGtD1x8sAHBYnJ6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402093; c=relaxed/simple;
	bh=J4YLsSb0ADwVaiqdgi3gHn5573IyKZUBPT1DevJVQzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSLNJmhKjvAGvLRBRxAOEtQA6MRWvv2/YgWt29v7YHhO/VrsSd/xOceRB6sIBIGY01wO1VocnZfN7RvRGvs2vlawTQ9SI1e03pSWhx8ZTKb52S4ru8BiAkqKJWRPuDgtrarbix9KGsuaFcJAxYLi3E/z/V4zRAMewTlaUWxFWh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsKXuoI1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731402092; x=1762938092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J4YLsSb0ADwVaiqdgi3gHn5573IyKZUBPT1DevJVQzk=;
  b=LsKXuoI1C1Mu7vnokLk/CziM86kV6FzpQ2Uh8dvPG0iwCbvAsbgaFKcA
   IO6/jSvasK8dmflL4Ga50+/eyqZw2kBnxVSq6k+1Yb3kabpJji0mLUAji
   b0sgvPW1c/yz6qobpNMXPt6OQ+V8mOddCmGTJaIQsuZsxrcTaqI4EuJIK
   Rta4/DsUIuydLR+WdInx9eCSEFZhm+68iKSYwBeO+z9xckF9Xe79xTJzI
   FGVqKTdJO9s0HFCh+dcHhyhV3f9CMb24D/DmRGsxyPjnu3RIHlO/WZ3hT
   jbvNNnahxGsx5uAo6KFpPyWjyRi5FI/2Ej9kRt55voSBPOmTQNDzc7wji
   g==;
X-CSE-ConnectionGUID: +Z37rsq7QK+CMa/yVjgDKg==
X-CSE-MsgGUID: D5eb+1hOSRa9Kc5EnzMEYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31318151"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="31318151"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:01:03 -0800
X-CSE-ConnectionGUID: e6kJCa25TRuj03V01nh0DA==
X-CSE-MsgGUID: ojG1P6OdTSyzEGAAibmwaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="118291844"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:00:59 -0800
Date: Tue, 12 Nov 2024 09:58:18 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
	David.Laight@aculab.com, pmenzel@molgen.mpg.de
Subject: Re: [iwl-next v7 2/9] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZzMYqp8A59lfnLa9@mev-dev.igk.intel.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
 <20241104121337.129287-3-michal.swiatkowski@linux.intel.com>
 <CADEbmW2=9s8iGJibWpPnVUraMOr7ecE6Hbpb1n3d9es-aUvA7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW2=9s8iGJibWpPnVUraMOr7ecE6Hbpb1n3d9es-aUvA7Q@mail.gmail.com>

On Mon, Nov 11, 2024 at 12:44:11PM +0100, Michal Schmidt wrote:
> On Mon, Nov 4, 2024 at 1:13 PM Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com> wrote:
> >
> > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> > range.
> >
> > Add notes about this parameters into ice devlink documentation.
> >
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  Documentation/networking/devlink/ice.rst      | 11 +++
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
> >  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
> >  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
> >  4 files changed, 107 insertions(+), 1 deletion(-)
> >
> [...]
> > @@ -1648,6 +1710,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
> >  int ice_devlink_register_params(struct ice_pf *pf)
> >  {
> >         struct devlink *devlink = priv_to_devlink(pf);
> > +       union devlink_param_value value;
> >         struct ice_hw *hw = &pf->hw;
> >         int status;
> >
> > @@ -1656,11 +1719,27 @@ int ice_devlink_register_params(struct ice_pf *pf)
> >         if (status)
> >                 return status;
> >
> > +       status = devl_params_register(devlink, ice_dvl_msix_params,
> > +                                     ARRAY_SIZE(ice_dvl_msix_params));
> > +       if (status)
> > +               return status;
> > +
> >         if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> >                 status = devl_params_register(devlink, ice_dvl_sched_params,
> >                                               ARRAY_SIZE(ice_dvl_sched_params));
> > +       if (status)
> > +               return status;
> 
> Error handling looks wrong in this function.
> You have to unwind the registration of the params from above or they will leak.
> Sorry I did not notice this earlier.
> 

Right, I  will send fixed version.
Thanks for reviewing,
Michal

> Michal
> 

