Return-Path: <netdev+bounces-224380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D28B843E6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD27ACBC7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B232F7446;
	Thu, 18 Sep 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmkMuGCb"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC518A6DB
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193104; cv=none; b=D68OTtbfGlXVQTehwxevub3jo8v6esBp+c51fnVYEYTYA0LyurXXSbFqaPzyArmX8v/jXH/cmHHSCJs2EA/wC+l03ewCHIKUzW1AXT97cpPbjiLqukU9CcRLs8727b/3KkKMhHzW9POR/xhHu+fBxiZgniiBkB1xPa7wJ8kOv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193104; c=relaxed/simple;
	bh=m0F5sK9Br7xom68QNmOgq4vD+IUQK/ytAcJDS28ftUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fELTInhRWaJq8Z/rFbU8izhxqXIrTwOhW1krG/0AeyNbdKcO0fa6bu+kQt24g+kNYtC73Viqvaul2orXwUohm98zPs5phoopHGlS3mUVFpCxFYdP/uFVlMcsYLpngcu11X6C2PGb9MX9dZLS43hHle3CikSCLo0ojzREVB3OnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmkMuGCb; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6cffe63f-4099-40f7-afee-3f13f1464e56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758193098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGmAXk85XR0eQMr0uyPembtkDsCH0jfFf7uqsLjvtFw=;
	b=fmkMuGCb2lQpBDdyKyjzq8xOE9zA6v0QZL7eK4YFpGcg1Sz591iH5P3eMFrhRZ6Pw9IMIo
	EiHJAct+Ho7ogJQvDkReKNPqJSPQzed0wiG+CRWhRAOjsZvyayvaJMino2OdD2t1/f3VM7
	6QZ/fpkNdcqq/CPGkTzRCZefoxeBlQM=
Date: Thu, 18 Sep 2025 11:58:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC bins
 histogram report
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Carolina Jubran <cjubran@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Gal Pressman <gal@nvidia.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tariq Toukan <tariqt@nvidia.com>, Michael Chan <michael.chan@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
 <20250916191257.13343-2-vadim.fedorenko@linux.dev>
 <IA3PR11MB89861635B2B78A559A8EAE12E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <IA3PR11MB89861635B2B78A559A8EAE12E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/09/2025 12:27, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Vadim Fedorenko
>> Sent: Tuesday, September 16, 2025 9:13 PM
>> To: Jakub Kicinski <kuba@kernel.org>; Andrew Lunn <andrew@lunn.ch>;
>> Michael Chan <michael.chan@broadcom.com>; Pavan Chebbi
>> <pavan.chebbi@broadcom.com>; Tariq Toukan <tariqt@nvidia.com>; Gal
>> Pressman <gal@nvidia.com>; intel-wired-lan@lists.osuosl.org; Donald
>> Hunter <donald.hunter@gmail.com>; Carolina Jubran
>> <cjubran@nvidia.com>; Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Cc: Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
>> netdev@vger.kernel.org
>> Subject: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC
>> bins histogram report
>>
>> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
>> clarifies it a bit further. Implement reporting interface through as
>> addition to FEC stats available in ethtool.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 

Thanks for the review!
BTW, do you know if Intel's E8xx series can provide such kind of statistics?

CC: Tony and Przemek as maintainers of ice driver

