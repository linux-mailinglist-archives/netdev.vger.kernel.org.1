Return-Path: <netdev+bounces-218696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52AB3DF53
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B7C1899CF0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0C330E0D5;
	Mon,  1 Sep 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WSmy2zED"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923103081A9;
	Mon,  1 Sep 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720747; cv=none; b=BqGASGaHLkAIe2Ud8E7UiBBNd+lslNLIET1XaMDNw5CzbJIg7xJjE0hdCPEcbWGCM/hg+/Uk7yj8pB8fJVQezR+Lae8RIPskjf4tVYDrW7g6tDERVdOGOvWDyymfKGZU/RNqgafturwQ6C9zRISMtBpfkgJXEzKzLNxpycoV50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720747; c=relaxed/simple;
	bh=QxYLehtcBAi69d1LkCeE7+C8BiDvA8vqNgIgSEupEwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtK4QIDIEbs7dDDcSGz/V/NHKZyutiHt+3q0jSB18aqFYKDt7G2y05j83bElCsJRVTczc58JAdxtFdTotN/awb+xSph8Wgp+RaUNR5EWGbDXAJ6JDT3loLkejYLRTiWBdPWM6+8b7tbG/q/NzkdDaWGTW/4V/zPm0rHG7d/T5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WSmy2zED; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3c51a9e-f0cb-4d25-a841-117da0ff943c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756720733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fI6X1gDmQhfOpGtZzFYvtwz7XRWedoWtufSbGm0SwBE=;
	b=WSmy2zEDWPbn5oFdmmVc3IDdc2eJhB/I9aZ1OYqW+aqA59vXbyQswdwNGNSq9ru7Ct8Evn
	GXdQL+qnYtOSBejWu8Ijd0rsfetJxSOwQoKqG+vL8ffIQKwOlSsGDftO6J+gqWK3Lqj3Gc
	A+FLEptHCF8FI8LenrRw1GMW8Bp1erc=
Date: Mon, 1 Sep 2025 10:58:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 1/5] net: rnpgbe: Add build support for rnpgbe
To: Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
 geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
 lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com,
 kees@kernel.org, gustavoars@kernel.org, rdunlap@infradead.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-2-dong100@mucse.com>
 <dcfb395d-1582-4531-98e4-8e80add5dea9@lunn.ch>
 <8AD0BD429DAFBD3B+20250901082052.GA49095@nic-Precision-5820-Tower>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <8AD0BD429DAFBD3B+20250901082052.GA49095@nic-Precision-5820-Tower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/09/2025 09:20, Yibo Dong wrote:
> On Thu, Aug 28, 2025 at 02:51:07PM +0200, Andrew Lunn wrote:
>> On Thu, Aug 28, 2025 at 10:55:43AM +0800, Dong Yibo wrote:
> 
> Hi, Andrew:
> 
>>> Add build options and doc for mucse.
>>> Initialize pci device access for MUCSE devices.
>>>
>>> Signed-off-by: Dong Yibo <dong100@mucse.com>
>>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>
>>      Andrew
>>
> 
> Should I add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>' to commit for
> [PATCH 1/5] in the next version?

The general rule is to carry over all the tags if there is no (big)
changes to the code in the patch.

