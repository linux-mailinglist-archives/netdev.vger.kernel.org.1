Return-Path: <netdev+bounces-250451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D370DD2C5EF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5ABE73003FD8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 06:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FFCA92E;
	Fri, 16 Jan 2026 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dsUmPhvM"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8BF34C981
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543933; cv=none; b=SVdfbQX6dvjxPlvGK99puMujb9kCIEoMdf/RmPDHaG2AKytk3ltEjI0ELBpOm/91yBHi+Q2azGKRouQyKIA/vHcTxu0FyGeb8/1WoB4QPqubddc9FX/5CPSpF8g/02WnW7t5BHtxWXAOO6koRejBaOpQPaocHWPEg37Q2UhUPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543933; c=relaxed/simple;
	bh=oTWZ9/czOkO1DJtahRcjyX+1qFd96At9CVN4EMd+OXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwmjSzusrnbE+r4JgOT//N7pEI+Y/ByMgd6S6sGlIHIaCdaa2izrgpYjHGVDi4U9KizhdXkxPknIJCEvgFqA3llc+FkUxu6f4qt1Zr5oPbHUDH5MqHA3iEJ30bNvai2zPmdDFVSR3NOdFJyKj9XAWqvmUxRn6i0T8C7SYnjzuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dsUmPhvM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b74a2241-bbbd-4c36-ad6f-1815b4838077@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768543928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSV4cmp+Ov310SrPmXEr26w/VgjgRXZub83vIHfmNjs=;
	b=dsUmPhvMQmt14r0RzFg1n912m3wLWMWef2xkAynMbmQ0SaMihTI5LzJ6IxQ1Dl2khSJ0VL
	ns9ficR8Q0xx5uqEVbB6WAO5qt+C/dhlNOqdn1E04tRQZ0jnCkPXmyD1JMmFBF3xr87C8I
	H1CTiT0GcdVdg1cXdomTJMQbVbq7IYk=
Date: Fri, 16 Jan 2026 06:12:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: extend HW timestamp test
 with ioctl
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org
References: <20260114224414.1225788-1-vadim.fedorenko@linux.dev>
 <20260114224414.1225788-2-vadim.fedorenko@linux.dev>
 <20260115201020.69f2a0b8@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260115201020.69f2a0b8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/01/2026 04:10, Jakub Kicinski wrote:
> On Wed, 14 Jan 2026 22:44:14 +0000 Vadim Fedorenko wrote:
>> Extend HW timestamp tests to check that ioctl interface is not broken
>> and configuration setups and requests are equal to netlink interface.
> 
> Haven't looked closely but pylint is not happy (pylint --disable=R
> $file):
> 
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:9:0: C0410: Multiple imports on one line (ctypes, fcntl, socket) (multiple-imports)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:16:0: C0115: Missing class docstring (missing-class-docstring)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:16:0: C0103: Class name "hwtstamp_config" doesn't conform to PascalCase naming style (invalid-name)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:86:4: W0201: Attribute 'rx_filter' defined outside __init__ (attribute-defined-outside-init)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:87:4: W0201: Attribute 'tx_type' defined outside __init__ (attribute-defined-outside-init)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:22:0: C0115: Missing class docstring (missing-class-docstring)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:22:0: C0103: Class name "ifreq" doesn't conform to PascalCase naming style (invalid-name)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:56:4: W0201: Attribute 'ifr_name' defined outside __init__ (attribute-defined-outside-init)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:89:4: W0201: Attribute 'ifr_name' defined outside __init__ (attribute-defined-outside-init)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:57:4: W0201: Attribute 'ifr_data' defined outside __init__ (attribute-defined-outside-init)
> tools/testing/selftests/drivers/net/hw/nic_timestamp.py:90:4: W0201: Attribute 'ifr_data' defined outside __init__ (attribute-defined-outside-init)

Most of them are because of ctypes. v2 will have linter happier

