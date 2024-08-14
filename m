Return-Path: <netdev+bounces-118426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2C9518CF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB431C21174
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88201AE042;
	Wed, 14 Aug 2024 10:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60AC1AE037
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631409; cv=none; b=GEmrE6gWMR0AbWRlRY5TwX23t6UT6/7lYnKcuYQt9fNpms3o7FB9MxGdw+XB1JRNseZICo1AZ2KyM76u7Bvs3n/DVdIGbtl7qyTbvCw0TLhdvZpXzIY7K8IFghLNhYoApwrJQAGMaihceCxJN3FjKGosRQYxFXjjAgq5tOXvYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631409; c=relaxed/simple;
	bh=Dn/9MYtOrESdqUgpwtWU62FaPTdI8i3aMe/ncgKcwLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exrWhqQ3EP6tyjn0LzmrmBzOGlcqD5ssub16XRDWyi5ZAA8J8ukKIbsuTsn+IuJdqtp7qY+ZssyRt3f18MQ7ULKMP7vfLAeg/iM4qHq0hjKiEcx/vWxVymxE8gXFs0gVtfA0qfHwESV+7AKKFxDfeJfCtnaV5oJ7TZ+K+Gl79lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so768829266b.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 03:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631406; x=1724236206;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PFYWxT5chWAM7+l+vG+WNnXh5IHrIxl9IsLYhZqqnc=;
        b=LK2+6zD1reoS9PEdruq9gSzy3/HM/5JxHjkjEnlkVA3NGpqXn7sW48cvxYAjMxYS3P
         seUmQlZ6FfayctdwRPHSa5CkcJNor5iszfdfLtGJkJm4Nyxt2jaq4DzAAMfWsCmdM3R3
         iG8HS2wDSQVY8oHvsLlbIiIRsGgvr24dNSEESW3sY5EEsZazySghcyFq8y3FfthBj8r/
         XDDMKT18sBTYG8AuW9d30ql1ZsqLdb36FjpuR+B58+Y0D4NLrqt79nYldpJRMrHeK+Bw
         KFJpbRMWdL3OExY34cIIkI/RnczrxNs5LtIU7GK7g5qKhc9CLyGfOegu2YIvyWmekMzi
         VRLA==
X-Forwarded-Encrypted: i=1; AJvYcCWQTONOvcn2FPTvxPxYm3IGP9XlJGCjy9+MbCbjckvjKqmYkGkCBZq8nHxDeTgr9v1JZJBYe+lcXjp/i8/UiBaACth+4fYp
X-Gm-Message-State: AOJu0YynXInuXiBzB+pfIwH+Hr527Xp6j3kb9oXKCe7KSKf2L+9rHZ6V
	pnMPL04TZ0AhXY+xbCYCQ3Fc7PN8kL4T2PvvOfYcridWEm5bj7+d
X-Google-Smtp-Source: AGHT+IEtageuySdO5Z1U8QEEgPtUU3yHC+cw4ojQt9U/1gd/dcF+Uq1o+EteF98hiD/AAxlzZG3Eog==
X-Received: by 2002:a17:907:e282:b0:a7a:bae8:f29d with SMTP id a640c23a62f3a-a8366c2f713mr153158766b.6.1723631405659;
        Wed, 14 Aug 2024 03:30:05 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f4b81bsm158575766b.16.2024.08.14.03.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:30:05 -0700 (PDT)
Message-ID: <831c8bb5-fb39-439b-9ffa-3f55620cb6b3@kernel.org>
Date: Wed, 14 Aug 2024 12:30:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org
References: <20240805220500.1808797-1-vadfed@meta.com>
 <2024081350-tingly-coming-a74d@gregkh>
 <a38797d7-326d-4ca9-b764-61045ad17b50@linux.dev>
 <dc9df0fd-6344-49ad-87c6-8e5c63857bd6@kernel.org>
 <6a28249c-be3a-498a-8a48-af853350c5d8@linux.dev>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <6a28249c-be3a-498a-8a48-af853350c5d8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14. 08. 24, 10:37, Vadim Fedorenko wrote:
