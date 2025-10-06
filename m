Return-Path: <netdev+bounces-227958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA0BBE133
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01023AB8AE
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37E215767;
	Mon,  6 Oct 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KHsvlTTX"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A514386D
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754644; cv=none; b=kIrStYHEchcGNBWpWebuMEBj7Yro6THW51d5p0lIhNxxWRRe3dNVIRExe62DXyHFzrWNx3SSOoPbVg9WgLqVNhzyZBxIszZdQ2fsMDa3lLhu/DmPQ44Ec8vEuQ5FlMhFuIHS3h1izeORGOONO9V/ehZhLPOANfdqlqkDJXcJqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754644; c=relaxed/simple;
	bh=RpzqFCOPRwAy0JQ08wI+zAryDLFl++KwUcVT7OygO8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qS6kazH4UxVp/0EFccUpYQ4h5a52PtGymbURey9jQhBWao54FtGhOwaAr9CV4zvlP+o/vLnfEjzVJioNFVNzJd1e47AT4b2nFqVQLSTK23xsTSYu1B4vpgxJCgPRTHTwNLBvZZMnkjrNXEbAECcUXGtUzEA4YmVamr8RzxG6mXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KHsvlTTX; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55dca281-3cd3-4d8f-a57a-097805526de6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759754638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjxGuBqBVI0ht2OzmEY5h8hro1aAaWshKoMaYTp+CYE=;
	b=KHsvlTTX3avBhpsxjKSb2Y3CgPG6mXkh2kPhQQf3c6TXdYT1SnbXuUo4BBPXT1fiFJ5xE3
	rh0zYg8JyOlEKnByuVfhExhsYk4IYpOorMvFbCxWlmbspvUipY6KV6KuMHEOp/R8z6HCjo
	sIJX1mBbFsft97O7XzvLhCthxH+NX/4=
Date: Mon, 6 Oct 2025 13:43:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: netc: Add dependency on NXP_ENETC4
To: Peter Robinson <pbrobinson@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Frank Li <Frank.Li@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 netdev@vger.kernel.org
References: <20251005204946.2150340-1-pbrobinson@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251005204946.2150340-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/10/2025 21:49, Peter Robinson wrote:
> The NETC V4 Timer PTP IP works with the associated NIC
> so depend on it, plus compile test, and default it on if
> the NIC is enabled similar to the other PTP modules.
> 
> Fixes: 87a201d59963e ("ptp: netc: add NETC V4 Timer PTP driver support")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>   drivers/ptp/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 5f8ea34d11d6d..a5542751216d6 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -255,6 +255,8 @@ config PTP_S390
>   
>   config PTP_NETC_V4_TIMER
>   	tristate "NXP NETC V4 Timer PTP Driver"
> +	depends on NXP_ENETC4 || COMPILE_TEST
> +	default y if NXP_ENETC4
>   	depends on PTP_1588_CLOCK
>   	depends on PCI_MSI
>   	help

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

