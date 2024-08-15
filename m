Return-Path: <netdev+bounces-118772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23933952C30
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BB81C23FAE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFD1C4621;
	Thu, 15 Aug 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="Wxdg8wSx"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466EC19E7D3
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714356; cv=pass; b=o6wXT1621Y0kJB8B/fOU6q2fojK79WFeNamb2Jcb+97PD1ZHDMIhX57wRJj2WtCE4FauJkn9BiXeTQZjXNYN1JF397vZKVYTgPvVhzMweV3fXLn10PmsMwbGoQrLkGJPlF+tINB2Zld1e4bzJSU/Bcn/Omhb8OPLpWl84Li8LqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714356; c=relaxed/simple;
	bh=WSS55jZv9x8epXHFI+VIXsm0nWlKgZqMf3CICeHUJoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSXyLAuEScq84+x5zQrZ9F180eKeBqq8a9PPQPy0+GAdCf4kK16Bisui8QSi0BhICMA+WkRhckZkkqz/sw9VaA+TM32/7olcPibJUFk+CjTHeJ+2/sM/hl8RVR56ig/V4KYNyXJHF6ndMF4uRDuS5FQYFunvGu8WqMogfqHF64c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=Wxdg8wSx; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723714347; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=buaUDZkZYIYbjLy54QjHmr1nzDk8z6sWykQ+N3tjtZzpeVAgMA8rGqtXpWXTXjJF28IDgZfsH5Q/tXmO5osBC1oX/+vMEw67cTFM39bnIDOOOlpmjzQcyadsgHP+mPGO/xlsvX8OAzfYHaE62Xh1GYc40e4Sqvk4IfGMFsNtPWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723714347; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NoyE33glC+estEipg42ketdRyJu8sV3/DsQVEuckFzQ=; 
	b=b5MV4aen661osDalB9GwjMXY5m4qy3cofJvQlaF1YxFzrCO725lJdFgS/g8Ba2TGKthZbQZKrOCDODDgehgOL3kP1Ei+hgpL+M3X6y1Jc5QLOTVinpJZ+U3FGVfNE0zhihBZWAiuToBUvta5DmXxjwCd5aY6tQhgcNKAxy4qnqk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723714347;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NoyE33glC+estEipg42ketdRyJu8sV3/DsQVEuckFzQ=;
	b=Wxdg8wSxNO8EJ/Y+rpqNfbQIs1r4AKtQcG0II04MnJewrGxkJoQ2/hL3HhZ9SAmj
	oI6m5GmZ483RYXQi6M7fHYp94p90eCZLLqQj5yKe/KioFOTCnXXEZZOsPltg0kr7Jjn
	l4jfoQeGs7RaCngEfft8mrFMAKf+IE8DAH90R31ixMir4bVsDn1kYdUhlkYPu5t6BSY
	hnJkLVMdIsBxDuyNaiuddNvw70dalEa5Tc+Ly5q8erOo7BWKvoTai07KFnddmxhE3I3
	7hkr+kGvENoFIoGxg0981/brA3q3uRBWuTiYj+0+2v868slTdFUig2G+ueUgogQKDVf
	l8+fm1qdZw==
Received: by mx.zohomail.com with SMTPS id 1723714345807720.560861535303;
	Thu, 15 Aug 2024 02:32:25 -0700 (PDT)
Message-ID: <6ce5c17b-7af3-4844-8373-85b363387a53@machnikowski.net>
Date: Thu, 15 Aug 2024 11:32:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, vadfed@meta.com, darinzon@amazon.com,
 kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
 <20240814114605.GC69536@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240814114605.GC69536@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 14/08/2024 13:46, Simon Horman wrote:
> On Tue, Aug 13, 2024 at 12:56:00PM +0000, Maciek Machnikowski wrote:
>> The Timex structure returned by the clock_adjtime() POSIX API allows
>> the clock to return the estimated error. Implement getesterror
>> and setesterror functions in the ptp_clock_info to enable drivers
>> to interact with the hardware to get the error information.
>>
>> getesterror additionally implements returning hw_ts and sys_ts
>> to enable upper layers to estimate the maximum error of the clock
>> based on the last time of correction. This functionality is not
>> directly implemented in the clock_adjtime and will require
>> a separate interface in the future.
>>
>> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
>> ---
>>  drivers/ptp/ptp_clock.c          | 18 +++++++++++++++++-
>>  include/linux/ptp_clock_kernel.h | 11 +++++++++++
>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
>> index c56cd0f63909..2cb1f6af60ea 100644
>> --- a/drivers/ptp/ptp_clock.c
>> +++ b/drivers/ptp/ptp_clock.c
>> @@ -164,9 +164,25 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
>>  
>>  			err = ops->adjphase(ops, offset);
>>  		}
>> +	} else if (tx->modes & ADJ_ESTERROR) {
>> +		if (ops->setesterror)
>> +			if (tx->modes & ADJ_NANO)
>> +				err = ops->setesterror(ops, tx->esterror * 1000);
>> +			else
>> +				err = ops->setesterror(ops, tx->esterror);
> 
> Both GCC-14 and Clang-18 complain when compiling with W=1 that the relation
> of the else to the two if's is ambiguous. Based on indentation I suggest
> adding a { } to the outer-if.

Thanks for catching this one - will fix in upcoming release!

