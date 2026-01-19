Return-Path: <netdev+bounces-251149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2601D3AE7F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 084BA3043F74
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21D369979;
	Mon, 19 Jan 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hEzL6BaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1023EA8D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835050; cv=none; b=ZSzUmSPIPUUaQHRdBxhl7LpnjHdQcnWKcrSqLMDh8jIs9yV1XQryB1ouoU5JKCZy6UQOjBV+1kjNKgiWxCHdWI9itLLH0nmvfBzNwE2N1Hq3OoPUpSw8JbQ7Scb4pEnbEcKBfzObRXhrCx7cqk+m0J8chPcXiBtNnhv1ZYfSj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835050; c=relaxed/simple;
	bh=Zzu5OCUUhPvyX9JSc19jPBW5ivEyqd+IWd+KiisbAAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YncM0BfM12jJJPyUcWugF6Tr8yJBXX5QYWz5A4QUCjSRFUgYPA4AmsZ+8vf2A2D5GXzHhGcgNTIKz+o1efkEI8OxZ6+hljO6WtvQOFcutVG1jut0Xuz5eKzj54TsQccbJ30/Qa15R7WPIu79TaTR0+AsZ/pbbVmLEl0jvjVFVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hEzL6BaF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CB3571A285D;
	Mon, 19 Jan 2026 15:04:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9205360731;
	Mon, 19 Jan 2026 15:04:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F62010B6B0FF;
	Mon, 19 Jan 2026 16:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768835045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cSmKic32n6ti5xOcPpQbUlIndt/JhQ9yoiHmChcJtRE=;
	b=hEzL6BaFT066Dkq6fkn2iM8Cz98b9mOWoul5nqw+sxKA/HI+bwQEt+qHbTNi6G6Ej27iPg
	RFubusD5i4DA6w0h3GAF8jpMFiAAAf/uGdfucxGXWfSKQHuHYPKvSkMoCFYJd6GXDJWYMS
	lpnmGML26CfYqmYQEWDSZmuJM/iht/h3uxWbSpJh4CpQrQqKyEFu2F+eXXjAXH7MsSMpKM
	J58IWOFFRwFzQMJ7QjMiUpJxZHM/8flWTmoq6N2Y95gngvgSooRxl1CnZZohnW96H3z9FX
	jQsooIGcyvRKE3u+Yg8J6czEHiItf9ezstKd5s1PDkmwgKFyexWaZXUZBrtvbQ==
Message-ID: <33b06fd6-3eb3-4eb7-8091-7ebe8a8373ba@bootlin.com>
Date: Mon, 19 Jan 2026 16:03:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: stmmac: enable RPS and RBU interrupts
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 17/01/2026 00:25, Russell King (Oracle) wrote:
> Enable receive process stopped and receive buffer unavailable
> interrupts, so that the statistic counters can be updated.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> Maxime,
> 
> You may find this patch useful, as it makes the "rx_buf_unav_irq"
> and "rx_process_stopped_irq" ethtool statistic counters functional.
> This means that the lack of receive descriptors can still be detected
> even if the receive side doesn't actually stall.
> 
> I'm not sure why we publish these statistic counters if we don't
> enable the interrupts to allow them to ever be non-zero.

It works, I can indeed see the stats get properly updated on imx8mp :)

There's one downside to it though, which is that as soon as we hit a situation
where we don't have RX bufs available, this patchs has a tendancy to make things
worse as we'll trigger interrupts for each packet we receive and that we can't
process, making it even longer for queues to be refilled.

It shows on iperf3 with small packets :

---- Before patch, 17% packet loss on UDP 56 bytes packets -----------------

