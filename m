Return-Path: <netdev+bounces-139990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F49B4F20
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDFF1F23C9A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA8B194C7D;
	Tue, 29 Oct 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/xw3gBX"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B8192D68
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218642; cv=none; b=rqefNzHjsbEWtcf5jk/PHt5Emqb2b5aihhXGHefOlCcUEPgqs8lg+w3TGEK7Fk4gmJyuxMprCtJb5FncOWlj/UpoVQs4l4/qW6E8Jl8utWa0arDZQb2EE7z0QO8ACtBlpz1deyItILnsmefuIKu/NVa6gYhCEbem6AZz+lqNEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218642; c=relaxed/simple;
	bh=elYEmHlzbap6ByYfsIRLBptosxVFacCVdp1spbzk8Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLNnEAJ/AhQjGUGw5bkUHRpCxYnNNBVPWpSBPOfsxChpHD/qpj1pGiD3jawkRZ9SViS/kr7qKv6FHuPsIXo2rZmgWjz6KsTvOqGbWRvxEdVJz2+A11iLQgzF5XtkrDmxiou95MCAUd2XCfjHzJZ3HeU75tyTDi5GVKmUHj6UiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/xw3gBX; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54b8ad89-5bac-475f-b655-942c7e6d60a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730218636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezYmkGlGSx9edqpDHAZhMKqx6HNJfpqrUbm2d+S7mr4=;
	b=E/xw3gBXRwoTD0j72Z0gRttCAx/mBKPcUud+4+geDwH4Eqs2A22gzw4CMWwQ/d46Eujxzj
	XSiKYbbnpgoWi1vhUpx4wE+nD6GUlCrdGSgsBnwTe2qqOjnVDwJCKRKQVqmnxWa27+cXqL
	YvXvTTothAJxiUTRN6UULge45yvhhCA=
Date: Tue, 29 Oct 2024 16:17:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/2] ptp: add control over HW timestamp latch
 point
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>
References: <20241028204755.1514189-1-arkadiusz.kubalewski@intel.com>
 <8899c12f-bc2f-49d3-bded-e838ac18fef8@linux.dev>
 <MN2PR11MB4664B05DF435E9731B7877419B4B2@MN2PR11MB4664.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <MN2PR11MB4664B05DF435E9731B7877419B4B2@MN2PR11MB4664.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/10/2024 15:56, Kubalewski, Arkadiusz wrote:
>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Sent: Tuesday, October 29, 2024 12:30 PM
>>
>> On 28/10/2024 20:47, Arkadiusz Kubalewski wrote:
>>> HW support of PTP/timesync solutions in network PHY chips can be
>>> achieved with two different approaches, the timestamp maybe latched
>>> either in the beginning or after the Start of Frame Delimiter (SFD) [1].
>>>
>>> Allow ptp device drivers to provide user with control over the timestamp
>>> latch point.
>>>
>>> [1] https://www.ieee802.org/3/cx/public/april20/tse_3cx_01_0420.pdf
>>
>> I just wonder should we add ethtool interface to control this feature.
>> As we are adding it for phy devices, it's good idea to have a way to
>> control it through eth device too. WDYT?
> 
> Seems doable, I guess somehow expand the controllability being added right
> now with this series:
> https://lore.kernel.org/netdev/20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com/#r
> Or some other idea?

Yeah, the series mentioned correlates with your work, that's why I asked 
about it.
It would be great to be sure that the interface you are proposing can be
reused or somehow combined with the series.

