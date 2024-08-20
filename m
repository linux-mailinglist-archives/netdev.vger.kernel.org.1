Return-Path: <netdev+bounces-120262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7050958B9A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4E51F242C8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643018FDA9;
	Tue, 20 Aug 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qt7tqFwm"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48E18C931
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168752; cv=none; b=oVZqi8GTZsy6fNkfuPrWWx+LUWJJ4BAxuu1MJV52WYhd1gjGar5lgwfx3qg7BjGUVjFVz5Bne6NlKvzQ42SaIHtaQFfe0x6t3Z5Oq/UuhzBavUjRc7tTjXp7WS1+BNZqxt6SECqN0mg3rpfjWOB59RRs4psUJ5q2EbdXIQkwDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168752; c=relaxed/simple;
	bh=fEL3k3VH9vKHkg+zWLMd02Gj9zqu6GenXTUXkYtaHq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMOPxhDWm+3gHFxZ3b6NGoKZ9HWzbuQmz7ByavrWhuYwOPMKq0WR2iB669hiq/GICIaOX6TXQAG2saXiG+o6+Do8WogNMQbmWoAkSHexfCxo6eW2VTXfYhXAhhtVsAupt3JUBRRbwJCvOKBDVJfzpbrXwr119FV3BZE9TPbpmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qt7tqFwm; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b01f7a4a-733c-4f38-a29e-893dc15fc79d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724168747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvGWCUYzijj0bEkxNqakeGax4hSKytFK7FM4L0Ab6Ig=;
	b=Qt7tqFwmG0BecNjRTLCHiRiPMyRIU79a3rk5aku1IrCmyMgdqPU9+V6T7soWvrSaKap3BJ
	vlI/i0pudTNWX+cCgGE/46Vfg6MTN1BfaSDfGp4qJHaGJZfcZ7PNNv3GM9HeUYUCI6KVj9
	qFsMm6YGx+HiCT0Sbkij/8FLOvFQRYw=
Date: Tue, 20 Aug 2024 16:45:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240820151617.3835870-1-vadfed@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240820151617.3835870-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/08/2024 16:16, Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design [1].
> Implement additional attributes to expose the information. Fixes tag
> points to the commit which introduced the change.
> 
> [1] https://lore.kernel.org/netdev/2024060503-subsonic-pupil-bbee@gregkh/
> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v3 -> v4:
> - re-organize info printing to use ptp_ocp_tty_port_name()
> - keep uintptr_t to be consistent with other code
> v2 -> v3:
> - replace serial ports definitions with array and enum for index
> - replace pointer math with direct array access
> - nit in documentation spelling
> v1 -> v2:
> - add Documentation/ABI changes
> ---
>   drivers/ptp/ptp_ocp.c | 168 +++++++++++++++++++++++++-----------------
>   1 file changed, 102 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index ee2ced88ab34..11d96045e5ec 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ .. snip .. ]

> @@ -3346,6 +3361,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
>   static EXT_ATTR_RO(freq, frequency, 2);
>   static EXT_ATTR_RO(freq, frequency, 3);
>   
> +static ssize_t
> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	struct ptp_ocp_serial_port *port;

looks like this fix didn't get to the series for some reasons.
I'll definitely send v5 with this part removed, but other code
is good to review

> +
> +	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
> +}
> +

