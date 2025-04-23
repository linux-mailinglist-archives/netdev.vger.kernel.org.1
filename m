Return-Path: <netdev+bounces-185062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4467A986F4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCEF176121
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365526D4E5;
	Wed, 23 Apr 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="goA6K/Cr"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF8223DD9
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403213; cv=none; b=fLQYHgA2ocXUjjphbEE8iVqHwichCb3BW3fhoF0J0zi2NEHQSEO0dvIns0cC0a7Qww+VzUbocUTg3fqIkMICyAoDHLvT+sJ+YPox4cxKngcXPevBv9IQ/4l6ZhhLOTYLFnZHN6L+IoME4mWX3zaffllI+QG2gbJjuqaUQOuO2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403213; c=relaxed/simple;
	bh=HQBDsgYZhBPh59w6ihf5bVFm3ivJjOfhgpGq8Icqh9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O68jXoKi5Vj5kQqGb+pYvztkw5SCRchul6ynpZEys3UIg/hO5JZFa5jQ525jW49Dd5iWnTxlF+AsMri1RoMi4MLuyF5eXvQT2FlKNZ0MgDCifa3JV+OhwRYVRePUFCwm/MHlCVGyWkaLZqz5/Sy7/8Kx37/ojeW1zEID+Er1QQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=goA6K/Cr; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3e40052-0d23-4f9e-87b1-4b71164cfa13@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745403199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Djwsr22QmQbVxK6LfymSVfTiOD/EcmVyLiPImXUyaz0=;
	b=goA6K/Cr5Q+5ioR3MqXCSe9KFZmoTIvV9AlPnUyxwUowIU+3TGwF+UbKQBrzuFLcBmKk6V
	9Jf9OPR2/Cxmp8oEcewb5XDcvNs+KHmGHjJAbPqAlAMN/BPS8GbDNp5a6WrlusCbu1WyFp
	yPgN0Cxn33yMCmuGafEMWuGYpeIFPHU=
Date: Wed, 23 Apr 2025 11:13:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/6] gve: Add Rx HW timestamping support
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org,
 thostet@google.com, jfraker@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418221254.112433-1-hramamurthy@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250418221254.112433-1-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/04/2025 23:12, Harshitha Ramamurthy wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> This patch series add the support of Rx HW timestamping, which sends
> adminq commands periodically to the device for clock synchronization with
> the nic.

It looks more like other PHC devices, but no PTP clock is exported. Do
you plan to implement TX HW timestamps for this device later?
Is it possible to use timecounter to provide proper PTP device on top of
GVE?

> 
> John Fraker (5):
>    gve: Add device option for nic clock synchronization
>    gve: Add adminq command to report nic timestamp.
>    gve: Add rx hardware timestamp expansion
>    gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
>    gve: Advertise support for rx hardware timestamping
> 
> Kevin Yang (1):
>    gve: Add initial gve_clock
> 
>   drivers/net/ethernet/google/gve/Makefile      |   2 +-
>   drivers/net/ethernet/google/gve/gve.h         |  14 +++
>   drivers/net/ethernet/google/gve/gve_adminq.c  |  51 ++++++++-
>   drivers/net/ethernet/google/gve/gve_adminq.h  |  26 +++++
>   drivers/net/ethernet/google/gve/gve_clock.c   | 103 ++++++++++++++++++
>   .../net/ethernet/google/gve/gve_desc_dqo.h    |   3 +-
>   drivers/net/ethernet/google/gve/gve_ethtool.c |  23 +++-
>   drivers/net/ethernet/google/gve/gve_main.c    |  47 ++++++++
>   drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  26 +++++
>   9 files changed, 290 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/net/ethernet/google/gve/gve_clock.c
> 


