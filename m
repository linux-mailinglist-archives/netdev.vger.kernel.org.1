Return-Path: <netdev+bounces-242388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B2C9001E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5515934E431
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23C30170E;
	Thu, 27 Nov 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkU6fxxq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB52DA75A;
	Thu, 27 Nov 2025 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271588; cv=none; b=U7GCwQ9D7zcFQ/tujjG4zZ6njclysHVpRpHJpkox63KX6CG+Sp+NmjA4NPyRqYm94EsV43q+dRluoYEhLoNJ0ukeT+vyHVaeDXbFrTn01pNSumM8k4zCyOw6brY3tRttHnq5kwkHy+2exo8k+BdjymlKHjD8rLY8/Xw0z3Xtz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271588; c=relaxed/simple;
	bh=GDxV4JLX59KLCi3WzT+HD4t6CnQ5J/u0qluMQ692J8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Txeq8YPoXoty43jMsGudUTLEVBOfUoxXnK4dzsvvom5jt8QRpgc5U+L7Cae6ZCdJNmXuSMcs3sc+GYz9zpmHYvG75rOqB+FdLnlSW2gxDxm7gMkzQKgAD+gxMqLTAmjw0ggtH3XLBjv/D2+uhw1qmZUDM3NSJqRoNf+nU9hhqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkU6fxxq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764271585; x=1795807585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GDxV4JLX59KLCi3WzT+HD4t6CnQ5J/u0qluMQ692J8s=;
  b=CkU6fxxqFH88O4IuSC8YckF8oWJ23E46kbLSD62Zx7kyHV4t4TYjtRrH
   KSrhmAZNgTpU9akrsATSR9pDNd0jm4T8U4tPBEOXl0tskzcjDurtROOWX
   Jg7h+VrhDQqCq/1euDbVuPvZbHZQcH/TNwMust+hyVHQmJ74HE2Kwc5Ts
   hkYltRRqxBZzKeHrU9Je2AVIWYqZbyaBDmbCWuXIt66OgYcHghINFq27O
   OyBU/KScP06WUT2qDl7Olr3iijBxTEmint9nKMoRhggE7pXYg9++Fnr/9
   K41M1wveAP5dj7M8DetEL1ryN/uj1w2kZ/zn2znCxzn5Ku7pCmReRh8pF
   A==;
X-CSE-ConnectionGUID: C8wHPhvGQiadkSR7aA9Zpw==
X-CSE-MsgGUID: Wb6l/WmmQt+5Dn/yJWQL7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="53887111"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="53887111"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:26:24 -0800
X-CSE-ConnectionGUID: 8nYqyqA6SBCpddRvcqaKKA==
X-CSE-MsgGUID: w1OVQSjrTfmQLLPqjN82MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="216649070"
Received: from troymavx-mobl.gar.corp.intel.com (HELO [10.94.251.92]) ([10.94.251.92])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:26:21 -0800
Message-ID: <ee934ba9-8ed8-4938-8058-ac80d88dafc9@linux.intel.com>
Date: Thu, 27 Nov 2025 20:26:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] igc: fix race condition in
 TX timestamp read for register 0
To: Chwee-Lin Choong <chwee.lin.choong@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Avi Shalev <avi.shalev@intel.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>
References: <20251127151137.2883-1-chwee.lin.choong@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20251127151137.2883-1-chwee.lin.choong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-11-27 4:11 PM, Chwee-Lin Choong wrote:
> The current HW bug workaround checks the TXTT_0 ready bit first,
> then reads TXSTMPL_0 twice (before and after reading TXSTMPH_0)
> to detect whether a new timestamp was captured by timestamp
> register 0 during the workaround.
> 
> This sequence has a race: if a new timestamp is captured after
> checking the TXTT_0 bit but before the first TXSTMPL_0 read, the
> detection fails because both the “old” and “new” values come from
> the same timestamp.
> 
> Fix by reading TXSTMPL_0 first to establish a baseline, then
> checking the TXTT_0 bit. This ensures any timestamp captured
> during the race window will be detected.
> 
> Old sequence:
>    1. Check TXTT_0 ready bit
>    2. Read TXSTMPL_0 (baseline)
>    3. Read TXSTMPH_0 (interrupt workaround)
>    4. Read TXSTMPL_0 (detect changes vs baseline)
> 
> New sequence:
>    1. Read TXSTMPL_0 (baseline)
>    2. Check TXTT_0 ready bit
>    3. Read TXSTMPH_0 (interrupt workaround)
>    4. Read TXSTMPL_0 (detect changes vs baseline)
> 
> Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing timestamps")
> Suggested-by: Avi Shalev <avi.shalev@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...

> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>

I don't understand the double sign-off here. Did Song Yoong Siang 
co-develop this fix or you are upstreaming a change they made somewhere 
else?

Please take a look at the documentation [1] regarding signing your work, 
especially the use of Co-developed-by tags in case there were multiple 
authors and/or proper From tag if you are submitting on someone's behalf.

[1] 
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Best regards,
Dawid



