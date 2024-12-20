Return-Path: <netdev+bounces-153606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8D9F8D4B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B211716AE30
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0B137C37;
	Fri, 20 Dec 2024 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="ecKzKE1l"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-31.ptr.blmpb.com (va-1-31.ptr.blmpb.com [209.127.230.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601946BF
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679891; cv=none; b=nCA0p06rWeTOySktodABDKIPY0WsNJyNVmoIlbEEmGpBHoVYPkaOqHGyzAV3+NEWw3h9TXQc0j58ALODP7uC2jto7SMoo9osWD/aN4PAN9CNYvvByfLPCgJ9e7e6Qox5VGjcCjnqlyeVnjsv5B2ga02u/mBW5ysFoqUSBE/OT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679891; c=relaxed/simple;
	bh=N3rqH403NZmMCIVLjupH0Yyt00DHk30DwGSNObMyqo0=;
	h=Cc:References:Content-Type:From:Mime-Version:Subject:To:Date:
	 Message-Id:In-Reply-To; b=MWr6WJ6kDoS7/POCrM3pBghUx95lVzlU/PZ7Kt+21nsTOFbQcQDHQ2//QJrk5+/cWjK6ljwv3udM2PZiWbC4L+QVyZLURmHBDKknRVMVf56OXxi9HbYcz50oLYNEkuQ/qW9gGcl/KfN3hLw481SKwZWYQs5O69WchP+3rG/gU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=ecKzKE1l; arc=none smtp.client-ip=209.127.230.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734679874; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EhymAME58alZrE7ZZmSk1yCl9Ga4mW2Rf0M7fWmwlt8=;
 b=ecKzKE1lVZUMbpGkDu5BmGGV5vDPwg/rapiMOqKvJCownrhNK6fgs/a607EAvHaS71F4dP
 MCJO/C7fVMxNbaFqF4LPI3MMYAw2TVFJZLAPudNWHRwvjfWRXLxct6wS/8qC/8X7TsZ6Ga
 jrQKlLPrwI/ZDdJqlMFdlXbgSNuctOptYBUw8DqPsynNuwskcJ0UkrQSoyPDKMTLZPbwoT
 ECu0jWkiMSWNA4s/zpY5jz8yKXyRfNvNTHleUEcA9Eiwc1AG+3JvhJRsHZjcqTYD5qn6tq
 eFbODQhkPrqH7/UhcArb3K450+aygXi3KOFJOeU/1viYJMSYo0YqGNWf3aP36g==
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com> <20241218105051.2237645-14-tianx@yunsilicon.com> <a965aadc-6e82-4d2d-8cf9-fc8da0f2817d@lunn.ch>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
From: "tianx" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+267651d40+ae858a+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 13/16] net-next/yunsilicon: Add eth rx
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Fri, 20 Dec 2024 15:31:11 +0800
To: "Andrew Lunn" <andrew@lunn.ch>
Date: Fri, 20 Dec 2024 15:31:09 +0800
Message-Id: <e61a710a-ea89-4c23-b720-cc91f917a162@yunsilicon.com>
In-Reply-To: <a965aadc-6e82-4d2d-8cf9-fc8da0f2817d@lunn.ch>
X-Original-From: tianx <tianx@yunsilicon.com>

Thank you for your suggestion. I will address this issue in the next 
version and avoid using inline functions in the .c files.


On 2024/12/19 3:47, Andrew Lunn wrote:
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
>> @@ -33,10 +33,572 @@
>>    * SOFTWARE.
>>    */
>>   
>> +#include <linux/net_tstamp.h>
>> +#include "xsc_eth.h"
>>   #include "xsc_eth_txrx.h"
>> +#include "xsc_eth_common.h"
>> +#include <linux/device.h>
>> +#include "common/xsc_pp.h"
>> +#include "xsc_pph.h"
>> +
>> +#define PAGE_REF_ELEV  (U16_MAX)
>> +/* Upper bound on number of packets that share a single page */
>> +#define PAGE_REF_THRSD (PAGE_SIZE / 64)
>> +
>> +static inline void xsc_rq_notify_hw(struct xsc_rq *rq)
>> +{
> Please don't use inline functions in .c files. Let the compiler
> decide.
>
> 	Andrew

