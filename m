Return-Path: <netdev+bounces-146460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CA9D38AB
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E61F21573
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244019C54D;
	Wed, 20 Nov 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+K0TzUt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586E187859;
	Wed, 20 Nov 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099699; cv=none; b=b0XaPN0ej/CiAOUwOzfbdt9t2a43XyCcoSkDMuavj+QZ/9MxR8B1GPfnhxOiIYBZZRIZtBGvLXcxprgzuJ7d/wQuhSBaHiEhEwut7hgHlzbl5PGGeRV6qfJ60LanumeezENsAfV7D2zdp5p9uVg0tLcTHfinO/Y5yYrFybqYI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099699; c=relaxed/simple;
	bh=DdnwLC1nlOOJXfXe14SuzanZGrbtUU6kyE6ng30glmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpYDPAyeJ5sMOf+mCg1jPPQNNMjqoUifvvd3amd+pQxHWODkBUDYYovHK+4z8pqbdUtjC/WOoh2Vp7TVFxGXrDkfOjZA9qlbIABQgpASXv70Ilu78QDZSfV0G6hgIlJpz8+qWFZaV8yw6BzEpZtZUpyxlcy5AO3APsXaxJeIesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+K0TzUt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732099698; x=1763635698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DdnwLC1nlOOJXfXe14SuzanZGrbtUU6kyE6ng30glmk=;
  b=Y+K0TzUtqBl3wHKabT50/bOCQGvo03J4OGbkcQA+6Uu7FZlyQAX/jqJl
   gBktxxGs0NXpzAakvWx93K3fi4GsHcFhcgMKrHqECttRsuccMNSfoPXud
   CB0MAtYsjI9o0D4SQhcZIwZPiPTRoEorgz/yIP3uCxj0bCoTCSwW4UTiG
   0QRJSW3/PELJzI5KHHrn+aUjkUdJghx9PtHLVMLGxm/0IYvax587uPqrW
   zsKI5iwPKHc3jpfX7cI4VN9z8rjpOKx1ZgauRwXXwQnua6Wt2ic9rRg3z
   BkZ7JSiIYzuZ5p2xgBOcaYEWlhQE5lW5crOu3KYyuwEBd6K0K5i7TYJtr
   Q==;
X-CSE-ConnectionGUID: D9U4O8JmT9eLJYhJcgcxKQ==
X-CSE-MsgGUID: J4NYQ8oRSTy/LSPbahvgPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31521005"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="31521005"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 02:48:17 -0800
X-CSE-ConnectionGUID: W48YHOZpTiGL35DWyTxvhg==
X-CSE-MsgGUID: BIrFOaQ7Sv+bsw9FnoXbDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="89677797"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.82.175]) ([10.247.82.175])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 02:48:13 -0800
Message-ID: <14202f42-5408-4127-8664-8ad958fb2046@linux.intel.com>
Date: Wed, 20 Nov 2024 18:48:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: phy: replace phydev->eee_enabled with
 eee_cfg.eee_enabled
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <20241115111151.183108-2-yong.liang.choong@linux.intel.com>
 <ZzdOkE0lqpl6wx2d@shell.armlinux.org.uk>
 <c1bb831c-fd88-4b03-bda6-d8f4ec4a1681@linux.intel.com>
 <ZzxerMEiUYUhdDIy@pengutronix.de>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZzxerMEiUYUhdDIy@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/11/2024 5:47 pm, Oleksij Rempel wrote:
>> Sorry for the late reply; I just got back from my sick leave. I wasn't aware
>> that you had already submitted a patch. I thought I should include it in my
>> patch series. However, I think I messed up the "Signed-off" part. Sorry
>> about that.
>>
>> The testing part actually took quite some time to complete, and I was
>> already sick last Friday. I was only able to complete the patch series and
>> resubmit the patch, and I thought we could discuss the test results from the
>> patch series. The issue was initially found with EEE on GPY PHY working
>> together with ptp4l, and it did not meet the expected results. There are
>> many things that need to be tested, as it is not only Marvell PHY that has
>> the issue.
> 
> Hm, the PTP issue with EEE is usually related to PHYs implementing the
> EEE without MAC/LPI support. This PHYs are buffering frames and changing
> the transmission time, so if the time stamp is made by MAC it will have
> different real transmission time. So far i know, Atheros and Realtek
> implement it, even if it is not always officially documented, it can be
> tested.
> 
> Regards,
> Oleksij

Thanks, Oleksij, for the suggestion.
The actual problem we are facing is that the software and hardware 
configuration is not in sync.

With the following patches applied, the issues were fixed:
- 
https://patchwork.kernel.org/project/netdevbpf/patch/E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk/
- 
https://patchwork.kernel.org/project/netdevbpf/patch/a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com/
- 
https://patchwork.kernel.org/project/netdevbpf/patch/20241120083818.1079456-1-yong.liang.choong@linux.intel.com/

