Return-Path: <netdev+bounces-249061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC10D135E4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFCFB3112D08
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579C22DB79C;
	Mon, 12 Jan 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qip6fCr2"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2392D9EF4
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229571; cv=none; b=ExTSwTcPf/kEhfhWDpIbA0Ob2hJbnsWcPuTUWA5n8y3HeM6KcS8+DUFs7rJwnktjz/pga/gFOfOiQrXvn+4nOVx9V0O+LuPz5V+OiSvgHGsipFAkVSHz4tlWqM4FFKpqmpuH0hBHgxcny5K+jIhC35xK3Q8J7g/ZMToxUELYdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229571; c=relaxed/simple;
	bh=rk8bXKLs85EyZHFcbsB6vMfK2HtohBmLI1PGrH8lWtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKBPAeMSZLwymzq0zyqWmfZg7iuwyDqb59s61bW8bqPn//VQWIZJ5rMqf5zbXl9EN0ZL+x3uPjXSfFlbzOnDCqMWUbbYA0y3xSFnC2DT3APfaxbFm96vEPxw2ceDL9i5XY3Ac0gWlexD/GHnThuUod+WZC1blDWCnFIMb/O9fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qip6fCr2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87495044-59a3-49ed-b00c-01a7e9a23f6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768229556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0emvJ+ADmIcSWvy6T91yM9f9/IPC+6X0Ta51udzejc=;
	b=Qip6fCr24w+mxhxajrnVbpJNOVzhcHP5SS4dq32LFfeHU6v++EZE708vYsjQP9R7ZtENgv
	3YxK9vD1mGRbCrfHbGZweg3170J+D6Wdn9qD6krCW9LQR4Wkt25LMMic/cLfy+u9tel1xT
	f1wp+rkLsaWPuOpgKjA53vMXKfcqtHk=
Date: Mon, 12 Jan 2026 14:52:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sven Schnelle <svens@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <yt9decnv6qpc.fsf@linux.ibm.com>
 <6a32849d-6c7b-4745-b7f0-762f1b541f3d@linux.dev>
 <7be41f07-50ab-4363-8a53-dcdda63b9147@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <7be41f07-50ab-4363-8a53-dcdda63b9147@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/01/2026 13:24, Andrew Lunn wrote:
>>> drivers/ptp/core    - API as written above
>>> drivers/ptp/virtual - all PtP drivers somehow emulating a PtP clock
>>>                         (like the ptp_s390 driver)
>>> drivers/ptp/net     - all NIC related drivers.
>>>
>>
>>
>> Well, drivers/ptp/virtual is not really good, because some drivers are
>> for physical devices exporting PTP interface, but without NIC.
> 
> If the lack of a NIC is the differentiating property:
> 
>>> drivers/ptp/net     - all NIC related drivers.
>>> drivers/ptp/netless - all related drivers which are not associated to a NIC.
> 
> Or
> 
>>> drivers/ptp/emulating - all drivers emulating a PtP clock

I would go with "emulating" then.

> 
> 	Andrew


