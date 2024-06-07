Return-Path: <netdev+bounces-101632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B28FFB43
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2ACB20C8B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298071805A;
	Fri,  7 Jun 2024 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI6an56l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FED2FE
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717737283; cv=none; b=O9IKXNWeUXzR3iT0w4/5l1PPGHWkGKB9obLWLIbSCAnok8blhWrLpob12v04vhBChr7ytFZm2w8InO4KHfla84X96gbOSBuoQtB/BAbJJMXU+tIcQxgkPcoBQ0zH31/Buca/PHtmi9grT2h16fEabq2d1but3z4pInFzv2Gqzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717737283; c=relaxed/simple;
	bh=7dsnqu5WBjDXEHpQeOxCbfOHKp1uGn5VAqYXbWQdcY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx1Bl2S7Ps1ItCCporzfE0Y+Ed6sxtV3oK88a+alRGMSIBWNlsWzZ+UPfJ31YJcu5KGo0GO1R8ga+iNr7MviT5ly2cKHhPaU7Xs02fTyPNlz24CJuLxtUof+CdfWUKiiZtwQbg2H9ZHLajrT71KGsHQnlvy0s3jYjHkePwe8fKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jI6an56l; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717737282; x=1749273282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7dsnqu5WBjDXEHpQeOxCbfOHKp1uGn5VAqYXbWQdcY4=;
  b=jI6an56l1/pckd91DaaaD9CgrduXIKwIpT9q3sArZeVlJrYvQHWotpaX
   WYvqMJOLPTjNJRXsQEiC2hg6I+99pV4G5H3L3TbMuG+zBfZjjCXjXtDnZ
   fRGDUDaB0E+kWRYtmomAZK2QKmWKwYmr9lEe7VmfzT9TcVy4BmA4RjwVX
   kkAmZ80duSjHozr5rI6Trvqxh5OIebhVp4efV8A73P79BdVciFhdOGNaF
   s/4JbG24hTh/sUjejAD+uc5+8cdlrQvB98rIoclnxG/c9hvc6AdPly8Gm
   ZD0LvIeMj08AWVNOp/SGx0nguUVlPY67W3uz7YaKpqh73j5wAbnOp9TUh
   Q==;
X-CSE-ConnectionGUID: b36FgkOnRWW4XN5a6dFQIA==
X-CSE-MsgGUID: EOpKFUHTSO6NKFqgM72HGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="39843786"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="39843786"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 22:14:40 -0700
X-CSE-ConnectionGUID: WkZm+pEUQrmb2McagBV7BQ==
X-CSE-MsgGUID: 5H5dFRUYSfq8NHu+jFB/yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="42775471"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 22:14:39 -0700
Date: Fri, 7 Jun 2024 07:13:47 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v2 2/7] ice: store representor ID in bridge port
Message-ID: <ZmKXCzNNjLO/NKPe@mev-dev>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
 <20240605-next-2024-06-03-intel-next-batch-v2-2-39c23963fa78@intel.com>
 <20240606175024.1274d1a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606175024.1274d1a8@kernel.org>

On Thu, Jun 06, 2024 at 05:50:24PM -0700, Jakub Kicinski wrote:
> On Wed, 05 Jun 2024 13:40:42 -0700 Jacob Keller wrote:
> > -struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi)
> 
> You need to delete it from the header, too:
> 
> drivers/net/ethernet/intel/ice/ice_repr.h:struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi);

Yeah, my fault, thanks for finding it.

Thanks,
Michal

