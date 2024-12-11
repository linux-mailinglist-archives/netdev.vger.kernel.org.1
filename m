Return-Path: <netdev+bounces-151190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1969ED481
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFED716783B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E31FECD7;
	Wed, 11 Dec 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jzu4tru7"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9C246344;
	Wed, 11 Dec 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940616; cv=none; b=abysbzpqqo4GDXrnTtYLi7Pp01JgDEfkvaChLkq1ssMIWFA/pEohONL1X8fn64W2uiZSZmZLTCL8QgwMyuRmyA6dXGcmHL6NpEgLcigNsGEFr5YzfBpt93aG837EMKx8JHHQa8/Aoo81wmMPfl8XM0WukXU1vdgv9l7r39aW7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940616; c=relaxed/simple;
	bh=hRMWpJMv0N7IZhbGQtO+Sp6up4p8yHu9z3NVOoOotVY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WumapdgKAzgT1LvHlE6/aa90piGxXwVPjNOmBsUXvcl4BOzbvm5XiweXtzXU0vKVsO4Z9t6yl5/EdOIltPlhdHkbcdKZG5KJ3BgzcK3eNM04UQBOtfCKwpB510cHfukVaTXfcCsy8QLsunAA0MKchu2hdRHoboadfLLKrMS9kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jzu4tru7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.209.235] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1CAC1204721E;
	Wed, 11 Dec 2024 10:10:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CAC1204721E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733940614;
	bh=ZY07N8Fk6Sa8iiS6Rn18TQt4x6MVCcqKSYjxwQqFd+0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Jzu4tru7wnqFd65g50+9pzCPQRfkGc/mFGHYbRmWk+CXFO/wK08lWoPBx4lbdc/WA
	 IK6bPKqji0dICkIJSBlbG5cUiZ904nE3LabGlle7UExka8byqCXOzaV79EMvudubh/
	 pWpOn4NGy8Ix1h5CvKGtqRmjEJ5p4vr2eO1xHvx0=
Message-ID: <58c2bbb7-cf39-4832-9e31-60ed9302372a@linux.microsoft.com>
Date: Wed, 11 Dec 2024 10:10:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 James Hershaw <james.hershaw@corigine.com>,
 Johannes Berg <johannes.berg@intel.com>, Mohammad Heib <mheib@redhat.com>,
 Fei Qin <fei.qin@corigine.com>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] nfp: Convert timeouts to secs_to_jiffies()
To: Louis Peens <louis.peens@corigine.com>
References: <20241210-converge-secs-to-jiffies-v3-20-59479891e658@linux.microsoft.com>
 <Z1ldtgYpXCIIN5uQ@LouisNoVo>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <Z1ldtgYpXCIIN5uQ@LouisNoVo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2024 1:39 AM, Louis Peens wrote:
> On Tue, Dec 10, 2024 at 10:56:53PM +0000, Easwar Hariharan wrote:
>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>> secs_to_jiffies(). As the value here is a multiple of 1000, use
>> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
>>
>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>> the following Coccinelle rules:
>>
>> @@ constant C; @@
>>
>> - msecs_to_jiffies(C * 1000)
>> + secs_to_jiffies(C)
>>
>> @@ constant C; @@
>>
>> - msecs_to_jiffies(C * MSEC_PER_SEC)
>> + secs_to_jiffies(C)
>>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>> This patch is pulled out from v2 [1] of my series to convert users of
>> msecs_to_jiffies() that need seconds-denominated timeouts to the new
>> secs_to_jiffies() API in include/linux/jiffies.h to send with the
>> net-next prefix as suggested by Christophe Leroy.
>>
>> It may be possible to use prefixes for some patches but not others with b4
>> (that I'm using to manage the series as a whole) but I didn't find such
>> in the help. v3 of the series addressing other review comments is here:
>> https://lore.kernel.org/r/20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com
>>
>> [1]: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com
>> ---

<snip>

>> -- 
>> 2.43.0
>>
> It's not super clear to me which patch is handled where and through which tree
> at the moment, but looks like this is a network driver change scoped to the
> netdev tree, so makes sense to me to add sign-off here. Thanks for applying
> this to the nfp driver.
> 
> Reviewed-by: Louis Peens <louis.peens@corigine.com>

Thanks for the review! All netdev patches will be handled via the netdev
tree, separately from the series, per Jakub's request. There are patches
for gve and ath11k that will also be pulled out from the series and go
through netdev. I'll send a v4 series to netdev including your
Reviewed-by for this patch.

Thanks,
Easwar

