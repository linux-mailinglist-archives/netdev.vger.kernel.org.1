Return-Path: <netdev+bounces-165076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B1A3050F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F67A2EFC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937331F03C0;
	Tue, 11 Feb 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="tFacrv4t"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68821EE034
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260733; cv=pass; b=gu9q0HmjMynURB0b+uMUG8xIguyBl0pOZIMsXKQ0QHEdcVqUxrkUfx9SKkAEBOi0HVWOgHwAPD+GqlUvq5clI9j0mrnIcYcWmIbWhqbYgDvIEYBoJujDCJ//Jm4FLc7a+F93WMFNvo14jTYL2oxrJF007Lxrc2paqstWSvW0NJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260733; c=relaxed/simple;
	bh=30vL05I/H3ATXK/5XjwzHbthHL+FeHI+0TLIfiqCtz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAT8DhsSQdteXSIp5XSWB1zLde19DfWfXsq+pJkkC/k5GMONln34Q8qfOcfSRA7QzoqGhHaxOgPZm0BV3WMeKz2O6GG1oI3tQEzX93gDK6bV2GK20AnFG8T9sVBn6tnJlvOSTnR171dwujii0ct15TUxIodFQxERWSn/MHto7GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=tFacrv4t; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1739260716; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=al9Rr0bVbuSRiWpns+0WRfnhq1dgG81D33dfpOz+lg+rcNmM4U1EOKnp0ZS++MEkUNRcSBD3UxOPnTDB3MDqHyZsOr9TAbP4Wx0on2mXztdxrjnWRrnlOmBVxFn9hu1M2QIUsrePgj1rNjvj0sWDj9JsT2pOD/gm8FMP5Le1z60=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260716; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hUIE8J1glB0Jp6XdrjusF7LVogDCOsnlUqQdIKvwbPc=; 
	b=EMN1YHaMf1MA6WbqOLfFs0YR6pKhX0avF2+MpxcA/roP7c6WCr7BIl8RJebgNZVQNdcATJ6Yxe/2L0Vcj4A7h8EUgLoPY4IeinKeX133Y5AwIJv32ivjD2iheCDNzr/eNppWa+c956tapioxcQKe0nXTTCzRyq0v/tXR8nwM+mM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260716;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hUIE8J1glB0Jp6XdrjusF7LVogDCOsnlUqQdIKvwbPc=;
	b=tFacrv4teY4tuHlWpQXMxnTm5fwSTYk1cylYPSIISh0kUoCucNS6TOauhytaHn9j
	10/627Gw6v8b4kbwHAISn1nAWUK8MvSsAO0JJTh0U9zbeQQhW9oloTd+lynlvoW8De1
	QMt7rjz0hxK5yR858tORij/+ODXhqLu+VRBnDfNQZGVZXy3QdBMhJSupFRGgUae42Mt
	hyV0eaMA0J8pOvH12Wazciehpf3o0ucK8MHQvqNUk7wLX/v7nk1baLNPFTSlDkxu2+c
	zAzFN6SIEWF0uxPxpMF8h3a9bRj/W/UQSf1T0I0VIO1ufrWjMbdHgp5KDsZx6KVCDab
	GrijGkGArw==
Received: by mx.zohomail.com with SMTPS id 1739260712848686.113977947831;
	Mon, 10 Feb 2025 23:58:32 -0800 (PST)
Message-ID: <72458ccc-9c18-4c95-8506-de4951851af7@machnikowski.net>
Date: Tue, 11 Feb 2025 08:58:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 0/4] PHC support in ENA driver
To: Jakub Kicinski <kuba@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20250206141538.549-1-darinzon@amazon.com>
 <20250207165846.53e52bf7@kernel.org>
 <7bc5e34e-8be6-46a2-8262-7129fff5e2f3@linux.dev>
 <20250210164626.178efa58@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20250210164626.178efa58@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 2/11/2025 1:46 AM, Jakub Kicinski wrote:
> On Sun, 9 Feb 2025 12:33:24 +0000 Vadim Fedorenko wrote:
>> Yes, we have seen this patchset, and we were thinking of how to
>> generalize error_bound property, which was removed from the latest
>> version unfortunately. But it's a good point to look at it once
>> again in terms of our prototype, thanks!
> 
> I was wondering whether they have a user space "time extrapolation
> component" which we should try to be compatible with. Perhaps they
> just expect that the user will sync system time.

error_bound has a different purpose - it tries to get the "baseline"
clock accuracy from the HW. The number returned here is needed to
calculate the uncertainty, not to extrapolate.

And yes - AFIK AWS suggests system time sync for EC2 instances [1]

[1]
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configure-ec2-ntp.html

