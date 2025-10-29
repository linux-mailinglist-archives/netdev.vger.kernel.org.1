Return-Path: <netdev+bounces-234124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1357AC1CD48
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427293BFA03
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DAC351FB9;
	Wed, 29 Oct 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ffvegbAw"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697D354AD3
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764016; cv=none; b=AQ4SfaE33r+sZONV9NCiVDwQHqCcczaM6QFNdudEZDYmbxeAkfIH2HpSf8rEzHcDIwd028SpJapTAVhhJ240Ljy3kpGcLeslldqmoEUBjvr/phw5PPjpMmxmUq4Pj3D3vMEhwuTeN8RHRDLSzYU5GK1SQzb3hsWmYKqzXjNraGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764016; c=relaxed/simple;
	bh=+Q66p02NmtpLJBWH5C8PAfH4CQJp874wyiCL4wH2ryg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTP6WYi13KaE8RFdtvHBx2DLzRnHCcVk6N3O6nw7ldpb68XKrP6oJbFKMvuQi+Lmj1v4TzpMXdX//BusXKgF31BS9xcm2wolkQ6xYb3U9CkOXFEOn8edK26JFOnPF8q2azM1uHk0jJbrZVi2CV4euo9/1iiUf2J0XOnzy3N2Dzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ffvegbAw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8693b213-2d22-4e47-99bb-5d8ca4f48dd5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lt1MMuNqxc0o6ECwibIWMD/IU9orIrmiqiY4tYq3pKM=;
	b=ffvegbAwMCE5R6hyDGqQQBK1j0OXDxhvcX68PzN+Q0F/EeORg/WAh2fZu1ginOwNmB5ZTg
	vbVVtdbloSP2Qjg5sH79SRqlwhZ9LEHuw2ZIWsrvz58BBobmHTc/XEEnRbQf+qruL8Nt/t
	woX6Cn52T0rQrGp/uktandGZejbXTB8=
Date: Wed, 29 Oct 2025 18:53:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
To: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
 <5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
 <ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
 <zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/10/2025 16:26, Michal Kubecek wrote:
> On Tue, Oct 28, 2025 at 09:48:00PM GMT, Vadim Fedorenko wrote:
>> On 26/10/2025 16:57, Michal Kubecek wrote:
>>> On Sat, Oct 04, 2025 at 08:27:15PM GMT, Vadim Fedorenko wrote:
>>>> The kernel supports configuring HW time stamping modes via netlink
>>>> messages, but previous implementation added support for HW time stamping
>>>> source configuration. Add support to configure TX/RX time stamping.
>>>>
>>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>
>>> As far as I can see, you only allow one bit to be set in each of
>>> ETHTOOL_A_TSCONFIG_TX_TYPES and ETHTOOL_A_TSCONFIG_RX_FILTERS. If only
>>> one bit is supposed to be set, why are they passed as bitmaps?
>>> (The netlink interface only mirrors what (read-only) ioctl interface
>>> did.)
>>
>> Well, yes, it's only 1 bit is supposed to be set. Unfortunately, netlink
>> interface was added this way almost a year ago, we cannot change it
>> anymore without breaking user-space API.
> 
> The netlink interface only mirrors what we already had in struct
> ethtool_ts_info (i.e. the ioctl interface). Therefore my question was
> not really about this part of kernel API (which is fixed already) but
> rather about the ethtool command line syntax.
> 
> In other words, what I really want to ask is: Can we be absolutely sure
> that it can never possibly happen in the future that we might need to
> set more than one bit in a set message?
> 
> If the answer is positive, I'm OK with the patch but perhaps we should
> document it explicitly in the TSCONFIG_SET description in kernel file
> Documentation/networking/ethtool-netlink.rst

Well, I cannot say about long-long future, but for the last decade we
haven't had a need for multiple bits to be set up. I would assume that
the reality will be around the same.

Jakub/Kory do you have thoughts?

