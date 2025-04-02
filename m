Return-Path: <netdev+bounces-178753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1DAA78B89
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D14F7A1B27
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB423496B;
	Wed,  2 Apr 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNSrXIJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A818D
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587427; cv=none; b=T1HxDNTsHWkr6yYd6WEYTkI2aRo3mE9QC7mngP2/FJLKim80fE7r4wQEKoGdtplGFvYbQa5qBiYrm8DZ5rCAgIZiokCSMREuTTbLyiYQbOUUjzRoPCrd19rMYqUzwmID1bhsJhpzqBW1+LwyVbyEX1X2TIKoSy66tJp3GWgvc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587427; c=relaxed/simple;
	bh=WjJTs6P3ilpPrUnWgbRh9qL9J5SqsxBe+zQ0ZZJnU7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDP36hExDznXM/BOw6sqYyfHOM3PUs5le502vYsUgjhZ+bX5IVEsd4byxVi4f59zZDlAJAcDwQVJQSRugcSJLSa/XgJca9USHv7CRGcVVUPZcSA9V+Jn1k+tevT+/CMGZSlw7OfJs9txf4Tcp+gn/pOr38y/irE5E/km5mSpUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNSrXIJ7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743587425; x=1775123425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WjJTs6P3ilpPrUnWgbRh9qL9J5SqsxBe+zQ0ZZJnU7w=;
  b=aNSrXIJ7EzO877gzVOovevDZOaXcJEzB3VZTuOAt5iy3nuzShEWs8Cfl
   i12UJG7TRZ+kqAMdqTMbZcVg/x34WSbJgvhj03JcSe4/eb+dhjjYgq+g8
   jb8owQqtylOqiDDoNZBDSx0idrT7kJbLnRUDXnwd/G+xmBFvzGaX1SqTF
   qwm38OGpsTpTGQqYBuJ4edGKLEIT41HMCbey6B1MKfEdhEPbuM/xvcCqD
   kWWpdFXVGRFy8CixTsCHhMSHTLrLN47u0JgWhzsHjbiy3gIRnXmfvKTu0
   uFMW84tBqX6Ascbpa572Zy7mE0ssVpUwaHC6pYaYmEB1KJy30WqRjRWOe
   Q==;
X-CSE-ConnectionGUID: B5qbNXgKRseu79OLZj0RbA==
X-CSE-MsgGUID: hQQfpkUOTI2GZRDo6My6Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44836986"
X-IronPort-AV: E=Sophos;i="6.14,181,1736841600"; 
   d="scan'208";a="44836986"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 02:50:25 -0700
X-CSE-ConnectionGUID: R1O/c36IRqWiGrGVwnBIDg==
X-CSE-MsgGUID: 0wbVn0ZjRbueDKs7qR9YCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,181,1736841600"; 
   d="scan'208";a="131777729"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 02:50:22 -0700
Date: Wed, 2 Apr 2025 11:50:12 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: Re: [PATCH net] sfc: fix NULL dereferences in
 ef100_process_design_param()
Message-ID: <Z+0ITvrUaZSfdehU@mev-dev.igk.intel.com>
References: <20250401225439.2401047-1-edward.cree@amd.com>
 <Z+zITLJ4wB2Mhk8h@mev-dev.igk.intel.com>
 <98a26384-5d6f-d5d2-3ecc-1914a74299eb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98a26384-5d6f-d5d2-3ecc-1914a74299eb@gmail.com>

On Wed, Apr 02, 2025 at 09:15:02AM +0100, Edward Cree wrote:
> On 02/04/2025 06:17, Michal Swiatkowski wrote:
> > On Tue, Apr 01, 2025 at 11:54:39PM +0100, edward.cree@amd.com wrote:
> >> -	netif_set_tso_max_segs(net_dev,
> >> -			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
> >> +	nic_data = efx->nic_data;
> >> +	netif_set_tso_max_size(efx->net_dev, nic_data->tso_max_payload_len);
> >> +	netif_set_tso_max_segs(efx->net_dev, nic_data->tso_max_payload_num_segs);
> > 
> > Is it fine to drop default value for max segs? Previously if somehow
> > this value wasn't read from HW it was set to default, now it will be 0.
> > 
> > At the beggining of ef100_probe_main() default values for nic_data are
> > set. Maybe it is worth to set also this default for max segs?
> 
> As I read it, ef100_probe_main() does set a default for this nic_data
>  field along with the others, and sets it to exactly this same value.
> 

Sorry, right, I somehow missed it.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> confused,
> -ed

