Return-Path: <netdev+bounces-189104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E0AB061D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 00:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4FA7BC2CA
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5AE224AFE;
	Thu,  8 May 2025 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EKbQ/BkL"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CF224FD
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746744757; cv=none; b=RUQxfl22+Gw01yvjUvuZDIgsmGGtj0pXAlOE5P9jEtIDRNRjTUJgGOXX9ji206+jVhJKN+mmvEV5huXSfPLn6p0GWjoMgGJ1f87omLsZ9PmUsgmuMXbTFmYn7Y69DyxKsEO7mZqcYhmYnw0IkjTdIVk6XsU1fMDKkVRm5x/LHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746744757; c=relaxed/simple;
	bh=Z0Y846iHN4tsFymQyVnFc+uRd774FOZ+CFSaABkuboo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0CBJncP6sGQfEGb2PXX7cGiCdUeAzZV44hG1CRBycmfLMVj0XLBPWt/3HdDtJoREJqq3EQAodrBgbN5ryjI3+MitA3/qMxkqXmFjoPvhTXYNw7IqGBuR4jnrn37nrsi779IvC3pCuDilMogQpgv2S7qE+bxbKv+QotgJk2MSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EKbQ/BkL; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9dba1da-34cf-4786-b463-6836f3bae0c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746744753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3eDGiLxYlAt+/pMDts6bkeRPseipyTsamG8BWSmPH8=;
	b=EKbQ/BkLtro67RmyoXLZUIy72RkL8jlkGAN+UDFxJ1EYZ+117bX1YZg9mMcQENFY45Dozo
	eUAesbz7L1oprxsUfZDZx7GXX/WHqJb/yhKlV/LSimNrWWxtzGq0HV3V7LZwcYHEbeMguh
	tLiiSnVn9z/2O0oqaurAkYha+HfvzF0=
Date: Thu, 8 May 2025 23:51:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: gianfar: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250508143659.1944220-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508143659.1944220-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 15:36, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the gianfar driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> Don't propagate the unnecessary "config.flags = 0;" assignment to
> gfar_hwtstamp_get(), because dev_get_hwtstamp() provides a zero
> initialized struct kernel_hwtstamp_config.
> 
> After removing timestamping logic from gfar_ioctl(), the rest is
> equivalent to phy_do_ioctl_running(), so provide that directly as our
> ndo_eth_ioctl() implementation.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LS1021A

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



