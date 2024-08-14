Return-Path: <netdev+bounces-118377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A669516DC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79761F2127B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91171411C7;
	Wed, 14 Aug 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A8dilmLy"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB513E020
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625077; cv=none; b=MVNB1tJ/z+vnhSU3jLLeGrhxd/JG9VjqTkqth2Y6BFw9L/exqoLJVYMNeEsy4I0b0UfFUi50sqZEaUm4xCUnHeh35j71UwYLhKruRYLr3xvYIyIHjQyFs8plsmngXK2gQZWNOHbCyOBftcTpTLz0zU1dJt8B3VyzjAUTM4tR6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625077; c=relaxed/simple;
	bh=lBm04SiMZQJwm9XoLGFTQSDLThW+H+lIXapk1FEERsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASgPRcklIDApJHPZnZgIMgzcpkgLiFFxVQMB5GwQemJApDSRtHe+lmSzTJwIJ280DmkV4WAPbA4ilKrnp/blpUz5glgXnmoQeUgopBfbEB+9oLpskDcFDcraU3O+dTOLtiBpRl/ttGAlHviKTDk4QkqmiRhIK4XKc97puRV1Nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A8dilmLy; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723625073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZtmI3FJlN6sEGHABETHslzdYicUgBcJ0aFWbfYyGws=;
	b=A8dilmLyxcqp8q2UR8ZwLkRvScYYEKRRkqhYUfyFwuLsm9+yULs+SI9Ao0zNRrFWF2L+y7
	TmL06+C0P/tGoqXNsw/7KU8Xyaa7AABvMeCx9wWi6GXjgVURf78wI09CRyiB5K/KP4ID8z
	VoDkN0JoiBxj1/imB32lxSw8Q2Mkt2o=
Date: Wed, 14 Aug 2024 09:44:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Andrew Lunn <andrew@lunn.ch>,
 Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/08/2024 21:05, Andrew Lunn wrote:
> On Tue, Aug 13, 2024 at 12:55:59PM +0000, Maciek Machnikowski wrote:
>> This patch series implements handling of timex esterror field
>> by ptp devices.
>>
>> Esterror field can be used to return or set the estimated error
>> of the clock. This is useful for devices containing a hardware
>> clock that is controlled and synchronized internally (such as
>> a time card) or when the synchronization is pushed to the embedded
>> CPU of a DPU.
> 
> How can you set the estimated error of a clock? Isn't it a properties
> of the hardware, and maybe the network link? A 10BaseT/Half duplex
> link is going to have a bigger error than a 1000BaseT link because the
> bits take longer on the wire etc.

AFAIU, it's in the spec of the hardware, but it can change depending on
the environment, like temperature. The link speed doesn't matter here,
this property can be used to calculate possible drift of the clock in
the micro holdover mode (between sync points).

> What is the device supposed to do with the set value?

It can be used to report the value back to user-space to calculate the
boundaries of "true time" returned by the hardware.

Thanks!

