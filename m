Return-Path: <netdev+bounces-118147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B4950C29
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC31C2276F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AAF1A2C1E;
	Tue, 13 Aug 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHu1oXEY"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43741A2560
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573485; cv=none; b=Z4CDRuYzcL3IfFDoRbTrOkFRnktQ+nrSMblC/UMvGH+6duRmdhqT2UHWuYTQIRqClcBxh4zpnhA8pLaNelGb2IzwRp1gdnkTOgsfMD0jK/ZKlMWC4CDAxhpgu3O4xeHkNVV3UchsSvnwsd/TgH1uwNtJKSnC7ivqrhqu3qfIPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573485; c=relaxed/simple;
	bh=V25gXFT6Ge58fu+VNMb6fXZGa6Q3IKYkqZdhrjhuFw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUMEKljS5fD0qgGqgwZIlocg87ufBXt5hv7utun2Q1T/pNQMeLRJPBQG12a5sbKPV3Mwv3lR6Y8PNitQS2hRb5F2qYdKvTEsKipSlC9V/72vffXbKGrZCbdd16Gltg2sC3IOdxKQtpdtnoe82BT/gz+ZXdmuQg16dY7Sm9pKjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHu1oXEY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a38797d7-326d-4ca9-b764-61045ad17b50@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723573482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKs6hMOw0cMo4qOm0qaIX248eidjrNDg0b3J2eu5kUY=;
	b=hHu1oXEYm4cw8CBbVLz4cA0S8iYcWEVc1oGm1SBKks6Zj8Hfct5d7Hus4YPumaZlaP+kXL
	wGkWbwr3aAJ9NB1E04hbabVbg9JYj5bUEllkmAvZm3xDt69xbTMayYUPiyGeeGzhRbh8yb
	oUf5JmZZnp0bZPIvzxdPQVrogliVLb0=
Date: Tue, 13 Aug 2024 19:24:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, netdev@vger.kernel.org
References: <20240805220500.1808797-1-vadfed@meta.com>
 <2024081350-tingly-coming-a74d@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2024081350-tingly-coming-a74d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/08/2024 10:33, Greg Kroah-Hartman wrote:
> On Mon, Aug 05, 2024 at 03:04:59PM -0700, Vadim Fedorenko wrote:
>> Starting v6.8 the serial port subsystem changed the hierarchy of devices
>> and symlinks are not working anymore. Previous discussion made it clear
>> that the idea of symlinks for tty devices was wrong by design. Implement
>> additional attributes to expose the information. Fixes tag points to the
>> commit which introduced the change.
>>
>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   drivers/ptp/ptp_ocp.c | 68 +++++++++++++++++++++++++++++++++----------
>>   1 file changed, 52 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>> index ee2ced88ab34..7a5026656452 100644
>> --- a/drivers/ptp/ptp_ocp.c
>> +++ b/drivers/ptp/ptp_ocp.c
>> @@ -3346,6 +3346,55 @@ static EXT_ATTR_RO(freq, frequency, 1);
>>   static EXT_ATTR_RO(freq, frequency, 2);
>>   static EXT_ATTR_RO(freq, frequency, 3);
>>   
>> +static ssize_t
>> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
>> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
>> +	struct ptp_ocp_serial_port *port;
>> +
>> +	port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);
> 
> That's insane pointer math, how do we know this is correct?
> 
>> +	return sysfs_emit(buf, "ttyS%d", port->line);
>> +}
>> +
>> +static umode_t
>> +ptp_ocp_timecard_tty_is_visible(struct kobject *kobj, struct attribute *attr, int n)
>> +{
>> +	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
>> +	struct ptp_ocp_serial_port *port;
>> +	struct device_attribute *dattr;
>> +	struct dev_ext_attribute *ea;
>> +
>> +	if (strncmp(attr->name, "tty", 3))
>> +		return attr->mode;
>> +
>> +	dattr = container_of(attr, struct device_attribute, attr);
>> +	ea = container_of(dattr, struct dev_ext_attribute, attr);
>> +	port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);
> 
> That's crazy pointer math, how are you ensured that it is correct?  Why
> isn't there a container_of() thing here instead?

Well, container_of cannot be used here because the attributes are static
while the function reads dynamic instance. The only values that are
populated into the attributes of the group are offsets.
But I can convert it to a helper which will check that the offset 
provided is the real offset of the structure we expect. And it could be 
reused in both "is_visible" and "show" functions.

> thanks,
> 
> greg k-h


