Return-Path: <netdev+bounces-189075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E2AB04BF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F887A0862
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACAD28BA9F;
	Thu,  8 May 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I15lbxJr"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284721D5B6
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736774; cv=none; b=UAtiPzPl2wjy3Y54x5PBGtQ9JSOzXZhSJETJapNO8KljPKDZjrG9Y1Bg5emOdIV6iNc5LONzXtSIShuUAnx1HhA5SUeVGpfKE7uZGLNh17rLNam0UEw/8u54G/xeO631UtHW9I+3swa7o2dpwv/g5U9QNnC2JW3SqF+a0zZ7rek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736774; c=relaxed/simple;
	bh=OzrAaiNREhsCcZ5piTxWmi5+xi0338q9UN3vldT6s/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1qfk2d9xTsncPOYMZCu1B0abft5Qrm5myPJM+VsbYQ/Bi901plb7HaUymoHqEwNCdg5XHdUDFgiFRwrUBioonBWcVx98UWN21sxXsWlwKewIT2EcuWtO+JloumoKi6baC6uQDZTu9N/5CjJ3CjVDoaPTnUOIyaKmyU9/sms/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I15lbxJr; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7395888c-d674-44aa-9220-dda90d7f6b96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746736770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exTPBcS6ztBxyKvnjJwhYkGJFCh4zMeDA6QE+FUcAlM=;
	b=I15lbxJrG72hXUNDBxg6q/6/D77tZkwbiPuWZKMC0RLWZ+CQAI19SKfuDJUeBF6z8skT3v
	gn1cXvRp7Pam9c6nlRAePIc/Sg1DRwhsd1WN2mp4UAy4NE/2SyMkIpzrw4H51dTFO5oDkd
	g763gvLCn/GOQPxjniGMWbm5BJOvfnE=
Date: Thu, 8 May 2025 21:39:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/3] dpaa_eth conversion to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 13:47, Vladimir Oltean wrote:
> This is part of the effort to finalize the conversion of drivers to the
> dedicated hardware timestamping API.
> 
> In the case of the DPAA1 Ethernet driver, a bit more care is needed,
> because dpaa_ioctl() looks a bit strange. It handles the "set" IOCTL but
> not the "get", and even the phylink_mii_ioctl() portion could do with
> some cleanup.
> 
> Vladimir Oltean (3):
>    net: dpaa_eth: convert to ndo_hwtstamp_set()
>    net: dpaa_eth: add ndo_hwtstamp_get() implementation
>    net: dpaa_eth: simplify dpaa_ioctl()
> 
>   .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 41 ++++++++++---------
>   1 file changed, 21 insertions(+), 20 deletions(-)
> 
For the series:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

