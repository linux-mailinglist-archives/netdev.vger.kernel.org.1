Return-Path: <netdev+bounces-118373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EB49516B5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B69E280FCD
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155913F01A;
	Wed, 14 Aug 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lgjK4w4d"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8913AD18
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624646; cv=none; b=hWuAh08q0dzZBitnwb3oJxHp7nQsnkmuSCn+hTtTDdaSNyg+f0W7TCAotT+ldfgtFVcyU/QfOU6IzYmRtoaxZoZ3hlHYcr4pEWC17UGT07eKUN4k2h4BpXCbcsCc57RsAdEwUr1X9m+TVTqmqdAThlNp4WtEEsGLHg2fFcGYAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624646; c=relaxed/simple;
	bh=aZOB9mN762DDkKivmK/LpSGlLxoxhfXRQmMRy9JdTLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUHQ7uwGAwG/93r6/e/ozoDCEH6GZQ+nVWYLlgRyBpPdtXrX1ITxG9hWWM3zfXoumCQat2IHWR5cCARjJaEceDogNvQ27ZmDmxaHaSbyfQq8wtyR5UHXXPXvuVTxcTmUrIHJNetvI/BavO4RsyjeYZAG3s0TzILswlAVb3Gx97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lgjK4w4d; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a28249c-be3a-498a-8a48-af853350c5d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723624641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZU85aRcnLeKwDO62xl2WYaro1cSTjHoMcnP7VtGOiLo=;
	b=lgjK4w4dB5XtCoKI5QFEE21CO4Vv8NOBj5YtrmByO9Lx0XhGDFdKY5c3lxeyEJ3G0/+Hlt
	DM9mUUkaNTRrFIcqOc8Yjwuk2+Pm87Ls7r4u8i+tsyEMPD2IqI917qnPpqpmH68u5UvCu4
	HZ5Zb2v5Ahs3KbVqQWYzJQ8qwues2mo=
Date: Wed, 14 Aug 2024 09:37:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org
References: <20240805220500.1808797-1-vadfed@meta.com>
 <2024081350-tingly-coming-a74d@gregkh>
 <a38797d7-326d-4ca9-b764-61045ad17b50@linux.dev>
 <dc9df0fd-6344-49ad-87c6-8e5c63857bd6@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <dc9df0fd-6344-49ad-87c6-8e5c63857bd6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 14/08/2024 06:00, Jiri Slaby wrote:
> On 13. 08. 24, 20:24, Vadim Fedorenko wrote:
>> On 13/08/2024 10:33, Greg Kroah-Hartman wrote:
>>> On Mon, Aug 05, 2024 at 03:04:59PM -0700, Vadim Fedorenko wrote:
>>>> Starting v6.8 the serial port subsystem changed the hierarchy of 
>>>> devices
>>>> and symlinks are not working anymore. Previous discussion made it clear
>>>> that the idea of symlinks for tty devices was wrong by design. 
>>>> Implement
>>>> additional attributes to expose the information. Fixes tag points to 
>>>> the
>>>> commit which introduced the change.
>>>>
>>>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be 
>>>> children of serial core port device")
>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>> ---
>>>>   drivers/ptp/ptp_ocp.c | 68 
>>>> +++++++++++++++++++++++++++++++++----------
>>>>   1 file changed, 52 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>>>> index ee2ced88ab34..7a5026656452 100644
>>>> --- a/drivers/ptp/ptp_ocp.c
>>>> +++ b/drivers/ptp/ptp_ocp.c
>>>> @@ -3346,6 +3346,55 @@ static EXT_ATTR_RO(freq, frequency, 1);
>>>>   static EXT_ATTR_RO(freq, frequency, 2);
>>>>   static EXT_ATTR_RO(freq, frequency, 3);
>>>> +static ssize_t
>>>> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, 
>>>> char *buf)
>>>> +{
>>>> +    struct dev_ext_attribute *ea = to_ext_attr(attr);
>>>> +    struct ptp_ocp *bp = dev_get_drvdata(dev);
>>>> +    struct ptp_ocp_serial_port *port;
>>>> +
>>>> +    port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);
>>>
>>> That's insane pointer math, how do we know this is correct?
>>>
>>>> +    return sysfs_emit(buf, "ttyS%d", port->line);
>>>> +}
>>>> +
>>>> +static umode_t
>>>> +ptp_ocp_timecard_tty_is_visible(struct kobject *kobj, struct 
>>>> attribute *attr, int n)
>>>> +{
>>>> +    struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
>>>> +    struct ptp_ocp_serial_port *port;
>>>> +    struct device_attribute *dattr;
>>>> +    struct dev_ext_attribute *ea;
>>>> +
>>>> +    if (strncmp(attr->name, "tty", 3))
>>>> +        return attr->mode;
>>>> +
>>>> +    dattr = container_of(attr, struct device_attribute, attr);
>>>> +    ea = container_of(dattr, struct dev_ext_attribute, attr);
>>>> +    port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);
>>>
>>> That's crazy pointer math, how are you ensured that it is correct?  Why
>>> isn't there a container_of() thing here instead?
>>
>> Well, container_of cannot be used here because the attributes are static
>> while the function reads dynamic instance. The only values that are
>> populated into the attributes of the group are offsets.
>> But I can convert it to a helper which will check that the offset 
>> provided is the real offset of the structure we expect. And it could 
>> be reused in both "is_visible" and "show" functions.
> 
> Strong NACK against this approach.
> 
> What about converting those 4 ports into an array and adding an enum { 
> PORT_GNSS, POTR_GNSS2, PORT_MAC, PORT_NMEA }?

Why is it a problem? I don't see big difference between these 2
implementations:

struct ptp_ocp_serial_port *get_port(struct ptp_ocp *bp, void *offset)
{
	switch((uintptr_t)offset) {
		case offsetof(struct ptp_ocp, gnss_port):
			return &bp->gnss_port;
		case offsetof(struct ptp_ocp, gnss2_port):
			return &bp->gnss2_port;
		case offsetof(struct ptp_ocp, mac_port):
			return &bp->mac_port;
		case offsetof(struct ptp_ocp, nmea_port):
			return &bp->nmea_port;
	}
	return NULL;
}

and:

struct ptp_ocp_serial_port *get_port(struct ptp_ocp *bp, void *offset)
{
	switch((enum port_type)offset) {
		case PORT_GNSS:
			return &bp->tty_port[PORT_GNSS];
		case PORT_GNSS2:
			return &bp->tty_port[PORT_GNSS2];
		case PORT_MAC:
			return &bp->tty_port[PORT_MAC];
		case PORT_NMEA:
			return &bp->tty_port[PORT_NMEA];
	}
	return NULL;
}

The second option will require more LoC to change the initialization
part of the driver, but will not simplify the access.
If you suggest to use enum value directly, without the check, then
it will not solve the problem of checking the boundary, which Greg
refers to AFAIU.

Thanks!