# iperf3 -u -b 0 -l 56 -c 192.168.2.1 -R
Connecting to host 192.168.2.1, port 5201
Reverse mode, remote host 192.168.2.1 is sending
[  5] local 192.168.2.18 port 47851 connected to 192.168.2.1 port 5201
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  10.7 MBytes  90.0 Mbits/sec  0.003 ms  48550/249650 (19%)  
[  5]   1.00-2.00   sec  11.3 MBytes  95.0 Mbits/sec  0.003 ms  41881/253832 (16%)  
[  5]   2.00-3.00   sec  11.3 MBytes  94.9 Mbits/sec  0.002 ms  42060/253913 (17%)  
[  5]   3.00-4.00   sec  11.3 MBytes  95.1 Mbits/sec  0.003 ms  41499/253785 (16%)  
[  5]   4.00-5.00   sec  11.3 MBytes  94.6 Mbits/sec  0.003 ms  42663/253787 (17%)  
[  5]   5.00-6.00   sec  11.3 MBytes  94.9 Mbits/sec  0.006 ms  41976/253719 (17%)  
[  5]   6.00-7.00   sec  11.3 MBytes  94.5 Mbits/sec  0.003 ms  43133/253999 (17%)  
[  5]   7.00-8.00   sec  11.3 MBytes  95.0 Mbits/sec  0.004 ms  41442/253579 (16%)  
[  5]   8.00-9.00   sec  11.4 MBytes  95.2 Mbits/sec  0.004 ms  41518/254131 (16%)  
[  5]   9.00-10.00  sec  11.2 MBytes  94.3 Mbits/sec  0.006 ms  43580/254143 (17%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   135 MBytes   114 Mbits/sec  0.000 ms  0/0 (0%)  sender
[  5]   0.00-10.00  sec   112 MBytes  94.3 Mbits/sec  0.006 ms  428302/2534538 (17%)  receiver

iperf Done.
# ethtool -S eth1 | grep rx_buf_unav_irq
     rx_buf_unav_irq: 0

---- After patch, 22% packet loss on UDP 56 bytes packets ----------------------

# iperf3 -u -b 0 -l 56 -c 192.168.2.1 -R
Connecting to host 192.168.2.1, port 5201
Reverse mode, remote host 192.168.2.1 is sending
[  5] local 192.168.2.18 port 42121 connected to 192.168.2.1 port 5201
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  10.3 MBytes  85.8 Mbits/sec  0.004 ms  55146/247172 (22%)  
[  5]   1.00-2.00   sec  10.6 MBytes  89.1 Mbits/sec  0.003 ms  54699/253355 (22%)  
[  5]   2.00-3.00   sec  10.6 MBytes  89.0 Mbits/sec  0.003 ms  55231/253887 (22%)  
[  5]   3.00-4.00   sec  10.6 MBytes  88.9 Mbits/sec  0.003 ms  55138/253602 (22%)  
[  5]   4.00-5.00   sec  10.6 MBytes  89.0 Mbits/sec  0.003 ms  54938/253722 (22%)  
[  5]   5.00-6.00   sec  10.6 MBytes  88.9 Mbits/sec  0.003 ms  55273/253580 (22%)  
[  5]   6.00-7.00   sec  10.6 MBytes  89.0 Mbits/sec  0.003 ms  55202/253986 (22%)  
[  5]   7.00-8.00   sec  10.6 MBytes  89.1 Mbits/sec  0.003 ms  55047/253958 (22%)  
[  5]   8.00-9.00   sec  10.6 MBytes  88.9 Mbits/sec  0.003 ms  55612/254140 (22%)  
[  5]   9.00-10.00  sec  10.6 MBytes  89.0 Mbits/sec  0.003 ms  55683/254403 (22%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   135 MBytes   113 Mbits/sec  0.000 ms  0/0 (0%)  sender
[  5]   0.00-10.00  sec   106 MBytes  88.7 Mbits/sec  0.003 ms  551969/2531805 (22%)  receiver

iperf Done.
# ethtool -S eth1 | grep rx_buf_unav_irq
     rx_buf_unav_irq: 30624


So clearly there are pros and cons with this, but I don't want to fall into the
"let's not break microbenchmarks" pitfall.

I personnaly find the stat useful, so :

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


Maxime

