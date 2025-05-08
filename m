Return-Path: <netdev+bounces-189078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A2AB04CF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A4A3BFC73
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445228C2C7;
	Thu,  8 May 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M2JuCfa9"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBE28BA9F
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736903; cv=none; b=Yt9ar3Iw0ujYsxYCnnxgsJMdFE1KnwxUriPA9/WfKv6jxGscFdiP8bKBomzdAkA8l0KLum6deRf1ue8WhHc1cWPTlDff8d8+jayHxsgGqY1FYNZ4y8W+RbbMKQZlLhLXu6EsHEvFZgXeiMLfM5Y2e5re+8tfF2vCaPkT/lrzMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736903; c=relaxed/simple;
	bh=ioUmbuKo5pcxglh/C/a2eGwKvsxJbEfxm2KZKVxmmJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvdqVUzYhBRZTKOOXQll4/0beU7Z5U98RlZBki13ZJvNIsO/26Z+8RZT4CDnbqCQLOziWKzQbVjXtg1N97bNhFhS43V0bS80aYHA8p9/dylPcYzALIJeeQG6nLykvEINpli/XNmSiddj09N3ZJquGTKQUDuTv9y3tZx3/S35cg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M2JuCfa9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03c54e2a-61a9-4377-80c0-7037c03d3127@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746736899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnuv5y5GncHbfe6Hcr7O5i1pTYi7yqZI3Oy2vC/nr5U=;
	b=M2JuCfa98YTR/PTDnVwqyKOXNuNH0npsYfQQJf6yMLukBNl07PXXW1vvJQhtm4X2DSJiYw
	GZiYARgXixyzhUe+uCjvGK0amO02IySJD08CLBUJAEsFLLZ4zfk1BqAErHDgj44mUa1I/r
	k3mX9wA93FAFb41yc5rNx65V5NHjmFo=
Date: Thu, 8 May 2025 21:41:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: dpaa2-eth: add ndo_hwtstamp_get()
 implementation
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
 <20250508134102.1747075-2-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508134102.1747075-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 14:41, Vladimir Oltean wrote:
> Allow SIOCGHWTSTAMP to retrieve the current timestamping settings on
> DPNIs. This reflects what has been done in dpaa2_eth_hwtstamp_set().
> 
> Tested with hwstamp_ctl -i endpmac17. Before the change, it prints
> "Device driver does not have support for non-destructive SIOCGHWTSTAMP."
> After the change, it retrieves the previously set configuration.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LX2160A

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

