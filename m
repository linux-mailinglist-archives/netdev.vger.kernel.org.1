Return-Path: <netdev+bounces-248993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1341D125C1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76626301DE36
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64883563E8;
	Mon, 12 Jan 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PbC+oshL"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4D283FCD
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218297; cv=none; b=eXQ708gh/GZvnsXsAlqPsSHZbMI8K4ndBaRBDMUNq/lOoYdA9lG+oIXyW/I8hy65PBskHclVVUhTF5BF+eBZzVXhKPvE+ympnM9LZeTa//Z+JQ7ltLStpo+deEPSOUwoz8hHK8st+Gxy3397gasGzXvEemBCepdtDQ0rqSPwTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218297; c=relaxed/simple;
	bh=gDyz9DEwu/PJ1o/0DeT833g8qAnydvU1mNL95N6NRRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOIYmzHO7nWXdnfXid3GEiN8Ek/oIu9+i3i2TJCG5mnjfWEvPDRsM96b2CCliQGyUqPCVJHzktFSsrW4H7nyZRU9/CPKPONIFwLVocz7tt6ZgzK0Dhv06EW3g0mNiW0ICYrJSqL13dDC8TNEmMJB2r6hL4Dek0fOYlaWXO5+vCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PbC+oshL; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba9928dc-2701-4e6e-a8b2-73a5484f75b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768218294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJLXyEczMZIPV6uir4SSL+PQjYmTXJlf4x91gK7pPbA=;
	b=PbC+oshLQP2z7U2LHV/ErsEAReN1s7YI0iQ8xALRJa8VHMCNIwNCU07w0Oo7YcrQ9/9FI3
	HyUVjkD94UTUWVeQH+0C5YHHoZFTD0EaQAYrKnX8IXK8fjTpRfFN3WB5YWCxgTbSa3tboG
	1hT1rGwIReEO3Roy6MwAHebLZmdROm4=
Date: Mon, 12 Jan 2026 11:44:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] dpll: add dpll_device op to get supported
 modes
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260112101409.804206-1-ivecera@redhat.com>
 <20260112101409.804206-2-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260112101409.804206-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/01/2026 10:14, Ivan Vecera wrote:
> Currently, the DPLL subsystem assumes that the only supported mode is
> the one currently active on the device. When dpll_msg_add_mode_supported()
> is called, it relies on ops->mode_get() and reports that single mode
> to userspace. This prevents users from discovering other modes the device
> might be capable of.
> 
> Add a new callback .supported_modes_get() to struct dpll_device_ops. This
> allows drivers to populate a bitmap indicating all modes supported by
> the hardware.
> 
> Update dpll_msg_add_mode_supported() to utilize this new callback:
> 
> * if ops->supported_modes_get is defined, use it to retrieve the full
>    bitmap of supported modes.
> * if not defined, fall back to the existing behavior: retrieve
>    the current mode via ops->mode_get and set the corresponding bit
>    in the bitmap.
> 
> Finally, iterate over the bitmap and add a DPLL_A_MODE_SUPPORTED netlink
> attribute for every set bit, accurately reporting the device's capabilities
> to userspace.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

