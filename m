Return-Path: <netdev+bounces-210862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01427B1527A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5165218A0E7C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AE22759C;
	Tue, 29 Jul 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hpmvJcey"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F92AE90
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812489; cv=none; b=aqn62QfzGYLgaS6A5On+MJ74g8y48P79R/18dW49ABpVXpax0eP1mUT9l/aLch0sG/RbN2UkcUl32Kp5hu+Ivuc8Fh4S3Okm89TsdHH7eFSQdiq8wgwp9/C6bw/R+6541tk8vVYmvkhSSpUnxFDfAKsEiTKJ2+twIEosM15TkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812489; c=relaxed/simple;
	bh=nlFz/GDMvYyQbSTCfqqmn70qAgYAbTw7mIE/LrHanOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hM+W8mKHl+O49NBvoMC2fhiFNNVmmW7AWLSgIvRx9NLnQkLx98iDhDOsxiN7xBQTVzAVQadMOP721gollUmYYGi7/L4ZVXkvRbYWvCzStlDKhYFbhcW69BQ35Oz7mEIpOAdgdPWQTbKOnhtlBPaqLzTfLT+n+fxlbdzDYLhCySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hpmvJcey; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <424e38be-127d-49d8-98bf-1b4a2075d710@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753812483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RXcBNh4+O3HiRyQXj8rk1CgupflqF5nLPTGPGDhtIE=;
	b=hpmvJceywDT/SQIXUrU9EbPkm5r68aZOcQIH86PxFvKAxSps45XroPkwkRWanNlGkmcRQI
	zR04Kn9btiL5koBgZj6LYU3IsWnHqdy3PFptZz5QPIoX4uavb+pXaJKKZiR8LrH6mjL8KV
	UNYhgNsfF4Qvl+QMicVMK4WrvxPRgmE=
Date: Tue, 29 Jul 2025 19:07:59 +0100
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
 <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
 <9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
 <4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>
 <c52af63b-1350-4574-874e-7d6c41bc615d@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <c52af63b-1350-4574-874e-7d6c41bc615d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/07/2025 18:31, Andrew Lunn wrote:
>> The only one bin will have negative value is the one to signal the end
>> of the list of the bins, which is not actually put into netlink message.
>> It actually better to change spec to have unsigned values, I believe.
> 
> Can any of these NICs send runt packets? Can any send packets without
> an ethernet header and FCS?
> 
> Seems to me, the bin (0,0) is meaningless, so can could be considered
> the end marker. You then have unsigned everywhere, keeping it KISS.

I had to revisit the 802.3df-2024, and it looks like you are right:
"FEC_codeword_error_bin_i, where i=1 to 15, are optional 32-bit
counters. While align_status is true, for each codeword received with
exactly i correctable 10-bit symbols"

That means bin (0,0) doesn't exist according to standard, so we can use
it as a marker even though some vendors provide this bin as part of
histogram.

Thanks for the feedback!

