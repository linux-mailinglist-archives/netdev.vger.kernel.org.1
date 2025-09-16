Return-Path: <netdev+bounces-223416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F59B590EF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54F01733C4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C661284B50;
	Tue, 16 Sep 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dPfeCEcX"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96B1BE871
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012056; cv=none; b=oX0hNHXLabd8pI/HiZWHQpgUtOX8Jv6enfWqH1qiJRpDcZd3im+RDQAcU9rU+LJ68geLMR2kzwICw7U/yXPNLtoUOo9lwdu+zB5pUVYFrdwd+HtTUQL1lZacYedvgj8GQdEQlqWsQeCyMOkJ2XMFfXsmBbfyfrXRs+gK3pd/zrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012056; c=relaxed/simple;
	bh=cJYEhYXMTWUNvsFy7pQizLbGwWX+KftlW82LhtLF8bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCsjTMR+gjfm1DTXKl3pcf0/d4qi/0isKAF5mpAo9p0PQDUfXg81Xb6QMdG3XDDE0ZlpDE2dUKhDh52yoYwem7tZHxPqMRjhqEnTsFpiLHm3FTTdgwrrQsizrKWpqBASKDsRuIW16MQ4xWSjVwx89Qda99YF4Y098sDrft8Cu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dPfeCEcX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0362eae-cd2f-4a83-a953-d2bbeae36857@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758012052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7Sv73ZgSd7KskYvlrKbT/Eq0g5/jOjT+g9cguZFYEk=;
	b=dPfeCEcXG8MohcOBBEV4g5T2N5kxRaejadZ9jUxkI4jar7RLhHA7T+CdjBhmKJXfoVrKVs
	RwBHhpnAopziDri5CZp/mzqrXUDAbFWUg0tpLRO/EJOAyx/RyqaDVDUPRkiSZ3Pco5gWqZ
	6oquFGdn3UbUBOy7s2IXUpJfk7EdyD4=
Date: Tue, 16 Sep 2025 09:40:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] MAINTAINERS: make the DPLL entry cover drivers
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us
References: <20250915234255.1306612-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250915234255.1306612-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16.09.2025 00:42, Jakub Kicinski wrote:
> DPLL maintainers should probably be CCed on driver patches, too.
> Remove the *, which makes the pattern only match files directly
> under drivers/dpll but not its sub-directories.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: vadim.fedorenko@linux.dev
> CC: arkadiusz.kubalewski@intel.com
> CC: jiri@resnulli.us
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47bc35743f22..4b2ef595c764 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7431,7 +7431,7 @@ S:	Supported
>   F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
>   F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>   F:	Documentation/driver-api/dpll.rst
> -F:	drivers/dpll/*
> +F:	drivers/dpll/
>   F:	include/linux/dpll.h
>   F:	include/uapi/linux/dpll.h

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

