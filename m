Return-Path: <netdev+bounces-118853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B15953297
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934701F21D8C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C41A2C04;
	Thu, 15 Aug 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W4KBqbwz"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59C1AC8BB
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730736; cv=none; b=pnf+qPB0vghrudR2JBvv7qVhb/Bb6ydI6nTCSfpVl0X/1qN2FdARNuyI7bfft+CPTxVjVcrbhvB4HKI3ExrcI4ylNtj0Chwc9CurwkI1hjvadHdF5uJvh26upIJXJ4fNvltvxteF0rSjoZ57EQasv1P+JJH3EhS4bGvPml6Ae2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730736; c=relaxed/simple;
	bh=7n/vQDBeKBbbzCWD0cA4ocshXGZoexHngwAn7a6v9hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQTJw801YhBzUY0CZaZeeLBmGXSk6Hg/O1yR+bMFcpQ39rlVkm4TmAfZUtZRByyVCel8UXWPXX7r//mrP//dctgmsSkTGViLyly4HczxF3uH4PA36qcKk+ZrGxPMqXWplTd3JmmHk+SOg65pZsmLAYfmi1T5M+nAep38536FkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W4KBqbwz; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e9a5b58-e975-4d6b-81fd-da5e0139a552@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723730732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwEXxUePti8zumfIZwdrzr6n7M1AwXW+8eqFPHAkYPY=;
	b=W4KBqbwzQyp/dg4puh76AnvnGLc+LJlr5IYa3EpTT1xncJKoTS9b2RxOZgBDl0BsVTL4y9
	NDNWjopllZ8VBeGjUrhenXTV65F+yzVDgINzL2BtCeUT3zs0h6A7XVeimTR4gIennLcwKh
	9fqgETcEkLRuNepSNEQmn8ZoIWC/2JY=
Date: Thu, 15 Aug 2024 15:05:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Simon Horman <horms@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 netdev@vger.kernel.org
References: <20240815125905.1667148-1-vadfed@meta.com>
 <20240815135455.GE632411@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240815135455.GE632411@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/08/2024 14:54, Simon Horman wrote:
> On Thu, Aug 15, 2024 at 05:59:04AM -0700, Vadim Fedorenko wrote:
>> Starting v6.8 the serial port subsystem changed the hierarchy of devices
>> and symlinks are not working anymore. Previous discussion made it clear
>> that the idea of symlinks for tty devices was wrong by design. Implement
>> additional attributes to expose the information. Fixes tag points to the
>> commit which introduced the change.
> 
> Hi Vadim,
> 
> Would it be possible to provide a link to the discussion(s)?
> 

Hi Simon,

Yeah, sure:
the initial RFC of serial port subsystem changes is
https://lore.kernel.org/linux-serial/20231024113624.54364-1-tony@atomide.com/

the merged version is (serial port subsystem):
https://lore.kernel.org/linux-serial/20231113080758.30346-1-tony@atomide.com/

The first update to ptp_ocp driver is
https://lore.kernel.org/linux-serial/20240510110405.15115-1-vadim.fedorenko@linux.dev/

>>
>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> ...
> 
>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> 
> ...
> 
>> @@ -3346,6 +3352,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
>>   static EXT_ATTR_RO(freq, frequency, 2);
>>   static EXT_ATTR_RO(freq, frequency, 3);
>>   
>> +static ssize_t
>> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
>> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
>> +	struct ptp_ocp_serial_port *port;
> 
> nit: Port is unused in this function, it should be removed.

Ah, yeah, it was last second change, didn't clean it fully,
thanks for pointing.

> 
>> +
>> +	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
>> +}
> 
> ...


