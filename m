Return-Path: <netdev+bounces-125288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EEF96CA98
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AD81F2237A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1568E14EC71;
	Wed,  4 Sep 2024 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SRWbSn/Z"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51557383A3
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725490245; cv=none; b=D3HI4J91z2rlpSRd5HVBsWRRltZv97OHiVUbpPjGxNPTlnztKHAjaV2WTkXeJ9WVrix9Dk/PvPY1WXdrcbqakencTmMxm4Zo5CkwY4234izhIWJBvAIQoAyHypwd2pMpJ+wtbUwUk76VkLXNWuG8UuwTLWiGpLB3XQR0TpmHFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725490245; c=relaxed/simple;
	bh=3WuFIEP+iH1p6cOYYAv3WbCyUuNGvaNbN35glkbONAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljeOPdCXQWImnvokVh/p0w3nkyXCEI+NK1f9yN8IYeUrFCkOSgXgsggC8lnG7rgORvJ1ssewiUSAt1VwE3menHS21dK3RvxG8+lvqUAv0JZVsNaDojUaaqY/oXUbA4mjPwRvi3WOVVNjIPNythE5UizbjTFBy1THEaPgFK+LsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SRWbSn/Z; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2b0e208a-a986-46a2-bd58-6464ae8da7d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725490240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsdBEM1LoJfCbEVYxxkKbcMs4q6P0CWR3o3fHmJSCR8=;
	b=SRWbSn/ZZN+FfZemD6VTApkg424qP3VyL/UNMOJLfRMYbn95rGbhj+Oby6LdoyHeMoEsl4
	fQ8W3KFUEvfFtITSR8OWk2fYGwa+2mydJvvww+xsnojorqtgX4VBtlJBhHR+uYemOLmjxi
	1fP9LNKL2rut4Jui5ErDA9a2pybcSuQ=
Date: Wed, 4 Sep 2024 23:50:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 0/4] Add option to provide OPT_ID value via
 cmsg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240904113153.2196238-1-vadfed@meta.com>
 <8a50a1f2-3b99-4030-9a96-6aecdd2841b7@linux.dev>
 <66d8cb426bc39_163d93294e@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66d8cb426bc39_163d93294e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 22:04, Willem de Bruijn wrote:
>>>
>>> Vadim Fedorenko (4):
>>>     net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
>>>     net_tstamp: add SCM_TS_OPT_ID for TCP sockets
>>>     net_tstamp: add SCM_TS_OPT_ID for RAW sockets
>>>     selftests: txtimestamp: add SCM_TS_OPT_ID test
>>>
>> Oh, sorry for the mess, patches:
>>
>> [PATCH v3 2/3] selftests: txtimestamp: add SCM_TS_OPT_ID test
>> [PATCH v3 3/3] net_tstamp: add SCM_TS_OPT_ID for TCP sockets
>>
>> should be ignored.
>>
>> If it too messy I can resend the series.
> 
> The series looks good to me. The four patches listed in the cover
> letter summary.
> 
> Overall looks great.
> 
> Perhaps the test can now also test TCP and RAW with a fixed OPT_ID.

Sure, I'll add these tests. As well as changes to address comments for 
1/4 patch.

Thanks,
Vadim

