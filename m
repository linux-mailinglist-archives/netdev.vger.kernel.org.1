Return-Path: <netdev+bounces-251909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG0jHfPtcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:17:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D849159093
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0549CA4C962
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FF340D92;
	Wed, 21 Jan 2026 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qKQqQLAt"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E433D4EA;
	Wed, 21 Jan 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005244; cv=none; b=ii9EPAYtpDkIWrSsTRTuu6ANzCw5IMUXC7CW/vOEkg5TEDM7/QgmN6InHUfRSz6+CVBESnWqdcRb0z1S3YSET+qHXwm0nIZHXHa0L3ZNr3hXJJyxv/lnbync1LozDEj/Pu0hTcK70IlbnsvEVvis1I8AdLwC4w7HVrSsSXTTnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005244; c=relaxed/simple;
	bh=nECRXUddvBB6r882YwmQmC1NCKzawqob/o0ecaEnuoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChAbpKwIWYK/W/zlSKQoahO7k6aOVSFBXW/as16f1VpTZxssUGkKZcMP/8gRDyk9nxGTVpoLfp+xBhRkqOk3hwAIBhkWoP0JR4rGyoeNpw+dq/bnKHfFMofh3I2h15cMsydjf+uvRhO6S5UXwxjcQ/B8mSZyqKlW9fUPHQ3I8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qKQqQLAt; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769005231; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4F4Z+wmFIYVbLHvWeOOQXSgEYrKMraRbThlYduC1oZ4=;
	b=qKQqQLAtXK1GxNUN4qxzQ89TRCJgj9rRs7da7L+7dQXVRwKhp0cqVaGOxzOxHn548K0MICjJSbjFCw1YDre9cOdMeynVPMi1oQQI8ok/UFkKg+tvrmFWhmrECgVKQOaCpf70dlbYqOjMN5cngGFBwX+qybK7bdXjUROWg5bGouA=
Received: from 30.221.145.201(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WxYTFJ9_1769005228 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 22:20:29 +0800
Message-ID: <711e54ef-97db-4e01-b0d8-bcf2dea61fe6@linux.alibaba.com>
Date: Wed, 21 Jan 2026 22:20:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Sven Schnelle <svens@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <yg3ikpcwukvv6z6gf6zzkoxlgu37ihauqpm2pkhmxuz6hsxfcc@eaeqykdvkh5v>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <yg3ikpcwukvv6z6gf6zzkoxlgu37ihauqpm2pkhmxuz6hsxfcc@eaeqykdvkh5v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-7.46 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-251909-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,gmail.com,vger.kernel.org,kernel.org,linux.alibaba.com,lunn.ch,infradead.org,lists.linux.dev,broadcom.com,linux.ibm.com,redhat.com];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D849159093
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/19 22:48, Manivannan Sadhasivam wrote:
> Hi Wen,
> 
> On Fri, Jan 09, 2026 at 10:56:56AM +0800, Wen Gu wrote:
>>
>> Hi all,
>>
>> This is an RFC to discuss the appropriate upstream home and maintenance
>> model for a class of devices/drivers which expose a high-precision clock
>> to userspace via the existing PHC interface (/dev/ptpX + standard PTP_*
>> ioctls), but are not tied to a traditional NIC/IEEE1588 packet
>> timestamping pipeline.
>>
> 
> Thanks for starting the discussion. I sent out an email just today on this
> topic [1] and learned about this thread afterwards.

[...]

> 
> Some Qcom MHI devices expose the high precision clock derived from GNSS/Cellular
> network over the MHI registers and we recently sent out a series exposing them
> as PHC [2]. Since this driver is closely tied with MHI bus, we added it as a
> part of drivers/bus/mhi/.
> 
Hi Manivannan,

Thanks for the note and for sharing the MHI PHC use case.

Yes, this is very similar to what motivated this RFC, there are more and
more PHC providers which are not tied to NIC/IEEE 1588.

[...]

>>
>> Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
>> require widespread userspace changes, duplicated tooling, and long-term
>> fragmentation. This RFC is explicitly NOT proposing a new userspace API.
>>
> 
> +1
> 

[...]

> 
> If we get a consensus to move forward with exposing the device clocks as PHC, we
> will respin the MHI driver and would love to get an ACK from the (new)
> maintainers.
> 
> - Mani
> 
> [1] https://lore.kernel.org/all/vmwwnl3zv26lmmuqp2vqltg2fudalpc5jrw7k6ifg6l5cwlk3j@i7jm62zcsl67/
> [2] https://lore.kernel.org/mhi/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/
> 


