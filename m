Return-Path: <netdev+bounces-233869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FEAC19A91
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C957646349A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49B72FB62D;
	Wed, 29 Oct 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7pGT2rO"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F52FC01A;
	Wed, 29 Oct 2025 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733252; cv=none; b=pzKXX4So2cqXBGsiOMFtoAZcUG3WMS1t4svF9lrApcRjk3WCPUJFYK4xGLBt6vzVl9t8xeUrZ5ZRgzIdpQLNL3eptB+Ti4yfA1cgmYwwxrGyTIw7YFKmomaCgo69KHKbZaaaOUE61/7uta1IZRd8BJtzm0dqxoQfuTldZXRLlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733252; c=relaxed/simple;
	bh=tZH2MFQROUgThRcgEuFL8l07GBDwuI8QzuO8RFhtbQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMC1r7Z5nsXwdo9zTyfrNP5Ee6S/4O/98nwyTx+7sVo6cYlM7SQzUy+0C83r+w12A3SSEmmjhf4vK/TIGuFt1e3UTpALuaS5cKdfcu0yZJ7qO/p4tKdzxegAdxzZA0izCSxY2WkVvqQ+A0Y4x9H9bBeSroUrUX2cpsX7guhGgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7pGT2rO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e878c19-077c-4e2f-8065-fe62296a5094@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761733237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDaiTXQP14JHHPE0XuBOV5J1pUUU1Y9JQ/SRe31gCyM=;
	b=E7pGT2rOm0PcEZwQbY1pJuZOdvTDSsj+swA8Fqk9SUHQm5uVtb5uUb5qPgaLo3jIB3PF/H
	sUt8/Gr/s7eZxJc7I36CeZ/wE+C8X/+czTNmqSwL3EXC5obrIE8+N24aK6TLuevN6PQqoA
	WuMH5ANcKD2Svaw2B2nSuPRmFBz+Pko=
Date: Wed, 29 Oct 2025 10:20:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] dpll: add phase-adjust-gran pin attribute
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024144927.587097-1-ivecera@redhat.com>
 <20251024144927.587097-2-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251024144927.587097-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/10/2025 15:49, Ivan Vecera wrote:
> Phase-adjust values are currently limited by a min-max range. Some
> hardware requires, for certain pin types, that values be multiples of
> a specific granularity, as in the zl3073x driver.
> 
> Add a `phase-adjust-gran` pin attribute and an appropriate field in
> dpll_pin_properties. If set by the driver, use its value to validate
> user-provided phase-adjust values.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Petr Oros <poros@redhat.com>
> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   Documentation/driver-api/dpll.rst     | 36 +++++++++++++++------------
>   Documentation/netlink/specs/dpll.yaml |  7 ++++++
>   drivers/dpll/dpll_netlink.c           | 12 ++++++++-
>   include/linux/dpll.h                  |  1 +
>   include/uapi/linux/dpll.h             |  1 +
>   5 files changed, 40 insertions(+), 17 deletions(-)
> 
> @@ -1261,7 +1265,13 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
>   	if (phase_adj > pin->prop.phase_range.max ||
>   	    phase_adj < pin->prop.phase_range.min) {
>   		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
> -				    "phase adjust value not supported");
> +				    "phase adjust value of out range");
> +		return -EINVAL;
> +	}
> +	if (pin->prop.phase_gran && phase_adj % pin->prop.phase_gran) {
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, phase_adj_attr,
> +					"phase adjust value not multiple of %u",
> +					pin->prop.phase_gran);

That is pretty strict on the uAPI input. Maybe it's better to allow any
value, but report back the one that is really applied based on driver's
understanding of hardware? I mean the driver is doing some math before
applying the math, it can potentially round any value to the closest
acceptable and report it back?

>   		return -EINVAL;
>   	}
>   

