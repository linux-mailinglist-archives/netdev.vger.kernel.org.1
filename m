Return-Path: <netdev+bounces-100945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97E8FC994
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D2EB21092
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E21922C2;
	Wed,  5 Jun 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TX8BeerZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCE18C348
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585181; cv=none; b=NDAmLfRvA1nspz9y2I/+5Winkv74W76A3shMWfKhWQ85BP6KHSiaSpCgyBJCsTpEV3ZgT2SgVnlhgILCCH8geELYvzh7Jmpi1AYJT9ZkI6uLlqytq1WjQBKZlxpYObuC/epEPipQrth1tOXr+Eh7uADcQjF1jqk+SBSpGgJDZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585181; c=relaxed/simple;
	bh=GIHJpbUa4dcfv6cQe5j4NgCQ1VgghAMwPcaeXNqPSoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpRDrerzKmQCXQ90LSPrJE3/xyMFSiq8EGkxsyatNqtFilNg71teddPlcdpxFcH/rAXVUWRcw9HOoe35N1e8Nk9JeHLenR2AdHLnh0a/MCDVEzwiEWUlrRZIzOFv0rzNS1ggmkyR9ocvs4Y71jOSQHHvxsZ0GGOXUZyljOsjA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TX8BeerZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: gregkh@linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717585176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLUG0E9rHHwaYveOUuRCOlFfTsn4mIqBwn1WKQ5TD0g=;
	b=TX8BeerZZcuDinCp2LvLArr7P2aiXNKun0ISCAlJHA7G/QcUUdZME72K41pb8jKhAKxsvi
	jBmOJneP1whTnFZ19tFiSO3PwVK/EOK2hEnewyMK2p7ECVVDYMcou2tcjwgnnIaRta896O
	m9fi7f9E/Bl4+A9ceakTMYZKiM1UZMw=
X-Envelope-To: kuba@kernel.org
X-Envelope-To: jirislaby@kernel.org
X-Envelope-To: jonathan.lemon@gmail.com
X-Envelope-To: linux-serial@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <15f59e29-ac03-4018-bbc3-c4ac5a2964db@linux.dev>
Date: Wed, 5 Jun 2024 11:59:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <2024051046-decimeter-devotee-076a@gregkh>
 <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>
 <2024060428-childcare-clunky-067c@gregkh>
 <d59e00e1-d390-4140-b34f-58eaf13baee7@linux.dev>
 <2024060505-expose-crouch-00b1@gregkh>
 <cbcf7cbb-809f-47f8-bd98-e140875bc2d1@linux.dev>
 <2024060514-recess-unblessed-431c@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2024060514-recess-unblessed-431c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/06/2024 11:41, Greg Kroah-Hartman wrote:
> On Wed, Jun 05, 2024 at 11:14:28AM +0100, Vadim Fedorenko wrote:
>> On 05/06/2024 11:05, Greg Kroah-Hartman wrote:
>>> On Wed, Jun 05, 2024 at 12:53:13AM +0100, Vadim Fedorenko wrote:
>>>> On 04/06/2024 12:50, Greg Kroah-Hartman wrote:
>>>>> On Wed, May 22, 2024 at 01:39:21PM +0100, Vadim Fedorenko wrote:
>>>>>> On 10/05/2024 12:13, Greg Kroah-Hartman wrote:
>>>>>>> On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
>>>>>>>> The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
>>>>>>>> of serial core port device") changed the hierarchy of serial port devices
>>>>>>>> and device_find_child_by_name cannot find ttyS* devices because they are
>>>>>>>> no longer directly attached. Add some logic to restore symlinks creation
>>>>>>>> to the driver for OCP TimeCard.
>>>>>>>>
>>>>>>>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
>>>>>>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>>>> ---
>>>>>>>> v2:
>>>>>>>>      add serial/8250 maintainers
>>>>>>>> ---
>>>>>>>>      drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
>>>>>>>>      1 file changed, 21 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>>>>>>> a patch that has triggered this response.  He used to manually respond
>>>>>>> to these common problems, but in order to save his sanity (he kept
>>>>>>> writing the same thing over and over, yet to different people), I was
>>>>>>> created.  Hopefully you will not take offence and will fix the problem
>>>>>>> in your patch and resubmit it so that it can be accepted into the Linux
>>>>>>> kernel tree.
>>>>>>>
>>>>>>> You are receiving this message because of the following common error(s)
>>>>>>> as indicated below:
>>>>>>>
>>>>>>> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>>>>>>>       older released kernel, yet you do not have a cc: stable line in the
>>>>>>>       signed-off-by area at all, which means that the patch will not be
>>>>>>>       applied to any older kernel releases.  To properly fix this, please
>>>>>>>       follow the documented rules in the
>>>>>>>       Documentation/process/stable-kernel-rules.rst file for how to resolve
>>>>>>>       this.
>>>>>>>
>>>>>>> If you wish to discuss this problem further, or you have questions about
>>>>>>> how to resolve this issue, please feel free to respond to this email and
>>>>>>> Greg will reply once he has dug out from the pending patches received
>>>>>>> from other developers.
>>>>>>
>>>>>> Hi Greg!
>>>>>>
>>>>>> Just gentle ping, I'm still looking for better solution for serial
>>>>>> device lookup in TimeCard driver.
>>>>>
>>>>> See my comment on the other patch in this thread.
>>>>>
>>>>> In short, you shouldn't need to do any of this.
>>>>
>>>> Got it, thanks. I'll try to find another way.
>>>
>>> Wait, no, please just remove all that, it should not be needed at all.
>>
>> Do you mean remove symlinks from the driver? We have open-source
>> user-space software which relies on them to discover proper devices. If
>> I remove symlinks it will break the software.
> 
> the symlinks should be done in userspace in the /dev/serial/ directory,
> why would userspace need to know the symlink of the serial device in
> a sysfs tree?  What exactly are you trying to represent here that
> requires this to be a custom thing?

Well, the hardware exposes up to 4 different serial ports for different
functions. And only driver knows which feature is attached to which port
because of differences in the HW. There is no way for user-space to get
this information on it's own. And one more thing, some HW versions
expose special attributes in sysfs consumed by the same software.
And there are setups with several boards in the system. Currently we
separate them by providing different sysfs entries only, the software
then figures all details automatically.

Thanks,
Vadim


