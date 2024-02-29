Return-Path: <netdev+bounces-76358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC586D60C
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24691F23328
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7944316FF43;
	Thu, 29 Feb 2024 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L56AT+Vm"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317F16FF21
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241748; cv=none; b=chvblxcE0fnJjGC68Fy7FcT7YXIZq5g/AfEMHZ4aOMFMY6em9NAcY/9aCY4ZFrpZVxAlgan9VqAzAx5eH6EMYF3QEJ5QIUh7+VJe7V8KSXoxxygUr766wHv+jPVxlmf3iw5XiiICZlmujwgc3UIUUzfqoLe3UHqYVgixrvCEpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241748; c=relaxed/simple;
	bh=AUMO1dwOotqMN3ZzIy/gsYjtophrhhpUFmG8jAcKCHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+PudMS4eNzIrAMeKIxy9gOCjo21XW/XAR96imjc74bB1EPQJMuE1XFDrO5AmOJz8AqtUNvPH1QqEznY6RQljKB1nhS/350o1gqj6YW0KjnR8Khbt6KSVmOoxTqwFS1IrtpIWuOnXwgfWXL3xO6pByS2z7+dc5+6rJcv+bmSc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L56AT+Vm; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709241744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWtiOH+KHBY/X4TT5M1tf4eFBhLUFT/RMzEfrBr87E4=;
	b=L56AT+Vm3YM6U5oK/c7HLOjPbczyAJdbj+shQMgpW8YVEfiP0Y11FK6JlWRFX6aGbwVf8a
	mPHJPzXQfonObqIAHETU64/pVr8Hc6NSsSK2wLobzcgpOMeWh28QIwei4eAgdBn+g3CwRW
	DN1QaCXvqWZwbEhV17bS8zHI2TFRsaU=
Date: Thu, 29 Feb 2024 21:22:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 richardcochran@gmail.com
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-2-michael.chan@broadcom.com>
 <ZeC61UannrX8sWDk@nanopsycho> <20240229093054.0bd96a27@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240229093054.0bd96a27@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/02/2024 17:30, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 18:11:49 +0100 Jiri Pirko wrote:
>> Idk. This does not look sane to me at all. Will we have custom knobs to
>> change timeout for arbitrary FW commands as this as a common thing?
>> Driver is the one to take care of timeouts of FW gracefully, he should
>> know the FW, not the user. Therefore exposing user knobs like this
>> sounds pure wrong to me.
>>
>> nack for adding this to devlink.
> 
> +1
> 
> BTW why is the documentation in a different patch that the param :(
> 
>> If this is some maybe-to-be-common ptp thing, can that be done as part
>> of ptp api perhaps?

Jiri, do you mean extend current ioctl used to enable/disable HW
timestamps?

> 
> Perhaps, but also I think it's fairly impractical. Specialized users may
> be able to tune this, but in DC environment PTP is handled at the host

That's correct, only 1 app is actually doing syncronization

> level, and the applications come and go. So all the poor admin can do

Container/VM level applications don't care about PTP packets timestamps.
They only care about the time being synchronized.

> is set this to the max value. While in the driver you can actually try

Pure admin will tune it according to the host level app configuration
which may differ because of environment.

> to be a bit more intelligent. Expecting the user to tune this strikes me
> as trying to take the easy way out..

There is no actual way for application to signal down to driver that it
gave up waiting for TX timestamp, what other kind of smartness can we
expect here?

