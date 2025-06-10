Return-Path: <netdev+bounces-196019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D9AD32A2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A5C3B70D2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF328C858;
	Tue, 10 Jun 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hpf2pZiE"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE328C859
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548884; cv=none; b=mhe7RDIynIX0frr2P12lAxaIEVGDDtxSBqdsRlE5mKqz/8YcEIMsAw17atqZ5X40tap851jCCu6SUS/fYt5vVzO7e4v7hKMgnGKThLiCxdcAMxrYzIeBryHxIdrtgLfDAhNVhN+6pbCAZQVKiFCg0UpSQ3agKYwJ4j77i0ftS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548884; c=relaxed/simple;
	bh=d9XSuqI+qYE9P44kl4pe7Jx2ec0YC8xHPTVtNKfBp/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+OXu/893RMj0q0GwOjoC0j84XqS/uZmrNqbf/2qdqatmUSqqNBS9jOJ4S4WMxEhKCIzzIDRLPUyP7Z1wUnP51AELBIVl30VTWaR5eGoaI6Wi9OSFTFb5pKLsjIJ/mShVV1tnmsoc+kLJSnOmjMndJxaLReC7tB9Zorf6BpEifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hpf2pZiE; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6724951f-9cc0-4d4b-82f0-ad4da7555b56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749548870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIjjxToFUYd0qpGBnf0yqzRXe2c56zbTJqbkywLvZG0=;
	b=Hpf2pZiEeRJ8+xcBglTeNO7r+yRFm9v3ylGL0zQcnmhFLJn+brGN9qPA2nMoC69LPa3rOT
	2Sm0yG8BiM0X+rFsXUAgOh5itqarVysxWYHC4ArgQNSV9L8oM9EhqlgTPL+qtqn81+//i2
	c8ar14bVPrkIQkY3tePV+wZV0Z9BkhE=
Date: Tue, 10 Jun 2025 10:47:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 5/8] gve: Add support to query the nic clock
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org,
 thostet@google.com, jfraker@google.com, richardcochran@gmail.com,
 jdamato@fastly.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250609184029.2634345-1-hramamurthy@google.com>
 <20250609184029.2634345-6-hramamurthy@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250609184029.2634345-6-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/06/2025 19:40, Harshitha Ramamurthy wrote:
> From: Kevin Yang <yyd@google.com>
> 
> Query the nic clock and store the results. The timestamp delivered
> in descriptors has a wraparound time of ~4 seconds so 250ms is chosen
> as the sync cadence to provide a balance between performance, and
> drift potential when we do start associating host time and nic time.
> 
> Leverage PTP's aux_work to query the nic clock periodically.
> 
> Signed-off-by: Kevin Yang <yyd@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>   Changes in v4:
>   - release the ptp in the error path of gve_init_clock (Jakub Kicinski)
> 
>   Changes in v2:
>   - Utilize the ptp's aux_work instead of delayed_work (Jakub Kicinski,
>     Vadim Fedorenko)
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

