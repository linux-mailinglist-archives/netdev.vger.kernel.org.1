Return-Path: <netdev+bounces-89250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDE8A9D82
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A279B1F2363C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18C161933;
	Thu, 18 Apr 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mf+oQqNy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F66FB0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451677; cv=none; b=OMopGBY0keKyoANq7Y1i/TyvNyimjVSVbb1u0TnH0BklEXgdCJnunb1yz63icb0hep/GUZRxY6/mAP2Kz+O5SWLx/GRKTfOc8rFdeF/9wQOZJIKnobzeTeuTBTVnIpEQHBWJptsqRvUXYm52b+qiuMdSVfEyhDwwoNUQYYcMXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451677; c=relaxed/simple;
	bh=Iu13BzXGDlDt7kkFojoXFutf6qwhY1eUz6UAvbHVCns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKjYYvkDybqKyyuFLfFuU8JAa/GJ6/hI629jg1wOmDY/JVqxMyudRofQUrhTYcgCqWsIYYaExi4jrAoum8ftpZeu2EVWYovdMopQysamA+QexZsNcqqs/wmqz39w6XmZkLkPUf/FWePTtyA47HGTk1wsXDQM5c+TVcGMeQ/mvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mf+oQqNy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713451676; x=1744987676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iu13BzXGDlDt7kkFojoXFutf6qwhY1eUz6UAvbHVCns=;
  b=Mf+oQqNy3zEP2Jp5OkNWSPz3g50zBcHexc3lAzaSXnGdgRrDHSWa60L7
   40GHwXW/pXFxo7gFDLW3gzCWvtQd1xgTP2JC0OpV2EbzGTVGzdzO4ZvNS
   KoOwERY0jRLA0HEOyLKmoSAlcP1kheNAU0favtTgltHwX0b66wiTvqjr7
   rPATwp0bvKTstmbrAS432jmnds6Ehutm/yLSXfnliDZN3QyBxxvoks2LO
   fsukT3YxFJQApCPqswI9qZiKTVe+3IhUswn/3Wqbr/XxBKrV0pphxRKmq
   yszEdHfnvXfY8cOpCXunoCVvf3N7s6B1UctCiqkujbaiiFIWVJkNHfy99
   A==;
X-CSE-ConnectionGUID: XCkYah7NQ3uLS6JLAuxzbQ==
X-CSE-MsgGUID: /SYaTRxiSbCTH1xxNS4Ecw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8870721"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8870721"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:47:55 -0700
X-CSE-ConnectionGUID: 5rTbXyYqQiir3dyJsma7Uw==
X-CSE-MsgGUID: b6mVba5BSiyXIhAdchBy/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27634185"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:47:52 -0700
Date: Thu, 18 Apr 2024 16:47:31 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Shay Drori <shayd@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 6/8] ice: base subfunction aux driver
Message-ID: <ZiEyg0qPac0GzTBN@mev-dev>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-7-michal.swiatkowski@linux.intel.com>
 <88b7e836-657c-4105-80e0-c0c68dffd140@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b7e836-657c-4105-80e0-c0c68dffd140@nvidia.com>

On Thu, Apr 18, 2024 at 10:57:17AM +0300, Shay Drori wrote:
> 
> On 17/04/2024 17:20, Michal Swiatkowski wrote:
> > From: Piotr Raczynski <piotr.raczynski@intel.com>
> > 
> > Implement subfunction driver. It is probe when subfunction port is
> > activated.
> > 
> > VSI is already created. During the probe VSI is being configured.
> > MAC unicast and broadcast filter is added to allow traffic to pass.
> > 
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/Makefile     |   1 +
> >   drivers/net/ethernet/intel/ice/ice_main.c   |  10 ++
> >   drivers/net/ethernet/intel/ice/ice_sf_eth.c | 140 ++++++++++++++++++++
> >   drivers/net/ethernet/intel/ice/ice_sf_eth.h |   9 ++
> >   4 files changed, 160 insertions(+)
> >   create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> 
> 
> <...>
> 
> > +
> > +/**
> > + * ice_sf_driver_register - Register new auxiliary subfunction driver
> > + *
> > + * Return: zero on success or an error code on failure.
> > + */
> > +int ice_sf_driver_register(void)
> > +{
> > +	return auxiliary_driver_register(&ice_sf_driver);
> > +}
> > +
> > +/**
> > + * ice_sf_driver_unregister - Unregister new auxiliary subfunction driver
> > + *
> > + * Return: zero on success or an error code on failure.
> 
> 
> this function doesn't return anything...
> 

Thanks, will remove it.

> > + */
> > +void ice_sf_driver_unregister(void)
> > +{
> > +	auxiliary_driver_unregister(&ice_sf_driver);
> > +}
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> > index a08f8b2bceef..e972c50f96c9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> > @@ -18,4 +18,13 @@ struct ice_sf_priv {
> >   	struct devlink_port devlink_port;
> >   };
> > +static inline struct
> > +ice_sf_dev *ice_adev_to_sf_dev(struct auxiliary_device *adev)
> > +{
> > +	return container_of(adev, struct ice_sf_dev, adev);
> > +}
> > +
> > +int ice_sf_driver_register(void);
> > +void ice_sf_driver_unregister(void);
> > +
> >   #endif /* _ICE_SF_ETH_H_ */

