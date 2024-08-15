Return-Path: <netdev+bounces-118884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415589536A6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750F51C20AA4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25219DF9C;
	Thu, 15 Aug 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONeD9jmh"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D332175A5
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734387; cv=none; b=iLtS6TkyxjrlrXzNwqmEOf2vSR7Axxx334xpjH+NorJsbO3/dK5fBv+IZYxWNCiuZtjDJSzUa22FjCSi3Sr7KhLPxlG3dHjF36SyIG4WisHl5OsRrCmxN9WFbRJiOg+Ato8hIUOyd2wSRfgkgGSwz61yvzS0p0BDi9vpS39cEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734387; c=relaxed/simple;
	bh=AmMTM4YGyAfNk8YVNd2LfC01D5srFtSg+d9wNj9fS8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuwrRFpGRe4xzGT3oxFdXx3eHc5UxjUYDLYQhWPjpXOQ+Fif4hRDH0FrhjgoISzUCqf5/8zmIPefjiWoRmLr8Pjn6oSunN1gP/kSUKLLxTozzWbSRx3bHR85XRKoI6aj9VUu4fsdjB2bST/y2tBk/u4wwSzv4f0UD8Cs3b9kZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONeD9jmh; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <425655d9-2bda-48c1-99b4-1ed70faa4bd3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723734382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBE/9ZU2hPyyRPVF4fslFqOhL3RXSGbP+DlLHry7c/w=;
	b=ONeD9jmhR8BtxwHRgly67bGRemivderIq4JOTDuxO/AFmvk+9TddD9q1a+Y1WD0VO4LHOP
	V+71bHxLlkJG0ZJq8Ay6XRdHk6ScWecNaheDCpsWD+ePPpZaZL7M8SjzU52NrOquGFOSca
	CpGq7XH+93VeRxIPvo3mIY8MWeFvpFo=
Date: Thu, 15 Aug 2024 16:06:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, netdev@vger.kernel.org
References: <20240815125905.1667148-1-vadfed@meta.com>
 <2024081530-clasp-frown-1586@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2024081530-clasp-frown-1586@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/08/2024 14:41, Greg Kroah-Hartman wrote:
> On Thu, Aug 15, 2024 at 05:59:04AM -0700, Vadim Fedorenko wrote:
>> Starting v6.8 the serial port subsystem changed the hierarchy of devices
>> and symlinks are not working anymore. Previous discussion made it clear
>> that the idea of symlinks for tty devices was wrong by design. Implement
>> additional attributes to expose the information. Fixes tag points to the
>> commit which introduced the change.
>>
>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> Complicated fixes, nice!  Thanks for doing this.  One question:
> 
>> +static ssize_t
>> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
>> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
>> +	struct ptp_ocp_serial_port *port;
>> +
>> +	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
> 
> "uintptr_t"?  That's not a normal kernel type.  var is of type "void *"
> so can't this just be "int" here?  Or am I reading this wrong?

Well, yes, looks like it can be used as pure int provided enum is int
and we simply use "void *" as a transport.

I'll send v4 with this fix and the one Simon pointed in 24hr (as per
netdev policy).

Thanks!

> thanks,
> 
> greg k-h


