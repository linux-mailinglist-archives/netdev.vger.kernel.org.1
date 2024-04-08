Return-Path: <netdev+bounces-85692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117FA89BDC6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FCD1C211F1
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947162172;
	Mon,  8 Apr 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mATPhNr5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599773FB81
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574549; cv=none; b=ikHi6Wf4fLz/M5QFIPtmXd1dR5SjUxYi1uc5KE14KMa/20xDWBuGu4MgraCo96I+ssV6KrCAdIxDgqeb8PO9Bk12KebvvkrxJqkPMPktoDDqKqs7r9xsupHd4ITuCdNQEat3CWw4WRyNTSUqYZEOkcmIArL1uhcW/RLMba6Z9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574549; c=relaxed/simple;
	bh=Qrx7AC75fkFqhCWgk6xvyRH1fhe0rjGaPHX3ATYIAWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy12zJORXhcRaKqHtId/aygPFqWahP8urQ6duNp+SA8WBFMynDJ3ceAqWfzXZI20zZiBQP7ykzmv/29dqfcmG6Qdbk02nnVbNY2OPVr6l4WmHXlU133MSyfDor/mv7Z8C2ImroQKh1DmYLywiXO1XntwTgHlrDha7IGeku6e8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mATPhNr5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712574547; x=1744110547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qrx7AC75fkFqhCWgk6xvyRH1fhe0rjGaPHX3ATYIAWk=;
  b=mATPhNr5suXSvEfP5hVBsl4LpsbJ0I+6Wa27IcWJWMU//mPSTesmlmzj
   KbV7CMRl3/PYLYTrQXGvAmRPxcc1EZjzH6rW0m2nGj1KDjYeHAvz1/1IA
   KZu2MbsHaHfFLgIvTOSWFXubquOBJr8SbM6/A+YXHa4LqkkMjqDp+eLTe
   F3fau5W9xJTFkLHeHxigDecP5i3UldtXcRAfC/RPAXhCxrlmG5FzuQTfe
   kdBUSBRnV7xmCSKBciGPmy/slmLsyU987iwTV+X9T5dnbp3fDfsCxk3t1
   mwu00/IL/SW5hznPEwDu0o1YqCMEkwLB868KAD3viOxwtQJaeD3eOKXpQ
   Q==;
X-CSE-ConnectionGUID: kh1V4LYVTDOmn8HWsuwZFQ==
X-CSE-MsgGUID: rHKdcHtaTy6x0D1vFSHYWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8069715"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="8069715"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 04:09:06 -0700
X-CSE-ConnectionGUID: vvDzA0l2SXuBL9ywvEUNWg==
X-CSE-MsgGUID: MkO9eEJKQlCzGaz7BJrtKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24317336"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 04:09:04 -0700
Date: Mon, 8 Apr 2024 13:08:50 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [net-next v2] pfcp: avoid copy warning by simplifing code
Message-ID: <ZhPQQkhRQQ4h3KVl@mev-dev>
References: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>
 <20240408081829.GC26556@kernel.org>
 <ZhPLEuZQ0T7mQHHT@mev-dev>
 <2bcb7a6c-27b6-4929-ac9c-c6eba3b804b1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bcb7a6c-27b6-4929-ac9c-c6eba3b804b1@intel.com>

On Mon, Apr 08, 2024 at 12:50:48PM +0200, Alexander Lobakin wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Date: Mon, 8 Apr 2024 12:46:42 +0200
> 
> > On Mon, Apr 08, 2024 at 09:18:29AM +0100, Simon Horman wrote:
> >> On Fri, Apr 05, 2024 at 08:36:05AM +0200, Michal Swiatkowski wrote:
> >>> >From Arnd comments:
> >>> "The memcpy() in the ip_tunnel_info_opts_set() causes
> >>> a string.h fortification warning, with at least gcc-13:
> >>>
> >>>     In function 'fortify_memcpy_chk',
> >>>         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
> >>>         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
> >>>     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >>>       553 |                         __write_overflow_field(p_size_field, size);"
> >>>
> >>> It is a false-positivie caused by ambiguity of the union.
> >>>
> >>> However, as Arnd noticed, copying here is unescessary. The code can be
> >>> simplified to avoid calling ip_tunnel_info_opts_set(), which is doing
> >>> copying, setting flags and options_len.
> >>>
> >>> Set correct flags and options_len directly on tun_info.
> >>>
> >>> Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
> >>> Reported-by: Arnd Bergmann <arnd@arndb.de>
> >>> Closes: https://lore.kernel.org/netdev/701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com/
> >>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >>
> >> I agree that it's nice to avoid a copy.
> >> But I do wonder where else this pattern may exist.
> >> And if it might be worth introducing a helper for it.
> > 
> > Right, the same is done in vxlan, ip_gre and ip6_gre at least. I will
> > send v3 with helper.
> 
> Dave applied v2 already, so send this helper as a general improvement
> w/o "Fixes:" :D
>

I missed that, thanks :) . So, I will send new patch.

> > 
> > Thanks,
> > Michal
> > 
> >>
> >> Regardless, this looks good to me.
> >>
> >> Reviewed-by: Simon Horman <horms@kernel.org>
> >>
> >> ...
> 
> Thanks,
> Olek

