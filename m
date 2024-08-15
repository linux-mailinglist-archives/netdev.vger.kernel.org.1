Return-Path: <netdev+bounces-118780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC8952C4E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9EF1F221C8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448C1A01D2;
	Thu, 15 Aug 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="YcXk999z"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61B19FA93
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715049; cv=pass; b=W1EcC99fg9t5UIyBaHRTf4/YmhHCSCCokTzG644O5VwhMZcWG7SmD2O53guNfYH6rbFJpWBxxWXx9IhcUBVLETt4U8Fz5tA1beyVngksOMUgOAIuF7YKHX1PoNtVlHWwOUmval0TWoEyq35nywCqPcuuh0o7WwNd97gRG+z9HPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715049; c=relaxed/simple;
	bh=C1u/nzICGc5ZOTkip2yj6o/t+/QkkP+tzdWFN4c3Ado=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ae06niy9ZZAguSsQr2zuUBJGJC6p0iPOk+OMvhBB4LNXTRXJjF/vUBGiL1gIyX9MsKSl213SAWywog8n17YoboZnD+k9DVFVa+k1QcO9iXi+6tHw3jR7IJ6xGHgQdVyqS337fchtnbA9Pz3iwI5J/LMTMEIdutIqVvy6jfzr28A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=YcXk999z; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723715041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DC6Q/DTCrYHpcEFkNzLqec6M4e0jrWlkuDlLCNAFnuOpyH3cMXyE0YcCJKUAQQtv6p53boHtSJpXrNp8K8K3+haPIKNXxbUNj4qIwZG/JfBacigVFMGl74VOrTtYcahlPpTUKFDsLhMsPYpT5+edsk9q/hmJ5AQdDYfsl/Q/arI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723715041; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mc62v3MUAfy7RdOFbORlUe7UZ/xC+9PZNHAtP/3llb8=; 
	b=JfNmK9RgCJ/Dvr+DwzD3cA7ScQqJYowT01FsDqDcBvLx/WYE6g05+YeI2Xd2pWYUEf+9cBuwjrPzU4p/pbrE1pUF2ae6iY3tyvLbUEbWI5D1KyFVK/caQrVEkQg0XpfnSsLSFTbcDBYp5ojjNcePG3d1HCtDAcUh9xfmgfG3P3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723715041;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Mc62v3MUAfy7RdOFbORlUe7UZ/xC+9PZNHAtP/3llb8=;
	b=YcXk999zo5v553OMkLfa/QSa2hGDAoZIadSLH/WjW3LEIY4Na9UX+ppnF6RwtKUB
	KZZszzWR7i3+fpLUYcT07670kBYrKdjnhyTImb+0mnj5xilrLitgD4SFMzajXAjpr2N
	OLEI0+7f0MiuumTbgY8tfwKL7C9ORqSGvGaNUOf/EmbTB5RRc3HzHAX0+PtYhskS5jX
	eeJRUsfh9kCRFe4wNIGWOYy0nchSli/8HBheoyeeAw1428QY4qjV2lIuVz1HRGW77xe
	OOfzHx6wSI9tOpvqrZg9JkOqNo6IjKCfedFhQAktOMR+CfvYyFAwDZgW3GrHqGly+rK
	04f0F8+KVg==
Received: by mx.zohomail.com with SMTPS id 17237150402661012.7845203558948;
	Thu, 15 Aug 2024 02:44:00 -0700 (PDT)
Message-ID: <8562b135-900f-4e8c-991b-4315fde5f1a7@machnikowski.net>
Date: Thu, 15 Aug 2024 11:43:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, vadfed@meta.com,
 darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
 <Zr2Cun2AhVLRAm1t@hoboy.vegasvil.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <Zr2Cun2AhVLRAm1t@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 06:23, Richard Cochran wrote:
> On Tue, Aug 13, 2024 at 12:56:00PM +0000, Maciek Machnikowski wrote:
>> The Timex structure returned by the clock_adjtime() POSIX API allows
>> the clock to return the estimated error. Implement getesterror
>> and setesterror functions in the ptp_clock_info to enable drivers
>> to interact with the hardware to get the error information.
> 
> So this can be implemented in the PTP class layer directly.  No need
> for driver callbacks.
Not if there is no connection between PTP layer and the consumer of this
information (TimeCard that uses PPS from embedded GNSS receiver, or a
PTP stack running on the infrastructure function of the multi-host
adapter or a DPU)

>  
>> getesterror additionally implements returning hw_ts and sys_ts
>> to enable upper layers to estimate the maximum error of the clock
>> based on the last time of correction.
> 
> But where are the upper layers?
They will be used to calculate the estimate of maxerror - don't want to
implement an API just to change it in a next RFC

> 
>> This functionality is not
>> directly implemented in the clock_adjtime and will require
>> a separate interface in the future.
> 
> We don't add interfaces that have no users.
> 
> Thanks,
> Richard

Noted - I'll try to explain it better next time



