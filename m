Return-Path: <netdev+bounces-171645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25456A4DF89
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A13B27F2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF2204C06;
	Tue,  4 Mar 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+2clm/y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919120485F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095839; cv=none; b=Xj5RLA4OUK9K5HshQKrU1NGWDs4mwKYFe7/SSRnsggZI6nqwGilwch1nsviVnqyELBlxwxVWL2dacv6Pa9WTTzTAPmiYYG4pc+Aj8JmVrjW8Nek2XsAXKjTDfC2vh3L9Kh4UVKsdbzhYA2UqsqoBazhmL7GZxdpLrlt6RDMQc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095839; c=relaxed/simple;
	bh=Z48O4Ncn2q7sweBP3Xxjj1MjYgx8ELkD/BGWzigQLYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvcJCtq/fIQ+I4QS5ncj1yD7PwUWlQl+nCuZh3ZXVvFUvhM39RCUGyoLCNBxSJzs+sQFpO+hrmPKSNPFCA0hkBOt1L9XuVxmowLoNlILZ4p/1UwfKlGUKD8J7IBtfXV+P3Fio8vlRXJIZIdWeAdOzEHMwep6eMyfaVY/YQfVeOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+2clm/y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741095838; x=1772631838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z48O4Ncn2q7sweBP3Xxjj1MjYgx8ELkD/BGWzigQLYQ=;
  b=J+2clm/y8GxZh0fshVpZGBsD218ebUmIq9gXgt4HyIxi/nI2XXHRgNvh
   mOQ4pIeot5Yi9jdkpUUliLY91/bTHw/p2cUvk9kKnOgQvkwilQJ7goRg6
   D8TbFQBdNdK9WxeSLeOL7c5WotvRajj5oVw0QaBL8bv4Fh47wTWxhanq5
   5I2jx61/WIw8t3+y8oRSkqWzAwlR7TnKrcD18+Rz1gDQpXjBzYotHljGM
   yuJ/RyJ9RvGwdsbUSrPXQhxcITLkNJZj28yOZpVUbGGwK/vmPbareaqVw
   5Q+Z1p8S/OePlMPiV4wIBoB5wd/SHlFGEfpxi4omB59keF+1yu7l7z4LU
   w==;
X-CSE-ConnectionGUID: A3OxCks0TXKaj0uQ/oII3Q==
X-CSE-MsgGUID: Uh/lm4J7QhmgXsbD9y5kLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67381864"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="67381864"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:43:57 -0800
X-CSE-ConnectionGUID: CfxVbsHYRjW0yR9GOYg7LA==
X-CSE-MsgGUID: XN0cNXYxQe6Luv4E1FQgyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="149163549"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.99.188]) ([10.245.99.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:43:54 -0800
Message-ID: <b5e34397-0b81-4132-86d0-498a111cc363@linux.intel.com>
Date: Tue, 4 Mar 2025 14:43:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor the Tx
 scheduler feature
To: Simon Horman <horms@kernel.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250226113409.446325-1-mateusz.polchlopek@intel.com>
 <20250303095405.GQ1615191@kernel.org>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250303095405.GQ1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/2025 10:54 AM, Simon Horman wrote:
> On Wed, Feb 26, 2025 at 12:33:56PM +0100, Mateusz Polchlopek wrote:
>> Embed ice_get_tx_topo_user_sel() inside the only caller:
>> ice_devlink_tx_sched_layers_get().
>> Instead of jump from the wrapper to the function that does "get" operation
>> it does "get" itself.
>>
>> Remove unnecessary comment and make usage of str_enabled_disabled()
>> in ice_init_tx_topology().
> 
> Hi Mateusz,
> 
> These changes seem reasonable to me.
> But I wonder if they could be motivated in the commit message.
> 
> What I mean is, the commit message explains what has been done.
> But I think it should explain why it has been done.

Hi Simon,

I'm replying on behalf of Mateusz since he's on leave, and we didn't 
want to keep this issue waiting too long.
Would such extended commit message make sense and address your concerns?

"Simplify the code by eliminating an unnecessary wrapper function. 
Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper 
around ice_get_tx_topo_user_sel(), adding no real value but increasing 
code complexity. Since both functions were only used once, the wrapper 
was redundant and contributed approximately 20 lines of unnecessary 
code. By directly calling ice_get_tx_topo_user_sel(), improve 
readability and reduce function jumps, without altering functionality.
Also remove unnecessary comment and make usage of str_enabled_disabled() 
in ice_init_tx_topology()."

Thank you,
Martyna

> 
>> Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> ...
> 


