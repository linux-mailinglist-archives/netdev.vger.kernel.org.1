Return-Path: <netdev+bounces-164466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA355A2DDC8
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 13:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040C918866DF
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35E14F9CC;
	Sun,  9 Feb 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ue+b2MLR"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06051E522
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104410; cv=none; b=A8mReLL6gILiTCPYCDGvwsmcXP3QOYX/endJ2TEQONepox3ufbxE7Wxq8/YHf2mq3JvTYUgNuSJSFZfAeN+m7m3UjD5Xvd9FMtxfKV+GKkf+B8LK9U3zd9THBcPxE5vL0wuwFz2JJGajmZ+jIVeMj7XQVkQ+CgYNFx+jXermjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104410; c=relaxed/simple;
	bh=A+wgcMVaIDGkfixJVkQvX0PeVRMtpzdwCfEl2Xoegyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hveObdVJ8LaXgREm/7f7LT+kSyeXxfo1f7AKfimMWGQO6Yj5psER85w8qxX6KWMk6HdVbNvNc8E/KH3sHsybYUmr7JjWTkbOUm6//nmVLuwk8WD9Ll4M3TWXBzNUQqMTc69VmDigQRIDXkrn/kTRZPUPlRXPl14daD29aiNDRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ue+b2MLR; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7bc5e34e-8be6-46a2-8262-7129fff5e2f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739104406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFczN+NeV30e/Hem1hNYdpuoU3uz9unVoiPgWRZFv8s=;
	b=ue+b2MLRaplF80rTO8sgQ9j5XcDIORLlO1DikFXQEN7eKcsYd0TE83RnZ+lzYAleQWZ6Ty
	DgAfAKOPWM/LncUteT8EaUx5stqXzo6uSeksWloJtkBiwB0JefpTJSPqlxZCZiI6WNeay+
	yNA28H6gapSMFZUj9jIKA8pbPX/mDws=
Date: Sun, 9 Feb 2025 12:33:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 net-next 0/4] PHC support in ENA driver
To: Jakub Kicinski <kuba@kernel.org>, David Arinzon <darinzon@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20250206141538.549-1-darinzon@amazon.com>
 <20250207165846.53e52bf7@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250207165846.53e52bf7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/02/2025 00:58, Jakub Kicinski wrote:
> On Thu, 6 Feb 2025 16:15:34 +0200 David Arinzon wrote:
>> This patchset adds the support for PHC (PTP Hardware Clock)
>> in the ENA driver. The documentation part of the patchset
>> includes additional information, including statistics,
>> utilization and invocation examples through the testptp
>> utility.
> 
> Vadim, Maciek, did you see this? Looks like the device has limitations
> on number of gettime calls per sec. Could be a good fit for the work
> you are prototyping?

Hi Jakub!

Yes, we have seen this patchset, and we were thinking of how to
generalize error_bound property, which was removed from the latest
version unfortunately. But it's a good point to look at it once
again in terms of our prototype, thanks!

Best,
Vadim

