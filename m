Return-Path: <netdev+bounces-128752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A684697B6CD
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 04:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D721B24D91
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E074C08;
	Wed, 18 Sep 2024 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxgkEqYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1C3D8E;
	Wed, 18 Sep 2024 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726626457; cv=none; b=iPFqdWvZPFJmJ56Y3VmWIILGRiXi5tWWgZeKC8W7clY72sY1yXxke70K/K7zHGU2fH/wxfD1Unj50z90DgsT8vhm6WihWjskx2qHPnTe9hzq/2IFGkz+EV6sotkyEM2i/+si+ecQ3FTJ55fbrnma3FG0uOJBCtuUi9CgVMcZxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726626457; c=relaxed/simple;
	bh=uS2YFxRvMGKdY4hVYbzDLw3B0Hjyf+pk1jbICas5hRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVIOydGAUJLG0v0EQg0xqxj7kF70KPFCGhmIb7LyUFlP0IVFbZIWxFR33CVUoJEhjEaUH/60TDOs6t69vKV1ute/UtA9xB4JmkImApRP3ngR5YYGGdaKw3f0ddcN72Su1iorGqq8UY5f0Q8zKT+y4kugWnWnbCFrqNYFKzlGzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxgkEqYJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726626456; x=1758162456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uS2YFxRvMGKdY4hVYbzDLw3B0Hjyf+pk1jbICas5hRA=;
  b=RxgkEqYJJz5s+vJWFhWtPXfr/3J3SH5x1jbzCbFB7yFUwgOAw0hD5yx7
   ZtULDonxP9VmmyEtsXydS7Dw8xxXe34m7g36QoFC3Dd6qu0nI5eE+FkOu
   oQErzT6+HB+ahU3LiuqrYp2a96lBbr9nWioTeBp5Au5QSP2pECKIp4gBT
   9IJbmhT4NQFU60UNIjfgZ5JMS2nM11HftbrpQqR/p6J3jaWbvNK7qIhmq
   7tIEq7LZ9uuOb2vkw2wcQpCPQPRxL2Qpmy9o66D524C6+8K6G8veSNjm8
   p8MY4C24gBlMnUsWEcd1Q1AQFb3Au1pDuMKcCsyQ0W03C6q2yQ912di+G
   Q==;
X-CSE-ConnectionGUID: lQ5RqSp3QiCkhEVx03LHRA==
X-CSE-MsgGUID: I1Xbma5mR0aLUBQGNi8deg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="48029180"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="48029180"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 19:27:36 -0700
X-CSE-ConnectionGUID: YftceeTmRu+lZhiPv3An2g==
X-CSE-MsgGUID: JqmCe4dtQyCA8IDnL3KVMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="74221109"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 19:27:35 -0700
Received: from [10.208.96.32] (unknown [10.208.96.32])
	by linux.intel.com (Postfix) with ESMTP id B0B2320CFEE5;
	Tue, 17 Sep 2024 19:27:31 -0700 (PDT)
Message-ID: <7b6283e8-9a8d-4daf-9e99-f32dd55bcea5@linux.intel.com>
Date: Wed, 18 Sep 2024 10:27:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: stmmac: Fix zero-division error when
 disabling tc cbs
To: Simon Horman <horms@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Xiaolei Wang <xiaolei.wang@windriver.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Tan Khai Wen <khai.wen.tan@intel.com>
References: <20240912015541.363600-1-khai.wen.tan@linux.intel.com>
 <20240912153730.GN572255@kernel.org> <20240912153913.GO572255@kernel.org>
Content-Language: en-US
From: "Tan, Khai Wen" <khai.wen.tan@linux.intel.com>
In-Reply-To: <20240912153913.GO572255@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/2024 11:39 pm, Simon Horman wrote:
> On Thu, Sep 12, 2024 at 04:37:30PM +0100, Simon Horman wrote:
>> On Thu, Sep 12, 2024 at 09:55:41AM +0800, KhaiWenTan wrote:
>>> The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
>>> when offload is disabled") allows the "port_transmit_rate_kbps" to be
>>> set to a value of 0, which is then passed to the "div_s64" function when
>>> tc-cbs is disabled. This leads to a zero-division error.
>>>
>>> When tc-cbs is disabled, the idleslope, sendslope, and credit values the
>>> credit values are not required to be configured. Therefore, adding a return
>>> statement after setting the txQ mode to DCB when tc-cbs is disabled would
>>> prevent a zero-division error.
>>>
>>> Fixes: b8c43360f6e4 ("net: stmmac: No need to calculate speed divider when offload is disabled")
>>> Cc: <stable@vger.kernel.org>
>>> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> ...
>
> One more thing, if you do post an updated patch, please
> be sure to wait until 24h after the original patch was posted.
>
> https://docs.kernel.org/process/maintainer-netdev.html

Hi Simon,

Thanks for the clarification. Will be updating a version 2 for this patch.


