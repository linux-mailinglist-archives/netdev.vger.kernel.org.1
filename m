Return-Path: <netdev+bounces-118781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BF952C4F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159B528598A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4217BEBB;
	Thu, 15 Aug 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="Ou/mYoyY"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985717BEA1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715121; cv=pass; b=vGP1H+tks02NxeUa0XNtmdkHec3KkLApNnR1le73cFKTweqrzfPQ9QBOD7hE+nakB8v1FlvdIjQGj1xDXgsadkXmjficQtKymuKHtzon4CnVgmI0xlgsDn/4NbpVNgjUFH8sBw9PeA/roSsi7+rsbRRoD5HyWMqvsxz2ZrGsgmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715121; c=relaxed/simple;
	bh=QV0eQI2137bd0zxSYDWSMZyCUVsBsn7y6Vg8IkJ4m2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2lyMHDyvZYgjkRhgOOd6SjTkLIwSC6sk8ZVQiQY7qicwKQdJ7OeZjGGwZgNyNxkdmYoU3eVRCVxUtRmN9JDU2A1y+prcGOnBp8lTfqwJNU0+sd4PAfcUT2dQ+sAxjoVkgGYkFYmdqyUDq97Dzw7vUsCLvmSiUPZLuJy/sEVQs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=Ou/mYoyY; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723715106; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hStFAJk6T2kRieML6CkMuzIjidSxYAPAby6jCBeOW2vo7b8basiU5UDMttMMwnzLPIILylNlLkZ1YmtFP/IUHEo5/pJ3X5mMNO7DEe1da9KkzDApImxwA93+pC9pPE11zzUSfmddFk/JNkSOkhUGZhm+RenoDTCspEiIuV3oyIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723715106; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D2ZpgUHhgLm5SZsSAQUIJBVikVlqCDu/Yf0j0OOlP0Q=; 
	b=G6qzo0sheWv0RmBFhFeQRPnbKAWQeN/VUiic+q7PnrSY3a8TYsvivH4iU9n2Vc6afh18WaLmzWFaf8p0jLKH+0Vh6jbX0jNRVhXIsyU6FaPGThIU8GxzRaWb/1KSnJCAEZuwKnZXtrzQq5ihFLuB2tYtLbJgT1eOrX+7PyF7Kfk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723715106;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=D2ZpgUHhgLm5SZsSAQUIJBVikVlqCDu/Yf0j0OOlP0Q=;
	b=Ou/mYoyYVEjQHmVduamz/rOx1mkDrVkLSiWM0+DlSonoYdUWAlIZVDvDxQfyManN
	bIt0B8mJmfxW+81sixZqia3TwBRkbu5T0ZYC6jLkhRySaLehicM+/qYogFWonyV3HJe
	dydecnKEhiSiptRrxac5MAnBD1uDsQ2M8ZU9sRfRtam25AfNmJUbHnirQLkCsWZqv39
	ySwqpbxO12zYNdWm0DqsJEEJjf7yBYecIdZwd0GB0wb2uxWZyhaDLGHPeiCnUMsN124
	mupSs37cHO4HmwwoQF3cSHmRs3FlkSAUxvp+uHIBvqBw/wWHXi/QK+qSqIKKgXNW/Aa
	qXkI607EYA==
Received: by mx.zohomail.com with SMTPS id 1723715104045467.4838583426898;
	Thu, 15 Aug 2024 02:45:04 -0700 (PDT)
Message-ID: <2ec122db-0987-4f92-bd40-6c7f4202a446@machnikowski.net>
Date: Thu, 15 Aug 2024 11:45:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Miroslav Lichvar <mlichvar@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <Zr13BpeT1on0k7TN@hoboy.vegasvil.org> <Zr2BDLnmIHCrceze@hoboy.vegasvil.org>
 <Zr2Q-sti4TjSjEug@localhost>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <Zr2Q-sti4TjSjEug@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 07:24, Miroslav Lichvar wrote:
> On Wed, Aug 14, 2024 at 09:16:12PM -0700, Richard Cochran wrote:
>> Actually, looking at the NTP code, we have:
>>
>> void process_adjtimex_modes(const struct __kernel_timex *txc,)
>> {
>> 	...
>> 	if (txc->modes & ADJ_ESTERROR)
>> 		time_esterror = txc->esterror;
>> 	...
>> }
>>
>> So I guess PHCs should also support setting this from user space?
> 
> Yes, I'd like that very much. It would allow other applications to get
> the estimated error of the clock they are using. Maxerror would be
> nice too, even if it didn't increase automatically at 500 ppm as the
> system clock. IIRC this was proposed before for the cross-timestamping
> PHC between VM host and guests, but there wasn't much interest at the
> time.
> 
Thanks, I plan to include maxerror later (not sure if it should be in
the same RFC, or a separate one)

