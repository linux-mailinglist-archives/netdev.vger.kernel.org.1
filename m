Return-Path: <netdev+bounces-185283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA74A999E8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C5C1B83DAF
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8027933F;
	Wed, 23 Apr 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hm3nApL2"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B628468B
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442404; cv=none; b=uxLJqa8r9X6uRt8uSPTgnFxDxmd/DzieqjakpH9bLmHSRUTFLfjijc6z0v7FiXrd3qUcYVEw1TLT1Zeu0BE64RqYXCDnZdbbs3jnFul+/fOQo2+prlD92VjYEphJPRoCpm975IOcr/L0vJ+MYkLheHDdu5/QK65klBm/rfLDf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442404; c=relaxed/simple;
	bh=qgnmbrs5R1omCctiVkoCevVxRfXdNIRKhT9uiNX8N8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg1IdkI9r2xt/UJYSCzCYtQAhnr1W9bV4OFBsQGf7JQvVsgHSrxCvnURcT727XYg7bS6AzVWJ6905Xl1N9nF1U3YK8i0IIosGSH2sw3fIzdjGA0PLkOUcfOOuRveN9X5zQSRUCYDuzjyqZ7JN/xhLiV6bOxxk+Wg5pe8LKcKhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hm3nApL2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99b52c22-c797-4291-92ad-39eaf041ae8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745442389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74tQ57PHLi6ZOj350BhyOhfjL3E4tvKmSozsLI7eDxo=;
	b=Hm3nApL2VyCOk1R8A1HZ9E99C91Zy63aYzPbt7jJv3V9l3XGw97qwhTzZ7tj6eN7tshG5Z
	zmKjm9EiOmybaMAsdLdtwnVXyFwnp5Tk17ytSPkkl+wW1hXDcliD7PYbcAO1gcfLRp7ln1
	UTH5caPBySOO30o2LNJSQ3vaF0VMn/Y=
Date: Wed, 23 Apr 2025 22:06:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/6] gve: Add Rx HW timestamping support
To: Ziwei Xiao <ziweixiao@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, pkaligineedi@google.com, yyd@google.com,
 joshwash@google.com, shailend@google.com, linux@treblig.org,
 thostet@google.com, jfraker@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418221254.112433-1-hramamurthy@google.com>
 <d3e40052-0d23-4f9e-87b1-4b71164cfa13@linux.dev>
 <CAG-FcCN-a_v33_d_+qLSqVy+heACB5JcXtiBXP63Q1DyZU+5vw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAG-FcCN-a_v33_d_+qLSqVy+heACB5JcXtiBXP63Q1DyZU+5vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 23/04/2025 21:46, Ziwei Xiao wrote:
> On Wed, Apr 23, 2025 at 3:13 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 18/04/2025 23:12, Harshitha Ramamurthy wrote:
>>> From: Ziwei Xiao <ziweixiao@google.com>
>>>
>>> This patch series add the support of Rx HW timestamping, which sends
>>> adminq commands periodically to the device for clock synchronization with
>>> the nic.
>>
>> It looks more like other PHC devices, but no PTP clock is exported. Do
>> you plan to implement TX HW timestamps for this device later?
>> Is it possible to use timecounter to provide proper PTP device on top of
>> GVE?
> Yes, the TX HW timestamps and PTP device work is undergoing. Those
> would be sent out in separate patch series when they are ready.

It looks like it's better to have PTP device ready firts as it
definitely needs some worker to keep time counting. And it should be
done with ptp::aux_work and replace the work you introduced in patch 3
of this series.

>>
>>>
>>> John Fraker (5):
>>>     gve: Add device option for nic clock synchronization
>>>     gve: Add adminq command to report nic timestamp.
>>>     gve: Add rx hardware timestamp expansion
>>>     gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
>>>     gve: Advertise support for rx hardware timestamping
>>>
>>> Kevin Yang (1):
>>>     gve: Add initial gve_clock
>>>
>>>    drivers/net/ethernet/google/gve/Makefile      |   2 +-
>>>    drivers/net/ethernet/google/gve/gve.h         |  14 +++
>>>    drivers/net/ethernet/google/gve/gve_adminq.c  |  51 ++++++++-
>>>    drivers/net/ethernet/google/gve/gve_adminq.h  |  26 +++++
>>>    drivers/net/ethernet/google/gve/gve_clock.c   | 103 ++++++++++++++++++
>>>    .../net/ethernet/google/gve/gve_desc_dqo.h    |   3 +-
>>>    drivers/net/ethernet/google/gve/gve_ethtool.c |  23 +++-
>>>    drivers/net/ethernet/google/gve/gve_main.c    |  47 ++++++++
>>>    drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  26 +++++
>>>    9 files changed, 290 insertions(+), 5 deletions(-)
>>>    create mode 100644 drivers/net/ethernet/google/gve/gve_clock.c
>>>
>>


