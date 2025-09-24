Return-Path: <netdev+bounces-225783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA61B98419
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DB63AF188
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18D5157480;
	Wed, 24 Sep 2025 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbwESf0L"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1123522F;
	Wed, 24 Sep 2025 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690059; cv=none; b=eFrxTp1hZZYr10EvO5KZpRftyyIEKNGkhsoPZXRzrE5rNBmyj67FOjtGHkbD/uifg7goYQxRPDOJT+5QubZ6ydsL+54kIDORKuSqYGIpq5BzpFhCw9MRM8/w5a0//1QhiDNcXC5a81gYkOev1E3q9IVqO9A22u/gvlLVWa9XJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690059; c=relaxed/simple;
	bh=3rjszu95LwE1fRgsGcOebfpTkAPj0WS3Rp15mrOWNo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VP1kxDGW+OcQZQuXZ2zMgMpvI7JasRjnPUvXoMfDhVeS/zgYCK0YiupFFECPZflMNNNznal0XnvTYEgpO6I44hj0XE1YVgvxeZ2Y3jSGxpPwen5q00GIMeocMXDlZPkegktAtVPPBak+x4V1np0OghpEMAdysUAe477gtEwLs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hbwESf0L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=V7nPlFqhwMN0z70WSRfK8sING9u+ehvo4/FrG+GyYT0=; b=hbwESf0LT/VXAMNqIXcv777z5a
	v9Vo4isG94dyNq/jtJAVRzM0drD1nqISA7sNa49eq+uhecER9HAMTZ9XUcKBRBaBEqfZP4KXNrQ/2
	zjGK2+ErmoxiDQxob9oEjUkt4eupBHg2RWbJW8zrw5lvxxfOkTuSbPE7oCJdvjzz5xemo9dZrtwJ7
	Y04Yoa8gNZHdxxibdTTGdMuKm3ZARFjo5LW2QWkI1Cg0jxzp+8Z7iS3SKm+QfX/JAGfPd9XOwTV4C
	AFPbJ6EDVcYcietX9/YuQFKk84Jet/QSF2SPyLTIO0OWA2goTEfph2sQ8bwcze3ggq8Nnd3XnmQPU
	KnR2TS1A==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Hcd-0000000FXdn-2pb0;
	Wed, 24 Sep 2025 05:00:55 +0000
Message-ID: <f41e4063-ac88-4444-b932-cc1c7cabbd7c@infradead.org>
Date: Tue, 23 Sep 2025 22:00:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dns_resolver: Move dns_query()
 explanation out of code block
To: Simon Horman <horms@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kees Cook <kees@kernel.org>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
 <20250922095647.38390-4-bagasdotme@gmail.com>
 <20250923101456.GI836419@horms.kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250923101456.GI836419@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/23/25 3:14 AM, Simon Horman wrote:
> On Mon, Sep 22, 2025 at 04:56:47PM +0700, Bagas Sanjaya wrote:
>> Documentation for dns_query() is placed in the function's literal code
>> block snippet instead. Move it out of there.
>>
>> Fixes: 9dfe1361261b ("docs: networking: convert dns_resolver.txt to ReST")
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Thanks, this renders much better. In a browser at least.Hi
> 
> I've added a few comments below.
> 
>> ---
>>   Documentation/networking/dns_resolver.rst | 45 +++++++++++------------
>>   1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
>> index 5cec37bedf9950..329fb21d005ccd 100644
>> --- a/Documentation/networking/dns_resolver.rst
>> +++ b/Documentation/networking/dns_resolver.rst
>> @@ -64,44 +64,43 @@ before the more general line given above as the first match is the one taken::
>>   Usage
>>   =====
>>   
>> -To make use of this facility, one of the following functions that are
>> -implemented in the module can be called after doing::
>> +To make use of this facility, the appropriate header must be included first::
> 
> Maybe: ..., first linux/dns_resolver.h must be included.
> 
>>   
>>   	#include <linux/dns_resolver.h>
>>   
>> -     ::
>> +Then you can make queries by calling::
> 
> Please use imperative mood:
> 
> Then queries may be made by calling::
> 

I think imperative mood would be more like:

   Then make queries by calling::

but I'm not asking for a v3 patch.


-- 
~Randy


