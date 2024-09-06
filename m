Return-Path: <netdev+bounces-125892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2496F279
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0F0B2130C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09EE1CB313;
	Fri,  6 Sep 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ujx0Df32"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CD1CB15C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621153; cv=none; b=EVQ2y07g9vEMVQ5q14K3KwvA/gMqnKqFqifPX8oljw9gvd7B6Ey3LVmcPq9cUPHBYnWZwodsugaebJd3Tr/lvn8P6ROcTUFZoS9mOnY0C+FJG0Sr5jSCdUM8NP+FsYCMTKU/6f9A4BpogEKAC1H04dNvwzHzaQ0Rzl/63Hsvl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621153; c=relaxed/simple;
	bh=CwTg5C3RAqrdegTeVgfHwHa/Ih6rpo8s6WHBMDaSmCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUi20EpNGwya0UfO+/RHWqshrqnZsyo7bwR4fKMxnT5Pzdh5VGN6I/oGueUwNdRAg9gG/UAN1r1j0CV4N4dYgn9zxJ8fVsaGP9OI6krgHLvzD0hxteLP+USF+2kmhZA0YGy1tPnBrW1wZCgBhXj69LXO7qxzdKd8LRbfGqTt/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Ujx0Df32; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725621151;
	bh=fCUr0yYMyiDqZLvbfPiEFIYbUFw3LPM+MmdgJ6xo9Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=Ujx0Df32xvrtyUA9oJOyR9JhNWfFNd3ehdqrza3sd0K3/Wg57tWl6j5lNXcR575oR
	 QEqp6PLArQyMg5TNUSuaGeYYbT+rvgdJxYsXh8HTqVCqAvFzRqgt4JEsj1o5y3YniD
	 zXZjSFGwxGDgYX2EZxgJYKxB/X10y1VkQg+znt3fLGMYXX81FAa2Banjj5HVIjCwc7
	 uUCsNa+OMZpJX50XGgfti3of/JdQPTmEwwj3SIBX/kw52g7WS6pvRS2FtcXnv9ubsY
	 1P0ntLKyA0vdB8TM+Bz9OCN9W43YlU3siALjdj8oedrVUOEd0grH4AqyVu30UvYd63
	 ZxtatkHsGteUg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 208573A1107;
	Fri,  6 Sep 2024 11:12:26 +0000 (UTC)
Message-ID: <e45ad7f7-ae35-48bb-ba36-af9952b661cf@icloud.com>
Date: Fri, 6 Sep 2024 19:12:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sysfs: Fix weird usage of class's namespace relevant
 fields
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240905-fix_class_ns-v1-1-88ecccc3517c@quicinc.com>
 <20240906102150.GD2097826@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240906102150.GD2097826@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L6DcvCBmeBusLR_6HNmlx7f3AADNuoSw
X-Proofpoint-ORIG-GUID: L6DcvCBmeBusLR_6HNmlx7f3AADNuoSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409060081

On 2024/9/6 18:21, Simon Horman wrote:
> On Thu, Sep 05, 2024 at 07:35:38AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Device class has two namespace relevant fields which are associated by
>> the following usage:
>>
>> struct class {
>> 	...
>> 	const struct kobj_ns_type_operations *ns_type;
>> 	const void *(*namespace)(const struct device *dev);
>> 	...
>> }
>> if (dev->class && dev->class->ns_type)
>> 	dev->class->namespace(dev);
>>
>> The usage looks weird since it checks @ns_type but calls namespace()
>> it is found for all existing class definitions that the other filed is
>> also assigned once one is assigned in current kernel tree, so fix this
>> weird usage by checking @namespace to call namespace().
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> driver-core tree has similar fix as shown below:
>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=a169a663bfa8198f33a5c1002634cc89e5128025
> 
> Thanks,
> 
> I agree that this change is consistent with the one at the link above.
> And that, given your explanation there and here, this change
> makes sense.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I don't think there is a need to repost because of this, but for future
> reference, please keep in mind that patches like this - non bug fixes for
> Networking code - should, in general, be targeted at net-next.
> 
> Subject: [PATCH net-next] ...
> 
> See: https://docs.kernel.org/process/maintainer-netdev.html

thank you very much for such important reminder
i will follow this guidance for further net patches. (^^)


