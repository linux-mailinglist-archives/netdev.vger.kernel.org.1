Return-Path: <netdev+bounces-225132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D27B8F386
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68953BC696
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E52F2916;
	Mon, 22 Sep 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="A2n6kzEz"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89762F1FF1;
	Mon, 22 Sep 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524906; cv=none; b=MGuMxov0u18NQuAcznj2GCeStCwdl+/Efz7m3A+BVWWFv/5JQwoUwq0A37J4SSUpVKbvODn4gksX8wgjMIb3Hyohn5gGfe9L2EjQSDpDuVR4NjkK2LZms28Dnp/VgUbg9eStSS7WeE6eWaLL3A+kkI8PBCPSraJiuOEcmA0jJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524906; c=relaxed/simple;
	bh=Zw//AWx9s+NUuDrZTHZtAxFcaUz8s//tgsNpthZDYWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh98Ibrsx8j4o8c5wrWQQAjSSBNejhQKAIAhygUg3vlvHGmuyC1T9jjN9pXS14JfW+O2Ig87cNHlbDPO+syQt08A4jlJO0EnBUYYwJzJPGh1sssBhFOxngV6CX9VVfEpRju9Qt+JDPN17ShgDUvNZ1jEumYmbXeDgiWYMQ57wq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=A2n6kzEz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 77CD62082E;
	Mon, 22 Sep 2025 09:08:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWJ7DA3ws5-W; Mon, 22 Sep 2025 09:08:16 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 00248207FC;
	Mon, 22 Sep 2025 09:08:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 00248207FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758524896;
	bh=AFxYm97oYb/+ELvmqLp3aS0HLl6emOyCGeufVhBOxnM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=A2n6kzEzxUD0p/l8ZrQkShbUevz8+/I2aOqqybZ6ZW1J0vhn/JMjVTWIS2QYHgTtv
	 pwFCzX090EbxYvMBBIqttCowvqtB2LB/LYPAvkXpCPINil7ppiJZ67Ippq3pS/ApuN
	 /aoFAWgQ7myREVLbOF/I4qpukJCRha4nl1zTxhnunP3BgKMqWPdmMpCqfClKMA90+M
	 TgGlkeG6IKFMXmNl5do2WdcupCDOGdLkXaR5FbwDOd/nMPIjEnQxuGbqitBkUVMppj
	 Ds/IhheqqjrLFNZZGH9dkp2oLZ9gIB7D6TLQuhjWbDVhkvRXHBGVyt6YD+UwjrH/0h
	 DSDvbyyZdwNBQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 22 Sep
 2025 09:08:15 +0200
Received: (nullmailer pid 2674351 invoked by uid 1000);
	Mon, 22 Sep 2025 07:08:14 -0000
Date: Mon, 22 Sep 2025 09:08:14 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saakashkumar@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH net] net/xfrm: Refuse to allocate xfrm_state with SPI
 value 0
Message-ID: <aND13piG0NIlBt1U@secunet.com>
References: <20250921022701.530305-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250921022701.530305-1-zlatistiv@gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Sun, Sep 21, 2025 at 05:27:01AM +0300, Nikola Z. Ivanov wrote:
> Reported by syzkaller: "KASAN: slab-use-after-free Read in xfrm_alloc_spi"
> 
> Before commit 94f39804d891 ("xfrm: Duplicate SPI Handling")
> xfrm_alloc_spi would report spi=0 as unavailable.
> Add this behaviour back by adding 1 to the "low" value when it is passed as 0.
> Allocating xfrm_state with spi=0 leads to UAF or CPU stall.
> 
> Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

This is already fixed in the ipsec tree by

commit cd8ae32e4e46 ("xfrm: xfrm_alloc_spi shouldn't use 0 as SPI")

Thanks a lot anyway!

