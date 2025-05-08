Return-Path: <netdev+bounces-189077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E79AB04C8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889821BA34EC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5EE28A1D7;
	Thu,  8 May 2025 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jx1jR0gp"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673928C5A7
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736876; cv=none; b=AElCKj0m+mZxWDwU2aXMippN1q3Lb6DTo6rg8lIkXZ+qtkiaAmb0HP60atmmkEWEEmn4Bvr28wPSsu3T7jGPiTPZrfrIUqFSK1ZqqlLW84bAovmTvNDAZGs1iQXp+Q/d8riJMdt+6Ymlh5Y6KXqBHZBUoHtWPURndRUZ0ipixP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736876; c=relaxed/simple;
	bh=37lV7jPkW6YLz6WO5s2EcM1hxUEERekb4IJ7GhriYd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lniaxdAwAW7rdwAZh1gfnlGZ00anRn71+0xRsHR3bx+1qosYRit0x+RML45PZhcZl4fajZ9Em0XWg/MD+/byilT8AqdFjV8Gk9Ev+gSxjgkOxGxAKXcuPxT9ya4kS1UlLS7gWGvPFNA1uf2c4rF90zdN3RjvQ6CrOGi51quLpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jx1jR0gp; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52b8aa58-d0ec-40ac-b4c9-277d9a1061ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746736873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQucGydOn5xsFCXrercW6KxVZ/vpaAqjNKGUt41GUao=;
	b=jx1jR0gpXuWbZPepm3f9jklTARJAFPGpaQsjvk14OWAGxIv32Ba7axHlMf5eIKbxq73al9
	lM50VhpKZ94Yv6/ps3HmDUN5/NVQklDV35dWqg2h3hSg6HG3OwOvHsTlAY2TLenkcngeG5
	gEl0u4YiRzPd+KDLhBl6mQ0iSKW7p90=
Date: Thu, 8 May 2025 21:41:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: dpaa2-eth: convert to
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 14:41, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the DPAA2 Ethernet driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> This driver only responds to SIOCSHWTSTAMP (not SIOCGHWTSTAMP) so
> convert just that.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LX2160A

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

