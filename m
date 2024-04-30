Return-Path: <netdev+bounces-92513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2058B7ABA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365E5281F2E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403014372C;
	Tue, 30 Apr 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="qKt/VLxa"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189607710D
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489132; cv=none; b=cxb9jwE7poLvkPvGRK2Oftb3h0GBUX4XwvFIxzZpXKdTm4gD0Uuv+u4YxeuffZeubtMEGRPvnDJSvujM7Nv+gPU5Da5xwggUimPsuudYzNG4EDkVWm5HB93MuNFRUsOUEWQSB/8rTBPGV1MgDjZAQc1QPqmBNr5RrbJICf42oro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489132; c=relaxed/simple;
	bh=aK8rNc36l84FoofPl3zvU9soOmwm+ULYNmXvO9yTgsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwrOXCykjoqoYyDPT1JVRR4c4fKf0F9iC4IZp31SsmXSms1VOFU+BX9UWWXrA52lbQe8MiGuz/v9EDcqmxWsTkIbQdGc+IGod7nPV1Twqmp3cAwmGliZfzLOB6wC74aCtBREcb2I/166umBeR6sA64opWXJoEYeaPdXOw+raO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=qKt/VLxa; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 45941885B7;
	Tue, 30 Apr 2024 16:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714489128;
	bh=MbS5kmDoV9ij1Dnn8Ot86aNEiqzKcScaTzIQmjRFeFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qKt/VLxaAjufqoXRReo15P3+8pbLhV8dZT5QpP88Mvh6q5U+G5ts8GWg6ZtxtbuL7
	 Tc32qWdGLqCPc4zrJ3E3qj5LC1slyKkzaQJHJzB+PFgQHF5ajly4ZIwKPhJ/w33uGQ
	 JGMSW1hBYvb3J+6aM5tPtutWBW4NqCfXA1fhUQ2Eyj4iVGK5ugqxKU00/Zwl4D30bH
	 yvjpOOagxoPGbNKleoqaRK1RZTwjXy1P8e+9RATKbqUonn+iuo0lTTen5GVjbb4QhZ
	 RjuGOkPvY6MYuPLSEdDB5ZuME2R3T7iNdijFKmebBRQkxif8HWiP2WyHWM/5P7ur/e
	 R0c36JSp1HJ9g==
Message-ID: <d51e8d34-10f3-431a-a3dc-d1daed046e86@denx.de>
Date: Tue, 30 Apr 2024 16:58:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH] net: ks8851: Queue RX packets in IRQ handler instead
 of disabling BHs
To: Ronald Wahl <ronald.wahl@raritan.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20240430011518.110416-1-marex@denx.de>
 <959c3cf5-c604-4b36-adb8-ee28ed4ef9c4@raritan.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <959c3cf5-c604-4b36-adb8-ee28ed4ef9c4@raritan.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/30/24 10:24 AM, Ronald Wahl wrote:
> On 30.04.24 03:14, Marek Vasut wrote:
>> Currently the driver uses local_bh_disable()/local_bh_enable() in its
>> IRQ handler to avoid triggering net_rx_action() softirq on exit from
>> netif_rx(). The net_rx_action() could trigger this driver .start_xmit
>> callback, which is protected by the same lock as the IRQ handler, so
>> calling the .start_xmit from netif_rx() from the IRQ handler critical
>> section protected by the lock could lead to an attempt to claim the
>> already claimed lock, and a hang.
>>
>> The local_bh_disable()/local_bh_enable() approach works only in case
>> the IRQ handler is protected by a spinlock, but does not work if the
>> IRQ handler is protected by mutex, i.e. this works for KS8851 with
>> Parallel bus interface, but not for KS8851 with SPI bus interface.
>>
>> Remove the BH manipulation and instead of calling netif_rx() inside
>> the IRQ handler code protected by the lock, queue all the received
>> SKBs in the IRQ handler into a queue first, and once the IRQ handler
>> exits the critical section protected by the lock, dequeue all the
>> queued SKBs and push them all into netif_rx(). At this point, it is
>> safe to trigger the net_rx_action() softirq, since the netif_rx()
>> call is outside of the lock that protects the IRQ handler.
>>
>> Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ 
>> thread to fix hang")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Ronald Wahl <ronald.wahl@raritan.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: netdev@vger.kernel.org
> 
> To me the code looks good. An iperf3 test shows that it now has even
> slightly more throughput in my setup (two interconnected ks8851-spi).
> Thanks for this fix!
> 
> Tested-by: Ronald Wahl <ronald.wahl@raritan.com>

That's nice. Thank you for testing. Sorry for the breakage.