> On 14/08/2024 06:00, Jiri Slaby wrote:
>> On 13. 08. 24, 20:24, Vadim Fedorenko wrote:
>>> On 13/08/2024 10:33, Greg Kroah-Hartman wrote:
>>>> On Mon, Aug 05, 2024 at 03:04:59PM -0700, Vadim Fedorenko wrote:
>>>>> Starting v6.8 the serial port subsystem changed the hierarchy of 
>>>>> devices
>>>>> and symlinks are not working anymore. Previous discussion made it 
>>>>> clear
>>>>> that the idea of symlinks for tty devices was wrong by design. 
>>>>> Implement
>>>>> additional attributes to expose the information. Fixes tag points 
>>>>> to the
>>>>> commit which introduced the change.
>>>>>
>>>>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be 
>>>>> children of serial core port device")
>>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>>> ---
>>>>>   drivers/ptp/ptp_ocp.c | 68 
>>>>> +++++++++++++++++++++++++++++++++----------
>>>>>   1 file changed, 52 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>>>>> index ee2ced88ab34..7a5026656452 100644
>>>>> --- a/drivers/ptp/ptp_ocp.c
>>>>> +++ b/drivers/ptp/ptp_ocp.c
>>>>> @@ -3346,6 +3346,55 @@ static EXT_ATTR_RO(freq, frequency, 1);
>>>>>   static EXT_ATTR_RO(freq, frequency, 2);
>>>>>   static EXT_ATTR_RO(freq, frequency, 3);
>>>>> +static ssize_t
>>>>> +ptp_ocp_tty_show(struct device *dev, struct device_attribute 
>>>>> *attr, char *buf)
>>>>> +{
>>>>> +    struct dev_ext_attribute *ea = to_ext_attr(attr);
>>>>> +    struct ptp_ocp *bp = dev_get_drvdata(dev);
>>>>> +    struct ptp_ocp_serial_port *port;
>>>>> +
>>>>> +    port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);
>>>>
>>>> That's insane pointer math, how do we know this is correct?
>>>>
>>>>> +    return sysfs_emit(buf, "ttyS%d", port->line);
>>>>> +}
>>>>> +
>>>>> +static umode_t
>>>>> +ptp_ocp_timecard_tty_is_visible(struct kobject *kobj, struct 
>>>>> attribute *attr, int n)
>>>>> +{
>>>>> +    struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
>>>>> +    struct ptp_ocp_serial_port *port;
>>>>> +    struct device_attribute *dattr;
>>>>> +    struct dev_ext_attribute *ea;
>>>>> +
>>>>> +    if (strncmp(attr->name, "tty", 3))
>>>>> +        return attr->mode;
>>>>> +
>>>>> +    dattr = container_of(attr, struct device_attribute, attr);
>>>>> +    ea = container_of(dattr, struct dev_ext_attribute, attr);
>>>>> +    port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);
>>>>
>>>> That's crazy pointer math, how are you ensured that it is correct?  Why
>>>> isn't there a container_of() thing here instead?
>>>
>>> Well, container_of cannot be used here because the attributes are static
>>> while the function reads dynamic instance. The only values that are
>>> populated into the attributes of the group are offsets.
>>> But I can convert it to a helper which will check that the offset 
>>> provided is the real offset of the structure we expect. And it could 
>>> be reused in both "is_visible" and "show" functions.
>>
>> Strong NACK against this approach.
>>
>> What about converting those 4 ports into an array and adding an enum { 
>> PORT_GNSS, POTR_GNSS2, PORT_MAC, PORT_NMEA }?
> 
> Why is it a problem? I don't see big difference between these 2
> implementations:
> 
> struct ptp_ocp_serial_port *get_port(struct ptp_ocp *bp, void *offset)
> {
>      switch((uintptr_t)offset) {
>          case offsetof(struct ptp_ocp, gnss_port):
>              return &bp->gnss_port;
>          case offsetof(struct ptp_ocp, gnss2_port):
>              return &bp->gnss2_port;
>          case offsetof(struct ptp_ocp, mac_port):
>              return &bp->mac_port;
>          case offsetof(struct ptp_ocp, nmea_port):
>              return &bp->nmea_port;
>      }
>      return NULL;
> }
> 
> and:
> 
> struct ptp_ocp_serial_port *get_port(struct ptp_ocp *bp, void *offset)
> {
>      switch((enum port_type)offset) {
>          case PORT_GNSS:
>              return &bp->tty_port[PORT_GNSS];
>          case PORT_GNSS2:
>              return &bp->tty_port[PORT_GNSS2];
>          case PORT_MAC:
>              return &bp->tty_port[PORT_MAC];
>          case PORT_NMEA:
>              return &bp->tty_port[PORT_NMEA];
>      }
>      return NULL;
> }
> 
> The second option will require more LoC to change the initialization
> part of the driver, but will not simplify the access.
> If you suggest to use enum value directly, without the check, then
> it will not solve the problem of checking the boundary, which Greg
> refers to AFAIU.

Why do you need this get_port() here at all? Simply doing 
bp->tty_port[ea->var] as in already present attrs will do the job, right?

thanks,
-- 
js
suse labs


