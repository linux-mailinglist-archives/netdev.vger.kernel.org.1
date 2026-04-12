Return-Path: <netdev+bounces-277803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id T9yLGeKm22kSEwkAu9opvQ
	(envelope-from <netdev+bounces-277803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EBA3E4240
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C5B3300E3A5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE5E1D130E;
	Sun, 12 Apr 2026 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H1SHUp2R"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04D17B50A
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002539; cv=none; b=Tkn1MD4uEvYDXehEYXRM+IMxOJe+lL/9Q7aS9sDFCVHRKB/M2DiIV8qACmxIj0hXoyNPB1uDR5DVDZjfts0StOSbSaX1y1lWNj8X9mChrZq5IR6Iy/qklmzrYTaJ3EB01dLbjc7RoTLJCeJ5Gkgt1keZagoul8/ZmVVuDm8Muf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002539; c=relaxed/simple;
	bh=wwX6mI3xqtGIgeIMKXJg5s5oy1QGAwj+DCbH2wyNQbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaD50KO1p50ZDDodD/ssaatNAzIMDZ9CFlGZYLpFLVaxkrPEU8+FDHpxelwF1eYuIlB9hllXvHfj+N/VwKu6r8fUC1i0BQcobgS5dM7N9romWnTqhiThUewppYgHmEBtipi7U8O1ixqUXjsq7dZnz67B0mWS0kjycvWViJG6Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H1SHUp2R; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9F15F4E425B6;
	Sun, 12 Apr 2026 14:02:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72DEA5FFB9;
	Sun, 12 Apr 2026 14:02:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E243710450084;
	Sun, 12 Apr 2026 16:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776002527; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JyrBejDYNW+FyCRkORkAaICvUo5I+HducgLjouVMK8Q=;
	b=H1SHUp2R7XPwq9Y3NwXMRHFL9rv7/aMub8BCAbRoGsvkYB4u71U8GqMr0QXdounn2viENY
	zw3G2x+z9Klw5QjfVdizmvk0jI7B04AX8ZpmqkoYXAbeFu1wJzDgkp71lYhIS4ii9K1DLO
	2vBkQPe+HymDPy73T1Zt7U+JzMzxPhWnTmACykWg7uU2kaUg26+Hy7YmTEntANuVJwSI5Z
	fp/Nj7T8u6mUUN5VVT1D2vLWHunbpjWtrvRheLGMv9Hgjr9ibBUmcBN5hRHNkJy8NSyNam
	n/pWT7WmiWvqGU8UnIetUuUX+/iR4SESagBhFHwYVzPsr6Qoq71fhkwp2d1B+A==
Message-ID: <266998d8-7e38-4bae-a4df-2f889538fe88@bootlin.com>
Date: Sun, 12 Apr 2026 16:01:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sam Edwards <cfsworks@gmail.com>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email]
X-Rspamd-Queue-Id: A0EBA3E4240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,

On 10/04/2026 15:07, Russell King (Oracle) wrote:
> Enable receive process stopped and receive buffer unavailable
> interrupts, so that the statistic counters can be updated.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Since we are seeing receive buffer exhaustion on several platforms,
> let's enable the interrupts so the statistics we publish via ethtool -S
> actually work to aid diagnosis. I've been in two minds about whether
> to send this patch, but given the problems with stmmac at the moment,
> I think it should be merged.

Looks like my reply to your original RFC was lost in limbo as the review/test tags are missing.

Here's my original answer :


It works, I can indeed see the stats get properly updated on imx8mp 🙂

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

I personnaly find the stat useful, and that having the stat visible to user
but stuck at 0 is misleading so,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


Maxime

> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index af6580332d49..43b036d4e95b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -99,6 +99,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  #define DMA_CHAN_INTR_ENA_NIE_4_10	BIT(15)
>  #define DMA_CHAN_INTR_ENA_AIE_4_10	BIT(14)
>  #define DMA_CHAN_INTR_ENA_FBE		BIT(12)
> +#define DMA_CHAN_INTR_ENA_RPS		BIT(8)
> +#define DMA_CHAN_INTR_ENA_RBU		BIT(7)
>  #define DMA_CHAN_INTR_ENA_RIE		BIT(6)
>  #define DMA_CHAN_INTR_ENA_TIE		BIT(0)
>  
> @@ -107,6 +109,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  					 DMA_CHAN_INTR_ENA_TIE)
>  
>  #define DMA_CHAN_INTR_ABNORMAL		(DMA_CHAN_INTR_ENA_AIE | \
> +					 DMA_CHAN_INTR_ENA_RPS | \
> +					 DMA_CHAN_INTR_ENA_RBU | \
>  					 DMA_CHAN_INTR_ENA_FBE)
>  /* DMA default interrupt mask for 4.00 */
>  #define DMA_CHAN_INTR_DEFAULT_MASK	(DMA_CHAN_INTR_NORMAL | \
> @@ -117,6 +121,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  					 DMA_CHAN_INTR_ENA_TIE)
>  
>  #define DMA_CHAN_INTR_ABNORMAL_4_10	(DMA_CHAN_INTR_ENA_AIE_4_10 | \
> +					 DMA_CHAN_INTR_ENA_RPS | \
> +					 DMA_CHAN_INTR_ENA_RBU | \
>  					 DMA_CHAN_INTR_ENA_FBE)
>  /* DMA default interrupt mask for 4.10a */
>  #define DMA_CHAN_INTR_DEFAULT_MASK_4_10	(DMA_CHAN_INTR_NORMAL_4_10 | \


