Return-Path: <netdev+bounces-236877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EDC412F3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9BEE4E51E8
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE49295DAC;
	Fri,  7 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3asmT3V"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A91DB125
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538479; cv=none; b=kk92KrDWxOjEds+dLv7pueJ9qmgTypuR1HwjFuK//dAxJu6POSGWQ3u/tP/VepjnBSQCzV8AWLtThTCPV17kK8FRlZ0Y9060HQbIdv03MnnMeouXYmmueczfMdKAaWc6plR32EhehYxxgmdE9qNEAO+z9SS43q6V7x1B3RG6yhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538479; c=relaxed/simple;
	bh=h3U6wkQUVKXBFLoXt7I24LS6WiGGAaHs05KTgE1xk4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0TD4lKmqilE0mBqARzxbAjG8F9XvAjPkJQlMkQpmcyKImmIjYDUGydhZpaIzF9fEdb2B+KMnWqI8Hlh3lLIoYBPU38pk4zTMsOb9yOkyRG5Eg8vufwKzCHyM6dpGAaBvNsZbjJIH/ttE25ruYjpwkUkSPUcMS8MJbMT4AzkQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3asmT3V; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd54cc15-b51f-4bf7-9362-2086031a9c7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762538473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apID74Euc7USZiCjVL0Jk33yLeWITRkTPWzpBzwP2Zg=;
	b=s3asmT3VDZYM1Nghx7ZOvTnzKHG3092h2MoIgsqtxuuvlUDe3/zCmn1KWbNt0iNSnesNJB
	KcjMTdoLaFVNPue01+aAaprN91HXo3RtDsQjxpglL+zXJzB33YK2QPZ42/lczvOsfClKCB
	oCByuU6uqqKqIeo+ZifpgowLQrV42Pk=
Date: Fri, 7 Nov 2025 18:01:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Document sysfs output format for backward
 compatibility
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107074533.416048-1-zhongqiu.han@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251107074533.416048-1-zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/11/2025 07:45, Zhongqiu Han wrote:
> Add a comment to ptp_ocp_tty_show() explaining that the sysfs output
> intentionally does not include a trailing newline. This is required for
> backward compatibility with existing userspace software that reads the
> sysfs attribute and uses the value directly as a device path.
> 
> A previous attempt to add a newline to align with common kernel
> conventions broke userspace applications that were opening device paths
> like "/dev/ttyS4\n" instead of "/dev/ttyS4", resulting in ENOENT errors.
> 
> This comment prevents future attempts to "fix" this behavior, which would
> break existing userspace applications.
> 
> Link: https://lore.kernel.org/netdev/20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com/
> Link: https://lore.kernel.org/netdev/aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>   drivers/ptp/ptp_ocp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index a5c363252986..eeebe4d149f7 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3430,6 +3430,12 @@ ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	struct dev_ext_attribute *ea = to_ext_attr(attr);
>   	struct ptp_ocp *bp = dev_get_drvdata(dev);
>   
> +	/*
> +	 * NOTE: This output does not include a trailing newline for backward
> +	 * compatibility. Existing userspace software uses this value directly
> +	 * as a device path (e.g., "/dev/ttyS4"), and adding a newline would
> +	 * break those applications. Do not add a newline to this output.
> +	 */
>   	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
>   }
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

