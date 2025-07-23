Return-Path: <netdev+bounces-209201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5212B0E9D4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF4D9607B1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1721ADA2;
	Wed, 23 Jul 2025 04:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDwsdq71"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25F21B9C9
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246199; cv=none; b=TVH4Oz8kombsDQlZn9FaK4w6h3RbEoT05QkMDrnVmVm9W1T3f8TQULi6DSAQoXCGnf2zirQ1bFy6IhZdu08l834CZvq2tv+d95EqpGnqfjcVDjcj/JcaPkmvgQplMssHbf+ACRO3nm8c1m4mU4niCmKCAAPdlqY0EwxNcNa8Z7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246199; c=relaxed/simple;
	bh=1+i5fwHsssFH8fer9hR+N6BmV3M+1an/8DwXt1LUWZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooG2N1EjPkyA6CZCx5vNu1nW5imTdz0Ojtr5FIzkR+p4lrwEPe1bEkM4wqyv/jsW29/Yx1IGMT/OiTer6cogu42nUBmZ6JYB2rfHGB6qhI22oIJh2Shppuk9Ravd/NVnbR2ZmzJOxtxWXO7pFqbrU6zGu6MsY7nSmlVCM26zqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDwsdq71; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753246198; x=1784782198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+i5fwHsssFH8fer9hR+N6BmV3M+1an/8DwXt1LUWZ4=;
  b=XDwsdq71cLlO2GSU6i6iqbGZZyuyed7zuNaLK6z7hju+zFE93FaguKRK
   XiFRNXS2OQAcD3oBbYmJrBL5QAcLKNfz45vrgoAUtbafRtEWdFQkNbwJw
   qSUh5oYUrXEgoUiJF+IBD0ivcHRJI964RmBfTVu8L7251lL6bpt8OEHkR
   dRivxCnEPka3zkeffzXfUHlvK8+WPDe0V+hWVH2AAaC02uC6UDuDDBQve
   LmpZD6XNR5sVI6jHAghxEGuaaov7Y2hwjXHwxmksHxbBnqa/ObB0X7ud9
   PdhSLIiyg18VuZXwuBzSL1t7vBcpppIiB5Z1yZGg1yalTcbEW22gr4A9X
   w==;
X-CSE-ConnectionGUID: /QJJ/5W8RWuQhwmD2gNZLg==
X-CSE-MsgGUID: Cq7ez+MBSr+v3X/Lm4gHqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55455935"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55455935"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 21:49:57 -0700
X-CSE-ConnectionGUID: HYkRLkIRT0ObbXeX4vJvig==
X-CSE-MsgGUID: XUU0kdGGQd2s737DBzYrvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163561384"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 21:49:56 -0700
Date: Wed, 23 Jul 2025 06:48:51 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"dawid.osuchowski@linux.intel.com" <dawid.osuchowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 02/15] ice: move
 get_fwlog_data() to fwlog file
Message-ID: <aIBps1pWsmrZhoDu@mev-dev.igk.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
 <20250722104600.10141-3-michal.swiatkowski@linux.intel.com>
 <IA3PR11MB8986DF9CBA9DD7D092D11D14E55CA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986DF9CBA9DD7D092D11D14E55CA@IA3PR11MB8986.namprd11.prod.outlook.com>

On Tue, Jul 22, 2025 at 12:02:52PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Michal Swiatkowski
> > Sent: Tuesday, July 22, 2025 12:46 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; dawid.osuchowski@linux.intel.com;
> > Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v1 02/15] ice: move
> > get_fwlog_data() to fwlog file
> > 
> > Change the function prototype to receive hw structure instead of pf to
> > simplify the call. Instead of passing whole event pass only msg_buf
> > pointer and length.
> > 
> > Make ice_fwlog_ring_full() static as it isn't  called from any other
> > context.
> > 
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_fwlog.c | 27 +++++++++++++++++++-
> > drivers/net/ethernet/intel/ice/ice_fwlog.h |  2 +-
> > drivers/net/ethernet/intel/ice/ice_main.c  | 29 ++--------------------
> >  3 files changed, 29 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c
> > b/drivers/net/ethernet/intel/ice/ice_fwlog.c
> > index e48856206648..ea5d6d2d3f30 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
> > @@ -6,7 +6,7 @@
> >  #include "ice_common.h"
> >  #include "ice_fwlog.h"
> > 
> > -bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
> > +static bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
> >  {
> >  	u16 head, tail;
> > 
> Can you consider adding kernel-doc for ice_fwlog_ring_full()?
> 

I will add it.

