Return-Path: <netdev+bounces-97808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F32E8CD568
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04714B20B29
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2B313D621;
	Thu, 23 May 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="cBdzmu9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16813B7BE
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473512; cv=none; b=GUNsjThflGFHBdVs5L6U/F2nSa74yElbC2D8N9ssMnGPeOxlsElE3cZhHHL/4lc3zWphRed/35Jbcw2oV22O1CU9Jx6spWJH1TYnH7CLogwdhxkjC2FKGSLOnP7OMHo+d3qAddJEaA35mvbwFWz+e9BCuuaxblpOB6i7OK4KBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473512; c=relaxed/simple;
	bh=RQGNtjvYnkg1hKRxTFFaFowcrvWD/Penss2kcFPrCtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Phnm4mGy55NvWmNLnaZY0SDcNRQtkq01GtGozuOv8xPEiOiVBzSt/s+2PNcalfYU4UZpk1U017Qjjlo9UzjPJqj9Lejx5wzK97PVbiYu8Ri2HYokox18haZXbEh0aU0b51sFKh0NUF5B7xjjw5LLDZuQR6ENNnu9Qx7deNFIUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=cBdzmu9Y; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=90Pf3AcyvD96Y/GrNvIuxxpAET850FleAdFOj6IXGjQ=; b=cBdzmu9YtblT6UfMwAQMx74IAL
	d4KPkSka225i9ck0ZJQYd2nf5L5WDw1idMqNR2SqN7bCbbaQAbxnj6OZD0T7YFQ8Oid/FeL1y6zn2
	vxe90297FSVdKhmr/bAsV+/diq9KQ/KbkdFHYj8STvvkh5TQbXpPwILCN4XJp0aSps93eGCdkA5LG
	Mf0uh23xUjzloXR3apvR0v3E6Up5fzCX2j0r+RUlvNcRSQqajaUoEmXNRrs+WVR8bp249tXF19mLz
	LlknLouCf9wr078MJY9rG2yHYxJqzhsWE7Th0a7QGRFnacsyLh+Ru5TdQum/hTE4JT9F5S8LgUsrt
	lFTxcanQ==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA9AW-000gJf-3A;
	Thu, 23 May 2024 14:11:45 +0000
Message-ID: <c535f22f-bdf6-446e-ba73-1df291a504f9@gedalya.net>
Date: Thu, 23 May 2024 22:11:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Dragan Simic <dsimic@manjaro.org>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
 <c6f8288c43666dc55a1b7de1b2eea56a@manjaro.org>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <c6f8288c43666dc55a1b7de1b2eea56a@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/24 10:02 PM, Dragan Simic wrote:
> See, once something becomes de facto standard, or some kind of de facto
> standard, it becomes quite hard to change it.  It's often required to
> offer much greater flexibility instead of just changing it.
>
Flexibility is offered by the COLORFGBG variable. The entire time we've 
been talking only about cases where that is not set.

Again, it is good to reduce to a minimum reliance on defaults. But aside 
from having a default the remaining option is to refuse to produce 
colors when COLORFGBG is not set, even when the user is explicitly 
asking for colors.

>>> everywhere and for the new feature to reach the users.  Shipping
>>> a few additional files in the /etc/profile.d directory would be a
>>> reasonable stopgap measure.
>>
>> No, it would be totally broken as explained.
>
> It would be broken only for those users who change their background
> color to some light color.  Though, it would be broken even with your
> patch applied, right?  I see no difference in the end results, for the
> users that reconfigure their terminals that way.
>
/etc/profile.d is shell session configuration.

If you want you can come up with shell magic that would set environment 
variables depending on which terminal environment the shell is running in.


