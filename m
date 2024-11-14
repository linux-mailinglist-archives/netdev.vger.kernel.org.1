Return-Path: <netdev+bounces-144935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89199C8CB3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3441F22127
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7113F44375;
	Thu, 14 Nov 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ijaZRq3J"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0B3D96D
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593974; cv=none; b=UVTsx10BfCOEh1p75m5tIvK0eAWMv4Z8QKIiS5/YH/P73HLGMMIAMMEP0847FqkGkyFi35wMSgDVwjt7wcgOkntTB3UjzYBjpLf7xz/IO6fo82PhCbDJbfIcd+CHriEDc7GjvNQHpL2mMFaqMqyXS6M7RvVAFv/Xp3N7Uy44K4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593974; c=relaxed/simple;
	bh=GoDf7z5WJuWKzli4ZEacTL3ZAKDDFzQoXaPHL6Tfwo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XBq8wSXVGPscsRiIjHJ/Lwd1u7aGQN3d2kiO4J0+of06E5BEwhfyoDu8avzs6qp1bcstleRmhNLrFKSiBl1zQB41uRQmzhLY1ONysagxlMQ0MhcSLt7T0ZsKNeyn6ITM48AH44abfTbpw0z2h1CDPMDDUpBlI/Kp3r7bDKY9LeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ijaZRq3J; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd034633-c70e-4f54-975b-ef0f21f53c70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731593970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJTkravJ8yLgz3NsCUGzMlvGqmMYI53Ri1ZvCYMUohU=;
	b=ijaZRq3JusL+BPzNUBYojIErqJjx5h2DIbQ7+BfaMaMlR/2OUA5sHMDJ9IooU+mHSDw+oz
	l+u21eiXtCpmBOkwwrkkqHeI7h4RFb7sP7H5kZzfhs9Dy9xw8xyz+sjqWhb+/WmBbLDLu3
	mczE6MKWRs+XSrANrdbX3gFi9jNy8kg=
Date: Thu, 14 Nov 2024 14:19:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com
References: <20241114120455.5413-1-divya.koppera@microchip.com>
 <20241114120455.5413-4-divya.koppera@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241114120455.5413-4-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/11/2024 12:04, Divya Koppera wrote:
> Add ptp library support in Kconfig
> As some of Microchip T1 phys support ptp, add dependency
> of 1588 optional flag in Kconfig
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v1 -> v2 -> v3 -> v4
> - No changes
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

