Return-Path: <netdev+bounces-97898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EEA8CDBB8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 23:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF5B28362C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA18127E04;
	Thu, 23 May 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nLOmcoFH"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41947F5D
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498373; cv=none; b=Yv8ey7Z0zgrBF4fVd8uYnBf55kdIzdYNY/LdDms81Fy7v3xMlG1B9q9q6TXyPE/bd4PRIqlS0Jy7iVS93dUe2P6yxugMrsT9O9xkXG6VrU4sit96dpisshaOyGbKvCxqHfct4/toP3Us3W1EnpoDeR3CegbPiw7AANGV2/PkWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498373; c=relaxed/simple;
	bh=FWP16rPLoiB93aLa4YgyuYQEJ8Wq3im02rMOxmEa1Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhsnu31tgCl0P6yNQQqBBR9oFEEPETeRDxDFwubMl+dKcZGVUjTxiWs9P8cKm63UHu8ebLsvTRX+Mfg9fIKBsW9A/lVyYxeNUgWV4+Fcj2ff79VdS9GgCOtlJAC0tgd+ScqoL05R4o3LLvKsV+QKi4AaR0pxBaaB/5ZjSlOJWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nLOmcoFH; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: gregkh@linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716498369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HYZrZuq8Ojw1nrvcRxGdj7LQnRliXR58D/HkwOvCk8=;
	b=nLOmcoFHCbXf9wwsA/5h7s4ORWVEJFCcBHfgZDOJKGQKu60hOcwVPTedqtWq/aPsm698fA
	ThOdpwVGi8sGk24l3xg6HGcIh+Ed6CHuQnwAElsh6ruyXday2mFSlmsrv96jAhkQ020XUz
	opxM5CNK/JxykYHsvoVK9hllKm5jop4=
X-Envelope-To: kuba@kernel.org
X-Envelope-To: jirislaby@kernel.org
X-Envelope-To: jonathan.lemon@gmail.com
X-Envelope-To: linux-serial@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <9a65d299-2c3f-43b4-a3c7-4dca397dafaa@linux.dev>
Date: Thu, 23 May 2024 22:06:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <20240523083943.6ecb60d9@kernel.org>
 <2024052349-tapestry-astronaut-0de1@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2024052349-tapestry-astronaut-0de1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/05/2024 17:26, Greg Kroah-Hartman wrote:
> On Thu, May 23, 2024 at 08:39:43AM -0700, Jakub Kicinski wrote:
>> On Fri, 10 May 2024 11:04:05 +0000 Vadim Fedorenko wrote:
>>> The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
>>> of serial core port device") changed the hierarchy of serial port devices
>>> and device_find_child_by_name cannot find ttyS* devices because they are
>>> no longer directly attached. Add some logic to restore symlinks creation
>>> to the driver for OCP TimeCard.
>>>
>>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>> ---
>>> v2:
>>>   add serial/8250 maintainers
>>> ---
>>>   drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
>>>   1 file changed, 21 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>>> index ee2ced88ab34..50b7cb9db3be 100644
>>> --- a/drivers/ptp/ptp_ocp.c
>>> +++ b/drivers/ptp/ptp_ocp.c
>>> @@ -25,6 +25,8 @@
>>>   #include <linux/crc16.h>
>>>   #include <linux/dpll.h>
>>>   
>>> +#include "../tty/serial/8250/8250.h"
>>
>> Hi Greg, Jiri, does this look reasonable to you?
>> The cross tree include raises an obvious red flag.
> 
> Yeah, that looks wrong.
> 
>> Should serial / u8250 provide a more official API?
> 
> If it needs to, but why is this driver poking around in here at all?

Hi Greg!

Well, the original idea was to have symlinks with self-explanatory names
to real serial devices exposed by PCIe device.

> 
>> Can we use device_for_each_child() to deal with the extra
>> layer in the hierarchy?
> 
> Or a real function where needed?

yep.

> 
>>
>>>   #define PCI_VENDOR_ID_FACEBOOK			0x1d9b
>>>   #define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
>>>   
>>> @@ -4330,11 +4332,9 @@ ptp_ocp_symlink(struct ptp_ocp *bp, struct device *child, const char *link)
>>>   }
>>>   
>>>   static void
>>> -ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
>>> +ptp_ocp_link_child(struct ptp_ocp *bp, struct device *dev, const char *name, const char *link)
>>>   {
>>> -	struct device *dev, *child;
>>> -
>>> -	dev = &bp->pdev->dev;
>>> +	struct device *child;
>>>   
>>>   	child = device_find_child_by_name(dev, name);
>>>   	if (!child) {
>>> @@ -4349,27 +4349,39 @@ ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
>>>   static int
>>>   ptp_ocp_complete(struct ptp_ocp *bp)
>>>   {
>>> +	struct device *dev, *port_dev;
>>> +	struct uart_8250_port *port;
>>>   	struct pps_device *pps;
>>>   	char buf[32];
>>>   
>>> +	dev = &bp->pdev->dev;
>>> +
>>>   	if (bp->gnss_port.line != -1) {
>>> +		port = serial8250_get_port(bp->gnss_port.line);
>>> +		port_dev = (struct device *)port->port.port_dev;
> 
> That cast is not going to go well.  How do you know this is always
> true?

AFAIU, port_dev starts with struct dev always. That's why it's safe.

> 
> What was the original code attempting to do?  It feels like that was
> wrong to start with if merely moving things around the device tree
> caused anything to break here.  That is not how the driver core is
> supposed to be used at all.
>

We just want to have a symlink with meaningful name to real tty device,
exposed by PCIe device. We provide up to 4 serial ports - GNSS, GNSS2,
MAC and NMEA, to user space and we don't want user space to guess which
one is which. We do have user space application which relies on symlinks
to discover features.

We don't use device tree because it's PCIe device with pre-defined
functions, so I don't see any other way to get this info and properly
create symlinks.

Thanks,
Vadim


> thanks,
> 
> greg k-h


