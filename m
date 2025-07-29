Return-Path: <netdev+bounces-210837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E9B150C3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CF018A1FFF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2AC153BD9;
	Tue, 29 Jul 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NyG2hHb5"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE31293C7F
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804873; cv=none; b=Gw+UZy+ph5v6OABa2SZyF2vae1I3w4k28zrtXK2lXJmcCuWW05GeplLCLauk4rGSpp8Z1VzjeBKjKCuKlZTgNW8i0VS3CDf54K/2zquPmpTURxPszzCJRcbSm+31psQ7qE0fETeULvL1NEvioypOD5RLsTDDqvoapZ/EKTw4gMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804873; c=relaxed/simple;
	bh=9pRCQ+Odukp8ehudDc+xKX6IjB9IT4bSCQS53eHoyVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gf/SnDPqYpArUiRxbX48S/jpDk8L9eXEn+kBAEY7R2s3XjQsXQHriIrrVHh3WHPdDnW+L1egZN0KJvtVKq5Fn02bj3dPe+lSCmlyiAc1GbaNtAGB9fZ05axNTWaSmMa+CP5wNELgMm0F7u4Lftb+8hah0utncU2QJssTAxOrdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NyG2hHb5; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753804868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AojRXkOOFjA2N/3VnYTbAXR8Q5lK8XT727nyCzSJxAg=;
	b=NyG2hHb5rIWP/mgK34lv6MFiSQFSSkv1SDG/UzC3R3zDbkdKl+7OClSATXiKAlhwpmX1pT
	18n4YBWsvGXxAaznHbrvPMPXhQ0T4hzMelJUv5jNthW54oAJ3gNE2xtnqfiUz8qnz9RlaC
	q01oatMv2xEv8kauF8+LWXyuxpvVAbM=
Date: Tue, 29 Jul 2025 17:01:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250729102354.771859-1-vadfed@meta.com>
 <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/07/2025 14:48, Andrew Lunn wrote:
>> +        name: fec-hist-bin-low
>> +        type: s32
> 
> Signed 32 bit
> 
>> +struct ethtool_fec_hist_range {
>> +	s16 low;
> 
> Signed 16 bit.
> 
>> +		if (nla_put_u32(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_LOW,
>> +				ranges[i].low) ||
> 
> Unsigned 32 bit.
> 
> Could we have some consistency with the types.

Yeah, it looks a bit messy. AFAIK, any type of integer less than 32 bits
will be extended to 32 bits anyway, so I believe it's ok to keep smaller
memory footprint for the histogram definition in the driver but still 
use s32 as netlink attr type. I'll change the code to use nla_put_s32()
to keep sign info.

Does it look OK?


> 
> 	Andrew


