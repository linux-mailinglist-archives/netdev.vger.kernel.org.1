Return-Path: <netdev+bounces-198729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15400ADD62B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278B2194733C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1ED2E8DF9;
	Tue, 17 Jun 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a8reajSM"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CF2E8DF3
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176629; cv=none; b=nCZzlWSkssDvVt5UxHuxg8tfcsfEVJr2MYx5ZN08TFl6dZi/I8PVuG/ZtHvViZYXHUHHztHCA4PukTkUb45S6VV3BpzNpKSau5+KzuDe+QWDVBeHg2nKRJc0nEBqLYiZQrQlIDFr6koTfX0YrqKKNaHdGN+heN4LcYZn/KwMyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176629; c=relaxed/simple;
	bh=eT/klJr61oZAmAZaG7qtMmJl9D24m3DWLyV1Jqt0Y0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPE+MyvrpV73ltYzEWy5xnjR0OeIVDVOCwqoXS1hHCMkA8OYM3JjLEgZT9v18cJ9vBDf/tuyQBt5jMH4rx8usKQPM1y5vrz7WLlhBk2N7OvS8BVI8usskPi/RwyZMqG1fFccvUbVpArOjyP3CIzMFgQ8Ixyj3g8q3fMxgKOB52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a8reajSM; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750176621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzN7mb8hfmg8NEosB0eBcLn7af74LMBrCULzpSPXO/Q=;
	b=a8reajSMTxhoo963aLG7Ntmq8A9typZTRmq2bef+UCTz8KwTDwKpYiZtlRKyBMxir0Aqil
	xAIJtYE0HRMUVBG2o69ZdffQL9RoRsMPEQxhsrVDFREvczU6ucIuZ4FpgdA2TKPwvinEjn
	Y4vsRPa4Y12QIJhqsna9B6lY2kCR9E0=
Date: Tue, 17 Jun 2025 17:10:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
To: Oleksij Rempel <o.rempel@pengutronix.de>, Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Arun Ramadoss <arun.ramadoss@microchip.com>,
 Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
 Richard Cochran <richardcochran@gmail.com>,
 Christian Eggers <ceggers@arri.de>
References: <20250616172501.00ea80c4@wsk> <aFD8VDUgRaZ3OZZd@pengutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aFD8VDUgRaZ3OZZd@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/06/2025 06:25, Oleksij Rempel wrote:
> On Mon, Jun 16, 2025 at 05:25:01PM +0200, Lukasz Majewski wrote:
>> Dear Community,
>>
>> As of [1] KSZ drivers support HW timestamping HWTSTAMP_TX_ONESTEP_P2P.
>> When used with ptp4l (config [2]) I'm able to see that two boards with
>> KSZ9477 can communicate and one of them is a grandmaster device.
>>
>> This is OK (/dev/ptp0 is created and works properly).
>>
>>  From what I have understood - the device which supports p2p1step also
>> supports "older" approaches, so communication with other HW shall be
>> possible.
> 
> This is not fully correct. "One step" and "two step" need different things from
> hardware and driver.
> 
> In "one step" mode, the switch modifies the PTP frame directly and inserts the
> timestamp during sending (start of frame). This works without host help.
> 
> But for "two step" mode, the hardware only timestamps after the frame is sent.
> The host must then read this timestamp. For that, the switch must trigger an
> interrupt to the host. This requires:
> - board to wire the IRQ line from switch to host,
> - and driver to handle that interrupt and read the timestamp (like in
> ksz_ptp_msg_thread_fn()).
> 
> So it's not only about switch HW. It also depends on board design and driver
> support.
> 
>> Hence the questions:
>>
>> 1. Would it be possible to communicate with beaglebone black (BBB)
>> connected to the same network?
> 
> No, this will not work correctly. Both sides must use the same timestamping
> mode: either both "one step" or both "two step".
>   

I'm not quite sure this statement is fully correct. I don't have a
hardware on hands to make this setup, but reading through the code in
linuxptp - the two-step fsm kicks off based on the message type bit. In 
case when linuxptp receives 1-step sync, it does all the calculations.
For delay response packets on GM side it doesn't matter as GM doesn't do
any calculations. I don't see any requirements here from the perspective
of protocol itself.

But again, I don't have HW to make a proof.



