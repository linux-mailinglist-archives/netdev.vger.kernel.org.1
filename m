Return-Path: <netdev+bounces-222209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBB8B538D2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2626A1BC2786
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0D33EB0D;
	Thu, 11 Sep 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nIqqQVm7"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566F350D6D
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607151; cv=none; b=PYz2m2FCnS4yAOhB9U326uc1NtQDxKj0BfE6WdMXvgWuoIfCvzItIDJFhlJd7hKwrHA3alcdC8f0RPQmMuChVVIUeA1Y6Um+/DjsIGPSF74uTyne/M9FrS6UoCFONEsjWugM9zIOGPwf5GoFRTrk40nHAtkARl1jZljp1E9E7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607151; c=relaxed/simple;
	bh=ZclenTwO0q3NUbtBAGnccOeSxuEq2DIxZAJxLaxHI34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPk4gCjDO+4E3ORLX+pqFB+x0HXPy3JFvsXX7p9daEM2KKlgkBFRp9mnwC1KTaakWUf9+dcgR5pqvMzoLplTJUdajzlGEC2+/eGbXAcXNZyocx6rJsHk041qLlHrZQUWQ8mdW2iAtSmxh2CRrXhYBcIAppYeYMIt7dpA37UCn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nIqqQVm7; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91db2877-96b8-451a-9316-5274c51441ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757607143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBBdyh1VMRnF/CtI3xW5c/r96TybJpOvQ4OBXkcO8Cw=;
	b=nIqqQVm72NCaRy2sbByX7araLF9Af4ZJtoCuIXYDTZDtTo2jLGU7QKH8ZTvbA8592P9fa5
	R1wIJWE8ugX89SZDFJFVIwrNIhJ8t512p7FnW6sBlzoXp3DByRNczzZzA1dWvdKv/hdK6T
	kG5Rr8F8bvkaj04AzzZNgf916F3/UCs=
Date: Thu, 11 Sep 2025 17:12:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 1/4] ethtool: add FEC bins
 histogramm report
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250910221111.1527502-1-vadim.fedorenko@linux.dev>
 <20250910221111.1527502-2-vadim.fedorenko@linux.dev>
 <8f52c5b8-bd8a-44b8-812c-4f30d50f63ff@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <8f52c5b8-bd8a-44b8-812c-4f30d50f63ff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11.09.2025 09:39, Paolo Abeni wrote:
> On 9/11/25 12:11 AM, Vadim Fedorenko wrote:
>> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
>> clarifies it a bit further. Implement reporting interface through as
>> addition to FEC stats available in ethtool.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Not really a review, but this is apparently causing self tests failures:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/292661/5-stats-py/stdout
> 
> and ynl build errors:
> 
> https://netdev.bots.linux.dev/static/nipa/1001130/ynl/stderr
> 
> /P
> 

Thanks for bringing it up, I'm trying to properly fix these things

